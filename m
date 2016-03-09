From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 3/3] thermal: max77620: Add thermal driver for reporting
 junction temp
Date: Wed, 9 Mar 2016 18:04:43 +0530
Message-ID: <56E01863.8080006@nvidia.com>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com> <1457098810-11964-4-git-send-email-ldewangan@nvidia.com> <20160308212455.GA8820@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16785 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbcCIMrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 07:47:41 -0500
In-Reply-To: <20160308212455.GA8820@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, corbet@lwn.net, rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


On Wednesday 09 March 2016 02:54 AM, Eduardo Valentin wrote:
>

> On Fri, Mar 04, 2016 at 07:10:10PM +0530, Laxman Dewangan wrote:
>> Maxim Semiconductor Max77620 supports alarm interrupts when
>> its die temperature crosses 120C and 140C. These threshold
>> temperatures are not configurable.
>>
>> Add thermal driver to register PMIC die temperature as thermal
>> zone sensor and capture the die temperature warning interrupts
>> to notifying the client.
> Are any of these critical?

Datasheet says that two alarm interrupt at 120 and 140degC. 165 degC is 
shutdown temp on which PMIC get shutdown.
So just says as the warning interrupt.


>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>>   drivers/thermal/Kconfig            |   9 +++
>>   drivers/thermal/Makefile           |   1 +
>>   drivers/thermal/thermal-max77620.c | 151 +++++++++++++++++++++++++++++++++++++
> Given that it is a DT based driver, please add also a binding entry
> under Documentation/devicetree/bindings/thermal/

There is no new DT property and so did not added. But will add the doc 
saying the mandatory properties from thermal framework i.e. 
#thermal-sensor-cells

>
> +	depends on MFD_MAX77620
> Can this be COMPILE_TEST'ed?

Yes, I compile and tested .

>> +	depends on OF
>> +	help
>> +	  Support for die junction temperature warning alarm for Maxim
>> +	  Semiconductor PMIC MAX77620 device. Device generates alert
>> +	  signal/interrupt when die temperature cross its threshold.
>> +
> Somehow checkpatch.pl --strict is complaining about this entry. Can you
> please check?

The help should be minimum 4 lines otherwise warning is generated. I 
made it for next patch.

Second warning is:
/**
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#57:
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 174 lines checked

0001-thermal-max77620-Add-thermal-driver-for-reporting-ju.patch has 
style problems, please review.
**/

This is because new file get added and I think we can ignore it.

>> +	if (val & MAX77620_IRQ_TJALRM2_MASK)
>> +		*temp = MAX77620_TJALARM2_TEMP;
>> +	else if (val & MAX77620_IRQ_TJALRM1_MASK)
>> +		*temp = MAX77620_TJALARM1_TEMP;
>> +	else
>> +		*temp = MAX77620_NORMAL_OPERATING_TEMP;
> So, no way at all to get a temp?

yaah, there is no way other than getting the bit for whether temp 
crossed threshold or not.

>
>> +
>> +	if (!pdev->dev.of_node)
>> +		pdev->dev.of_node = pdev->dev.parent->of_node;
> Why is this needed?

This driver is sub mfd devices and it is registered without device node 
pointer.
The DT binding doc for the mfdmax77620 is flat, does not have thermal 
sub node.

hence to get the of_node for sensor, I am making the device node as node 
pointer for thermal sensor.
I can overwrite as
  pdev->dev.of_node = pdev->dev.parent->of_node also without check for 
simplification.



