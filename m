From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 6/8] power: bq27xxx_battery: add i2c bulk read/write functions
Date: Sun, 29 Jan 2017 15:02:59 -0800
Message-ID: <CAKvHMgTT_YuHjFGVcE4VJ0TCywftBjnH_E91TkhwXGG0xCkMCw@mail.gmail.com>
References: <20170129200825.32648-1-liam@networkimprov.net> <20170129222245.kimtf5f5t5zjjcnq@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33677 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdA2XD1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 18:03:27 -0500
Received: by mail-it0-f66.google.com with SMTP id e137so13785416itc.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Jan 2017 15:03:05 -0800 (PST)
In-Reply-To: <20170129222245.kimtf5f5t5zjjcnq@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sun, Jan 29, 2017 at 2:22 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Sun, Jan 29, 2017 at 12:08:25PM -0800, Liam Breck wrote:
>> On Sun, 2017-01-29 at 18:38:26, Sebastian Reichel wrote:
>> >> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> >> index 3f265dbf11af..581402380d6e 100644
>> >> --- a/include/linux/power/bq27xxx_battery.h
>> >> +++ b/include/linux/power/bq27xxx_battery.h
>> >> @@ -41,6 +41,9 @@ struct bq27xxx_platform_data {
>> >>  struct bq27xxx_device_info;
>> >>  struct bq27xxx_access_methods {
>> >>    int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
>> >> +  int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
>> >> +  int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>> >> +  int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>> >
>> >So I had a look at patch 8 and I think we should start with finally
>> >converting bq27xxx to regmap API and probably a second regmap for
>> >the block data stuff. That way you get all the debugging info in
>> >debugfs and the driver looks much cleaner.
>>
>> Could we complete this patchset using the I2C api? We haven't added to it
>> extensively, and regmap is unrelated to the purpose of this patchset.
>
> Previously we had only a read operation, which could be easily
> converted to regmap, since it accesses a single register. Afterwards
> we have read,write,bulk_read and bulk_write. That's 400% and 2/4
> functions, which do not follow the regmap style.
>
> So what is your definition of extensively? :)

We added all of 51 LOC, plus whitespace. Extensive is at least greater
than UCHAR_MAX :-)

>> Also maybe the primary maintainers of BQ27xxx should be on the hook for
>> that api change :-)
>
> https://lkml.org/lkml/2015/9/23/542
>
> The w1 stuff is not that hard to implement actually by just using
> the existing functions and devm_regmap_init().

We don't really have the bandwidth or budget for general driver
maintenance. There was no indication in the I2C code that it was
deprecated. Please ask TI to fund this, not us.

>> Plus we're blocked here on devicetree support for BQ24190 waiting for
>> power_supply_battery_info.
>
> Well this patch depends on the power_supply_battery_info patch, not
> the other way around. I will apply the power_supply_battery_info
> patch once its ok. No need to wait for this patch. So not really a
> problem for your BQ24190 work?

Usually features like that aren't added without a client?
