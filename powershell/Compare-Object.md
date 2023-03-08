# Compare-Object 

Compare-Object compares two sets of objects and returns the differences between them. 

The output of Compare-Object has two main properties: InputObject and SideIndicator.

## InputObject

This property contains the objects being compared. 
When comparing two sets of objects, 
the InputObject property will contain the objects from the reference set.

## SideIndicator

This property contains a character indicating whether an object is 
in the reference set (<=) or the difference set (=>). 

If an object is in both sets, it will have an == side indicator.

## Additional Properties

Additional properties can be included in the output of 
Compare-Object by using the -Property parameter. 

For example, when comparing two sets of files using the -Property Hash parameter, 
the output of Compare-Object will include a Hash property with the hash value of each file.

