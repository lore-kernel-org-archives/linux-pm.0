From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/7] power: supply: ab8500_fg: convert to IIO ADC
Date: Sat, 14 Jan 2017 14:58:14 +0000
Message-ID: <418086c3-94aa-9ca1-4adf-f31893a423f7@kernel.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-4-linus.walleij@linaro.org>
 <20170112030320.yozvhsu2m4lmq2vo@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20170112030320.yozvhsu2m4lmq2vo@earth>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/01/17 03:03, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jan 11, 2017 at 12:47:41AM +0100, Linus Walleij wrote:
>> This switches the AB8500 fuel gauge driver to using
>> the standard IIO ADC channel lookup and conversion routines.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-By: Sebastian Reichel <sre@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> -- Sebastian
> 
>>  drivers/power/supply/ab8500_fg.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
>> index c569f82a0071..b26122e1da51 100644
>> --- a/drivers/power/supply/ab8500_fg.c
>> +++ b/drivers/power/supply/ab8500_fg.c
>> @@ -32,7 +32,7 @@
>>  #include <linux/mfd/abx500.h>
>>  #include <linux/mfd/abx500/ab8500.h>
>>  #include <linux/mfd/abx500/ab8500-bm.h>
>> -#include <linux/mfd/abx500/ab8500-gpadc.h>
>> +#include <linux/iio/consumer.h>
>>  #include <linux/kernel.h>
>>  
>>  #define MILLI_TO_MICRO			1000
>> @@ -182,7 +182,7 @@ struct inst_curr_result_list {
>>   * @bat_cap:		Structure for battery capacity specific parameters
>>   * @avg_cap:		Average capacity filter
>>   * @parent:		Pointer to the struct ab8500
>> - * @gpadc:		Pointer to the struct gpadc
>> + * @main_bat_v:		ADC channel for the main battery voltage
>>   * @bm:           	Platform specific battery management information
>>   * @fg_psy:		Structure that holds the FG specific battery properties
>>   * @fg_wq:		Work queue for running the FG algorithm
>> @@ -224,7 +224,7 @@ struct ab8500_fg {
>>  	struct ab8500_fg_battery_capacity bat_cap;
>>  	struct ab8500_fg_avg_cap avg_cap;
>>  	struct ab8500 *parent;
>> -	struct ab8500_gpadc *gpadc;
>> +	struct iio_channel *main_bat_v;
>>  	struct abx500_bm_data *bm;
>>  	struct power_supply *fg_psy;
>>  	struct workqueue_struct *fg_wq;
>> @@ -831,13 +831,13 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
>>   */
>>  static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
>>  {
>> -	int vbat;
>> +	int vbat, ret;
>>  	static int prev;
>>  
>> -	vbat = ab8500_gpadc_convert(di->gpadc, MAIN_BAT_V);
>> -	if (vbat < 0) {
>> +	ret = iio_read_channel_processed(di->main_bat_v, &vbat);
>> +	if (ret < 0) {
>>  		dev_err(di->dev,
>> -			"%s gpadc conversion failed, using previous value\n",
>> +			"%s ADC conversion failed, using previous value\n",
>>  			__func__);
>>  		return prev;
>>  	}
>> @@ -3072,7 +3072,14 @@ static int ab8500_fg_probe(struct platform_device *pdev)
>>  	/* get parent data */
>>  	di->dev = &pdev->dev;
>>  	di->parent = dev_get_drvdata(pdev->dev.parent);
>> -	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
>> +
>> +	di->main_bat_v = devm_iio_channel_get(&pdev->dev, "main_bat_v");
>> +	if (IS_ERR(di->main_bat_v)) {
>> +		if (PTR_ERR(di->main_bat_v) == -ENODEV)
>> +                        return -EPROBE_DEFER;
>> +		dev_err(&pdev->dev, "failed to get main battery ADC channel\n");
>> +		return PTR_ERR(di->main_bat_v);
>> +	}
>>  
>>  	psy_cfg.supplied_to = supply_interface;
>>  	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
>> -- 
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

