From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v10 8/8] power: bq27xxx_battery_i2c: Add I2C bulk
 read/write functions
Date: Wed, 15 Mar 2017 15:34:23 -0700
Message-ID: <CAKvHMgSuvFjD39nv9cfkEs4U+79F=K_DBuBPcAqqvDejszeGfQ@mail.gmail.com>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-9-liam@networkimprov.net> <20170315221414.mcig3c6bp44bitcu@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33602 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdCOWet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 18:34:49 -0400
Received: by mail-it0-f65.google.com with SMTP id g138so4582674itb.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 15:34:24 -0700 (PDT)
In-Reply-To: <20170315221414.mcig3c6bp44bitcu@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Wed, Mar 15, 2017 at 3:14 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Mar 15, 2017 at 12:26:53PM -0700, Liam Breck wrote:
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> write(), read_bulk(), write_bulk() are required by bq27xxx_battery
>> power_supply_battery_info code.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>
> This is required by the previous patch, so your order is not bisect
> safe. Please just merge it with Patch 5.

It is bisect-safe; bq27xxx_battery only uses the functions if available.

Patch 5 could be merged with 7. But the I2C implementation should be
separate from the header.

>>  drivers/power/supply/bq27xxx_battery_i2c.c | 82 +++++++++++++++++++++++++++++-
>>  1 file changed, 81 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 13def59..abdc266 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -38,7 +38,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>>  {
>>       struct i2c_client *client = to_i2c_client(di->dev);
>>       struct i2c_msg msg[2];
>> -     unsigned char data[2];
>> +     u8 data[2];
>>       int ret;
>>
>>       if (!client->adapter)
>> @@ -68,6 +68,82 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>>       return ret;
>>  }
>>
>> +static int bq27xxx_battery_i2c_write(struct bq27xxx_device_info *di, u8 reg,
>> +                                  int value, bool single)
>> +{
>> +     struct i2c_client *client = to_i2c_client(di->dev);
>> +     struct i2c_msg msg;
>> +     u8 data[4];
>> +     int ret;
>> +
>> +     if (!client->adapter)
>> +             return -ENODEV;
>> +
>> +     data[0] = reg;
>> +     if (single) {
>> +             data[1] = (u8) value;
>> +             msg.len = 2;
>> +     } else {
>> +             put_unaligned_le16(value, &data[1]);
>> +             msg.len = 3;
>> +     }
>> +
>> +     msg.buf = data;
>> +     msg.addr = client->addr;
>> +     msg.flags = 0;
>> +
>> +     ret = i2c_transfer(client->adapter, &msg, 1);
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != 1)
>> +             return -EINVAL;
>> +     return 0;
>> +}
>> +
>> +static int bq27xxx_battery_i2c_bulk_read(struct bq27xxx_device_info *di, u8 reg,
>> +                                      u8 *data, int len)
>> +{
>> +     struct i2c_client *client = to_i2c_client(di->dev);
>> +     int ret;
>> +
>> +     if (!client->adapter)
>> +             return -ENODEV;
>> +
>> +     ret = i2c_smbus_read_i2c_block_data(client, reg, len, data);
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != len)
>> +             return -EINVAL;
>> +     return 0;
>> +}
>> +
>> +static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
>> +                                       u8 reg, u8 *data, int len)
>> +{
>> +     struct i2c_client *client = to_i2c_client(di->dev);
>> +     struct i2c_msg msg;
>> +     u8 buf[33];
>> +     int ret;
>> +
>> +     if (!client->adapter)
>> +             return -ENODEV;
>> +
>> +     buf[0] = reg;
>> +     memcpy(&buf[1], data, len);
>> +
>> +     msg.buf = buf;
>> +     msg.addr = client->addr;
>> +     msg.flags = 0;
>> +     msg.len = len + 1;
>> +
>> +     ret = i2c_transfer(client->adapter, &msg, 1);
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != 1)
>> +             return -EINVAL;
>> +     return 0;
>> +}
>> +
>>  static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>                                    const struct i2c_device_id *id)
>>  {
>> @@ -95,7 +171,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>       di->dev = &client->dev;
>>       di->chip = id->driver_data;
>>       di->name = name;
>> +
>>       di->bus.read = bq27xxx_battery_i2c_read;
>> +     di->bus.write = bq27xxx_battery_i2c_write;
>> +     di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
>> +     di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
>>
>>       ret = bq27xxx_battery_setup(di);
>>       if (ret)
>> --
>> 2.9.3
>>
