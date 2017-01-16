From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 1/6] power: bq24190_charger: Fix irq trigger to IRQF_TRIGGER_FALLING
Date: Mon, 16 Jan 2017 12:20:41 -0800
Message-ID: <CAKvHMgS7rNrz6N+t-8-=KOfeeXu=p83c3XGer7Z-+nHPFmmWKQ@mail.gmail.com>
References: <CAKvHMgRHAJ8LAbpTByaYS1ECHK_gtT1ZH=Vs7umr_003ENEG7Q@mail.gmail.com>
 <20170116174410.GB27262@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35540 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPUUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 15:20:42 -0500
Received: by mail-it0-f68.google.com with SMTP id 203so13418192ith.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 12:20:42 -0800 (PST)
In-Reply-To: <20170116174410.GB27262@animalcreek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Jan 16, 2017 at 9:44 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> On Sun, Jan 15, 2017 at 10:06:16PM -0800, Liam Breck wrote:
>>
>
>> The interrupt signal is TRIGGER_FALLING. This is is specified in the
>> data sheet PIN FUNCTIONS: "The INT pin sends active low, 256us
>> pulse to host to report charger device status and fault."
>>
>> Also the direction can be seen in the data sheet Figure 1 "BQ24190
>                                                           ^
>> with D+/D- Detection and USB On-The-Go (OTG)" which shows a 10k
>> pull-up resistor installed for the sample configurations.
>
> Nit: I just downloaded what I believe is the latest datasheet (SLUSAW5B,
> Revised Dec 2014, http://www.ti.com/lit/ds/symlink/bq24190.pdf) and it
> looks like the figure you're referring to is Figure 37 not Figure 1.

Thanks, will fix.

>> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
>> Cc: Mark A. Greer <mgreer@animalcreek.com>
>> Cc: Matt Ranostay <matt@ranostay.consulting>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index f5746b9..694c088 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1394,7 +1394,7 @@ static int bq24190_probe(struct i2c_client *client,
>>
>>       ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
>>                       bq24190_irq_handler_thread,
>> -                     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> +                     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>                       "bq24190-charger", bdi);
>>       if (ret < 0) {
>>               dev_err(dev, "Can't set up irq handler\n");
>
> Assuming the Figure number is fixed or a clarification of the document
> referred to, if not the datasheet:
>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
