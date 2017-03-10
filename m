From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v9.3 7/8] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Fri, 10 Mar 2017 13:49:52 -0800
Message-ID: <CAKvHMgT5FKjWP92gr5B_Tia5pLE095BWsmkgF56g+5nCzXu0TA@mail.gmail.com>
References: <20170310002726.30949-1-liam@networkimprov.net>
 <20170310002726.30949-2-liam@networkimprov.net> <CAKvHMgQJ4hzDnR2BAG=Se2MOu6gk_yP_dC4vr3uCWwV07WQVLw@mail.gmail.com>
 <ac96575c-6b1b-7735-87a8-77e8ef58895d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35003 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdCJVty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2017 16:49:54 -0500
Received: by mail-io0-f193.google.com with SMTP id f103so8204636ioi.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2017 13:49:53 -0800 (PST)
In-Reply-To: <ac96575c-6b1b-7735-87a8-77e8ef58895d@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Fri, Mar 10, 2017 at 1:25 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/10/2017 03:01 PM, Liam Breck wrote:
>> Andrew, any comments on these last two drafts?
>>
>
> 1) Don't ping maintainers/reviewers, I haven't forgotten about you, it
> hasn't been even 24 hours since you posted this.

Sorry. You did say at start of week that you'd have some time to test
this patchset.

> 2) I have lots of comments, but it's Friday and I don't feel like
> reviewing stuff, if you want some comments to work on go read my old
> ones, many have not been fixed in this series yet.

I believe I have addressed all your comments. I didn't fix things
where the comment missed my rationale, but I did clarify the
rationale.

