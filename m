From: Michael Heinemann <posted@heine.so>
Subject: Re: [PATCH 4/4] power: supply: sbs-battery: Don't reset mode in
 get_battery_capacity
Date: Tue, 11 Jul 2017 12:03:08 +0200
Message-ID: <ce7b3d0c2ac49c6d654402881c05d90e@heine.so>
References: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
 <1499667800-69055-5-git-send-email-preid@electromag.com.au>
 <f27e0672-fbc5-dd9d-c9dd-1bfbfed8272a@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:35370 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755827AbdGKKDM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 06:03:12 -0400
In-Reply-To: <f27e0672-fbc5-dd9d-c9dd-1bfbfed8272a@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: sre@kernel.org, linux-pm@vger.kernel.org

On 2017-07-11 06:57, Phil Reid wrote:
> On 10/07/2017 14:23, Phil Reid wrote:
>> There seems little point in resetting the capacity mode bit when
>> reading a capacity register that is affected by this bit. The
>> next call to the register read will set the bit if it's not in
>> the correct mode.
>> 
> 
> Thinking about this a bit more and I don't think this is a good idea.
> Reading the spec again I'm guessing the runtime till empty calcs will
> be different based on this mode bit.
> 
> ie:
> in uW mode, the spec is making an assumption of constant power, ie
> Switch Mode regulator load.
> in mA mode, the spec is make an assumption of constant current, ie
> linear regulator load
> 
> What it probably needs is a mode selection option and set that at
> probe or when a battery is detected.
> 
> I'm not sure what impact changing the mode has to data calcs that uses
> averaging.
> 
> Please drop this patch for now.
> 

I agree that changing the mode implictly might lead to trouble. So
getting back to the initial mode might be wise to do.

I applied your patches (without Patch 4/4) and made the following
observation:

Coming fresh from the charger the battery is in Amps mode.
But sometimes it is suddenly in Watts mode. I guess switching the
mode back failed at some point.
So maybe it would make sense to define a default mode to which it is
always set back. This might also be configurable (devicetree?). But
for a Battery I guess Amps should be the default Mode.

(Actually it confused me intially that WATTS mode is handled as the
default from code perspective.)

> 
> 
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>   drivers/power/supply/sbs-battery.c | 31 
>> ++++++++++++-------------------
>>   1 file changed, 12 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/power/supply/sbs-battery.c 
>> b/drivers/power/supply/sbs-battery.c
>> index 3473b45..441a576 100644
>> --- a/drivers/power/supply/sbs-battery.c
>> +++ b/drivers/power/supply/sbs-battery.c
>> @@ -491,22 +491,19 @@ static void  sbs_unit_adjustment(struct 
>> i2c_client *client,
>>   	}
>>   }
>>   -static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client 
>> *client,
>> +static int sbs_set_battery_mode(struct i2c_client *client,
>>   	enum sbs_battery_mode mode)
>>   {
>> -	int ret, original_val;
>> +	int ret;
>>   -	original_val = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
>> -	if (original_val < 0)
>> -		return original_val;
>> +	ret = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
>> +	if (ret < 0)
>> +		return ret;
>>   -	if ((original_val & BATTERY_MODE_MASK) == mode)
>> -		return mode;
>> +	if ((ret & BATTERY_MODE_MASK) == mode)
>> +		return 0;
>>   -	if (mode == BATTERY_MODE_AMPS)
>> -		ret = original_val & ~BATTERY_MODE_MASK;
>> -	else
>> -		ret = original_val | BATTERY_MODE_MASK;
>> +	ret = (ret & ~BATTERY_MODE_MASK) | mode;
>>     	ret = sbs_write_word_data(client, BATTERY_MODE_OFFSET, ret);
>>   	if (ret < 0)
>> @@ -514,7 +511,7 @@ static enum sbs_battery_mode 
>> sbs_set_battery_mode(struct i2c_client *client,
>>     	usleep_range(1000, 2000);
>>   -	return original_val & BATTERY_MODE_MASK;
>> +	return 0;
>>   }
>>     static int sbs_get_battery_capacity(struct i2c_client *client,
>> @@ -527,9 +524,9 @@ static int sbs_get_battery_capacity(struct 
>> i2c_client *client,
>>   	if (power_supply_is_amp_property(psp))
>>   		mode = BATTERY_MODE_AMPS;
>>   -	mode = sbs_set_battery_mode(client, mode);
>> -	if (mode < 0)
>> -		return mode;
>> +	ret = sbs_set_battery_mode(client, mode);
>> +	if (ret < 0)
>> +		return ret;
>>     	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
>>   	if (ret < 0)
>> @@ -542,10 +539,6 @@ static int sbs_get_battery_capacity(struct 
>> i2c_client *client,
>>   	} else
>>   		val->intval = ret;
>>   -	ret = sbs_set_battery_mode(client, mode);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>   	return 0;
>>   }
>> 

Regards,
Michael
