From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 7/7] power: bq27xxx_battery: Add interrupt handling
 support
Date: Tue, 15 Sep 2015 15:53:06 -0500
Message-ID: <55F88532.5010507@ti.com>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-8-git-send-email-afd@ti.com> <20150915184714.GB18055@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbIOUxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 16:53:35 -0400
In-Reply-To: <20150915184714.GB18055@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/15/2015 01:47 PM, Andreas Dannenberg wrote:
> On Mon, Sep 14, 2015 at 04:26:13PM -0500, Andrew F. Davis wrote:
>> Some devices have a pin that can generate an interrupt when
>> the battery's status changes. Add an interrupt handler to
>> read the new battery status.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>   drivers/power/bq27xxx_battery.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
>> index 10be8a6..29fdcd7 100644
>> --- a/drivers/power/bq27xxx_battery.c
>> +++ b/drivers/power/bq27xxx_battery.c
>> @@ -48,6 +48,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/i2c.h>
>>   #include <linux/slab.h>
>> +#include <linux/interrupt.h>
>>   #include <asm/unaligned.h>
>>
>>   #include <linux/power/bq27xxx_battery.h>
>> @@ -732,6 +733,15 @@ static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>>   	di->last_update = jiffies;
>>   }
>>
>> +static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
>> +{
>> +	struct bq27xxx_device_info *di = data;
>> +
>> +	bq27xxx_battery_update(di);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static void bq27xxx_battery_poll(struct work_struct *work)
>>   {
>>   	struct bq27xxx_device_info *di =
>> @@ -1137,6 +1147,19 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>
>>   	i2c_set_clientdata(client, di);
>>
>> +	if (client->irq) {
>> +		retval = devm_request_threaded_irq(&client->dev, client->irq,
>> +				NULL, bq27xxx_battery_irq_handler_thread,
>> +				IRQF_ONESHOT,
>> +				name, di);
>
> Hi Andrew,
> I think it'll be better if you explicitly specify the rising vs. falling
> edge interrupt flags according to exactly what the bq27xxx will trigger
> on to ensure the corresponding GPIO module is always configured properly.
>

That was how I was going to have it, but this may be device dependent, so
I decided to leave it up to the interrupt controller and set it with DT:

interrupts = <28 IRQ_TYPE_EDGE_FALLING>;

> While we are at it, was the platform-data based initialization in
> conjunction with interrupts tested?
>

The only time we initialize with platform-data is when we are wired
with HDQ, in that case this IRQ code does not get called, so nothing
changes.

Regards,
Andrew

> Regards,
>
> --
> Andreas Dannenberg
> Texas Instruments Inc
>
>
>> +		if (retval) {
>> +			dev_err(&client->dev,
>> +				"Unable to register IRQ %d error %d\n",
>> +				client->irq, retval);
>> +			return retval;
>> +		}
>> +	}
>> +
>>   	return 0;
>>
>>   batt_failed:
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
