From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] CPU Package temperarure thermal driver (v02)
Date: Fri, 17 May 2013 16:42:00 -0700
Message-ID: <1368834123-9591-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36763 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab3EQXhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 May 2013 19:37:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This driver register CPU digital temperature package level sensor as a
thermal zone with two user mode configurable trip points. Once
the trip point is violated, user mode can receive notification via thermal
notification mechanism and can take any action to control temperature.

Changes:
v02:
Did majority of changes suggested by Eduardo Valentin. Main changes are:
- Module parameters for rate control delay
- Removed user space gov parameter in thermal_zone_register
- Changes related to returning of errors values
- Error code return values

v01:
First version for review

Background:
This set of changes were done to coretemp driver and posted to lm_sensors
mailing list on 04/04/2013. This was reviewed by Guenter Roeck from lm-sensors
and Zhang Rui (thermal maintainer). They were in agreement not to add notification
mechanism to coretemp driver but use thermal sysfs.
Guenter Roeck suggested to use approach like "db8500_thermal driver in drivers/thermal".
So resubmitting the driver as a thermal zone driver.
Previous discussion link:
http://comments.gmane.org/gmane.linux.drivers.sensors/32182
" 
This is clear that there is reluctance in adding thresholds in coretemp sysfs,
during previous attempts. Probably because of lake of use cases.
But this time use case may be more compelling.

We have many small form factor devices like ultrabooks, slate PCs in the market.
Unfortunately these devices reach maximum temperature with relatively less
workloads, causing BIOS to do thermal throttling. There are real performance
issues due to aggressive BIOS action to control thermals and also thermal breakdown
in some cases.

Even the most expensive laptops, don't have correct ACPI thermal configuration,
so that kernel thermal driver can act. In some case even the trip point is higher
than critical temperature setting.

Intel has developed several drivers, which can be used to cool the system very efficiently.
They include RAPL based cooling driver, Powerclamp driver and P state driver.
To utilize these cooling device a closed loop user mode program is required, which
will utilize these method and dynamically compensate for high CPU temperatures,
without relying on any configuration data.
One such solution is developed is "Linux thermal daemon". More details can be
obtained from 
"https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf".
This daemon polls for cpu temperature and apply compensation once the CPU reach target
temperature. 

This polling can be mostly avoided, by getting notification for the temperature, where
it needs to wake up and get ready for apply compensation. In most of the normal use 
cases, there may not be any threshold events. So very minimal number of user space
notification for thermal thresholds.

Srinivas Pandruvada (3):
  x86, mcheck, therm_throt: Process package thresholds
  Thermal: CPU Package temperature thermal
  Thermal: Documentation for x86 package temperature thermal driver

 Documentation/thermal/x86_pkg_temperature_thermal |  47 ++
 arch/x86/include/asm/mce.h                        |   7 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c          |  63 ++-
 drivers/thermal/Kconfig                           |  12 +
 drivers/thermal/Makefile                          |   2 +-
 drivers/thermal/x86_pkg_temp_thermal.c            | 642 ++++++++++++++++++++++
 6 files changed, 768 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/thermal/x86_pkg_temperature_thermal
 create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c

-- 
1.7.11.7

