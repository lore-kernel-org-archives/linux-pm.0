From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 04/13] power: max17042_battery: Add default platform_data
 for x86 use
Date: Fri, 14 Apr 2017 19:11:51 +0200
Message-ID: <f872ad19-397d-3c69-f00e-63a1ff33932e@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-4-hdegoede@redhat.com>
 <20170414160727.bcpoven53zay42is@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdDNRLx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 13:11:53 -0400
In-Reply-To: <20170414160727.bcpoven53zay42is@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

Hi,

On 14-04-17 17:54, Krzysztof Kozlowski wrote:
 > On Fri, Apr 14, 2017 at 05:43:37PM +0200, Hans de Goede wrote:
 >> Hi,
 >>
 >> On 14-04-17 17:35, Krzysztof Kozlowski wrote:
 >>> On Fri, Apr 14, 2017 at 02:59:10PM +0200, Hans de Goede wrote:
 >>>> Some x86 machines use a max17047 fuel-gauge. X86 does not have board
 >>>> files / dt to provide platform data, so add default platform_data
 >>>> as fallback option so that the driver can work on x86.
 >>>
 >>> I am not convinced by this explanation. AFAIR, the x86 boards which use
 >>> max17042-family are providing the platform data. See commit edd4ab055931
 >>> ("power: max17042_battery: add HEALTH and TEMP_* properties support").
 >>
 >> Yes that commits adds the members to the struct max17042_platform_data,
 >> but if you grep through the mainline kernel there is no code what so
 >> ever ever filling such a struct.
 >
 > Yes, my assumption was they are coming out of tree - through Simple
 > Firmware Interface. At least that was how I understood Ramakrishna's
 > reply:
 > https://patchwork.kernel.org/patch/6326981/
 >
 > I think the commit message is a little bit non-precise here. How about
 > changing the initial sentence adding "might" ("86 might be missing platform_data if
 > not provided by SFI" or something similar).

Ok, will do for v2.

>> Since not all boards have a thermistor hooked up, set temp_min to 0 and
>> change the health checks from temp <= temp_min to temp < temp_min to
>> not trigger on such boards (where temp reads 0).
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/max17042_battery.c | 60 +++++++++++++++++++++++++++++----
>>  1 file changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>> index a51b296..85a6bf3 100644
>> --- a/drivers/power/supply/max17042_battery.c
>> +++ b/drivers/power/supply/max17042_battery.c
>> @@ -150,12 +150,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
>>  	if (ret < 0)
>>  		goto health_error;
>>
>> -	if (temp <= chip->pdata->temp_min) {
>> +	if (temp < chip->pdata->temp_min) {
>>  		*health = POWER_SUPPLY_HEALTH_COLD;
>>  		goto out;
>>  	}
>>
>> -	if (temp >= chip->pdata->temp_max) {
>> +	if (temp > chip->pdata->temp_max) {
>>  		*health = POWER_SUPPLY_HEALTH_OVERHEAT;
>>  		goto out;
>>  	}
>> @@ -772,8 +772,9 @@ static void max17042_init_worker(struct work_struct *work)
>>
>>  #ifdef CONFIG_OF
>>  static struct max17042_platform_data *
>> -max17042_get_pdata(struct device *dev)
>> +max17042_get_pdata(struct max17042_chip *chip)
>>  {
>> +	struct device *dev = &chip->client->dev;
>>  	struct device_node *np = dev->of_node;
>>  	u32 prop;
>>  	struct max17042_platform_data *pdata;
>> @@ -806,10 +807,55 @@ max17042_get_pdata(struct device *dev)
>>  	return pdata;
>>  }
>>  #else
>> +static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
>> +	/*
>> +	 * Some firmwares do not set FullSOCThr, Enable End-of-Charge Detection
>> +	 * when the voltage FG reports 95%, as recommend in the datasheet.
>> +	 */
>> +	{ MAX17047_FullSOCThr, 95 << 8 },
>
> Maybe use MAX17042_BATTERY_FULL (and replace it to 95?). If not the
> MAX17042_BATTERY_FULL can be removed in separate patch.

Ok, will do for v2.

>> +};
>> +
>>  static struct max17042_platform_data *
>> -max17042_get_pdata(struct device *dev)
>> +max17042_get_pdata(struct max17042_chip *chip)
>>  {
>> -	return dev->platform_data;
>> +	struct device *dev = &chip->client->dev;
>> +	struct max17042_platform_data *pdata;
>> +	int ret, misc_cfg;
>> +
>> +	if (dev->platform_data)
>> +		return dev->platform_data;
>> +
>> +	/*
>> +	 * The MAX17047 gets used on x86 where we've no platform data, assume
>> +	 * the firmware will already have initialized the fuel-gauge and provide
>> +	 * default values for the non init bits to make things work.
>> +	 */
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return pdata;
>> +
>> +	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042) {
>> +		pdata->init_data = max17047_default_pdata_init_regs;
>> +		pdata->num_init_data =
>> +			ARRAY_SIZE(max17047_default_pdata_init_regs);
>> +	}
>> +
>> +	ret = regmap_read(chip->regmap, MAX17042_MiscCFG, &misc_cfg);
>> +	if (ret < 0)
>> +		return NULL;
>> +
>> +	/* If bits 0-1 are set to 3 then only Voltage readings are used */
>> +	if ((misc_cfg & 0x3) == 3)
>
> Mixing 0x3 and 3 looks suspicious. How about " == 0x3"?

Ok, will do for v2.

>> +		pdata->enable_current_sense = false;
>> +	else
>> +		pdata->enable_current_sense = true;
>
> In that case you need to set the r_sns (unless
> MAX17042_DEFAULT_SNS_RESISTOR is okay for you).

The default value is ok for me / my board.

>> +
>> +	pdata->vmin = 3000;
>> +	pdata->vmax = 4500;	/* Some devices use a LiHV cell */
>> +	pdata->temp_min = 0;	/* Some devices do not have a temp sensor */
>> +	pdata->temp_max = 700;	/* 70 degrees Celcius */
>
> How about putting all of these hard-coded numbers next to
> MAX17042_DEFAULT_SNS_RESISTOR?

Ok, will also do for v2 :)

Thank you for all the reviews.

Regards,

Hans
