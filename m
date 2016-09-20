From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 1/1] power: supply: sbs-battery: Cleanup removal of
 chip->pdata
Date: Tue, 20 Sep 2016 08:29:30 +0800
Message-ID: <72d65c63-7804-c203-1520-2ad35b21e339@electromag.com.au>
References: <1474278372-38077-1-git-send-email-preid@electromag.com.au>
 <20160919184731.uuba5vkwv4xf3vxs@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:59550 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbcITA3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 20:29:36 -0400
In-Reply-To: <20160919184731.uuba5vkwv4xf3vxs@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

G'day Sebastian,

On 20/09/2016 02:47, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Sep 19, 2016 at 05:46:12PM +0800, Phil Reid wrote:
>> There where still a few lingering references to pdata after commit
>> power: supply: sbs-battery: simplify DT parsing.
>>
>> Remove pdata from struct·sbs_info and conditional checks to ser if this
>> was set from the i2c read / write functions.
>> Instead of call max in each function for incrementing poll_retry_count
>> do it once in the probe function.
>> Fixup null pointer dereference in to pdata in sbs_external_power_changed.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  drivers/power/supply/sbs-battery.c | 18 +++++++-----------
>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
>> index 248a5dd..3ffa0ec 100644
>> --- a/drivers/power/supply/sbs-battery.c
>> +++ b/drivers/power/supply/sbs-battery.c
>> @@ -163,7 +163,6 @@ static enum power_supply_property sbs_properties[] = {
>>  struct sbs_info {
>>  	struct i2c_client		*client;
>>  	struct power_supply		*power_supply;
>> -	struct sbs_platform_data	*pdata;
>>  	bool				is_present;
>>  	struct gpio_desc		*gpio_detect;
>>  	bool				enable_detection;
>> @@ -185,8 +184,7 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
>>  	s32 ret = 0;
>>  	int retries = 1;
>>
>> -	if (chip->pdata)
>> -		retries = max(chip->i2c_retry_count + 1, 1);
>> +	retries = chip->i2c_retry_count + 1;
>
> Why + 1? This should already be done in probe().
Yeap my mistake.

>
>>  	while (retries > 0) {
>>  		ret = i2c_smbus_read_word_data(client, address);
>> @@ -213,10 +211,8 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
>>  	int retries_length = 1, retries_block = 1;
>>  	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
>>
>> -	if (chip->pdata) {
>> -		retries_length = max(chip->i2c_retry_count + 1, 1);
>> -		retries_block = max(chip->i2c_retry_count + 1, 1);
>> -	}
>> +	retries_length = chip->i2c_retry_count;
>> +	retries_block = chip->i2c_retry_count;
>>
>>  	/* Adapter needs to support these two functions */
>>  	if (!i2c_check_functionality(client->adapter,
>> @@ -280,8 +276,7 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
>>  	s32 ret = 0;
>>  	int retries = 1;
>>
>> -	if (chip->pdata)
>> -		retries = max(chip->i2c_retry_count + 1, 1);
>> +	retries = max(chip->i2c_retry_count + 1, 1);
>
> Here we should be able to drop max() and +1, too.
>
>>  	while (retries > 0) {
>>  		ret = i2c_smbus_write_word_data(client, address,
>> @@ -707,7 +702,7 @@ static void sbs_external_power_changed(struct power_supply *psy)
>>  	cancel_delayed_work_sync(&chip->work);
>>
>>  	schedule_delayed_work(&chip->work, HZ);
>> -	chip->poll_time = chip->pdata->poll_retry_count;
>> +	chip->poll_time = chip->poll_retry_count;
>>  }
>>
>>  static void sbs_delayed_work(struct work_struct *work)
>> @@ -791,7 +786,7 @@ static int sbs_probe(struct i2c_client *client,
>>  	rc = of_property_read_u32(client->dev.of_node, "sbs,i2c-retry-count",
>>  				  &chip->i2c_retry_count);
>>  	if (rc)
>> -		chip->i2c_retry_count = 1;
>> +		chip->i2c_retry_count = 0;
>
> I think 0 was correct, since you do a + 1 later.
>
>>  	rc = of_property_read_u32(client->dev.of_node, "sbs,poll-retry-count",
>>  				  &chip->poll_retry_count);
>> @@ -802,6 +797,7 @@ static int sbs_probe(struct i2c_client *client,
>>  		chip->poll_retry_count = pdata->poll_retry_count;
>>  		chip->i2c_retry_count  = pdata->i2c_retry_count;
>>  	}
>> +	chip->i2c_retry_count = max(chip->i2c_retry_count + 1, 1);
>>
>>  	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
>>  			"sbs,battery-detect", GPIOD_IN);
>
> I still think we should make i2c_retry_count and poll_retry_count
> unsigned and skip the max() part completely.
>
Will do.



-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
