From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/5] thermal: rockchip: Support the RK3328 SOC in thermal
 driver
Date: Fri, 11 Aug 2017 12:03:00 +0800
Message-ID: <e7f88ab7-3491-3399-5705-391eb064d2d2@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
 <1500973788-14627-3-git-send-email-rocky.hao@rock-chips.com>
 <1502420573.2598.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502420573.2598.7.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

在 2017年08月11日 11:02, Zhang Rui 写道:
> On Tue, 2017-07-25 at 17:09 +0800, Rocky Hao wrote:
>> RK3328 SOC has one Temperature Sensor for CPU.
>>
>> Change-Id: I176c76bae1801d815a513986cfefcb55272c69a8
>> Signed-off-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> Caesar,
>
> what do you think of this patch?

Have a look at the rk3328's TRM,  looks good to me.


-Caesar

>
> thanks,
> rui
>
>> ---
>>   drivers/thermal/rockchip_thermal.c | 65
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c
>> b/drivers/thermal/rockchip_thermal.c
>> index 4c7796512453..206035139110 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -320,6 +320,44 @@ struct tsadc_table {
>>   	{0, 125000},
>>   };
>>   
>> +static const struct tsadc_table rk3328_code_table[] = {
>> +	{0, -40000},
>> +	{296, -40000},
>> +	{304, -35000},
>> +	{313, -30000},
>> +	{331, -20000},
>> +	{340, -15000},
>> +	{349, -10000},
>> +	{359, -5000},
>> +	{368, 0},
>> +	{378, 5000},
>> +	{388, 10000},
>> +	{398, 15000},
>> +	{408, 20000},
>> +	{418, 25000},
>> +	{429, 30000},
>> +	{440, 35000},
>> +	{451, 40000},
>> +	{462, 45000},
>> +	{473, 50000},
>> +	{485, 55000},
>> +	{496, 60000},
>> +	{508, 65000},
>> +	{521, 70000},
>> +	{533, 75000},
>> +	{546, 80000},
>> +	{559, 85000},
>> +	{572, 90000},
>> +	{586, 95000},
>> +	{600, 100000},
>> +	{614, 105000},
>> +	{629, 110000},
>> +	{644, 115000},
>> +	{659, 120000},
>> +	{675, 125000},
>> +	{TSADCV2_DATA_MASK, 125000},
>> +};
>> +
>>   static const struct tsadc_table rk3368_code_table[] = {
>>   	{0, -40000},
>>   	{106, -40000},
>> @@ -790,6 +828,29 @@ static void rk_tsadcv2_tshut_mode(int chn, void
>> __iomem *regs,
>>   	},
>>   };
>>   
>> +static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>> +	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>> +	.chn_num = 1, /* one channels for tsadc */
>> +
>> +	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>> +	.tshut_temp = 95000,
>> +
>> +	.initialize = rk_tsadcv2_initialize,
>> +	.irq_ack = rk_tsadcv3_irq_ack,
>> +	.control = rk_tsadcv3_control,
>> +	.get_temp = rk_tsadcv2_get_temp,
>> +	.set_alarm_temp = rk_tsadcv2_alarm_temp,
>> +	.set_tshut_temp = rk_tsadcv2_tshut_temp,
>> +	.set_tshut_mode = rk_tsadcv2_tshut_mode,
>> +
>> +	.table = {
>> +		.id = rk3328_code_table,
>> +		.length = ARRAY_SIZE(rk3328_code_table),
>> +		.data_mask = TSADCV2_DATA_MASK,
>> +		.mode = ADC_INCREMENT,
>> +	},
>> +};
>> +
>>   static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>>   	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>   	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>> @@ -875,6 +936,10 @@ static void rk_tsadcv2_tshut_mode(int chn, void
>> __iomem *regs,
>>   		.data = (void *)&rk3288_tsadc_data,
>>   	},
>>   	{
>> +		.compatible = "rockchip,rk3328-tsadc",
>> +		.data = (void *)&rk3328_tsadc_data,
>> +	},
>> +	{
>>   		.compatible = "rockchip,rk3366-tsadc",
>>   		.data = (void *)&rk3366_tsadc_data,
>>   	},
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
