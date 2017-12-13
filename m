From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: ARM: sort the Kconfig menu
Date: Wed, 13 Dec 2017 17:49:47 +0100
Message-ID: <87r2rypo7o.fsf@free-electrons.com>
References: <20171212165419.752-1-gregory.clement@free-electrons.com>
        <20171212165419.752-2-gregory.clement@free-electrons.com>
        <97091943-dcb8-47ab-0e55-831d35b1f73e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <97091943-dcb8-47ab-0e55-831d35b1f73e-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> (Randy
        Dunlap's message of "Tue, 12 Dec 2017 09:45:54 -0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider@g>
List-Id: linux-pm@vger.kernel.org

Hi Randy,
 
 On mar., déc. 12 2017, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:

> On 12/12/2017 08:54 AM, Gregory CLEMENT wrote:
>> Group all the related big LITTLE configuration together and sort the
>> other entries in alphabetic order.
>> 
>> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm | 82 ++++++++++++++++++++++-----------------------
>>  1 file changed, 41 insertions(+), 41 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index bdce4488ded1..0baf43837b51 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -2,6 +2,23 @@
>>  # ARM CPU Frequency scaling drivers
>>  #
>>  
>> +config ACPI_CPPC_CPUFREQ
>> +	tristate "CPUFreq driver based on the ACPI CPPC spec"
>> +	depends on ACPI_PROCESSOR
>> +	select ACPI_CPPC_LIB
>> +	default n
>
> Drop "default n" since that is the default default.

This lines and as weel as all you pointed was already here, I've jsute
move things. But OK why not fixing it too.

Gregory

>
>> +	help
>> +	  This adds a CPUFreq driver which uses CPPC methods
>> +	  as described in the ACPIv5.1 spec. CPPC stands for
>> +	  Collaborative Processor Performance Controls. It
>> +	  is based on an abstract continuous scale of CPU
>> +	  performance values which allows the remote power
>> +	  processor to flexibly optimize for power and
>> +	  performance. CPPC relies on power management firmware
>> +	  support for its operation.
>> +
>> +	  If in doubt, say N.
>> +
>>  # big LITTLE core layer and glue drivers
>>  config ARM_BIG_LITTLE_CPUFREQ
>>  	tristate "Generic ARM big LITTLE CPUfreq driver"
>> @@ -12,6 +29,30 @@ config ARM_BIG_LITTLE_CPUFREQ
>>  	help
>>  	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>>  
>> +config ARM_DT_BL_CPUFREQ
>> +	tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
>> +	depends on ARM_BIG_LITTLE_CPUFREQ && OF
>> +	help
>> +	  This enables probing via DT for Generic CPUfreq driver for ARM
>> +	  big.LITTLE platform. This gets frequency tables from DT.
>> +
>> +config ARM_SCPI_CPUFREQ
>> +        tristate "SCPI based CPUfreq driver"
>> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
>> +        help
>
> Fix the help and tristate lines -- use tab instead of spaces.
>
>> +	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
>> +	  using SCPI protocol for CPU power management.
>> +
>> +	  This driver uses SCPI Message Protocol driver to interact with the
>> +	  firmware providing the CPU DVFS functionality.
>> +
>> +config ARM_VEXPRESS_SPC_CPUFREQ
>> +        tristate "Versatile Express SPC based CPUfreq driver"
>> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
>> +        help
>
> Use tab instead of spaces above. Oh, and one line below.
>
>> +          This add the CPUfreq driver support for Versatile Express
>> +	  big.LITTLE platforms using SPC for power management.
>> +
>>  config ARM_BRCMSTB_AVS_CPUFREQ
>>  	tristate "Broadcom STB AVS CPUfreq driver"
>>  	depends on ARCH_BRCMSTB || COMPILE_TEST
>
>
> -- 
> ~Randy

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
