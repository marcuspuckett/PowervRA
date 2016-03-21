# Get-vRAService

## SYNOPSIS
    
Retrieve vRA services

## SYNTAX


## DESCRIPTION

A service represents a customer-facing/user friendly set of activities. In the context of this Service Catalog, 
these activities are the catalog items and resource actions. 
A service must be owned by a specific organization and all the activities it contains should belongs to the same organization.

## PARAMETERS


### Id

The id of the service
* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### Name

The Name of the service
* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### Limit

The number of entries returned per page from the API. This has a default value of 100.
* Required: false
* Position: named
* Default value: 100
* Accept pipeline input: false

## INPUTS

System.String

## OUTPUTS

System.Management.Automation.PSObject.

## EXAMPLES
```
-------------------------- EXAMPLE 1 --------------------------

C:\PS>Get-vRAService







-------------------------- EXAMPLE 2 --------------------------

C:\PS>Get-vRAService -Id 332d38d5-c8db-4519-87a7-7ef9f358091a







-------------------------- EXAMPLE 3 --------------------------

C:\PS>Get-vRAService -Name "Default Service"
```
