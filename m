From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12 5/9] power: bq27xxx_battery: Add bulk transfer bus methods
Date: Mon, 27 Mar 2017 12:34:20 -0700
Message-ID: <CAKvHMgRXeQHWHsiye2v=q1PPrWJk16AxZ+PD6vGmV-F3bRzvUQ@mail.gmail.com>
References: <20170327074159.16213-1-liam@networkimprov.net>
 <20170327074159.16213-2-liam@networkimprov.net> <b0566e5a-0f68-4938-d717-193ad62c951f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35260 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdC0TeX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 15:34:23 -0400
Received: by mail-it0-f65.google.com with SMTP id y18so13681171itc.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2017 12:34:22 -0700 (PDT)
In-Reply-To: <b0566e5a-0f68-4938-d717-193ad62c951f@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Mon, Mar 27, 2017 at 7:49 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/27/2017 02:41 AM, Liam Breck wrote:
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> Declare bus.write/read_bulk/write_bulk().
>> Add I2C write/read_bulk/write_bulk() to implement the above.
>> Add bq27xxx_write/read_block/write_block() helper functions to call the above.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c     | 55 +++++++++++++++++++-
>>  drivers/power/supply/bq27xxx_battery_i2c.c | 82 +++++++++++++++++++++++++++++-
>>  include/linux/power/bq27xxx_battery.h      |  3 ++
>>  3 files changed, 137 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 398801a..f8c919e 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -794,11 +794,62 @@ MODULE_PARM_DESC(poll_interval,
>>  static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>>                              bool single)
>>  {
>> -     /* Reports EINVAL for invalid/missing registers */
>> +     int ret;
>> +
>>       if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
>>               return -EINVAL;
>>
>> -     return di->bus.read(di, di->regs[reg_index], single);
>> +     ret = di->bus.read(di, di->regs[reg_index], single);
>> +     if (ret < 0)
>> +             dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
>> +                     di->regs[reg_index], reg_index);
>> +
>> +     return ret;
>> +}
>> +
>> +static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
>> +                             u16 value, bool single)
>> +{
>> +     int ret;
>> +
>> +     if (!di || di->regs[reg_index] == INVALID_REG_ADDR || !di->bus.write)
>> +             return -EINVAL;
>> +
>> +     ret = di->bus.write(di, di->regs[reg_index], value, single);
>> +     if (ret < 0)
>> +             dev_dbg(di->dev, "failed to write register 0x%02x (index %d)\n",
>> +                     di->regs[reg_index], reg_index);
>> +
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_xfer(struct bq27xxx_device_info *di,
>> +                     int (*xfer)(struct bq27xxx_device_info*, u8, u8*, int),
>> +                     u8* data, int len)
>> +{
>
> I'm not sure why you reverted this change from my suggested patch, it

So you know, I didn't revert anything per se; I copied changes out of a diff.

> only adds a couple lines to have a separate _read/write functions, but
> it makes it 100x more readable. This way includes passing functions and
> all kinds of ternary operators, this isn't a contest to see how clever
> you can code, please keep the readable version.
>
>> +     int ret;
>> +
>> +     if (!di || di->regs[BQ27XXX_DM_DATA] == INVALID_REG_ADDR || !xfer)
>
> NAK, I removed the hard-coded register for a reason, BQ27XXX_DM_DATA is
> not the only register you can bulk read. Let the caller pass in the
> requested register like I showed you.
>
>> +             return -EINVAL;
>> +
>> +     ret = xfer(di, di->regs[BQ27XXX_DM_DATA], data, len);
>> +     if (ret < 0)
>> +             dev_dbg(di->dev, "failed to xfer register 0x%02x (index %d)\n",
>> +                     di->regs[BQ27XXX_DM_DATA], BQ27XXX_DM_DATA);
>> +
>> +     return ret;
>> +}
>> +
>> +static inline int bq27xxx_read_block(struct bq27xxx_device_info *di,
>> +                                  u8* data, int len)
>> +{
>> +     return bq27xxx_xfer(di, di ? di->bus.read_bulk : 0, data, len);
>> +}
>> +
>> +static inline int bq27xxx_write_block(struct bq27xxx_device_info *di,
>> +                                   u8* data, int len)
>> +{
>> +     return bq27xxx_xfer(di, di ? di->bus.write_bulk : 0, data, len);
>>  }
>>
>>  /*
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index c68fbc3..a597221 100644
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
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index b312bce..c3369fa 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -40,6 +40,9 @@ struct bq27xxx_platform_data {
>>  struct bq27xxx_device_info;
>>  struct bq27xxx_access_methods {
>>       int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
>> +     int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
>> +     int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>> +     int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>>  };
>>
>>  struct bq27xxx_reg_cache {
>>
