From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/5] thermal: rockchip: Support the RV1108 SoC in thermal
 driver
Date: Fri, 15 Sep 2017 11:19:07 +0800
Message-ID: <9d7f1485-a026-2225-2913-237703a2ebcd@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-3-git-send-email-rocky.hao@rock-chips.com>
 <341e8e9b-21c7-f418-b744-8c18737cb026@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <341e8e9b-21c7-f418-b744-8c18737cb026-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

在 2017年09月15日 10:10, Caesar Wang 写道:
> Hi Rocky,
>
> 在 2017年08月24日 18:27, Rocky Hao 写道:
>> RV1108 SOC has one Temperature Sensor for CPU.
>>
>> Signed-off-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Reviewed-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

>> ---
>>   drivers/thermal/rockchip_thermal.c | 67 
>> ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c 
>> b/drivers/thermal/rockchip_thermal.c
>> index 9da3e1819210..299a8ade71fa 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -242,6 +242,45 @@ struct tsadc_table {
>>       int temp;
>>   };
>>   +static const struct tsadc_table rv1108_table[] = {
>> +    {0, -40000},
>> +    {374, -40000},
>> +    {382, -35000},
>> +    {389, -30000},
>> +    {397, -25000},
>> +    {405, -20000},
>> +    {413, -15000},
>> +    {421, -10000},
>> +    {429, -5000},
>> +    {436, 0},
>> +    {444, 5000},
>> +    {452, 10000},
>> +    {460, 15000},
>> +    {468, 20000},
>> +    {476, 25000},
>> +    {483, 30000},
>> +    {491, 35000},
>> +    {499, 40000},
>> +    {507, 45000},
>> +    {515, 50000},
>> +    {523, 55000},
>> +    {531, 60000},
>> +    {539, 65000},
>> +    {547, 70000},
>> +    {555, 75000},
>> +    {562, 80000},
>> +    {570, 85000},
>> +    {578, 90000},
>> +    {586, 95000},
>> +    {594, 100000},
>> +    {602, 105000},
>> +    {610, 110000},
>> +    {618, 115000},
>> +    {626, 120000},
>> +    {634, 125000},
>> +    {TSADCV2_DATA_MASK, 125000},
>> +};
>> +
>
> From the RV1108 TRM said,  this table was used for  the negative 
> temperature coefficient.
> But the default table is positive temperature coefficient, why?
> I think you don't need to use the negative temperature coefficient.

Sorry,  the RV1108 TRM document is old on my hand,  from the lastest 
document Rockchip RV1108 TRM V1.0 Part1-20170505.pdf said,
The RV1108 is negative temprature coefficient, so please set this bit as 
1'b1 :(

>
>>   static const struct tsadc_table rk3228_code_table[] = {
>>       {0, -40000},
>>       {588, -40000},
>> @@ -779,6 +818,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void 
>> __iomem *regs,
>>       writel_relaxed(val, regs + TSADCV2_INT_EN);
>>   }
>>   +static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>> +    .chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>> +    .chn_num = 1, /* one channel for tsadc */
>> +
>> +    .tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give 
>> PMIC */
>> +    .tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>> +    .tshut_temp = 95000,
>> +
>> +    .initialize = rk_tsadcv2_initialize,
>> +    .irq_ack = rk_tsadcv3_irq_ack,
>> +    .control = rk_tsadcv3_control,
>
> If you will use the positive temperature coefficient, we need change it.
>
> .control = rk_tsadcv2_control,
>
>
>
>> +    .get_temp = rk_tsadcv2_get_temp,
>> +    .set_alarm_temp = rk_tsadcv2_alarm_temp,
>> +    .set_tshut_temp = rk_tsadcv2_tshut_temp,
>> +    .set_tshut_mode = rk_tsadcv2_tshut_mode,
>> +
>> +    .table = {
>> +        .id = rv1108_table,
>> +        .length = ARRAY_SIZE(rv1108_table),
>> +        .data_mask = TSADCV2_DATA_MASK,
>> +        .mode = ADC_INCREMENT,
>
> Ditto
>
> -Caesar
>
>
>> +    },
>> +};
>> +
>>   static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>>       .chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>       .chn_num = 1, /* one channel for tsadc */
>> @@ -928,6 +991,10 @@ static void rk_tsadcv2_tshut_mode(int chn, void 
>> __iomem *regs,
>>     static const struct of_device_id of_rockchip_thermal_match[] = {
>>       {
>> +        .compatible = "rockchip,rv1108-tsadc",
>> +        .data = (void *)&rv1108_tsadc_data,
>> +    },
>> +    {
>>           .compatible = "rockchip,rk3228-tsadc",
>>           .data = (void *)&rk3228_tsadc_data,
>>       },
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
