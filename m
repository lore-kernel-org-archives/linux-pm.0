From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] CPU Package temperarure thermal driver (v02)
Date: Thu, 13 Jun 2013 10:17:13 +0800
Message-ID: <1371089833.2135.6.camel@rzhang1-mobl4>
References: <1368834123-9591-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6793 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182Ab3FMCR0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Jun 2013 22:17:26 -0400
In-Reply-To: <1368834123-9591-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, tony.luck@intel.com, linux-edac@vger.kernel.org

On Fri, 2013-05-17 at 16:42 -0700, Srinivas Pandruvada wrote:
> This driver register CPU digital temperature package level sensor as a
> thermal zone with two user mode configurable trip points. Once
> the trip point is violated, user mode can receive notification via thermal
> notification mechanism and can take any action to control temperature.
> 
the whole patch series has been applied.

thanks,
rui

> Changes:
> v02:
> Did majority of changes suggested by Eduardo Valentin. Main changes are:
> - Module parameters for rate control delay
> - Removed user space gov parameter in thermal_zone_register
> - Changes related to returning of errors values
> - Error code return values
> 
> v01:
> First version for review
> 
> Background:
> This set of changes were done to coretemp driver and posted to lm_sensors
> mailing list on 04/04/2013. This was reviewed by Guenter Roeck from lm-sensors
> and Zhang Rui (thermal maintainer). They were in agreement not to add notification
> mechanism to coretemp driver but use thermal sysfs.
> Guenter Roeck suggested to use approach like "db8500_thermal driver in drivers/thermal".
> So resubmitting the driver as a thermal zone driver.
> Previous discussion link:
> http://comments.gmane.org/gmane.linux.drivers.sensors/32182
> " 
> This is clear that there is reluctance in adding thresholds in coretemp sysfs,
> during previous attempts. Probably because of lake of use cases.
> But this time use case may be more compelling.
> 
> We have many small form factor devices like ultrabooks, slate PCs in the market.
> Unfortunately these devices reach maximum temperature with relatively less
> workloads, causing BIOS to do thermal throttling. There are real performance
> issues due to aggressive BIOS action to control thermals and also thermal breakdown
> in some cases.
> 
> Even the most expensive laptops, don't have correct ACPI thermal configuration,
> so that kernel thermal driver can act. In some case even the trip point is higher
> than critical temperature setting.
> 
> Intel has developed several drivers, which can be used to cool the system very efficiently.
> They include RAPL based cooling driver, Powerclamp driver and P state driver.
> To utilize these cooling device a closed loop user mode program is required, which
> will utilize these method and dynamically compensate for high CPU temperatures,
> without relying on any configuration data.
> One such solution is developed is "Linux thermal daemon". More details can be
> obtained from 
> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf".
> This daemon polls for cpu temperature and apply compensation once the CPU reach target
> temperature. 
> 
> This polling can be mostly avoided, by getting notification for the temperature, where
> it needs to wake up and get ready for apply compensation. In most of the normal use 
> cases, there may not be any threshold events. So very minimal number of user space
> notification for thermal thresholds.
> 
> Srinivas Pandruvada (3):
>   x86, mcheck, therm_throt: Process package thresholds
>   Thermal: CPU Package temperature thermal
>   Thermal: Documentation for x86 package temperature thermal driver
> 
>  Documentation/thermal/x86_pkg_temperature_thermal |  47 ++
>  arch/x86/include/asm/mce.h                        |   7 +
>  arch/x86/kernel/cpu/mcheck/therm_throt.c          |  63 ++-
>  drivers/thermal/Kconfig                           |  12 +
>  drivers/thermal/Makefile                          |   2 +-
>  drivers/thermal/x86_pkg_temp_thermal.c            | 642 ++++++++++++++++++++++
>  6 files changed, 768 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/thermal/x86_pkg_temperature_thermal
>  create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c
> 


