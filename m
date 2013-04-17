From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [patch] Thermal: cpufreq cooling: endian bug in cpufreq_get_max_state()
Date: Wed, 17 Apr 2013 12:55:22 -0400
Message-ID: <516ED3FA.4020205@ti.com>
References: <20130417071828.GD7923@elgon.mountain> <1366213553.2091.70.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab3DQQzx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 12:55:53 -0400
In-Reply-To: <1366213553.2091.70.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, eduardo.valentin@ti.com

On 17-04-2013 11:45, Zhang Rui wrote:
> On Wed, 2013-04-17 at 10:18 +0300, Dan Carpenter wrote:
>> This code doesn't work on big endian systems because we're storing low
>> values in the high bits of the unsigned long.  It makes it a very high
>> value instead.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> applied to thermal -next.

Rui,

Can you please add also my:
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Tested-by: Eduardo Valentin <eduardo.valentin@ti.com>

Tested on TI OMAP4430.


>
> thanks,
> rui
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 5f5c780..768b508 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -303,12 +303,12 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
>>   	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
>>   	struct cpumask *mask = &cpufreq_device->allowed_cpus;
>>   	unsigned int cpu;
>> -	unsigned long count = 0;
>> +	unsigned int count = 0;
>>   	int ret;
>>
>>   	cpu = cpumask_any(mask);
>>
>> -	ret = get_property(cpu, 0, (unsigned int *)&count, GET_MAXL);
>> +	ret = get_property(cpu, 0, &count, GET_MAXL);
>>
>>   	if (count > 0)
>>   		*state = count;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