>> On Thu, Mar 9, 2017 at 4:27 PM, Liam Breck <liam@networkimprov.net> wrot=
e:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Previously there was no way to configure chip registers in the event th=
at the
>>> defaults didn't match the battery in question.
>>>
>>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inpu=
ts,
>>> and writes battery data to chip RAM or non-volatile memory.
>>>
>>> Supports chips BQ27500, 545, 421, 425, 441, 621. Others may be added.
>>>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  drivers/power/supply/bq27xxx_battery.c | 476 +++++++++++++++++++++++++=
+++++++-
>>>  include/linux/power/bq27xxx_battery.h  |   2 +
>>>  2 files changed, 468 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
>>> index 8ce2940..f382d18 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -51,7 +51,7 @@
>>>
>>>  #include <linux/power/bq27xxx_battery.h>
>>>
>>> -#define DRIVER_VERSION         "1.2.0"
>>> +#define DRIVER_VERSION         "1.3.0"
>>>
>>>  #define BQ27XXX_MANUFACTURER   "Texas Instruments"
>>>
>>> @@ -59,6 +59,7 @@
>>>  #define BQ27XXX_FLAG_DSC       BIT(0)
>>>  #define BQ27XXX_FLAG_SOCF      BIT(1) /* State-of-Charge threshold fin=
al */
>>>  #define BQ27XXX_FLAG_SOC1      BIT(2) /* State-of-Charge threshold 1 *=
/
>>> +#define BQ27XXX_FLAG_CFGUP     BIT(4)
>>>  #define BQ27XXX_FLAG_FC                BIT(9)
>>>  #define BQ27XXX_FLAG_OTD       BIT(14)
>>>  #define BQ27XXX_FLAG_OTC       BIT(15)
>>> @@ -72,6 +73,11 @@
>>>  #define BQ27000_FLAG_FC                BIT(5)
>>>  #define BQ27000_FLAG_CHGS      BIT(7) /* Charge state flag */
>>>
>>> +/* control register params */
>>> +#define BQ27XXX_SEALED                 0x20
>>> +#define BQ27XXX_SET_CFGUPDATE          0x13
>>> +#define BQ27XXX_SOFT_RESET             0x42
>>> +
>>>  #define BQ27XXX_RS                     (20) /* Resistor sense mOhm */
>>>  #define BQ27XXX_POWER_CONSTANT         (29200) /* 29.2 =C2=B5V^2 * 100=
0 */
>>>  #define BQ27XXX_CURRENT_CONSTANT       (3570) /* 3.57 =C2=B5V * 1000 *=
/
>>> @@ -102,6 +108,11 @@ enum bq27xxx_reg_index {
>>>         BQ27XXX_REG_SOC,        /* State-of-Charge */
>>>         BQ27XXX_REG_DCAP,       /* Design Capacity */
>>>         BQ27XXX_REG_AP,         /* Average Power */
>>> +       BQ27XXX_DM_CTRL,        /* BlockDataControl() */
>>> +       BQ27XXX_DM_CLASS,       /* DataClass() */
>>> +       BQ27XXX_DM_BLOCK,       /* DataBlock() */
>>> +       BQ27XXX_DM_DATA,        /* BlockData() */
>>> +       BQ27XXX_DM_CKSUM,       /* BlockDataChecksum() */
>>>         BQ27XXX_REG_MAX,        /* sentinel */
>>>  };
>>>
>>> @@ -125,6 +136,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x0b,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x76,
>>>                 [BQ27XXX_REG_AP] =3D 0x24,
>>> +               [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>>         },
>>>         [BQ27010] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -144,6 +160,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x0b,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x76,
>>>                 [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
>>>         },
>>>         [BQ27500] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -163,6 +184,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x2c,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>                 [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>         [BQ27510] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -182,6 +208,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x20,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x2e,
>>>                 [BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>         [BQ27530] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -201,6 +232,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x2c,
>>>                 [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>>                 [BQ27XXX_REG_AP] =3D 0x24,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>         [BQ27541] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -220,6 +256,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x2c,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>                 [BQ27XXX_REG_AP] =3D 0x24,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>         [BQ27545] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -239,6 +280,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x2c,
>>>                 [BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
>>>                 [BQ27XXX_REG_AP] =3D 0x24,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>         [BQ27421] =3D {
>>>                 [BQ27XXX_REG_CTRL] =3D 0x00,
>>> @@ -258,6 +304,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>>>                 [BQ27XXX_REG_SOC] =3D 0x1c,
>>>                 [BQ27XXX_REG_DCAP] =3D 0x3c,
>>>                 [BQ27XXX_REG_AP] =3D 0x18,
>>> +               [BQ27XXX_DM_CTRL] =3D 0x61,
>>> +               [BQ27XXX_DM_CLASS] =3D 0x3e,
>>> +               [BQ27XXX_DM_BLOCK] =3D 0x3f,
>>> +               [BQ27XXX_DM_DATA] =3D 0x40,
>>> +               [BQ27XXX_DM_CKSUM] =3D 0x60,
>>>         },
>>>  };
>>>
>>> @@ -432,6 +483,82 @@ static struct {
>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>
>>> +#define BQ27XXX_DM_SZ  32
>>> +
>>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>>> +
>>> +struct bq27xxx_dm_reg {
>>> +       u8 subclass_id;
>>> +       u8 offset;
>>> +       u8 bytes;
>>> +       u16 min, max;
>>> +};
>>> +
>>> +struct bq27xxx_dm_buf {
>>> +       u8 class;
>>> +       u8 block;
>>> +       u8 a[BQ27XXX_DM_SZ];
>>> +       bool full, updt;
>>> +};
>>> +
>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>> +       .class =3D (di)->dm_regs[i].subclass_id, \
>>> +       .block =3D (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
>>> +}
>>> +
>>> +static inline u16* bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
>>> +                                     struct bq27xxx_dm_reg *reg)
>>> +{
>>> +       if (buf->class =3D=3D reg->subclass_id
>>> +        && buf->block =3D=3D reg->offset / BQ27XXX_DM_SZ)
>>> +               return (u16*) (buf->a + reg->offset % BQ27XXX_DM_SZ);
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>> +enum bq27xxx_dm_reg_id {
>>> +       BQ27XXX_DM_DESIGN_CAPACITY =3D 0,
>>> +       BQ27XXX_DM_DESIGN_ENERGY,
>>> +       BQ27XXX_DM_TERMINATE_VOLTAGE,
>>> +};
>>> +
>>> +static const char* bq27xxx_dm_reg_name[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY] =3D "design-capacity",
>>> +       [BQ27XXX_DM_DESIGN_ENERGY] =3D "design-energy",
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D "terminate-voltage",
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 10, 2,    0, 65535 },
>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     =3D { }, /* missing on chip */
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 48, 2, 1000, 32767 },
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 23, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 48, 25, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 67, 2, 2800,  3700 },
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0,  8000 },
>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2500,  3700 },
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 12, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 14, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 18, 2, 2800,  3700 },
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>>> +       [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 3, 2,    0,  8000 },
>>> +       [BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 5, 2,    0, 32767 },
>>> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 9, 2, 2500,  3700 },
>>> +};
>>> +
>>> +
>>>  static int poll_interval_param_set(const char *val, const struct kerne=
l_param *kp)
>>>  {
>>>         struct bq27xxx_device_info *di;
>>> @@ -476,6 +603,316 @@ static inline int bq27xxx_read(struct bq27xxx_dev=
ice_info *di, int reg_index,
>>>         return di->bus.read(di, di->regs[reg_index], single);
>>>  }
>>>
>>> +static int bq27xxx_battery_set_seal_state(struct bq27xxx_device_info *=
di,
>>> +                                         bool state)
>>> +{
>>> +       int ret;
>>> +
>>> +       if (state) {
>>> +               ret =3D di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], B=
Q27XXX_SEALED, false);
>>> +               if (ret < 0)
>>> +                       goto out;
>>> +       } else {
>>> +               ret =3D di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], (=
u16)(di->unseal_key >> 16), false);
>>> +               if (ret < 0)
>>> +                       goto out;
>>> +
>>> +               ret =3D di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], (=
u16)di->unseal_key, false);
>>> +               if (ret < 0)
>>> +                       goto out;
>>> +       }
>>> +       return 0;
>>> +
>>> +out:
>>> +       dev_err(di->dev, "bus error on %s: %d\n", state ? "seal" : "uns=
eal", ret);
>>> +       return ret;
>>> +}
>>> +
>>> +static u8 bq27xxx_battery_checksum_dm_block(struct bq27xxx_dm_buf *buf=
)
>>> +{
>>> +       u16 sum =3D 0;
>>> +       int i;
>>> +
>>> +       for (i =3D 0; i < BQ27XXX_DM_SZ; i++)
>>> +               sum +=3D buf->a[i];
>>> +       sum &=3D 0xff;
>>> +
>>> +       return 0xff - sum;
>>> +}
>>> +
>>> +static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *d=
i,
>>> +                                        struct bq27xxx_dm_buf *buf)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_CLASS], buf->clas=
s, true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_BLOCK], buf->bloc=
k, true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       BQ27XXX_MSLEEP(1);
>>> +
>>> +       ret =3D di->bus.read_bulk(di, di->regs[BQ27XXX_DM_DATA], buf->a=
, BQ27XXX_DM_SZ);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       ret =3D di->bus.read(di, di->regs[BQ27XXX_DM_CKSUM], true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       if ((u8)ret !=3D bq27xxx_battery_checksum_dm_block(buf)) {
>>> +               ret =3D -EINVAL;
>>> +               goto out;
>>> +       }
>>> +
>>> +       buf->full =3D true;
>>> +       buf->updt =3D false;
>>> +       return 0;
>>> +
>>> +out:
>>> +       dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
>>> +       return ret;
>>> +}
>>> +
>>> +static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info=
 *di,
