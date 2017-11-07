From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH] thermal: imx: use cpufreq cooling of registration method
Date: Tue, 7 Nov 2017 11:26:13 +0100
Message-ID: <9b2075d7-55bb-935c-9a3d-f90515c4d5b7@pengutronix.de>
References: <20171103164203.5805-1-bst@pengutronix.de>
 <20171106015733.GA2525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44003 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965097AbdKGK0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 05:26:16 -0500
In-Reply-To: <20171106015733.GA2525@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org

Hi Eduardo,

On 11/06/2017 02:57 AM, Eduardo Valentin wrote:
> On Fri, Nov 03, 2017 at 05:42:03PM +0100, Bastian Stender wrote:
>> The of variant of cpufreq_cooling_register links the cooling device to
>> the device tree node provided.
>>
>> This makes it possible to bind the cpufreq cooling device to a custom
>> thermal zone via a cooling-maps entry like:
>>
>> 	cooling-maps {
>> 		map0 {
>> 			trip = <&board_alert>;
>> 			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> 		};
>> 	};
>>
>> Assuming a cpu node exists with label "cpu0" and #cooling-cells
>> property.
>>
>> Signed-off-by: Bastian Stender <bst@pengutronix.de>
>> ---
>>   drivers/thermal/imx_thermal.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>> index 4798b4b1fd77..de71cd3bb03a 100644
>> --- a/drivers/thermal/imx_thermal.c
>> +++ b/drivers/thermal/imx_thermal.c
>> @@ -473,6 +473,8 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>>   
>>   static int imx_thermal_probe(struct platform_device *pdev)
>>   {
>> +	struct device_node *np;
>> +	struct device *cpu_dev;
>>   	struct imx_thermal_data *data;
>>   	struct regmap *map;
>>   	int measure_freq;
>> @@ -533,7 +535,19 @@ static int imx_thermal_probe(struct platform_device *pdev)
>>   		return -EPROBE_DEFER;
>>   	}
>>   
>> -	data->cdev = cpufreq_cooling_register(data->policy);
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev) {
>> +		pr_err("%s: failed to get cpu0 device\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	np = of_node_get(cpu_dev->of_node);
>> +	if (!np) {
>> +		dev_err(cpu_dev, "failed to find cpu0 node\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	data->cdev = of_cpufreq_cooling_register(np, data->policy);
> 
> This would actually be better suited if added to IMX cpufreq driver 
> instead. Any reason to attempt to add to the thermal driver?

Yes, you are right. Leaving the cooling device in imx_thermal.c was just
the path of least resistance. I will have a look in moving the cooling
device to the IMX cpufreq driver.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
