From: Liam Breck <liam@networkimprov.net>
Subject: Re: [RFC v2 2/5] power: supply: bq27xxx: Add chip IDs for previously
 shadowed chips
Date: Sat, 12 Aug 2017 10:56:09 -0700
Message-ID: <CAKvHMgQciRY+v0prYsfcLUOGcgzz9RRmMawwBMuKF60qC8U4Rg@mail.gmail.com>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-3-liam@networkimprov.net> <20170812150243.yglsy42mpigff6gw@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36715 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdHLR4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 13:56:10 -0400
Received: by mail-it0-f68.google.com with SMTP id o72so952030ita.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Aug 2017 10:56:10 -0700 (PDT)
In-Reply-To: <20170812150243.yglsy42mpigff6gw@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

Hi Sebastian,

On Sat, Aug 12, 2017 at 8:02 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Sun, Aug 06, 2017 at 11:22:13PM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> For the existing feature set, these chips act like ones already listed,
>> so they had been given false but functional IDs. We will be adding features
>> which obsolete that shadowing, so the following IDs are added:
>> BQ2752X, 531, 542, 546, 742, 425, 441, 621
>
> Patch looks ok, but the patch description does not match the patch?

Does this clarify it?

For the existing driver features, the chips below act like others already ID'd,
so they had been given false but functional IDs. We will be adding features
which obsolete that ID shadowing, so the following IDs are added:
BQ2752X, 531, 542, 546, 742, 425, 441, 621

