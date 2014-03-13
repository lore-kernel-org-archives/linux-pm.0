From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/4] devfreq: exynos4: Support devicetree to get device id
 of Exynos4 SoC
Date: Thu, 13 Mar 2014 11:16:18 +0900
Message-ID: <532114F2.7050405@samsung.com>
References: <1394624882-2989-1-git-send-email-cw00.choi@samsung.com>
 <1394624882-2989-2-git-send-email-cw00.choi@samsung.com>
 <1794344.yC40yetU2h@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57229 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbaCMCQU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 22:16:20 -0400
In-reply-to: <1794344.yC40yetU2h@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org

Hi Batlomiej,

On 03/12/2014 11:37 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On Wednesday, March 12, 2014 08:47:59 PM Chanwoo Choi wrote:
>> This patch support DT(DeviceTree) method to probe exynos4_bus and get device
>> id of each Exynos4 SoC by using dt helper function.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/exynos/exynos4_bus.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
>> index e07b0c6..168a7c6 100644
>> --- a/drivers/devfreq/exynos/exynos4_bus.c
>> +++ b/drivers/devfreq/exynos/exynos4_bus.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/devfreq.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/of.h>
>>  #include <linux/module.h>
>>  
>>  /* Exynos4 ASV has been in the mailing list, but not upstreamed, yet. */
>> @@ -1017,6 +1018,28 @@ unlock:
>>  	return NOTIFY_DONE;
>>  }
>>  
>> +static struct of_device_id exynos4_busfreq_id_match[] = {
>> +	{
>> +		.compatible = "samsung,exynos4210-busfreq",
>> +		.data = (void *)TYPE_BUSF_EXYNOS4210,
>> +	}, {
>> +		.compatible = "samsung,exynos4x12-busfreq",
>> +		.data = (void *)TYPE_BUSF_EXYNOS4x12,
>> +	},
>> +};
>> +
>> +static int exynos4_busfreq_get_driver_data(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_node(exynos4_busfreq_id_match, dev->of_node);
>> +	if (!match)
>> +		return -ENODEV;
>> +
>> +	return (int) match->data;
>> +}
>> +
>>  static int exynos4_busfreq_probe(struct platform_device *pdev)
>>  {
>>  	struct busfreq_data *data;
>> @@ -1030,7 +1053,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	data->type = pdev->id_entry->driver_data;
>> +	data->type = exynos4_busfreq_get_driver_data(pdev);
>>  	data->dmc[0].hw_base = S5P_VA_DMC0;
>>  	data->dmc[1].hw_base = S5P_VA_DMC1;
>>  	data->pm_notifier.notifier_call = exynos4_busfreq_pm_notifier_event;
>> @@ -1135,6 +1158,7 @@ static struct platform_driver exynos4_busfreq_driver = {
>>  		.name	= "exynos4-busfreq",
>>  		.owner	= THIS_MODULE,
>>  		.pm	= &exynos4_busfreq_pm,
>> +		.of_match_table = exynos4_busfreq_id_match,
>>  	},
>>  };
> 
> It looks OK but it would be good to also add bindings documentation file,
> i.e. Documentation/devicetree/bindings/devfreq/exynos4_bus.txt.

OK I'll add documentation for exynos4_bus.c

Best Regards,
Chanwoo Choi

