function Get-Blueprint{
<#
    .SYNOPSIS
    Retrieves JSON doc representing blueprint via the blueprint ID, blueprint name, or a filter of the blueprint name.
    
    .DESCRIPTION
    Retrieve vRA Blueprint documents
    
    .PARAMETER Id
    Specify the ID of a Blueprint

    .PARAMETER Name
    Specify the Name of a Blueprint

    .PARAMETER Limit
    The number of entries returned per page from the API. This has a default value of 100.
	
	.PARAMETER Filter
	OData filter to use 

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject.

    .EXAMPLE
    Get-vRABlueprint
    
    .EXAMPLE
    Get-vRABlueprint -Id "309100fd-b8ce-4e8c-ac8c-a667b8ace54f"

    .EXAMPLE
    Get-vRABlueprint -Name "Blueprint01","Blueprint02"
	
	.EXAMPLE
	Get-vRABlueprint -Filter "startswith(name,'Blueprint')"
#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject')]
	
	Param (
	
	[parameter(Mandatory=$true,ValueFromPipeline=$false,ParameterSetName="ById")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Id, 
	
	[parameter(Mandatory=$true,ValueFromPipeline=$false,ParameterSetName="ByName")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Name,
	
	[parameter(Mandatory=$true,ValueFromPipeline=$false,ParameterSetName="ByFilter")]
    [ValidateNotNullOrEmpty()]
    [String]$Filter,
    
	[parameter(Mandatory=$false,ValueFromPipeline=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Limit = "100"
	)
	
	# --- Test for vRA API version
    xRequires -Version 7.0
	

	try {                
        switch ($PsCmdlet.ParameterSetName) 
        { 
            "ById"  {                
                
                foreach ($BlueprintId in $Id){

                    $URI = "/composition-service/api/blueprintdocuments/$($BlueprintId)"

                    # --- Run vRA REST Request
                    $Response = Invoke-vRARestMethod -Method GET -URI $URI
                    
                    $Blueprints = $Response | Where-Object {$_.contentTypeId -eq "composite-blueprint"}
                }                              
            
                break
            }

            "ByName"  {                

               foreach ($BlueprintName in $Name){

                    $URI = "/composition-service/api/blueprintdocuments?`$filter=name%20eq%20'$($BlueprintName)'"

                    # --- Run vRA REST Request
                    $Response = Invoke-vRARestMethod -Method GET -URI $URI
                    
                    $Blueprints = $Response.content | Where-Object {$_.contentTypeId -eq "composite-blueprint"}

                    if (-not $Blueprints){

                        throw "Unable to find vRA Blueprint: $($BlueprintName)"
                    }
                }  
                
                break
            }
			
			"ByFilter"  {                

               foreach ($BlueprintName in $Name){

                    $URI = "/composition-service/api/blueprintdocuments?`$filter=$($BlueprintFilter)"

                    # --- Run vRA REST Request
                    $Response = Invoke-vRARestMethod -Method GET -URI $URI
                    
                    $Blueprints = $Response.content | Where-Object {$_.contentTypeId -eq "composite-blueprint"}

                    if (-not $Blueprints){

                        throw "Unable to find vRA Blueprint using filter: $($BlueprintFilter)"
                    }
                }  
                
                break
            }

            "Standard"  {

                $URI = "/composition-service/api/blueprintdocuments?`$filter=contentTypeId%20eq%20'composite-blueprint'"

                # --- Run vRA REST Request
                $Response = Invoke-vRARestMethod -Method GET -URI $URI

                $Blueprints = $Response.content

                break
            }
        }
    }
    catch [Exception]{

        throw
    }
}