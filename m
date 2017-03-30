From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.2 6/9] power: bq27xxx_battery: Add chip data memory
 read/write support
Date: Thu, 30 Mar 2017 13:04:09 -0700
Message-ID: <CAKvHMgSPQH1S=wEBjG-68mypkshWcKysS=UWkmp-M1An=K845g@mail.gmail.com>
References: <20170330090216.12381-1-liam@networkimprov.net>
 <20170330090216.12381-3-liam@networkimprov.net> <d8c550c5-1d57-baa9-4d8e-dc3f2f05704f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33427 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934711AbdC3UEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 16:04:11 -0400
Received: by mail-io0-f194.google.com with SMTP id f84so4031084ioj.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 13:04:10 -0700 (PDT)
In-Reply-To: <d8c550c5-1d57-baa9-4d8e-dc3f2f05704f@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 30, 2017 at 5:55 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/30/2017 04:02 AM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Add the following to enable read/write of chip data memory (DM) RAM/NVM/flash:
>>   bq27xxx_battery_seal()
>>   bq27xxx_battery_unseal()
>>   bq27xxx_battery_set_cfgupdate()
>>   bq27xxx_battery_read_dm_block()
>>   bq27xxx_battery_write_dm_block()
>>   bq27xxx_battery_checksum_dm_block()
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 285 +++++++++++++++++++++++++++++++++
>>  include/linux/power/bq27xxx_battery.h  |   1 +
>>  2 files changed, 286 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index e3472c3..dbcf14a 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c

>> @@ -757,6 +849,18 @@ static struct {
>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>  static LIST_HEAD(bq27xxx_battery_devices);
>>
>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>> +
>> +#define BQ27XXX_DM_SZ        32
>> +
>> +struct bq27xxx_dm_buf {
>> +     u8 class;
>> +     u8 block;
>> +     u8 data[BQ27XXX_DM_SZ];
>> +     bool has_data, dirty;
>> +};
>> +
>
> kernel-doc this struct
>
>> +
>>  static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
>>  {
>>       struct bq27xxx_device_info *di;
>> @@ -855,6 +959,187 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
>>       return ret;
>>  }
>>
>> +static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_SEALED, false);
>> +     if (ret >= 0)
>> +             return 0;
>> +
>
> This logic is reversed, return on error first.

It mirrors the structure of all the other functions, with an out:
error case at the end. Can I use goto-out here too?

>> +     dev_err(di->dev, "bus error on seal: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_unseal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)(di->unseal_key >> 16), false);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)di->unseal_key, false);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error on unseal: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static u8 bq27xxx_battery_checksum_dm_block(struct bq27xxx_dm_buf *buf)
>> +{
>> +     u16 sum = 0;
>
> I haven't tested this, but maybe you could:
>
> u8 sum = 0xff;
>
> for (i = 0; i < BQ27XXX_DM_SZ; i++)
>         sum -= buf->data[i];
>
> return sum;

I gracefully decline. I prefer the bqtool algorithm. We will cause
confusion with distinct logic. Also using subtraction in a checkSUM is
odd.

>> +     int i;
>> +
>> +     for (i = 0; i < BQ27XXX_DM_SZ; i++)
>> +             sum += buf->data[i];
>> +     sum &= 0xff;
>> +
>> +     return 0xff - sum;
>> +}
>> +
>> +static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
>> +                                      struct bq27xxx_dm_buf *buf)
>> +{
>> +     int ret;
>> +
>> +     buf->has_data = false;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret = bq27xxx_read_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XXX_DM_SZ);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_read(di, BQ27XXX_DM_CKSUM, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     if ((u8)ret != bq27xxx_battery_checksum_dm_block(buf)) {
>> +             ret = -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     buf->has_data = true;
>> +     buf->dirty = false;
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di, u16 state)
>> +{
>> +     const int limit = 100;
>> +     int ret, try = limit;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_REG_CTRL,
>> +                         state ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_RESET,
>> +                         false);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     do {
>> +             BQ27XXX_MSLEEP(25);
>> +             ret = di->bus.read(di, di->regs[BQ27XXX_REG_FLAGS], false);
>> +             if (ret < 0)
>> +                     goto out;
>> +     } while ((ret & BQ27XXX_FLAG_CFGUP) != state && --try);
>> +
>> +     if (!try) {
>> +             dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", !!state);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (limit-try > 3)
>> +             dev_warn(di->dev, "cfgupdate %d, retries %d\n", !!state, limit-try);
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error on %s: %d\n", state ? "set_cfgupdate" : "soft_reset", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
>> +                                       struct bq27xxx_dm_buf *buf)
>> +{
>> +     bool cfgup = di->chip == BQ27421; /* assume group supports cfgupdate */
>> +     int ret;
>> +
>> +     if (!buf->dirty)
>> +             return 0;
>> +
>> +     if (cfgup) {
>> +             ret = bq27xxx_battery_set_cfgupdate(di, BQ27XXX_FLAG_CFGUP);
>> +             if (ret < 0)
>> +                     return ret;
>> +     }
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_CTRL, 0, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret = bq27xxx_write_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XXX_DM_SZ);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret = bq27xxx_write(di, BQ27XXX_DM_CKSUM,
>> +                         bq27xxx_battery_checksum_dm_block(buf), true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     /* DO NOT read BQ27XXX_DM_CKSUM here to verify it! That may cause NVM
>> +      * corruption on the '425 chip (and perhaps others), which can damage
>> +      * the chip. See TI bqtool for what not to do:
>
> The bqtool does work, it even says delay needs to be long enough.

It doesn't say the result is catastrophic if the delay isn't
sufficient. It does increase the delay and retry on failure, implying
that the starting value is flexible.

>> +      * http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
>> +      */
>> +
>> +     if (cfgup) {
>> +             BQ27XXX_MSLEEP(1);
>> +             ret = bq27xxx_battery_set_cfgupdate(di, 0);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else {
>> +             BQ27XXX_MSLEEP(100); /* flash DM updates in <100ms */
>> +     }
>> +
>> +     buf->dirty = false;
>> +
>> +     return 0;
>> +
>> +out:
>> +     if (cfgup)
>> +             bq27xxx_battery_set_cfgupdate(di, 0);
>> +
>> +     dev_err(di->dev, "bus error writing chip memory: %d\n", ret);
>> +     return ret;
>> +}
>> +
>>  /*
>>   * Return the battery State-of-Charge
>>   * Or < 0 if something fails.
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index c3369fa..b1defb8 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -64,6 +64,7 @@ struct bq27xxx_device_info {
>>       int id;
>>       enum bq27xxx_chip chip;
>>       const char *name;
>> +     u32 unseal_key;
>>       struct bq27xxx_access_methods bus;
>>       struct bq27xxx_reg_cache cache;
>>       int charge_design_full;
>>
