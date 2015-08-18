From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 18/21] mfd: htc-pasic3: Prepare driver for leds-pasic3
Date: Tue, 18 Aug 2015 23:01:25 +0200
Message-ID: <55D39D25.7010909@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ABC.1000405@tul.cz>
 <20150818065207.GC6180@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:36757 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbbHRU63 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Aug 2015 16:58:29 -0400
In-Reply-To: <20150818065207.GC6180@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 18.8.2015 v 08:52 Lee Jones napsal(a):
> On Tue, 18 Aug 2015, Petr Cvek wrote:
> 
>> Fix register definitions and prepare structures for new leds-pasic3
>> driver.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>> ---
>>  drivers/mfd/htc-pasic3.c       | 54 ++++++++++++++++-----------
>>  include/linux/mfd/htc-pasic3.h | 85 +++++++++++++++++++++++++++++++-----------
>>  2 files changed, 97 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
>> index e88d4f6..16e156d 100644
>> --- a/drivers/mfd/htc-pasic3.c
>> +++ b/drivers/mfd/htc-pasic3.c
>> @@ -3,6 +3,9 @@
>>   *
>>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
>>   *
>> + * 2015:	Added registers for LED and RESET, see htc-pasic3.h
>> + *		-- Petr Cvek
>> + *
> 
> This is pretty unconventional.
> 
> Please look to see what others have done.

LED support: Petr Cvek <petr.cvek@tul.cz>

OK?

>> @@ -130,6 +140,7 @@ static int __init pasic3_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct pasic3_data *asic;
>>  	struct resource *r;
>> +	struct pasic3_leds_pdata *leds_pdata;
>>  	int ret;
>>  	int irq = 0;
>>  
>> @@ -162,6 +173,8 @@ static int __init pasic3_probe(struct platform_device *pdev)
>>  	/* calculate bus shift from mem resource */
>>  	asic->bus_shift = (resource_size(r) - 5) >> 3;
>>  
>> +	spin_lock_init(&asic->lock);
>> +
>>  	if (pdata && pdata->clock_rate) {
>>  		ds1wm_pdata.clock_rate = pdata->clock_rate;
>>  		/* the first 5 PASIC3 registers control the DS1WM */
>> @@ -172,13 +185,12 @@ static int __init pasic3_probe(struct platform_device *pdev)
>>  			dev_warn(dev, "failed to register DS1WM\n");
>>  	}
>>  
>> -	if (pdata && pdata->led_pdata) {
>> -		led_cell.platform_data = pdata->led_pdata;
>> -		led_cell.pdata_size = sizeof(struct pasic3_leds_machinfo);
>> -		ret = mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
>> -				      0, NULL);
>> -		if (ret < 0)
>> -			dev_warn(dev, "failed to register LED device\n");
>> +	if (pdata && pdata->pasic3_leds) {
>> +		leds_pdata = dev_get_platdata(&pdata->pasic3_leds->dev);
> 
> Whoa!  You're passing a pointer to a device through pdata?
> 
> I don't like that at all.  Please explain.

> 
>> +		if (leds_pdata) {
>> +			leds_pdata->mfd_dev = dev;
>> +			platform_device_register(pdata->pasic3_leds);
> 
> What's the idea here?

Actually, I don't know how to do this in a clean way as pasic3_read_register() and pasic3_write_register() require device struct to pass address for accessing the registers. Only way would be to rewrite all functions which call pasic3_*_register() (removing struct device *dev and change it to struct pasic3_data *asic).

Petr
