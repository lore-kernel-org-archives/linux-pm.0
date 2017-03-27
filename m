From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12 6/9] power: bq27xxx_battery: Add chip data memory
 read/write support
Date: Mon, 27 Mar 2017 12:52:53 -0700
Message-ID: <CAKvHMgQyBVW_p=syX6+zGQtjhAN3WjRahZYf5rg=BdUU6Hveyg@mail.gmail.com>
References: <20170327074159.16213-1-liam@networkimprov.net>
 <20170327074159.16213-3-liam@networkimprov.net> <ed9e4220-c6e9-59ad-b31b-bf31a002d6dd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34251 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbdC0Tw4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 15:52:56 -0400
Received: by mail-it0-f65.google.com with SMTP id e75so6658877itd.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2017 12:52:55 -0700 (PDT)
In-Reply-To: <ed9e4220-c6e9-59ad-b31b-bf31a002d6dd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Mon, Mar 27, 2017 at 7:58 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/27/2017 02:41 AM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Add the following to enable read/write of chip data memory (DM) RAM/NVM/=
flash:
>>   bq27xxx_battery_seal
>>   bq27xxx_battery_unseal
>>   bq27xxx_battery_set_cfgupdate
>>   bq27xxx_battery_read_dm_block
>>   bq27xxx_battery_update_dm_block
>>   bq27xxx_battery_write_dm_block
>>   bq27xxx_battery_checksum_dm_block
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 360 ++++++++++++++++++++++++++=
++++++-
>>  include/linux/power/bq27xxx_battery.h  |   2 +
>>  2 files changed, 361 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supp=
ly/bq27xxx_battery.c
>> index f8c919e..ad152cc 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -57,7 +57,7 @@
>>
>>  #include <linux/power/bq27xxx_battery.h>
>>
>> -#define DRIVER_VERSION               "1.2.0"
>> +#define DRIVER_VERSION               "1.3.0"
>>
>
> Lets hold of on this until we change functionality, this patch should
> not add functional changes.

I'll move it to "Enable chip data memory update..." patch

