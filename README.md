[![Build status](https://ci.appveyor.com/api/projects/status/8etfu1hw4y513i2w?svg=true)](https://ci.appveyor.com/project/devblackops/ovf-windows-server)

# OVF.Windows.Server

## Overview
This is a set of [Pester](https://github.com/pester/Pester) / [poshspec](https://github.com/Ticketmaster/poshspec) tests designed to test the
operation of a basic Windows server. These Pester tests have been packaged into a module according to the
[Operation Validation Framework](https://github.com/PowerShell/Operation-Validation-Framework) layout.

### Current tests

* Logical Disks
  * Availability
    * All volumes are available.
  * Capacity
    * All volumes have free space above a certain threshold.

* Memory
  * Capacity
    * Free megabytes is above a certain threshold.

* Network
  * Availability
    * All physical network adapters are connected.

* Services
  * Availability
    * Critical Windows services are running.

## Example Output

![Example Pester output](/Media/example.png)