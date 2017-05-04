From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v13 07/11] power: supply: bq27xxx_battery: Add chip data
 memory read/write support
Date: Thu, 4 May 2017 11:07:28 -0700
Message-ID: <CAKvHMgRkZXdY=fnZga4e8YZ7wFG4A4rej5W0_fp5Fz-DaHdk0g@mail.gmail.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-8-liam@networkimprov.net> <b29a4425-eab1-d192-b06d-9a27967d4207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33885 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbdEDSHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 14:07:40 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so5458242ioi.1
        for <linux-pm@vger.kernel.org>; Thu, 04 May 2017 11:07:39 -0700 (PDT)
In-Reply-To: <b29a4425-eab1-d192-b06d-9a27967d4207@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, May 4, 2017 at 9:44 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 05/04/2017 01:18 AM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Add these to enable read/write of chip data memory RAM/NVM/flash:
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
>>  drivers/power/supply/bq27xxx_battery.c | 253 ++++++++++++++++++++++++++=
+++++++
>>  include/linux/power/bq27xxx_battery.h  |   1 +
>>  2 files changed, 254 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supp=
ly/bq27xxx_battery.c
>> index a11dfad..8ab184c 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -5,6 +5,7 @@
>>   * Copyright (C) 2008 Eurotech S.p.A. <info@eurotech.it>
>>   * Copyright (C) 2010-2011 Lars-Peter Clausen <lars@metafoo.de>
>>   * Copyright (C) 2011 Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> + * Copyright (C) 2017 Liam Breck <kernel@networkimprov.net>
>>   *
>>   * Based on a previous work by Copyright (C) 2008 Texas Instruments, In=
c.
>>   *
>> @@ -65,6 +66,7 @@
>>  #define BQ27XXX_FLAG_DSC     BIT(0)
>>  #define BQ27XXX_FLAG_SOCF    BIT(1) /* State-of-Charge threshold final =
*/
>>  #define BQ27XXX_FLAG_SOC1    BIT(2) /* State-of-Charge threshold 1 */
>> +#define BQ27XXX_FLAG_CFGUP   BIT(4)
>>  #define BQ27XXX_FLAG_FC              BIT(9)
>>  #define BQ27XXX_FLAG_OTD     BIT(14)
>>  #define BQ27XXX_FLAG_OTC     BIT(15)
>> @@ -78,6 +80,12 @@
>>  #define BQ27000_FLAG_FC              BIT(5)
>>  #define BQ27000_FLAG_CHGS    BIT(7) /* Charge state flag */
>>
>> +/* control register params */
>> +#define BQ27XXX_SEALED                       0x20
>> +#define BQ27XXX_SET_CFGUPDATE                0x13
>> +#define BQ27XXX_SOFT_RESET           0x42
>> +#define BQ27XXX_RESET                        0x41
>> +
>>  #define BQ27XXX_RS                   (20) /* Resistor sense mOhm */
>>  #define BQ27XXX_POWER_CONSTANT               (29200) /* 29.2 =C2=B5V^2 =
* 1000 */
>>  #define BQ27XXX_CURRENT_CONSTANT     (3570) /* 3.57 =C2=B5V * 1000 */
>> @@ -108,9 +116,21 @@ enum bq27xxx_reg_index {
>>       BQ27XXX_REG_SOC,        /* State-of-Charge */
>>       BQ27XXX_REG_DCAP,       /* Design Capacity */
>>       BQ27XXX_REG_AP,         /* Average Power */
>> +     BQ27XXX_DM_CTRL,        /* Block Data Control */
>> +     BQ27XXX_DM_CLASS,       /* Data Class */
>> +     BQ27XXX_DM_BLOCK,       /* Data Block */
>> +     BQ27XXX_DM_DATA,        /* Block Data */
>> +     BQ27XXX_DM_CKSUM,       /* Block Data Checksum */
>>       BQ27XXX_REG_MAX,        /* sentinel */
>>  };
>>
>> +#define BQ27XXX_DM_REG_ROWS \
>> +     [BQ27XXX_DM_CTRL] =3D 0x61,  \
>> +     [BQ27XXX_DM_CLASS] =3D 0x3e, \
>> +     [BQ27XXX_DM_BLOCK] =3D 0x3f, \
>> +     [BQ27XXX_DM_DATA] =3D 0x40,  \
>> +     [BQ27XXX_DM_CKSUM] =3D 0x60
>> +
>>  /* Register mappings */
>>  static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>       [BQ27000] =3D {
>> @@ -131,6 +151,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x0b,
>>               [BQ27XXX_REG_DCAP] =3D 0x76,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>       },
>>       [BQ27010] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -150,6 +175,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x0b,
>>               [BQ27XXX_REG_DCAP] =3D 0x76,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>       },
>>       [BQ2750X] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -169,6 +199,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ2751X] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -188,6 +219,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D 0x2e,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27500] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -207,6 +239,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27510G1] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -226,6 +259,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27510G2] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -245,6 +279,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27510G3] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -264,6 +299,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D 0x2e,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27520G1] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -283,6 +319,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27520G2] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -302,6 +339,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27520G3] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -321,6 +359,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27520G4] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -340,6 +379,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27530] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -359,6 +399,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27541] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -378,6 +419,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27545] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -397,6 +439,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>       [BQ27421] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -416,6 +459,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x1c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x18,
>> +             BQ27XXX_DM_REG_ROWS,
>>       },
>>  };
>>
>> @@ -757,6 +801,28 @@ static struct {
>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>  static LIST_HEAD(bq27xxx_battery_devices);
>>
>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>> +
>> +#define BQ27XXX_DM_SZ        32
>> +
>> +/**
>> + * struct bq27xxx_dm_buf - chip data memory buffer
>> + * @class: data memory subclass_id
>> + * @block: data memory block number
>> + * @data: data from/for the block
>> + * @has_data: true if data has been filled by read
>> + * @dirty: true if data has changed since last read/write
>> + *
>> + * Encapsulates info required to manage chip data memory blocks.
>> + */
>> +struct bq27xxx_dm_buf {
>> +     u8 class;
>> +     u8 block;
>> +     u8 data[BQ27XXX_DM_SZ];
>> +     bool has_data, dirty;
>> +};
>> +
>> +
>>  static int poll_interval_param_set(const char *val, const struct kernel=
_param *kp)
>>  {
>>       struct bq27xxx_device_info *di;
>> @@ -864,6 +930,193 @@ static inline int bq27xxx_write_block(struct bq27x=
xx_device_info *di, int reg_in
>>       return ret;
>>  }
>>
>> +static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_SEALED, false)=
;
>> +     if (ret < 0) {
>> +             dev_err(di->dev, "bus error on seal: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int bq27xxx_battery_unseal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
>> +
>> +     if (di->unseal_key =3D=3D 0) {
>> +             dev_err(di->dev, "unseal failed due to missing key\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)(di->unseal_key >=
> 16), false);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)di->unseal_key, f=
alse);
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
>> +     u16 sum =3D 0;
>> +     int i;
>> +
>> +     for (i =3D 0; i < BQ27XXX_DM_SZ; i++)
>> +             sum +=3D buf->data[i];
>> +     sum &=3D 0xff;
>> +
>> +     return 0xff - sum;
>> +}
>> +
>> +static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di=
,
>> +                                      struct bq27xxx_dm_buf *buf)
>> +{
>> +     int ret;
>> +
>> +     buf->has_data =3D false;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret =3D bq27xxx_read_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XXX=
_DM_SZ);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_read(di, BQ27XXX_DM_CKSUM, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     if ((u8)ret !=3D bq27xxx_battery_checksum_dm_block(buf)) {
>> +             ret =3D -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     buf->has_data =3D true;
>> +     buf->dirty =3D false;
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di=
, u16 state)
>
> Why do you pass in a flag but treat it like a bool? This whole function
> needs to be re-factored.

I will rename this cfgupdate_priv() and add apis set_cfgupdate() and
soft_reset() to call it.

>> +{
>> +     const int limit =3D 100;
>> +     int ret, try =3D limit;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL,
>> +                         state ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_R=
ESET,
>> +                         false);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     do {
>> +             BQ27XXX_MSLEEP(25);
>> +             ret =3D di->bus.read(di, di->regs[BQ27XXX_REG_FLAGS], fals=
e);
>> +             if (ret < 0)
>> +                     goto out;
>> +     } while ((ret & BQ27XXX_FLAG_CFGUP) !=3D state && --try);
>> +
>> +     if (!try) {
>> +             dev_err(di->dev, "timed out waiting for cfgupdate flag %d\=
n", !!state);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (limit-try > 3)
>> +             dev_warn(di->dev, "cfgupdate %d, retries %d\n", !!state, l=
imit-try);
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error on %s: %d\n", state ? "set_cfgupdate" =
: "soft_reset", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *d=
i,
>> +                                       struct bq27xxx_dm_buf *buf)
>> +{
>> +     bool cfgup =3D di->chip =3D=3D BQ27421; /* assume group supports c=
fgupdate */
>
> Group? This is a single chip ID.

Many of the "single" chip IDs represent several chips. That predates
this patchset. I will change "group" to "class".

>> +     int ret;
>> +
>> +     if (!buf->dirty)
>> +             return 0;
>> +
>> +     if (cfgup) {
>> +             ret =3D bq27xxx_battery_set_cfgupdate(di, BQ27XXX_FLAG_CFG=
UP);
>> +             if (ret < 0)
>> +                     return ret;
>> +     }
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_CTRL, 0, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     BQ27XXX_MSLEEP(1);
>> +
>> +     ret =3D bq27xxx_write_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XX=
X_DM_SZ);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_CKSUM,
>> +                         bq27xxx_battery_checksum_dm_block(buf), true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     /* DO NOT read BQ27XXX_DM_CKSUM here to verify it! That may cause =
NVM
>> +      * corruption on the '425 chip (and perhaps others), which can dam=
age
>> +      * the chip. See TI bqtool for what not to do:
>> +      * http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
>> +      */
>> +
>
> Again, this is not needed, I'm sorry you fried your chip somehow but
> this program is not incorrect, it is used by our customers all the time
> and does not fry chips, drop this comment.

Bqtool works because it has a long-enough initial delay, but it
implies that the delay is flexible, because on failure it delays again
and retries. I read that and assumed we could use a shorter delay,
which ruined a chip. The datasheet does not indicate a required delay
after checksum write.

I will take out the link to bqtool, but we need to leave the comment
in to prevent others making that mistake.

>> +     if (cfgup) {
>> +             BQ27XXX_MSLEEP(1);
>> +             ret =3D bq27xxx_battery_set_cfgupdate(di, 0);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else {
>> +             BQ27XXX_MSLEEP(100); /* flash DM updates in <100ms */
>> +     }
>> +
>> +     buf->dirty =3D false;
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
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power=
/bq27xxx_battery.h
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