>>> +                                           struct bq27xxx_dm_buf *buf,
>>> +                                           enum bq27xxx_dm_reg_id reg_=
id,
>>> +                                           unsigned int val)
>>> +{
>>> +       struct bq27xxx_dm_reg *reg =3D &di->dm_regs[reg_id];
>>> +       const char* str =3D bq27xxx_dm_reg_name[reg_id];
>>> +       u16 *prev =3D bq27xxx_dm_reg_ptr(buf, reg);
>>> +
>>> +       if (prev =3D=3D NULL) {
>>> +               dev_warn(di->dev, "buffer does not match %s dm spec\n",=
 str);
>>> +               return;
>>> +       }
>>> +
>>> +       if (reg->bytes !=3D 2) {
>>> +               dev_warn(di->dev, "%s dm spec has unsupported byte size=
\n", str);
>>> +               return;
>>> +       }
>>> +
>>> +       if (!buf->full)
>>> +               return;
>>> +
>>> +       if (be16_to_cpup(prev) =3D=3D val) {
>>> +               dev_info(di->dev, "%s has %u\n", str, val);
>>> +               return;
>>> +       }
>>> +
>>> +       dev_info(di->dev, "update %s to %u\n", str, val);
>>> +
>>> +       *prev =3D cpu_to_be16(val);
>>> +       buf->updt =3D true;
>>> +}
>>> +
>>> +static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *d=
i,
>>> +                                        bool state)
>>> +{
>>> +       int ret, try=3D100;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_REG_CTRL],
>>> +                           state ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOF=
T_RESET,
>>> +                           false);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       do {
>>> +               BQ27XXX_MSLEEP(25);
>>> +               ret =3D di->bus.read(di, di->regs[BQ27XXX_REG_FLAGS], f=
alse);
>>> +               if (ret < 0)
>>> +                       goto out;
>>> +       } while (!(ret & BQ27XXX_FLAG_CFGUP) =3D=3D state && --try);
>>> +
>>> +       if (100-try) /* remove after other cfgupdate parts are tested *=
/
>>> +               dev_info(di->dev, "cfgupdate %d, retries %d\n", state, =
100-try);
>>> +
>>> +       if (try)
>>> +               return 0;
>>> +
>>> +       dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", s=
tate);
>>> +       return -EINVAL;
>>> +
>>> +out:
>>> +       dev_err(di->dev, "bus error on %s: %d\n", state ? "set_cfgupdat=
e" : "soft_reset", ret);
>>> +       return ret;
>>> +}
>>> +
>>> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *=
di,
>>> +                                         struct bq27xxx_dm_buf *buf)
>>> +{
>>> +       bool cfgup =3D di->chip =3D=3D BQ27421; /* assume group support=
s cfgupdate */
>>> +       int ret;
>>> +
>>> +       if (!buf->updt)
>>> +               return 0;
>>> +
>>> +       if (cfgup) {
>>> +               ret =3D bq27xxx_battery_set_cfgupdate(di, true);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_CTRL], 0, true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_CLASS], buf->clas=
s, true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_BLOCK], buf->bloc=
k, true);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       BQ27XXX_MSLEEP(1);
>>> +
>>> +       ret =3D di->bus.write_bulk(di, di->regs[BQ27XXX_DM_DATA], buf->=
a, BQ27XXX_DM_SZ);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       ret =3D di->bus.write(di, di->regs[BQ27XXX_DM_CKSUM],
>>> +                           bq27xxx_battery_checksum_dm_block(buf), tru=
e);
>>> +       if (ret < 0)
>>> +               goto out;
>>> +
>>> +       /* THE FOLLOWING SEQUENCE IS TOXIC. DO NOT USE!
>>> +        * If the 'time' delay is insufficient, NVM corruption results =
on
>>> +        * the '425 chip (and perhaps others), which could damage the c=
hip.
>>> +        * It was suggested in this TI tool:
>>> +        *   http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#li=
ne328
>>> +        *
>>> +        * 1. MSLEEP(time) after above write(BQ27XXX_DM_CKSUM, ...)
>>> +        * 2. write(BQ27XXX_DM_BLOCK, buf->block)
>>> +        * 3. sum =3D read(BQ27XXX_DM_CKSUM)
>>> +        * 4. if (sum !=3D bq27xxx_battery_checksum_dm_block(buf))
>>> +        *      report error
>>> +        */
>>> +
>>> +       if (cfgup) {
>>> +               BQ27XXX_MSLEEP(1);
>>> +               ret =3D bq27xxx_battery_set_cfgupdate(di, false);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +       } else {
>>> +               /* flash DM updates in <100ms, but reset time isn't doc=
umented */
>>> +               BQ27XXX_MSLEEP(400);
>>> +       }
>>> +
>>> +       buf->updt =3D false;
>>> +       return 0;
>>> +
>>> +out:
>>> +       if (cfgup)
>>> +               bq27xxx_battery_set_cfgupdate(di, false);
>>> +
>>> +       dev_err(di->dev, "bus error writing chip memory: %d\n", ret);
>>> +       return ret;
>>> +}
>>> +
>>> +static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>>> +                                      struct power_supply_battery_info=
 *info)
