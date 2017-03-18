From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [07/15] power: supply: bq24190_charger: Add support for
 bq24192[i]
Date: Sat, 18 Mar 2017 15:30:02 +0100
Message-ID: <d670369f-4f0c-2658-e6e2-4c6e4604f987@redhat.com>
References: <20170318071019.4561-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdCROaG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Mar 2017 10:30:06 -0400
In-Reply-To: <20170318071019.4561-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi,

On 18-03-17 08:10, Liam Breck wrote:
> On Fri, 17 Mar 2017 10:55:19 +0100, Hans de Goede wrote:
>
>> The bq24192 and bq24192i are mostly identical to the bq24190, TI even
>> published a single datasheet for all 3 of them. The difference
>> between the bq24190 and bq24192[i] is the way charger-type detection
>> is done, the bq24190 is to be directly connected to the USB a/b lines,
>> where as the the bq24192[i] has a gpio which should be driven high/low
>> externally depending on the type of charger connected, from a register
>> level access pov there is no difference.
>>
>> The differences between the bq24192 and bq24192i are:
>> 1) Lower default charge rate on the bq24192i
>> 2) Pre-charge-current can be max 640 mA on the bq24192i
>>
>> Since we do not provide an API for setting the pre-charge-current,
>> these differences can be ignored and we can simply use the existing
>> code as-is with the bq24192 and bq24192i.
>
> FYI, coming patchset will set pre- and termination-charge current via DT.

Ok, note that this again is something which we cannot do on x86,
so we need to retain the BIOS set values there. I assume this will
not be a problem since you will need to keep the driver working
with device-trees which do not specify this info, for compatibility
with existing devicetrees.


>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index 9c4b171..9014dee 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1275,7 +1275,14 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>  	if (ret < 0)
>>  		goto out;
>>
>> -	if (v != bdi->model) {
>> +	switch (v) {
>> +	case BQ24190_REG_VPRS_PN_24190:
>> +	case BQ24190_REG_VPRS_PN_24192:
>> +	case BQ24190_REG_VPRS_PN_24192I:
>> +		bdi->model = v;
>
> We should set model in probe(). Doesn't the previous code still work?

On x86 we know we have a variant but not which variant, since the
driver supports all variants we can simply make the driver flexible
enough to handle all variants and be done with it.

>
>> +		break;
>> +	default:
>> +		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
>
> Feel free to add the error msg.
>
>>  		ret = -ENODEV;
>>  		goto out;
>>  	}
>> @@ -1316,7 +1323,6 @@ static int bq24190_probe(struct i2c_client *client,
>>
>>  	bdi->client = client;
>>  	bdi->dev = dev;
>> -	bdi->model = id->driver_data;
>
> Is driver_data no longer always correct?

See above, I was actually planning on dropping the
setting of driver_data from the ids tables, but I forgot.

>
>>  	bdi->pdata = client->dev.platform_data;
>>  	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
>>  	mutex_init(&bdi->f_reg_lock);
>> @@ -1450,6 +1456,8 @@ static SIMPLE_DEV_PM_OPS(bq24190_pm_ops, bq24190_pm_suspend, bq24190_pm_resume);
>>   */
>>  static const struct i2c_device_id bq24190_i2c_ids[] = {
>>  	{ "bq24190", BQ24190_REG_VPRS_PN_24190 },
>> +	{ "bq24192", BQ24190_REG_VPRS_PN_24192 },
>> +	{ "bq24192i", BQ24190_REG_VPRS_PN_24192I },
>
> This may be the only essential change.

See above, actually this should have been:

static const struct i2c_device_id bq24190_i2c_ids[] = {
  	{ "bq24190" },
	{ "bq24192" },
	{ "bq24192i" },
	{ },
};

Or (also works for me): just:

static const struct i2c_device_id bq24190_i2c_ids[] = {
  	{ "bq24190" },
	{ },	
};

And use the same compatible for all variants as they are
all compatible anyways.

Regards,

Hans
