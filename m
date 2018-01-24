From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Wed, 24 Jan 2018 17:59:09 +0100
Message-ID: <02e80d2c-3672-f7e2-dfb2-aed3efc84759@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180124163441.7sqq7qny66d6sqrz@oak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33182 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934315AbeAXQ7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jan 2018 11:59:13 -0500
Received: by mail-wr0-f194.google.com with SMTP id s5so3430979wra.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2018 08:59:13 -0800 (PST)
In-Reply-To: <20180124163441.7sqq7qny66d6sqrz@oak.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On 24/01/2018 17:34, Daniel Thompson wrote:
> On Tue, Jan 23, 2018 at 04:34:27PM +0100, Daniel Lezcano wrote:
>> The next changes will add new way to cool down a CPU. In order to
>> sanitize and make the overall cpu cooling code consistent and robust
>> we must prevent the cpu cooling devices to co-exists with the same
>> purpose at the same time in the kernel.
>>
>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>> cooling strategy can be chosen.
> 
> I puzzled by the role of Kconfig here.
> 
> IIUC a distro kernel will always be forced to select the combo strategy 
> otherwise it will never be able to cool systems that don't have cpufreq
> (I hope the combo strategy treats such system as a special case with
> only one OPP).

Actually it does not make sense to select the combo if there is no
cpufreq support. The cpuidle cooling device must be used instead.

> This raises the question what the other options (cpufreq-only
> idle-injection-only) are for? Are they just for petrol heads who want to
> save a few bytes of code or is idle-injection undesirable for some
> users.

The combo cooling device must be used on a system with a proper support
for cpuidle and cpufreq and with the power numbers specified in the DT.

By proper support of cpuidle, I mean a cluster power down idle state,
fast enough. This idle state allows to drop the dynamic power *and* the
static leakage (the latter to prevent a thermal runaway).

If the system does not have power numbers, no (or bad) cpuidle, the
combo cooling device must not be used. If there is no cpufreq support,
the cpuidle cooling must be used and if there is no proper support for
both, the CPU cooling can't be used. In this case, you have to put a fan
on your board or reduce the frequency where the system stays in its
thermal envelope.

> If the later, how can a distro kernel mitigate the undesired effects
> whilst still selecting the combo strategy.

I'm not sure to understand the question. Distros always use the make
allmodconfig, so that chooses the cpufreq CPU cooling device which was
the case before without this change.

However, we are talking about distros here but the CPU cooling mechanism
is for mobile and in this case the kernel (usually Android based) comes
with a specific configuration file and this is where the SoC vendor has
to choose the right strategy.


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 315ae29..925e73b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
>>  	  allocating and limiting power to devices.
>>  
>>  config CPU_THERMAL
>> -	bool "generic cpu cooling support"
>> -	depends on CPU_FREQ
>> +	bool "Generic cpu cooling support"
>>  	depends on THERMAL_OF
>>  	help
>> +	  Enable the CPU cooling features. If the system has no active
>> +	  cooling device available, this option allows to use the CPU
>> +	  as a cooling device.
>> +
>> +choice
>> +	prompt "CPU cooling strategies"
>> +	depends on CPU_THERMAL
>> +	default CPU_FREQ_THERMAL
>> +	help
>> +	  Select the CPU cooling strategy.
>> +
>> +config CPU_FREQ_THERMAL
>> +        bool "CPU frequency cooling strategy"
>> +	depends on CPU_FREQ
>> +	help
>>  	  This implements the generic cpu cooling mechanism through frequency
>>  	  reduction. An ACPI version of this already exists
>>  	  (drivers/acpi/processor_thermal.c).
>>  	  This will be useful for platforms using the generic thermal interface
>>  	  and not the ACPI interface.
>>  
>> -	  If you want this support, you should say Y here.
> 
> ... this may not be great advice... if you think you want this support
> then you *probably* actually want the comboappears to be terrible advice.
> 
> This cooling strategies should only be selected by petrolheads making a 
> device specific *and* are obsessive about code size.
> 
> The 
>> +endchoice
>>  
>>  config CLOCK_THERMAL
>>  	bool "Generic clock cooling support"
>> -- 
>> 2.7.4
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
