$MyDashboard = New-UDDashboard -Title "Mina Dash Repo https://github.com/Gavin-Garley/mina-dashboard" -Content {  
   
   #all the things with api/v1/label/__name__/values
   $webData3 = (Invoke-webrequest http://localhost:9090/api/v1/label/__name__/values).Content
   New-UDCard -Title "All the things" -Text $webData3 
  
   $webDataUp = (invoke-WebRequest http://localhost:9090/api/v1/query?query=up).content
   New-UDCard -Title "Up WebRequest" -Text $webDataUp 
   
   #invoke-RestMethod and walking through PSCustomObject 
   $webDataUpRM = invoke-RestMethod http://localhost:9090/api/v1/query?query=up
   New-UDCard -Title "Up RestMethod" -Text $webDataUpRM
   New-UDCard -Title "Up RestMethod Data" -Text $WebDataUpRM.data 
   #pipe to out-string for text
   $webDataUpRMDataResult = $webdataUpRM.data.result | out-string
   New-UDCard -Title "Up RestMethod Data Result" -Text $WebDataUpRMDataResult
    
   #query Coda metric
   $CodaData1 = Invoke-RestMethod http://localhost:9090/api/v1/query?query=Coda_Network_get_ancestry_latency
   $CodaValue1 = $CodaData1.data.result.value[1] | Out-String
   New-UDCard -Title "Coda_Network_get_ancestry_latency" -Text $CodaValue1

   #query Coda metric 2
   $CodaData2 = Invoke-RestMethod http://localhost:9090/api/v1/query?query=Coda_Network_get_ancestry_read_response_avg_size_count
   $CodaValue2 = $CodaData2.data.result.value[1] | Out-String
   New-UDCard -Title "Coda_Network_get_ancestry_read_response_avg_size_count" -Text $CodaValue2
 
   #query Coda metric 3
   $CodaData3 = Invoke-RestMethod http://localhost:9090/api/v1/query?query=Coda_Network_peers
   $CodaValue3 = $CodaData3.data.result.value[1] | Out-String
   New-UDCard -Title "Coda_Network_peers" -Text $CodaValue3
    
}

Start-UDDashboard -Port 80 -Dashboard $MyDashboard -AutoReload
