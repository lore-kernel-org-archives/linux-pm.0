From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v2 3/5] thermal: rockchip: fixes invalid temperature case
Date: Thu, 24 Nov 2016 09:16:25 +0800
Message-ID: <7ac501cf-5bdb-4d69-4447-ab589bbcdb27@rock-chips.com>
References: <1479911374-22006-1-git-send-email-wxt@rock-chips.com>
 <1479911374-22006-4-git-send-email-wxt@rock-chips.com>
 <20161123183513.GA12380@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:52541 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbcKXBQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:16:41 -0500
In-Reply-To: <20161123183513.GA12380@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com

在 2016年11月24日 02:35, Brian Norris 写道:
> Hi Caesar,
>
> On Wed, Nov 23, 2016 at 10:29:32PM +0800, Caesar Wang wrote:
>> The temp_to_code function will return 0 when we set the temperature to a
>> invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
>> will prevent this case happening. That will return the max analog value to
>> indicate the temperature is invalid or over table temperature range.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - As Brian commnets that restructure this to pass error codes back to the
>>    upper layers.
>> - Improve the commit message.
>>
>> Changes in v1: None
>>
>>   drivers/thermal/rockchip_thermal.c | 41 ++++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index 766486f..e243e40 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -120,9 +120,9 @@ struct rockchip_tsadc_chip {
>>   	/* Per-sensor methods */
>>   	int (*get_temp)(const struct chip_tsadc_table *table,
>>   			int chn, void __iomem *reg, int *temp);
>> -	void (*set_alarm_temp)(const struct chip_tsadc_table *table,
>> +	int (*set_alarm_temp)(const struct chip_tsadc_table *table,
>>   			       int chn, void __iomem *reg, int temp);
>> -	void (*set_tshut_temp)(const struct chip_tsadc_table *table,
>> +	int (*set_tshut_temp)(const struct chip_tsadc_table *table,
>>   			       int chn, void __iomem *reg, int temp);
>>   	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
>>   
>> @@ -401,17 +401,15 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
>>   				   int temp)
>>   {
>>   	int high, low, mid;
>> -	u32 error = 0;
>> +	u32 error = table->data_mask;
>>   
>>   	low = 0;
>>   	high = table->length - 1;
>>   	mid = (high + low) / 2;
>>   
>>   	/* Return mask code data when the temp is over table range */
>> -	if (temp < table->id[low].temp || temp > table->id[high].temp) {
>> -		error = table->data_mask;
>> +	if (temp < table->id[low].temp || temp > table->id[high].temp)
>>   		goto exit;
>> -	}
>>   
>>   	while (low <= high) {
>>   		if (temp == table->id[mid].temp)
>> @@ -651,7 +649,7 @@ static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
>>   	return rk_tsadcv2_code_to_temp(table, val, temp);
>>   }
>>   
>> -static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>> +static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>>   				  int chn, void __iomem *regs, int temp)
>>   {
>>   	u32 alarm_value, int_en;
>> @@ -659,7 +657,7 @@ static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>>   	/* Make sure the value is valid */
>>   	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
>>   	if (alarm_value == table->data_mask)
>> -		return;
>> +		return -ERANGE;
>>   
>>   	writel_relaxed(alarm_value & table->data_mask,
>>   		       regs + TSADCV2_COMP_INT(chn));
>> @@ -667,9 +665,11 @@ static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>>   	int_en = readl_relaxed(regs + TSADCV2_INT_EN);
>>   	int_en |= TSADCV2_INT_SRC_EN(chn);
>>   	writel_relaxed(int_en, regs + TSADCV2_INT_EN);
>> +
>> +	return 0;
>>   }
>>   
>> -static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
>> +static int rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
>>   				  int chn, void __iomem *regs, int temp)
>>   {
>>   	u32 tshut_value, val;
>> @@ -677,13 +677,15 @@ static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
>>   	/* Make sure the value is valid */
>>   	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
>>   	if (tshut_value == table->data_mask)
>> -		return;
>> +		return -ERANGE;
>>   
>>   	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
>>   
>>   	/* TSHUT will be valid */
>>   	val = readl_relaxed(regs + TSADCV2_AUTO_CON);
>>   	writel_relaxed(val | TSADCV2_AUTO_SRC_EN(chn), regs + TSADCV2_AUTO_CON);
>> +
>> +	return 0;
>>   }
>>   
>>   static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>> @@ -882,12 +884,17 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
>>   	struct rockchip_thermal_sensor *sensor = _sensor;
>>   	struct rockchip_thermal_data *thermal = sensor->thermal;
>>   	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
>> +	int ret;
>>   
>>   	dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
>>   		__func__, sensor->id, low, high);
>>   
>> -	tsadc->set_alarm_temp(&tsadc->table,
>> +	ret = tsadc->set_alarm_temp(&tsadc->table,
>>   			      sensor->id, thermal->regs, high);
>> +	if (ret)
>> +		dev_err(&thermal->pdev->dev,
>> +			"%s: disable sensor[%d] alarm temp: %d, ret: %d\n",
> You're not necessarily disabling the sensor; you're just not programming
> it. If this is the second time setting the trip points (e.g., using
> 'echo > trip_X_temp') then this just means you've retained the old
> value.
>
> Also, I'm not sure you need to print anything here, as the thermal core
> prints errors for you. Maybe make this dev_dbg() so it doesn't print by
> default?

Yeah, the thermal core will print something, look like I just print 
"failed set the sensor*....
or return ret".
Anyway,  that's not ugly thing.

>> +			__func__, sensor->id, high, ret);
>>   
>>   	return 0;
> Oh, but you missed the whole point of returning errors; you need to
> propagate 'ret' here! i.e.:
>
> 	return ret;

Right, thanks for tracking into it.
I will wait someone feedback for this series patches before posting new 
patchset.

-Caesar
>
> Brian
>
>>   }
>> @@ -985,8 +992,12 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
>>   	int error;
>>   
>>   	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
>> -	tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
>> +
>> +	error = tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
>>   			      thermal->tshut_temp);
>> +	if (error)
>> +		dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
>> +			__func__, thermal->tshut_temp, error);
>>   
>>   	sensor->thermal = thermal;
>>   	sensor->id = id;
>> @@ -1199,9 +1210,13 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>>   
>>   		thermal->chip->set_tshut_mode(id, thermal->regs,
>>   					      thermal->tshut_mode);
>> -		thermal->chip->set_tshut_temp(&thermal->chip->table,
>> +
>> +		error = thermal->chip->set_tshut_temp(&thermal->chip->table,
>>   					      id, thermal->regs,
>>   					      thermal->tshut_temp);
>> +		if (error)
>> +			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
>> +				__func__, thermal->tshut_temp, error);
>>   	}
>>   
>>   	thermal->chip->control(thermal->regs, true);
>> -- 
>> 2.7.4
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


