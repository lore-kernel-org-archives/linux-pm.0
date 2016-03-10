From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V2 5/6] thermal: max77620: Add thermal driver for reporting
 junction temp
Date: Thu, 10 Mar 2016 12:26:24 +0530
Message-ID: <56E11A98.4000000@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com> <1457529010-6538-6-git-send-email-ldewangan@nvidia.com> <20160309192751.GB2422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160309192751.GB2422@localhost.localdomain>
Sender: linux-doc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com
List-Id: linux-pm@vger.kernel.org


On Thursday 10 March 2016 12:57 AM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>
> On Wed, Mar 09, 2016 at 06:40:09PM +0530, Laxman Dewangan wrote:
>> Maxim Semiconductor Max77620 supports alarm interrupts when
>> its die temperature crosses 120C and 140C. These threshold
>> temperatures are not configurable.
>>
>> Add thermal driver to register PMIC die temperature as thermal
>> zone sensor and capture the die temperature warning interrupts
>> to notifying the client.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>
>> ---
>> Changes from V1:
>> - checkpatch warning fix and simplifying the dev.of_node
>>    initialisation.
>>
>>   drivers/thermal/Kconfig            |  10 +++
>>   drivers/thermal/Makefile           |   1 +
>>   drivers/thermal/thermal-max77620.c | 151 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 162 insertions(+)
>>   create mode 100644 drivers/thermal/thermal-max77620.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5e7c97a..fc856eb 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -194,6 +194,16 @@ config IMX_THERMAL
>>   	  cpufreq is used as the cooling device to throttle CPUs when the
>>   	  passive trip is crossed.
>>   
>> +config MAX77620_THERMAL
>> +	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>> +	depends on MFD_MAX77620
>> +	depends on OF
> The previous question on compile test was more if we could add depends
> on COMPILE_TEST flag. Sorry if I was not clear enough.
>
>
> I am adding the flag here:
>
>   
>    config MAX77620_THERMAL
>            tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
> 	  -       depends on MFD_MAX77620
> 	  +       depends on MFD_MAX77620 || COMPILE_TEST
> 	  +       depends on HAS_IOMEM
> 	          depends on OF
> 		          help
> 			            Support for die junction temperature
> 				    warning alarm for Maxim
>
>
> but I still cannot compile test the file because of the missing header.
> drivers/thermal/thermal-max77620.c:16:32: fatal error:
> linux/mfd/max77620.h: No such file or directory
>   #include <linux/mfd/max77620.h>
>
>
> I wont be able to merge this as it is. We need to sort out the
> dependency first.
>
I will update you once the mfd patches will merge as this header is on 
that patch.