>>> +{
>>> +       struct bq27xxx_dm_buf bd =3D BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESI=
GN_CAPACITY);
>>> +       struct bq27xxx_dm_buf bt =3D BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERM=
INATE_VOLTAGE);
>>> +
>>> +       if (info->charge_full_design_uah !=3D -EINVAL
>>> +        && info->energy_full_design_uwh !=3D -EINVAL) {
>>> +               bq27xxx_battery_read_dm_block(di, &bd);
>>> +               /* assume design energy & capacity are in same block */
>>> +               bq27xxx_battery_update_dm_block(di, &bd,
>>> +                                       BQ27XXX_DM_DESIGN_CAPACITY,
>>> +                                       info->charge_full_design_uah / =
1000);
>>> +               bq27xxx_battery_update_dm_block(di, &bd,
>>> +                                       BQ27XXX_DM_DESIGN_ENERGY,
>>> +                                       info->energy_full_design_uwh / =
1000);
>>> +       }
>>> +
>>> +       if (info->voltage_min_design_uv !=3D -EINVAL) {
>>> +               bool same =3D bd.class =3D=3D bt.class && bd.block =3D=
=3D bt.block;
>>> +               if (!same)
>>> +                       bq27xxx_battery_read_dm_block(di, &bt);
>>> +               bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
>>> +                                       BQ27XXX_DM_TERMINATE_VOLTAGE,
>>> +                                       info->voltage_min_design_uv / 1=
000);
>>> +       }
>>> +
>>> +       bq27xxx_battery_write_dm_block(di, &bd);
>>> +       bq27xxx_battery_write_dm_block(di, &bt);
>>> +}
>>> +
>>> +void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>>> +{
>>> +       struct power_supply_battery_info info =3D {};
>>> +       unsigned int min, max;
>>> +
>>> +       /* functions don't exist for writing data so abort */
>>> +       if (!di->bus.write || !di->bus.write_bulk)
>>> +               return;
>>> +
>>> +       /* no settings to be set for this chipset so abort */
>>> +       if (!di->dm_regs)
>>> +               return;
>>> +
>>> +       if (bq27xxx_battery_set_seal_state(di, false) < 0)
>>> +               return;
>>> +
>>> +       if (power_supply_get_battery_info(di->bat, &info) < 0)
>>> +               goto out;
>>> +
>>> +       if (info.energy_full_design_uwh !=3D info.charge_full_design_ua=
h) {
>>> +               if (info.energy_full_design_uwh =3D=3D -EINVAL)
>>> +                       dev_warn(di->dev,
>>> +                               "missing battery:energy-full-design-mic=
rowatt-hours\n");
>>> +               else if (info.charge_full_design_uah =3D=3D -EINVAL)
>>> +                       dev_warn(di->dev,
>>> +                               "missing battery:charge-full-design-mic=
roamp-hours\n");
>>> +       }
>>> +
>>> +       /* assume min =3D=3D 0 */
>>> +       max =3D di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
>>> +       if (info.energy_full_design_uwh > max * 1000) {
>>> +               dev_err(di->dev,
>>> +                      "invalid battery:energy-full-design-microwatt-ho=
urs %d\n",
>>> +                       info.energy_full_design_uwh);
>>> +               info.energy_full_design_uwh =3D -EINVAL;
>>> +       }
>>> +
>>> +       /* assume min =3D=3D 0 */
>>> +       max =3D di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
>>> +       if (info.charge_full_design_uah > max * 1000) {
>>> +               dev_err(di->dev,
>>> +                      "invalid battery:charge-full-design-microamp-hou=
rs %d\n",
>>> +                       info.charge_full_design_uah);
>>> +               info.charge_full_design_uah =3D -EINVAL;
>>> +       }
>>> +
>>> +       min =3D di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
>>> +       max =3D di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
>>> +       if ((info.voltage_min_design_uv < min * 1000
>>> +         || info.voltage_min_design_uv > max * 1000)
>>> +         && info.voltage_min_design_uv !=3D -EINVAL) {
>>> +               dev_err(di->dev,
>>> +                      "invalid battery:voltage-min-design-microvolt %d=
\n",
>>> +                       info.voltage_min_design_uv);
>>> +               info.voltage_min_design_uv =3D -EINVAL;
>>> +       }
>>> +
>>> +       if ((info.energy_full_design_uwh =3D=3D -EINVAL
>>> +         || info.charge_full_design_uah =3D=3D -EINVAL)
>>> +         && info.voltage_min_design_uv  =3D=3D -EINVAL)
>>> +               goto out;
>>> +
>>> +       bq27xxx_battery_set_config(di, &info);
>>> +
>>> +out:
>>> +       bq27xxx_battery_set_seal_state(di, true);
>>> +}
>>> +
>>>  /*
>>>   * Return the battery State-of-Charge
>>>   * Or < 0 if something fails.
>>> @@ -985,6 +1422,13 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>>>         case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>>                 ret =3D bq27xxx_simple_value(di->charge_design_full, va=
l);
>>>                 break;
>>> +       /*
>>> +        * TODO: Implement these to make registers set from
>>> +        * power_supply_battery_info visible in sysfs.
>>> +        */
>>> +       case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
>>> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>> +               return -EINVAL;
>>>         case POWER_SUPPLY_PROP_CYCLE_COUNT:
>>>                 ret =3D bq27xxx_simple_value(di->cache.cycle_count, val=
);
>>>                 break;
>>> @@ -1015,20 +1459,31 @@ static void bq27xxx_external_power_changed(stru=
ct power_supply *psy)
>>>         schedule_delayed_work(&di->work, 0);
>>>  }
>>>
>>> +#define BQ27XXX_INIT(c,d,k)   \
>>> +       di->chip       =3D (c); \
>>> +       di->dm_regs    =3D (d); \
>>> +       di->unseal_key =3D (k)
>>> +
>>>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>  {
>>>         struct power_supply_desc *psy_desc;
>>> -       struct power_supply_config psy_cfg =3D { .drv_data =3D di, };
>>> +       struct power_supply_config psy_cfg =3D {
>>> +               .of_node =3D di->dev->of_node,
>>> +               .drv_data =3D di,
>>> +       };
>>>
>>>         switch(di->chip) {
>>> -       case BQ27520: di->chip =3D BQ27510; break;
>>> -       case BQ27531: di->chip =3D BQ27530; break;
>>> -       case BQ27542: di->chip =3D BQ27541; break;
>>> -       case BQ27546: di->chip =3D BQ27541; break;
>>> -       case BQ27742: di->chip =3D BQ27541; break;
>>> -       case BQ27425: di->chip =3D BQ27421; break;
>>> -       case BQ27441: di->chip =3D BQ27421; break;
>>> -       case BQ27621: di->chip =3D BQ27421; break;
>>> +       case BQ27500: BQ27XXX_INIT(BQ27500, bq27500_dm_regs, 0x04143672=
); break;
>>> +       case BQ27545: BQ27XXX_INIT(BQ27545, bq27545_dm_regs, 0x04143672=
); break;
>>> +       case BQ27520: BQ27XXX_INIT(BQ27510, 0, 0); break;
>>> +       case BQ27531: BQ27XXX_INIT(BQ27530, 0, 0); break;
>>> +       case BQ27542: BQ27XXX_INIT(BQ27541, 0, 0); break;
>>> +       case BQ27546: BQ27XXX_INIT(BQ27541, 0, 0); break;
>>> +       case BQ27742: BQ27XXX_INIT(BQ27541, 0, 0); break;
>>> +       case BQ27421: BQ27XXX_INIT(BQ27421, bq27421_dm_regs, 0x80008000=
); break;
>>> +       case BQ27425: BQ27XXX_INIT(BQ27421, bq27425_dm_regs, 0x04143672=
); break;
>>> +       case BQ27441: BQ27XXX_INIT(BQ27421, bq27421_dm_regs, 0x80008000=
); break;
>>> +       case BQ27621: BQ27XXX_INIT(BQ27421, bq27621_dm_regs, 0x80008000=
); break;
>>>         default: break;
>>>         }
>>>
>>> @@ -1055,6 +1510,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_i=
nfo *di)
>>>
>>>         dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>>>
>>> +       bq27xxx_battery_settings(di);
>>>         bq27xxx_battery_update(di);
>>>
>>>         mutex_lock(&bq27xxx_list_lock);
>>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/powe=
r/bq27xxx_battery.h
>>> index 90b7ca1..9a1c30b 100644
>>> --- a/include/linux/power/bq27xxx_battery.h
>>> +++ b/include/linux/power/bq27xxx_battery.h
>>> @@ -66,6 +66,8 @@ struct bq27xxx_device_info {
>>>         int id;
>>>         enum bq27xxx_chip chip;
>>>         const char *name;
>>> +       struct bq27xxx_dm_reg* dm_regs;
>>> +       u32 unseal_key;
>>>         struct bq27xxx_access_methods bus;
>>>         struct bq27xxx_reg_cache cache;
>>>         int charge_design_full;
>>> --
>>> 2.9.3
>>>
