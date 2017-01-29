From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 6/8] power: bq27xxx_battery: add i2c bulk read/write functions
Date: Sun, 29 Jan 2017 12:08:25 -0800
Message-ID: <20170129200825.32648-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34830 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdA2UJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 15:09:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so21926482pfa.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Jan 2017 12:09:19 -0800 (PST)
In-Reply-To: 20170129183826.cyysprznipidkttb@earth
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sun, 2017-01-29 at 18:38:26, Sebastian Reichel wrote:
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 3f265dbf11af..581402380d6e 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -41,6 +41,9 @@ struct bq27xxx_platform_data {
>>  struct bq27xxx_device_info;
>>  struct bq27xxx_access_methods {
>>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
>> +	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
>> +	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>> +	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>
>So I had a look at patch 8 and I think we should start with finally
>converting bq27xxx to regmap API and probably a second regmap for
>the block data stuff. That way you get all the debugging info in
>debugfs and the driver looks much cleaner.
										
Could we complete this patchset using the I2C api? We haven't added to it
extensively, and regmap is unrelated to the purpose of this patchset.

Also maybe the primary maintainers of BQ27xxx should be on the hook for
that api change :-)

Plus we're blocked here on devicetree support for BQ24190 waiting for
power_supply_battery_info.

Thanks
