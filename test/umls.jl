#Test "globals"
user= ""
psswd = ""
try
    user = ENV["UMLS_USER"]
    psswd = ENV["UMLS_PSSWD"]
catch
    println("UMLS tests require the following enviroment variables:")
    println("UMLS_USER")
    println("UMLS_PSSWD")
end

credentials = BioMedQuery.UMLS.Credentials(user, psswd)
println(credentials)
term = "obesity"
query = Dict("string"=>term, "searchType"=>"exact" )


# @testset "Testing UMLS" begin
    @test 1==1
    all_results= BioMedQuery.UMLS.search_umls(credentials, query)
    # @test length(all_results[1]["result"]["results"]) == 2
    # cui = BioMedQuery.UMLS.best_match_cui(all_results, term)
    # @test cui == "C0028754"
    # sm = BioMedQuery.UMLS.get_semantic_type(credentials, cui)
    # println(sm)
# end
