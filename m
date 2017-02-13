From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v6 7/8] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Sun, 12 Feb 2017 18:32:59 -0800
Message-ID: <CAKvHMgQQ16+Xcffz8hE8oRPFhPMq7xtPDDXCP5mnJnh8ma7aDg@mail.gmail.com>
References: <20170211024340.19491-1-liam@networkimprov.net> <20170211024340.19491-8-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33864 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdBMCdG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Feb 2017 21:33:06 -0500
Received: by mail-it0-f65.google.com with SMTP id o185so10923425itb.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Feb 2017 18:33:05 -0800 (PST)
In-Reply-To: <20170211024340.19491-8-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

Hi Andrew,

Based on Sebastian's feedback on v1-4 of this patchset, I believe it
will go upstream. (He hasn't written anything on linux-pm since before
I posted v5 a week ago.)

Could we get your feedback on making this adaptable to the rest of the
BQ27 family? Specifically...

Is the op sequence in these functions common across the chips?

bq27xxx_battery_set_seal_state()
bq27xxx_battery_read_dm_block()
bq27xxx_battery_write_dm_block()

Should we move these constants to bq27xxx_regs[chip][name]?

/* writable registers */
#define BQ27XXX_DATA_CLASS             0x3E
#define BQ27XXX_DATA_BLOCK             0x3F
#define BQ27XXX_BLOCK_DATA             0x40
#define BQ27XXX_BLOCK_DATA_CHECKSUM    0x60
#define BQ27XXX_BLOCK_DATA_CONTROL     0x61

/* writable register inputs */
#define BQ27XXX_SET_CFGUPDATE          0x13
#define BQ27XXX_SOFT_RESET             0x42
#define BQ27XXX_SUBCLASS_STATE_NVM     82

If you are dead set against including this in bq27xxx_battery, we
could site the code in a companion module loaded by the I2C module.
Then the main module calls just one function.

Thanks,
Liam


