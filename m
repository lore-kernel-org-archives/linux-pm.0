From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/2] staging: ti-soc-thermal: remove external heat while
 extrapolating hotspot
Date: Mon, 25 Mar 2013 07:18:36 -0400
Message-ID: <5150328C.80303@ti.com>
References: <1363986787-28147-1-git-send-email-eduardo.valentin@ti.com>  <1363986787-28147-3-git-send-email-eduardo.valentin@ti.com> <1364192605.2465.18.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364192605.2465.18.camel@rzhang1-mobl4>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25-03-2013 02:23, Zhang Rui wrote:
> On Fri, 2013-03-22 at 17:13 -0400, Eduardo Valentin wrote:
>> For boards that provide a PCB sensor close to SoC junction
>> temperature, it is possible to remove the cumulative heat
>> reported by the SoC temperature sensor.
>>
>> This patch changes the extrapolation computation to consider
>> an external sensor in the extrapolation equations.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>   drivers/staging/ti-soc-thermal/ti-thermal-common.c |    5 ++---
>>   1 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/ti-soc-thermal/ti-thermal-common.c b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
>> index 231c549..52d3c1b 100644
>> --- a/drivers/staging/ti-soc-thermal/ti-thermal-common.c
>> +++ b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
>> @@ -92,10 +92,9 @@ static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
>>   	if (ret)
>>   		return ret;
>>
>> -	pcb_temp = 0;
>> -	/* TODO: Introduce pcb temperature lookup */
>> +	ret = thermal_zone_lookup_temperature("pcb", &pcb_temp);
>>   	/* In case pcb zone is available, use the extrapolation rule with it */
>> -	if (pcb_temp) {
>> +	if (!ret) {
>>   		tmp -= pcb_temp;
>>   		slope = s->slope_pcb;
>>   		constant = s->constant_pcb;
>
> I can not see this piece of code.
> But I assume that the thermal_zone_device is registered in another
> driver, right?

It is because I made this patch based on staging-next. But you will find 
the same under drivers/stating/omap-thermal/omap-bandgap.c


Yes. The sensor managed by another driver. And the temperature lookup is 
assumed to be done by the fw.

> or else you can use the thermal_zone_device pointer directly instead.
>

I'd not recommend this because of the above statements

> thanks,
> rui
>
>
>
