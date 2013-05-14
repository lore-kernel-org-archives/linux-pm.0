From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/2] CPU Package temperarure thermal driver
Date: Tue, 14 May 2013 08:12:04 -0700
Message-ID: <51925444.9010902@linux.intel.com>
References: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com> <51913A47.9080206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64819 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757932Ab3ENPHk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 May 2013 11:07:40 -0400
In-Reply-To: <51913A47.9080206@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org

Hi Valentin,

Thanks for the review.

On 05/13/2013 12:08 PM, Eduardo Valentin wrote:
> On 07-05-2013 14:57, Srinivas Pandruvada wrote:
>> This driver register CPU digital temperature package level sensor as a
>> thermal zone with two user mode configurable trip points. Once
>> the trip point is violated, user mode can receive notification via thermal
>> notification mechanism and can take any action to control temperature.
>
> So, you have an IRQ that will be translated into a thermal event to
> userland. Userland takes care of cooling the device. Is that correct?
<Yes.>
>> Background:
>> This set of changes were done to coretemp driver and posted to lm_sensors
>> mailing list on 04/04/2013. This was reviewed by Guenter Roeck from lm-sensors
>> and Zhang Rui (thermal maintainer). They were in agreement not to add notification
>> mechanism to coretemp driver but use thermal sysfs.
>> Guenter Roeck suggested to use approach like "db8500_thermal driver in drivers/thermal".
>> So resubmitting the driver as a thermal zone driver.
>> Previous discussion link:
>> http://comments.gmane.org/gmane.linux.drivers.sensors/32182
>> "
>> This is clear that there is reluctance in adding thresholds in coretemp sysfs,
>> during previous attempts. Probably because of lake of use cases.
>> But this time use case may be more compelling.
>>
>> We have many small form factor devices like ultrabooks, slate PCs in the market.
>> Unfortunately these devices reach maximum temperature with relatively less
>> workloads, causing BIOS to do thermal throttling. There are real performance
>> issues due to aggressive BIOS action to control thermals and also thermal breakdown
>> in some cases.
>>
>> Even the most expensive laptops, don't have correct ACPI thermal configuration,
>> so that kernel thermal driver can act. In some case even the trip point is higher
>> than critical temperature setting.
>>
> So, this driver is meant for ACPI capable systems, but with incorrect
> ACPI thermal configuration. Is my understanding correct? Does it apply
> to other types of systems?
>
> <This doesn't limit usage in non ACPI acpi systems. This is one of the problem scenerio. >
>
>> Intel has developed several drivers, which can be used to cool the system very efficiently.
>> They include RAPL based cooling driver, Powerclamp driver and P state driver.
>> To utilize these cooling device a closed loop user mode program is required, which
>> will utilize these method and dynamically compensate for high CPU temperatures,
>> without relying on any configuration data.
>> One such solution is developed is "Linux thermal daemon". More details can be
>> obtained from
>> "https://github.com/01org/thermal_daemon/blob/master/ThermalDaemon_Introduction.pdf".
>> This daemon polls for cpu temperature and apply compensation once the CPU reach target
>> temperature.
>>
>> This polling can be mostly avoided, by getting notification for the temperature, where
>> it needs to wake up and get ready for apply compensation. In most of the normal use
>> cases, there may not be any threshold events. So very minimal number of user space
>> notification for thermal thresholds.
>> "
>>
> IMO, interrupt based TDM can be extended to non ACPI systems in most
> cases. This is based on the fact that most temperature sensors for
> embedded systems provide int high/low thresholds for triggering IRQs.
> Not only Bandgaps but also I2C devices. Thus, avoiding polling is a
> common target.
>
> If the design can be generalized enough to cope with improving the
> framework, I believe is a better way to go.
>
<Basically we need some interface to: Get/Set thresholds, notifications 
mechanism from client drivers.
If these are provided, this can be generalized. So there can be common 
notification driver and client drivers using this interface. You already 
have a thermal framework. This will add another level.
Rui and Durga may have more thoughts in expanding thermal APIs. >
>> Srinivas Pandruvada (2):
>>    x86, mcheck, therm_throt: Process package thresholds
>>    Thermal: CPU Package temperature thermal
>>
>>   arch/x86/include/asm/mce.h               |   7 +
>>   arch/x86/kernel/cpu/mcheck/therm_throt.c |  63 ++-
>>   drivers/thermal/Kconfig                  |  12 +
>>   drivers/thermal/Makefile                 |   2 +-
>>   drivers/thermal/x86_pkg_temp_thermal.c   | 633 +++++++++++++++++++++++++++++++
>>   5 files changed, 712 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c
>>
>

