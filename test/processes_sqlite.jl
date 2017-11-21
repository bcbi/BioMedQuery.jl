#************************ LOCALS TO CONFIGURE!!!! **************************
email= "" #This is an enviroment variable that you need to setup
search_term="(obesity[MeSH Major Topic]) AND (\"2010\"[Date - Publication] : \"2012\"[Date - Publication])"
max_articles = 2
overwrite_db=true
verbose = false
#************************ SQLite **************************
db_path="./pubmed_save_and_search_test.db"
#***************************************************************************

db = nothing

@testset "Save and Search" begin

    println("-----------------------------------------")
    println("       Testing Search and Save")
    db_config = Dict(:db_path=>db_path,
                     :overwrite=>overwrite_db)
    db = pubmed_search_and_save(email, search_term, max_articles,
    save_efetch_sqlite, db_config, verbose)
    #query the article table and make sure the count is correct
    all_pmids = BioMedQuery.PubMed.all_pmids(db)
    @test length(all_pmids) == max_articles

end

@testset "MESH2UMLS" begin
    println("-----------------------------------------")
    println("       Testing MESH2UMLS")
    user = ENV["UMLS_USER"]
    psswd = ENV["UMLS_PSSWD"]
    append = false


    @time begin
        map_mesh_to_umls_async!(db, umls_user, umls_pswd; append_results=append)
    end

    all_pairs_query = db_query(db, "SELECT mesh FROM mesh2umls;")
    all_pairs = all_pairs_query[1]
    @test length(all_pairs) > 0

    @time begin
        map_mesh_to_umls!(db, umls_user, umls_pswd; append_results=append)
    end

    all_pairs_query = db_query(db, "SELECT mesh FROM mesh2umls;")
    all_pairs = all_pairs_query[1]
    @test length(all_pairs) > 0
end

@testset "Occurrences" begin

    println("-----------------------------------------")
    println("       Testing Occurrences")
    umls_concept = "Disease or Syndrome"
    @time begin
        labels2ind, occur = umls_semantic_occurrences(db, umls_concept)
    end

    @test length(keys(labels2ind)) > 0
    @test length(find(x->x=="Obesity", collect(keys(labels2ind)))) ==1
end

# remove temp files
if isfile(db_path)
    rm(db_path)
end
println("------------End Test Processes SQLite-----------")
println("------------------------------------------------")