>> Chip-specific features are now tracked by BQ27XXX_O_* flags in di->opts.
>>
>> No functional changes to the driver.
>>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c     | 120 +++++++++++++++++------------
>>  drivers/power/supply/bq27xxx_battery_i2c.c |  16 ++--
>>  include/linux/power/bq27xxx_battery.h      |   9 +++
>>  3 files changed, 86 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index dd84e3d9..b186216d 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -221,6 +221,7 @@ static u8
>>               [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>>               BQ27XXX_DM_REG_ROWS,
>>       },
>> +#define bq2752x_regs bq2751x_regs
>>       bq27500_regs[BQ27XXX_REG_MAX] = {
>>               [BQ27XXX_REG_CTRL] = 0x00,
>>               [BQ27XXX_REG_TEMP] = 0x06,
>> @@ -401,6 +402,7 @@ static u8
>>               [BQ27XXX_REG_AP] = 0x24,
>>               BQ27XXX_DM_REG_ROWS,
>>       },
>> +#define bq27531_regs bq27530_regs
>>       bq27541_regs[BQ27XXX_REG_MAX] = {
>>               [BQ27XXX_REG_CTRL] = 0x00,
>>               [BQ27XXX_REG_TEMP] = 0x06,
>> @@ -421,6 +423,9 @@ static u8
>>               [BQ27XXX_REG_AP] = 0x24,
>>               BQ27XXX_DM_REG_ROWS,
>>       },
>> +#define bq27542_regs bq27541_regs
>> +#define bq27546_regs bq27541_regs
>> +#define bq27742_regs bq27541_regs
>>       bq27545_regs[BQ27XXX_REG_MAX] = {
>>               [BQ27XXX_REG_CTRL] = 0x00,
>>               [BQ27XXX_REG_TEMP] = 0x06,
>> @@ -461,6 +466,9 @@ static u8
>>               [BQ27XXX_REG_AP] = 0x18,
>>               BQ27XXX_DM_REG_ROWS,
>>       };
>> +#define bq27425_regs bq27421_regs
>> +#define bq27441_regs bq27421_regs
>> +#define bq27621_regs bq27421_regs
>>
>>  static enum power_supply_property bq27000_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>> @@ -539,6 +547,7 @@ static enum power_supply_property bq2751x_props[] = {
>>       POWER_SUPPLY_PROP_HEALTH,
>>       POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq2752x_props bq2751x_props
>>
>>  static enum power_supply_property bq27500_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>> @@ -716,6 +725,7 @@ static enum power_supply_property bq27530_props[] = {
>>       POWER_SUPPLY_PROP_CYCLE_COUNT,
>>       POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq27531_props bq27530_props
>>
>>  static enum power_supply_property bq27541_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>> @@ -735,6 +745,9 @@ static enum power_supply_property bq27541_props[] = {
>>       POWER_SUPPLY_PROP_HEALTH,
>>       POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq27542_props bq27541_props
>> +#define bq27546_props bq27541_props
>> +#define bq27742_props bq27541_props
>>
>>  static enum power_supply_property bq27545_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>> @@ -768,33 +781,50 @@ static enum power_supply_property bq27421_props[] = {
>>       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>       POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq27425_props bq27421_props
>> +#define bq27441_props bq27421_props
>> +#define bq27621_props bq27421_props
>>
>> -#define BQ27XXX_DATA(ref) {                  \
>> +#define BQ27XXX_O_ZERO       0x00000001
>> +#define BQ27XXX_O_OTDC       0x00000002
>> +#define BQ27XXX_O_UTOT  0x00000004
>> +
>> +#define BQ27XXX_DATA(ref, opt) {             \
>> +     .opts = (opt),                          \
>>       .regs  = ref##_regs,                    \
>>       .props = ref##_props,                   \
>>       .props_size = ARRAY_SIZE(ref##_props) }
>>
>>  static struct {
>> +     u32 opts;
>>       u8 *regs;
>>       enum power_supply_property *props;
>>       size_t props_size;
>>  } bq27xxx_chip_data[] = {
>> -     [BQ27000]   = BQ27XXX_DATA(bq27000),
>> -     [BQ27010]   = BQ27XXX_DATA(bq27010),
>> -     [BQ2750X]   = BQ27XXX_DATA(bq2750x),
>> -     [BQ2751X]   = BQ27XXX_DATA(bq2751x),
>> -     [BQ27500]   = BQ27XXX_DATA(bq27500),
>> -     [BQ27510G1] = BQ27XXX_DATA(bq27510g1),
>> -     [BQ27510G2] = BQ27XXX_DATA(bq27510g2),
>> -     [BQ27510G3] = BQ27XXX_DATA(bq27510g3),
>> -     [BQ27520G1] = BQ27XXX_DATA(bq27520g1),
>> -     [BQ27520G2] = BQ27XXX_DATA(bq27520g2),
>> -     [BQ27520G3] = BQ27XXX_DATA(bq27520g3),
>> -     [BQ27520G4] = BQ27XXX_DATA(bq27520g4),
>> -     [BQ27530]   = BQ27XXX_DATA(bq27530),
>> -     [BQ27541]   = BQ27XXX_DATA(bq27541),
>> -     [BQ27545]   = BQ27XXX_DATA(bq27545),
>> -     [BQ27421]   = BQ27XXX_DATA(bq27421),
>> +     [BQ27000]   = BQ27XXX_DATA(bq27000,   BQ27XXX_O_ZERO),
>> +     [BQ27010]   = BQ27XXX_DATA(bq27010,   BQ27XXX_O_ZERO),
>> +     [BQ2750X]   = BQ27XXX_DATA(bq2750x,   BQ27XXX_O_OTDC),
>> +     [BQ2751X]   = BQ27XXX_DATA(bq2751x,   BQ27XXX_O_OTDC),
>> +     [BQ2752X]   = BQ27XXX_DATA(bq2752x,   BQ27XXX_O_OTDC),
>> +     [BQ27500]   = BQ27XXX_DATA(bq27500,   BQ27XXX_O_OTDC),
>> +     [BQ27510G1] = BQ27XXX_DATA(bq27510g1, BQ27XXX_O_OTDC),
>> +     [BQ27510G2] = BQ27XXX_DATA(bq27510g2, BQ27XXX_O_OTDC),
>> +     [BQ27510G3] = BQ27XXX_DATA(bq27510g3, BQ27XXX_O_OTDC),
>> +     [BQ27520G1] = BQ27XXX_DATA(bq27520g1, BQ27XXX_O_OTDC),
>> +     [BQ27520G2] = BQ27XXX_DATA(bq27520g2, BQ27XXX_O_OTDC),
>> +     [BQ27520G3] = BQ27XXX_DATA(bq27520g3, BQ27XXX_O_OTDC),
>> +     [BQ27520G4] = BQ27XXX_DATA(bq27520g4, BQ27XXX_O_OTDC),
>> +     [BQ27530]   = BQ27XXX_DATA(bq27530,   BQ27XXX_O_UTOT),
>> +     [BQ27531]   = BQ27XXX_DATA(bq27531,   BQ27XXX_O_UTOT),
>> +     [BQ27541]   = BQ27XXX_DATA(bq27541,   BQ27XXX_O_OTDC),
>> +     [BQ27542]   = BQ27XXX_DATA(bq27542,   BQ27XXX_O_OTDC),
>> +     [BQ27546]   = BQ27XXX_DATA(bq27546,   BQ27XXX_O_OTDC),
>> +     [BQ27742]   = BQ27XXX_DATA(bq27742,   BQ27XXX_O_OTDC),
>> +     [BQ27545]   = BQ27XXX_DATA(bq27545,   BQ27XXX_O_OTDC),
>> +     [BQ27421]   = BQ27XXX_DATA(bq27421,   BQ27XXX_O_UTOT),
>> +     [BQ27425]   = BQ27XXX_DATA(bq27425,   BQ27XXX_O_UTOT),
>> +     [BQ27441]   = BQ27XXX_DATA(bq27441,   BQ27XXX_O_UTOT),
>> +     [BQ27621]   = BQ27XXX_DATA(bq27621,   BQ27XXX_O_UTOT),
>>  };
>>
>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>> @@ -1327,7 +1357,7 @@ static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
>>  {
>>       int soc;
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               soc = bq27xxx_read(di, BQ27XXX_REG_SOC, true);
>>       else
>>               soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
>> @@ -1353,7 +1383,7 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
>>               return charge;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               charge *= BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>>       else
>>               charge *= 1000;
>> @@ -1369,7 +1399,7 @@ static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
>>  {
>>       int flags;
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010) {
>> +     if (di->opts & BQ27XXX_O_ZERO) {
>>               flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
>>               if (flags >= 0 && (flags & BQ27000_FLAG_CI))
>>                       return -ENODATA;
>> @@ -1395,7 +1425,7 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>>  {
>>       int dcap;
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, true);
>>       else
>>               dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
>> @@ -1405,7 +1435,7 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>>               return dcap;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               dcap = (dcap << 8) * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>>       else
>>               dcap *= 1000;
>> @@ -1427,7 +1457,7 @@ static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
>>               return ae;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               ae *= BQ27XXX_POWER_CONSTANT / BQ27XXX_RS;
>>       else
>>               ae *= 1000;
>> @@ -1449,7 +1479,7 @@ static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di)
>>               return temp;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               temp = 5 * temp / 2;
>>
>>       return temp;
>> @@ -1506,7 +1536,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
>>               return tval;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
>>       else
>>               return tval;
>> @@ -1517,26 +1547,12 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
>>   */
>>  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>>  {
>> -     switch (di->chip) {
>> -     case BQ2750X:
>> -     case BQ2751X:
>> -     case BQ27500:
>> -     case BQ27510G1:
>> -     case BQ27510G2:
>> -     case BQ27510G3:
>> -     case BQ27520G1:
>> -     case BQ27520G2:
>> -     case BQ27520G3:
>> -     case BQ27520G4:
>> -     case BQ27541:
>> -     case BQ27545:
>> +     if (di->opts & BQ27XXX_O_OTDC)
>>               return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>> -     case BQ27530:
>> -     case BQ27421:
>> +        if (di->opts & BQ27XXX_O_UTOT)
>>               return flags & BQ27XXX_FLAG_OT;
>> -     default:
>> -             return false;
>> -     }
>> +
>> +     return false;
>>  }
>>
>>  /*
>> @@ -1544,7 +1560,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>>   */
>>  static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
>>  {
>> -     if (di->chip == BQ27530 || di->chip == BQ27421)
>> +     if (di->opts & BQ27XXX_O_UTOT)
>>               return flags & BQ27XXX_FLAG_UT;
>>
>>       return false;
>> @@ -1555,7 +1571,7 @@ static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
>>   */
>>  static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
>>  {
>> -     if (di->chip == BQ27000 || di->chip == BQ27010)
>> +     if (di->opts & BQ27XXX_O_ZERO)
>>               return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
>>       else
>>               return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
>> @@ -1568,7 +1584,7 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
>>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>>  {
>>       int flags;
>> -     bool has_singe_flag = di->chip == BQ27000 || di->chip == BQ27010;
>> +     bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>>
>>       flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>>       if (flags < 0) {
>> @@ -1590,8 +1606,8 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>>  void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>>  {
>>       struct bq27xxx_reg_cache cache = {0, };
>> -     bool has_ci_flag = di->chip == BQ27000 || di->chip == BQ27010;
>> -     bool has_singe_flag = di->chip == BQ27000 || di->chip == BQ27010;
>> +     bool has_ci_flag = di->opts & BQ27XXX_O_ZERO;
>> +     bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>>
>>       cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>>       if ((cache.flags & 0xff) == 0xff)
>> @@ -1669,7 +1685,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
>>               return curr;
>>       }
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010) {
>> +     if (di->opts & BQ27XXX_O_ZERO) {
>>               flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
>>               if (flags & BQ27000_FLAG_CHGS) {
>>                       dev_dbg(di->dev, "negative current!\n");
>> @@ -1690,7 +1706,7 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>>  {
>>       int status;
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010) {
>> +     if (di->opts & BQ27XXX_O_ZERO) {
>>               if (di->cache.flags & BQ27000_FLAG_FC)
>>                       status = POWER_SUPPLY_STATUS_FULL;
>>               else if (di->cache.flags & BQ27000_FLAG_CHGS)
>> @@ -1718,7 +1734,7 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>>  {
>>       int level;
>>
>> -     if (di->chip == BQ27000 || di->chip == BQ27010) {
>> +     if (di->opts & BQ27XXX_O_ZERO) {
>>               if (di->cache.flags & BQ27000_FLAG_FC)
>>                       level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
>>               else if (di->cache.flags & BQ27000_FLAG_EDV1)
>> @@ -1883,7 +1899,9 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>
>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>       mutex_init(&di->lock);
>> +
>>       di->regs = bq27xxx_chip_data[di->chip].regs;
>> +     di->opts = bq27xxx_chip_data[di->chip].opts;
>>
>>       psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>>       if (!psy_desc)
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index a5972214..0b11ed47 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -230,7 +230,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>       { "bq27210", BQ27010 },
>>       { "bq27500", BQ2750X },
>>       { "bq27510", BQ2751X },
>> -     { "bq27520", BQ2751X },
>> +     { "bq27520", BQ2752X },
>>       { "bq27500-1", BQ27500 },
>>       { "bq27510g1", BQ27510G1 },
>>       { "bq27510g2", BQ27510G2 },
>> @@ -240,16 +240,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>       { "bq27520g3", BQ27520G3 },
>>       { "bq27520g4", BQ27520G4 },
>>       { "bq27530", BQ27530 },
>> -     { "bq27531", BQ27530 },
>> +     { "bq27531", BQ27531 },
>>       { "bq27541", BQ27541 },
>> -     { "bq27542", BQ27541 },
>> -     { "bq27546", BQ27541 },
>> -     { "bq27742", BQ27541 },
>> +     { "bq27542", BQ27542 },
>> +     { "bq27546", BQ27546 },
>> +     { "bq27742", BQ27742 },
>>       { "bq27545", BQ27545 },
>>       { "bq27421", BQ27421 },
>> -     { "bq27425", BQ27421 },
>> -     { "bq27441", BQ27421 },
>> -     { "bq27621", BQ27421 },
>> +     { "bq27425", BQ27425 },
>> +     { "bq27441", BQ27441 },
>> +     { "bq27621", BQ27621 },
>>       {},
>>  };
>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 11e11685..77fe94f1 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -6,6 +6,7 @@ enum bq27xxx_chip {
>>       BQ27010, /* bq27010, bq27210 */
>>       BQ2750X, /* bq27500 deprecated alias */
>>       BQ2751X, /* bq27510, bq27520 deprecated alias */
>> +     BQ2752X,
>>       BQ27500, /* bq27500/1 */
>>       BQ27510G1, /* bq27510G1 */
>>       BQ27510G2, /* bq27510G2 */
>> @@ -15,9 +16,16 @@ enum bq27xxx_chip {
>>       BQ27520G3, /* bq27520G3 */
>>       BQ27520G4, /* bq27520G4 */
>>       BQ27530, /* bq27530, bq27531 */
>> +     BQ27531,
>>       BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>> +     BQ27542,
>> +     BQ27546,
>> +     BQ27742,
>>       BQ27545, /* bq27545 */
>>       BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>> +     BQ27425,
>> +     BQ27441,
>> +     BQ27621,
>>  };
>>
>>  /**
>> @@ -64,6 +72,7 @@ struct bq27xxx_device_info {
>>       int id;
>>       enum bq27xxx_chip chip;
>>       bool ram_chip;
>> +     u32 opts;
>>       const char *name;
>>       struct bq27xxx_dm_reg *dm_regs;
>>       u32 unseal_key;
>> --
>> 2.13.2
>>