On Fri, Feb 10, 2017 at 6:43 PM, Liam Breck <liam@networkimprov.net> wrote:
> From: Matt Ranostay <matt@ranostay.consulting>
>
> Previously there was no way to set chip registers in the event that the
> defaults didn't match the battery in question.
>
> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
> and writes battery data to non-volatile memory.
>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 302 ++++++++++++++++++++++++++++++++-
>  1 file changed, 301 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 7475a5f..70d0142 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -37,6 +37,7 @@
>   * http://www.ti.com/product/bq27621-g1
>   */
>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -452,6 +453,59 @@ static struct {
>  static DEFINE_MUTEX(bq27xxx_list_lock);
>  static LIST_HEAD(bq27xxx_battery_devices);
>
> +#define BQ27XXX_TERM_V_MIN     2800
> +#define BQ27XXX_TERM_V_MAX     3700
> +
> +#define BQ27XXX_BLOCK_DATA_CLASS       0x3E
> +#define BQ27XXX_DATA_BLOCK             0x3F
> +#define BQ27XXX_BLOCK_DATA             0x40
> +#define BQ27XXX_BLOCK_DATA_CHECKSUM    0x60
> +#define BQ27XXX_BLOCK_DATA_CONTROL     0x61
> +#define BQ27XXX_SET_CFGUPDATE          0x13
> +#define BQ27XXX_SOFT_RESET             0x42
> +#define BQ27XXX_SUBCLASS_STATE_NVM     82
> +
> +struct bq27xxx_dm_buf {
> +       u8 a[32];
> +};
> +
> +struct bq27xxx_dm_reg {
> +       unsigned int subclass_id;
> +       unsigned int offset;
> +       unsigned int bytes;
> +       char *name;
> +};
> +
> +#define BQ27XXX_DM_SUPPORTED(r) ( \
> +          r->subclass_id == BQ27XXX_SUBCLASS_STATE_NVM \
> +       && r->offset <= 30 \
> +       && r->bytes == 2 \
> +)
> +
> +enum bq27xxx_dm_reg_id {
> +       BQ27XXX_DM_DESIGN_CAPACITY = 0,
> +       BQ27XXX_DM_DESIGN_ENERGY,
> +       BQ27XXX_DM_TERMINATE_VOLTAGE,
> +       BQ27XXX_DM_END,
> +};
> +
> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
> +       [BQ27XXX_DM_DESIGN_CAPACITY] =
> +               { BQ27XXX_SUBCLASS_STATE_NVM, 12, 2, "design-capacity" },
> +       [BQ27XXX_DM_DESIGN_ENERGY] =
> +               { BQ27XXX_SUBCLASS_STATE_NVM, 14, 2, "design-energy" },
> +       [BQ27XXX_DM_TERMINATE_VOLTAGE] =
> +               { BQ27XXX_SUBCLASS_STATE_NVM, 18, 2, "terminate-voltage" },
> +};
> +
> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
> +       [BQ27425] = bq27425_dm_regs,
> +};
> +
> +static unsigned int bq27xxx_unseal_keys[] = {
> +       [BQ27425] = 0x04143672,
> +};
> +
>  static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
>  {
>         struct bq27xxx_device_info *di;
> @@ -496,6 +550,183 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>         return di->bus.read(di, di->regs[reg_index], single);
>  }
>
> +static int bq27xxx_battery_set_seal_state(struct bq27xxx_device_info *di,
> +                                         bool state)
> +{
> +       unsigned int key = bq27xxx_unseal_keys[di->chip];
> +       int ret;
> +
> +       if (state)
> +               return di->bus.write(di, BQ27XXX_REG_CTRL, 0x20, false);
> +
> +       ret = di->bus.write(di, BQ27XXX_REG_CTRL, (key >> 16) & 0xffff, false);
> +       if (ret < 0)
> +               return ret;
> +
> +       return di->bus.write(di, BQ27XXX_REG_CTRL, key & 0xffff, false);
> +}
> +
> +static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
> +                                        int subclass,
> +                                        struct bq27xxx_dm_buf *buf)
> +{
> +       int ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_REG_CTRL, 0, false);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CONTROL, 0, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CLASS, subclass, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, 0, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(1000, 1500);
> +
> +       return di->bus.read_bulk(di, BQ27XXX_BLOCK_DATA, buf->a, sizeof buf->a);
> +}
> +
> +static int bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
> +{
> +       struct bq27xxx_dm_buf buf;
> +       struct bq27xxx_dm_reg *reg = bq27xxx_dm_regs[di->chip];
> +       int ret, i;
> +
> +       ret = bq27xxx_battery_read_dm_block(di, BQ27XXX_SUBCLASS_STATE_NVM,
> +                                           &buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       for (i = 0; i < BQ27XXX_DM_END; i++, reg++) {
> +               int val;
> +
> +               if (!BQ27XXX_DM_SUPPORTED(reg)) {
> +                       dev_warn(di->dev, "unsupported config register %s\n", reg->name);
> +                       continue;
> +               }
> +
> +               val = be16_to_cpup((u16 *) &buf.a[reg->offset]);
> +
> +               dev_info(di->dev, "config register %s set at %d\n", reg->name, val);
> +       }
> +
> +       return 0;
> +}
> +
> +static bool bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
> +                                           struct bq27xxx_dm_buf *buf,
> +                                           enum bq27xxx_dm_reg_id reg_id,
> +                                           unsigned int val)
> +{
> +       struct bq27xxx_dm_reg *reg = &bq27xxx_dm_regs[di->chip][reg_id];
> +       u16 *prev;
> +
> +       if (!BQ27XXX_DM_SUPPORTED(reg))
> +               return false;
> +
> +       prev = (u16 *) &buf->a[reg->offset];
> +
> +       if (be16_to_cpup(prev) == val)
> +               return false;
> +
> +       *prev = cpu_to_be16(val);
> +
> +       return true;
> +}
> +
> +static u8 bq27xxx_battery_checksum(struct bq27xxx_dm_buf *buf)
> +{
> +       u16 sum = 0;
> +       int i;
> +
> +       for (i = 0; i < sizeof buf->a; i++) {
> +               sum += buf->a[i];
> +               sum &= 0xff;
> +       }
> +
> +       return 0xff - sum;
> +}
> +
> +static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
> +                                         int subclass,
> +                                         struct bq27xxx_dm_buf *buf)
> +{
> +       int ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_SET_CFGUPDATE, false);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CONTROL, 0, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CLASS, subclass, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, 0, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = di->bus.write_bulk(di, BQ27XXX_BLOCK_DATA, buf->a, sizeof buf->a);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(1000, 1500);
> +
> +       ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CHECKSUM,
> +                           bq27xxx_battery_checksum(buf), true);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(1000, 1500);
> +
> +       return di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_SOFT_RESET, false);
> +}
> +
> +static int bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
> +                                     struct power_supply_battery_info *info)
> +{
> +       struct bq27xxx_dm_buf buf;
> +       int ret;
> +
> +       ret = bq27xxx_battery_read_dm_block(di, BQ27XXX_SUBCLASS_STATE_NVM,
> +                                           &buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (info->charge_full_design_uah != -EINVAL
> +        && info->energy_full_design_uwh != -EINVAL) {
> +               ret |= bq27xxx_battery_update_dm_block(di, &buf,
> +                                       BQ27XXX_DM_DESIGN_CAPACITY,
> +                                       info->charge_full_design_uah / 1000);
> +               ret |= bq27xxx_battery_update_dm_block(di, &buf,
> +                                       BQ27XXX_DM_DESIGN_ENERGY,
> +                                       info->energy_full_design_uwh / 1000);
> +       }
> +
> +       if (info->voltage_min_design_uv != -EINVAL)
> +               ret |= bq27xxx_battery_update_dm_block(di, &buf,
> +                                       BQ27XXX_DM_TERMINATE_VOLTAGE,
> +                                       info->voltage_min_design_uv / 1000);
> +
> +       if (ret) {
> +               dev_info(di->dev, "updating NVM settings\n");
> +               return bq27xxx_battery_write_dm_block(di, BQ27XXX_SUBCLASS_STATE_NVM,
> +                                                     &buf);
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Return the battery State-of-Charge
>   * Or < 0 if something fails.
> @@ -757,6 +988,64 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>         return POWER_SUPPLY_HEALTH_GOOD;
>  }
>
> +void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
> +{
> +       struct power_supply_battery_info info = {};
> +
> +       /* functions don't exist for writing data so abort */
> +       if (!di->bus.write || !di->bus.write_bulk)
> +               return;
> +
> +       /* no settings to be set for this chipset so abort */
> +       if (!bq27xxx_dm_regs[di->chip])
> +               return;
> +
> +       bq27xxx_battery_set_seal_state(di, false);
> +
> +       if (power_supply_get_battery_info(di->bat, &info) < 0)
> +               goto out;
> +
> +       if (info.energy_full_design_uwh != info.charge_full_design_uah) {
> +               if (info.energy_full_design_uwh == -EINVAL)
> +                       dev_warn(di->dev,
> +                               "missing battery:energy-full-design-microwatt-hours\n");
> +               else if (info.charge_full_design_uah == -EINVAL)
> +                       dev_warn(di->dev,
> +                               "missing battery:charge-full-design-microamp-hours\n");
> +       }
> +
> +       if (info.energy_full_design_uwh > 0x7fff * 1000) {
> +               dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
> +                       info.energy_full_design_uwh);
> +               info.energy_full_design_uwh = -EINVAL;
> +       }
> +
> +       if (info.charge_full_design_uah > 0x7fff * 1000) {
> +               dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
> +                       info.charge_full_design_uah);
> +               info.charge_full_design_uah = -EINVAL;
> +       }
> +
> +       if ((info.voltage_min_design_uv < BQ27XXX_TERM_V_MIN * 1000
> +         || info.voltage_min_design_uv > BQ27XXX_TERM_V_MAX * 1000)
> +         && info.voltage_min_design_uv != -EINVAL) {
> +               dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
> +                       info.voltage_min_design_uv);
> +               info.voltage_min_design_uv = -EINVAL;
> +       }
> +
> +       if ((info.energy_full_design_uwh == -EINVAL
> +         || info.charge_full_design_uah == -EINVAL)
> +         && info.voltage_min_design_uv  == -EINVAL)
> +               goto out;
> +
> +       bq27xxx_battery_set_config(di, &info);
> +
> +out:
> +       bq27xxx_battery_print_config(di);
> +       bq27xxx_battery_set_seal_state(di, true);
> +}
> +
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  {
>         struct bq27xxx_reg_cache cache = {0, };
> @@ -1006,6 +1295,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>                 ret = bq27xxx_simple_value(di->charge_design_full, val);
>                 break;
> +       /*
> +        * TODO: Implement these to make registers set from
> +        * power_supply_battery_info visible in sysfs.
> +        */
> +       case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +               return -EINVAL;
>         case POWER_SUPPLY_PROP_CYCLE_COUNT:
>                 ret = bq27xxx_simple_value(di->cache.cycle_count, val);
>                 break;
> @@ -1039,7 +1335,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  {
>         struct power_supply_desc *psy_desc;
> -       struct power_supply_config psy_cfg = { .drv_data = di, };
> +       struct power_supply_config psy_cfg = {
> +               .of_node = di->dev->of_node,
> +               .drv_data = di,
> +       };
>
>         INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>         mutex_init(&di->lock);
> @@ -1064,6 +1363,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>
>         dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>
> +       bq27xxx_battery_settings(di);
>         bq27xxx_battery_update(di);
>
>         mutex_lock(&bq27xxx_list_lock);
> --
> 2.9.3
>