>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>
>> @@ -65,6 +65,7 @@
>>  #define BQ27XXX_FLAG_DSC     BIT(0)
>>  #define BQ27XXX_FLAG_SOCF    BIT(1) /* State-of-Charge threshold final =
*/
>>  #define BQ27XXX_FLAG_SOC1    BIT(2) /* State-of-Charge threshold 1 */
>> +#define BQ27XXX_FLAG_CFGUP   BIT(4)
>>  #define BQ27XXX_FLAG_FC              BIT(9)
>>  #define BQ27XXX_FLAG_OTD     BIT(14)
>>  #define BQ27XXX_FLAG_OTC     BIT(15)
>> @@ -78,6 +79,12 @@
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
>> @@ -108,6 +115,11 @@ enum bq27xxx_reg_index {
>>       BQ27XXX_REG_SOC,        /* State-of-Charge */
>>       BQ27XXX_REG_DCAP,       /* Design Capacity */
>>       BQ27XXX_REG_AP,         /* Average Power */
>> +     BQ27XXX_DM_CTRL,        /* BlockDataControl() */
>> +     BQ27XXX_DM_CLASS,       /* DataClass() */
>> +     BQ27XXX_DM_BLOCK,       /* DataBlock() */
>> +     BQ27XXX_DM_DATA,        /* BlockData() */
>> +     BQ27XXX_DM_CKSUM,       /* BlockDataChecksum() */
>
> Not all data sheets will refer to them in this way, all the other
> registers explain what they do, not how they are referred in some
> version of some parts datasheet. This makes adding new parts easier as
> we look for the register that does what the comment says it does, not
> necessarily what the register is named.
>
>>       BQ27XXX_REG_MAX,        /* sentinel */
>>  };
>>
>> @@ -131,6 +143,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
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
>> @@ -150,6 +167,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
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
>> @@ -169,6 +191,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ2751X] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -188,6 +215,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D 0x2e,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27500] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -207,6 +239,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27510G1] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -226,6 +263,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27510G2] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -245,6 +287,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27510G3] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -264,6 +311,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D 0x2e,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27520G1] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -283,6 +335,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27520G2] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -302,6 +359,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27520G3] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -321,6 +383,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27520G4] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -340,6 +407,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x20,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27530] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -359,6 +431,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27541] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -378,6 +455,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27545] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -397,6 +479,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x2c,
>>               [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>               [BQ27XXX_REG_AP] =3D 0x24,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>       [BQ27421] =3D {
>>               [BQ27XXX_REG_CTRL] =3D 0x00,
>> @@ -416,6 +503,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>               [BQ27XXX_REG_SOC] =3D 0x1c,
>>               [BQ27XXX_REG_DCAP] =3D 0x3c,
>>               [BQ27XXX_REG_AP] =3D 0x18,
>> +             [BQ27XXX_DM_CTRL] =3D 0x61,
>> +             [BQ27XXX_DM_CLASS] =3D 0x3e,
>> +             [BQ27XXX_DM_BLOCK] =3D 0x3f,
>> +             [BQ27XXX_DM_DATA] =3D 0x40,
>> +             [BQ27XXX_DM_CKSUM] =3D 0x60,
>>       },
>>  };
>>
>> @@ -757,6 +849,52 @@ static struct {
>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>  static LIST_HEAD(bq27xxx_battery_devices);
>>
>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>> +
>> +#define BQ27XXX_DM_SZ        32
>> +
>> +struct bq27xxx_dm_reg {
>> +     u8 subclass_id;
>> +     u8 offset;
>> +     u8 bytes;
>> +     u16 min, max;
>> +};
>> +
>> +struct bq27xxx_dm_buf {
>> +     u8 class;
>> +     u8 block;
>> +     u8 data[BQ27XXX_DM_SZ];
>> +     bool full, updt;
>> +};
>> +
>> +#define BQ27XXX_DM_BUF(di, i) { \
>> +     .class =3D (di)->dm_regs[i].subclass_id, \
>> +     .block =3D (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
>> +}
>> +
>> +static inline u16* bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
>> +                                   struct bq27xxx_dm_reg *reg)
>> +{
>> +     if (buf->class =3D=3D reg->subclass_id &&
>> +         buf->block =3D=3D reg->offset / BQ27XXX_DM_SZ)
>> +             return (u16*) (buf->data + reg->offset % BQ27XXX_DM_SZ);
>> +
>> +     return NULL;
>> +}
>> +
>> +enum bq27xxx_dm_reg_id {
>> +     BQ27XXX_DM_DESIGN_CAPACITY =3D 0,
>> +     BQ27XXX_DM_DESIGN_ENERGY,
>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>> +};
>> +
>> +static const char* bq27xxx_dm_reg_name[] =3D {
>> +     [BQ27XXX_DM_DESIGN_CAPACITY] =3D "design-capacity",
>> +     [BQ27XXX_DM_DESIGN_ENERGY] =3D "design-energy",
>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D "terminate-voltage",
>> +};
>> +
>> +
>>  static int poll_interval_param_set(const char *val, const struct kernel=
_param *kp)
>>  {
>>       struct bq27xxx_device_info *di;
>> @@ -852,6 +990,226 @@ static inline int bq27xxx_write_block(struct bq27x=
xx_device_info *di,
>>       return bq27xxx_xfer(di, di ? di->bus.write_bulk : 0, data, len);
>>  }
>>
>> +static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_SEALED, false)=
;
>> +     if (ret >=3D 0)
>> +             return 0;
>> +
>> +     dev_err(di->dev, "bus error on seal: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_unseal(struct bq27xxx_device_info *di)
>> +{
>> +     int ret;
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
>> +     ret =3D bq27xxx_read_block(di, buf->data, BQ27XXX_DM_SZ);
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
>> +     buf->full =3D true;
>> +     buf->updt =3D false;
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info =
*di,
>> +                                         struct bq27xxx_dm_buf *buf,
>> +                                         enum bq27xxx_dm_reg_id reg_id,
>> +                                         unsigned int val)
>> +{
>> +     struct bq27xxx_dm_reg *reg =3D &di->dm_regs[reg_id];
>> +     const char* str =3D bq27xxx_dm_reg_name[reg_id];
>> +     u16 *prev =3D bq27xxx_dm_reg_ptr(buf, reg);
>> +
>> +     if (prev =3D=3D NULL) {
>> +             dev_warn(di->dev, "buffer does not match %s dm spec\n", st=
r);
>> +             return;
>> +     }
>> +
>> +     if (reg->bytes !=3D 2) {
>> +             dev_warn(di->dev, "%s dm spec has unsupported byte size\n"=
, str);
>> +             return;
>> +     }
>> +
>> +     if (!buf->full)
>> +             return;
>> +
>> +     if (be16_to_cpup(prev) =3D=3D val) {
>> +             dev_info(di->dev, "%s has %u\n", str, val);
>> +             return;
>> +     }
>> +
>> +     dev_info(di->dev, "update %s to %u\n", str, val);
>> +
>> +     *prev =3D cpu_to_be16(val);
>> +     buf->updt =3D true;
>> +}
>> +
>> +static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di=
, u16 flag)
>> +{
>> +     const int limit =3D 100;
>> +     int ret, try =3D limit;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_REG_CTRL,
>> +                         flag ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_RE=
SET,
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
>> +     } while ((ret & BQ27XXX_FLAG_CFGUP) !=3D flag && --try);
>> +
>> +     if (!try) {
>> +             dev_err(di->dev, "timed out waiting for cfgupdate flag %d\=
n", !!flag);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (limit-try > 3)
>> +             dev_warn(di->dev, "cfgupdate %d, retries %d\n", !!flag, li=
mit-try);
>> +
>> +     return 0;
>> +
>> +out:
>> +     dev_err(di->dev, "bus error on %s: %d\n", flag ? "set_cfgupdate" :=
 "soft_reset", ret);
>> +     return ret;
>> +}
>> +
>> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *d=
i,
>> +                                       struct bq27xxx_dm_buf *buf)
>> +{
>> +     bool cfgup =3D di->chip =3D=3D BQ27421; /* assume group supports c=
fgupdate */
>> +     int ret;
>> +
>> +     if (!buf->updt)
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
>> +     ret =3D bq27xxx_write_block(di, buf->data, BQ27XXX_DM_SZ);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     ret =3D bq27xxx_write(di, BQ27XXX_DM_CKSUM,
>> +                         bq27xxx_battery_checksum_dm_block(buf), true);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     /* DO NOT ADD THIS FEATURE, IT IS TOXIC.
>
> DONT RUN system("rm -rf /"); !!!!
>
> We know drivers can break hardware, simply say:
>
> /*
>  * If the 'time' delay is insufficient, DM corruption results on
>  * the '425 chip (and perhaps others), which could damage the chip.
>  */
>
> This is more that sufficient, a working example of erasing your device's
> NVM is not needed.

The comment without code would be, "Don't read BQ27XXX_DM_CKSUM here.
It may trigger DM corruption..."

>> +      * TI's bqtool reads checksum after above write:
>> +      *
>> +      *   BQ27XXX_MSLEEP(time)
>> +      *   bq27xxx_write(BQ27XXX_DM_BLOCK, buf->block)
>> +      *   sum =3D bq27xxx_read(BQ27XXX_DM_CKSUM)
>> +      *   if (sum !=3D bq27xxx_battery_checksum_dm_block(buf))
>> +      *     report error
>> +      *
>> +      * If the 'time' delay is insufficient, DM corruption results on
>> +      * the '425 chip (and perhaps others), which could damage the chip=
.
>> +      * http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
>> +      */
>> +
>> +     if (cfgup) {
>> +             BQ27XXX_MSLEEP(1);
>> +             ret =3D bq27xxx_battery_set_cfgupdate(di, 0);
>> +             if (ret < 0)
>> +                     return ret;
>> +     } else {
>> +             BQ27XXX_MSLEEP(100); /* flash DM updates in <100ms */
>> +     }
>> +
>> +     buf->updt =3D false;
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
>> index c3369fa..227eb08 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -64,6 +64,8 @@ struct bq27xxx_device_info {
>>       int id;
>>       enum bq27xxx_chip chip;
>>       const char *name;
>> +     struct bq27xxx_dm_reg *dm_regs;
>> +     u32 unseal_key;
>>       struct bq27xxx_access_methods bus;
>>       struct bq27xxx_reg_cache cache;
>>       int charge_design_full;
>>
