From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Wed, 5 Jul 2017 23:06:31 -0700
Message-ID: <CAKvHMgQ3bqzi5Y4x2KGL4_koaciYm5fSxO3nom6U7zbGUgdz0Q@mail.gmail.com>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net> <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
 <20170616103307.bfl6ig66qeq2qvz6@earth> <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
 <20170703164833.govvgqz7xxbeuycv@earth> <CAKvHMgQr98kEtp6obizO94zy84990uZ=2_iowfn+EFQDUvPHmg@mail.gmail.com>
 <20170705094732.jxpf3yoiqb276e36@earth> <CAKvHMgSLYDfrbfwJYLha90s=4F+DeaANUEVrk+0OB8JbsjEsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34788 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdGFGGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 02:06:33 -0400
Received: by mail-it0-f67.google.com with SMTP id o202so17492832itc.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2017 23:06:32 -0700 (PDT)
In-Reply-To: <CAKvHMgSLYDfrbfwJYLha90s=4F+DeaANUEVrk+0OB8JbsjEsQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

Hi Sebastian,

On Wed, Jul 5, 2017 at 10:49 AM, Liam Breck <liam@networkimprov.net> wrote:
> Hi Sebastian,
>
> On Wed, Jul 5, 2017 at 2:47 AM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
>> Hi,
>>
>> On Tue, Jul 04, 2017 at 04:24:05PM -0700, Liam Breck wrote:
>>> OK, below is a minimal change to bq27xxx_battery.c creating a single
>>> data table for all chips. It can easily be extended with new fields
>>> for my patchset.
>>
>> Patch looks good.
>>
>>> This is probably safe to upstream without testing on all the chips, as
>>> it was mostly search/replace. However various conditionals test the
>>> chip ID, so when adding the rest of the IDs (previously only in
>>> real_chip) in the next patch, I'd have to touch that code, but I have
>>> no way of testing all the affected parts. I could use .acts_like =
>>> OTHER_ID in the data table to minimize that risk. Thoughts?
>>
>> As far as I can see there are only a couple of different things
>> di->chip is used for:
>>
>> di->chip == BQ27421 => flag_cfgupdate,
>> di->chip == BQ27000 || di->chip == BQ27010 => flag_single,
>> di->chip == BQ27530 || di->chip == BQ27421 => flag_temp_ot_ut,
>
> There are two more cases. Also there's a lot more which could be added
> to the driver down the road. Therefore I'd suggest a single u32 field
> and bitwise flags. Then the table has:
>
> [BQ27421]   = BQ27XXX_DATA(bq27421, BQ27OPT_CFGUP | BQ27OPT_OTUT | BQ27OPT_RAM)
>
>> If we add those flags to bq27xxx_battery_data we do not need
>> to check di->chip in the driver at all.
>
> I can define .opts in the table, and constants for the two cases I'm
> responsible for. Outside of those, this idea has me changing a LOT of
> logic for chips I cannot test, which isn't fail-safe. I would like to
> leave that logic as-is and do the following after setup() is done with
> bq27xxx_battery_data[di->chip].*
>
> di->chip = bq27xxx_battery_data[di->chip].acts_like
>    //todo migrate this and other di->chip uses to di->opts

Below is a second patch which adds the missing IDs and enables the
.opts field in table. Specific opts would be defined in subsequent
patches.

Re the defines at the top of the patch, I first tried pointers to the
referenced arrays, but C rejects that in a static initializer.


From: Liam Breck <kernel@networkimprov.net>

power: supply: bq27xxx: add chip IDs for previously unlisted supported chips

No functional change to the driver.

---
 drivers/power/supply/bq27xxx_battery.c     | 65 ++++++++++++++++++++++--------
 drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++----
 include/linux/power/bq27xxx_battery.h      |  9 +++++
 3 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c
b/drivers/power/supply/bq27xxx_battery.c
index 9769a83cd2db9..c7039d4ba6d07 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -221,6 +221,7 @@ static u8
         [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
         BQ27XXX_DM_REG_ROWS,
     },
+#define bq2752x_regs bq2751x_regs
     bq27500_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
@@ -401,6 +402,7 @@ static u8
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
+#define bq27531_regs bq27530_regs
     bq27541_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
@@ -421,6 +423,9 @@ static u8
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
+#define bq27542_regs bq27541_regs
+#define bq27546_regs bq27541_regs
+#define bq27742_regs bq27541_regs
     bq27545_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
@@ -461,6 +466,9 @@ static u8
         [BQ27XXX_REG_AP] = 0x18,
         BQ27XXX_DM_REG_ROWS,
     };
+#define bq27425_regs bq27421_regs
+#define bq27441_regs bq27421_regs
+#define bq27621_regs bq27421_regs

 static enum power_supply_property bq27000_props[] = {
     POWER_SUPPLY_PROP_STATUS,
@@ -539,6 +547,7 @@ static enum power_supply_property bq2751x_props[] = {
     POWER_SUPPLY_PROP_HEALTH,
     POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq2752x_props bq2751x_props

 static enum power_supply_property bq27500_props[] = {
     POWER_SUPPLY_PROP_STATUS,
@@ -716,6 +725,7 @@ static enum power_supply_property bq27530_props[] = {
     POWER_SUPPLY_PROP_CYCLE_COUNT,
     POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27531_props bq27530_props

 static enum power_supply_property bq27541_props[] = {
     POWER_SUPPLY_PROP_STATUS,
@@ -735,6 +745,9 @@ static enum power_supply_property bq27541_props[] = {
     POWER_SUPPLY_PROP_HEALTH,
     POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27542_props bq27541_props
+#define bq27546_props bq27541_props
+#define bq27742_props bq27541_props

 static enum power_supply_property bq27545_props[] = {
     POWER_SUPPLY_PROP_STATUS,
@@ -768,33 +781,48 @@ static enum power_supply_property bq27421_props[] = {
     POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
     POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27425_props bq27421_props
+#define bq27441_props bq27421_props
+#define bq27621_props bq27421_props

-#define BQ27XXX_DATA(ref) {            \
+#define BQ27XXX_DATA(ref, act, opt) {        \
+    .opts = (opt),                \
+    .acts_like = act,            \
     .regs  = bq27##ref##_regs,        \
     .props = bq27##ref##_props,        \
     .props_size = ARRAY_SIZE(bq27##ref##_props) }

 static struct {
+    u32 opts;
+    int acts_like; //todo drop this when opts fully implemented
     u8 *regs;
     enum power_supply_property *props;
     size_t props_size;
 } bq27xxx_battery_data[] = {
-    [BQ27000]   = BQ27XXX_DATA(000),
-    [BQ27010]   = BQ27XXX_DATA(010),
-    [BQ2750X]   = BQ27XXX_DATA(50x),
-    [BQ2751X]   = BQ27XXX_DATA(51x),
-    [BQ27500]   = BQ27XXX_DATA(500),
-    [BQ27510G1] = BQ27XXX_DATA(510g1),
-    [BQ27510G2] = BQ27XXX_DATA(510g2),
-    [BQ27510G3] = BQ27XXX_DATA(510g3),
-    [BQ27520G1] = BQ27XXX_DATA(520g1),
-    [BQ27520G2] = BQ27XXX_DATA(520g2),
-    [BQ27520G3] = BQ27XXX_DATA(520g3),
-    [BQ27520G4] = BQ27XXX_DATA(520g4),
-    [BQ27530]   = BQ27XXX_DATA(530),
-    [BQ27541]   = BQ27XXX_DATA(541),
-    [BQ27545]   = BQ27XXX_DATA(545),
-    [BQ27421]   = BQ27XXX_DATA(421),
+    [BQ27000]   = BQ27XXX_DATA(000,   BQ27000, 0),
+    [BQ27010]   = BQ27XXX_DATA(010,   BQ27010, 0),
+    [BQ2750X]   = BQ27XXX_DATA(50x,   BQ2750X, 0),
+    [BQ2751X]   = BQ27XXX_DATA(51x,   BQ2751X, 0),
+    [BQ2752X]   = BQ27XXX_DATA(52x,   BQ2751X, 0),
+    [BQ27500]   = BQ27XXX_DATA(500,   BQ27500, 0),
+    [BQ27510G1] = BQ27XXX_DATA(510g1, BQ27510G1, 0),
+    [BQ27510G2] = BQ27XXX_DATA(510g2, BQ27510G2, 0),
+    [BQ27510G3] = BQ27XXX_DATA(510g3, BQ27510G3, 0),
+    [BQ27520G1] = BQ27XXX_DATA(520g1, BQ27520G1, 0),
+    [BQ27520G2] = BQ27XXX_DATA(520g2, BQ27520G2, 0),
+    [BQ27520G3] = BQ27XXX_DATA(520g3, BQ27520G3, 0),
+    [BQ27520G4] = BQ27XXX_DATA(520g4, BQ27520G4, 0),
+    [BQ27530]   = BQ27XXX_DATA(530,   BQ27530, 0),
+    [BQ27531]   = BQ27XXX_DATA(531,   BQ27530, 0),
+    [BQ27541]   = BQ27XXX_DATA(541,   BQ27541, 0),
+    [BQ27542]   = BQ27XXX_DATA(542,   BQ27541, 0),
+    [BQ27546]   = BQ27XXX_DATA(546,   BQ27541, 0),
+    [BQ27742]   = BQ27XXX_DATA(742,   BQ27541, 0),
+    [BQ27545]   = BQ27XXX_DATA(545,   BQ27545, 0),
+    [BQ27421]   = BQ27XXX_DATA(421,   BQ27421, 0),
+    [BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0),
+    [BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0),
+    [BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0),
 };

 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1902,6 +1930,9 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
         return PTR_ERR(di->bat);
     }

+    di->opts = bq27xxx_battery_data[di->chip].opts;
+    di->chip = bq27xxx_battery_data[di->chip].acts_like;
+
     dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);

     bq27xxx_battery_settings(di);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c
b/drivers/power/supply/bq27xxx_battery_i2c.c
index a5972214f0742..0b11ed472f338 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -230,7 +230,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
     { "bq27210", BQ27010 },
     { "bq27500", BQ2750X },
     { "bq27510", BQ2751X },
-    { "bq27520", BQ2751X },
+    { "bq27520", BQ2752X },
     { "bq27500-1", BQ27500 },
     { "bq27510g1", BQ27510G1 },
     { "bq27510g2", BQ27510G2 },
@@ -240,16 +240,16 @@ static const struct i2c_device_id
bq27xxx_i2c_id_table[] = {
     { "bq27520g3", BQ27520G3 },
     { "bq27520g4", BQ27520G4 },
     { "bq27530", BQ27530 },
-    { "bq27531", BQ27530 },
+    { "bq27531", BQ27531 },
     { "bq27541", BQ27541 },
-    { "bq27542", BQ27541 },
-    { "bq27546", BQ27541 },
-    { "bq27742", BQ27541 },
+    { "bq27542", BQ27542 },
+    { "bq27546", BQ27546 },
+    { "bq27742", BQ27742 },
     { "bq27545", BQ27545 },
     { "bq27421", BQ27421 },
-    { "bq27425", BQ27421 },
-    { "bq27441", BQ27421 },
-    { "bq27621", BQ27421 },
+    { "bq27425", BQ27425 },
+    { "bq27441", BQ27441 },
+    { "bq27621", BQ27621 },
     {},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
diff --git a/include/linux/power/bq27xxx_battery.h
b/include/linux/power/bq27xxx_battery.h
index 11e11685dd1d5..77fe94f1d5f25 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -6,6 +6,7 @@ enum bq27xxx_chip {
     BQ27010, /* bq27010, bq27210 */
     BQ2750X, /* bq27500 deprecated alias */
     BQ2751X, /* bq27510, bq27520 deprecated alias */
+    BQ2752X,
     BQ27500, /* bq27500/1 */
     BQ27510G1, /* bq27510G1 */
     BQ27510G2, /* bq27510G2 */
@@ -15,9 +16,16 @@ enum bq27xxx_chip {
     BQ27520G3, /* bq27520G3 */
     BQ27520G4, /* bq27520G4 */
     BQ27530, /* bq27530, bq27531 */
+    BQ27531,
     BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
+    BQ27542,
+    BQ27546,
+    BQ27742,
     BQ27545, /* bq27545 */
     BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+    BQ27425,
+    BQ27441,
+    BQ27621,
 };

 /**
@@ -64,6 +72,7 @@ struct bq27xxx_device_info {
     int id;
     enum bq27xxx_chip chip;
     bool ram_chip;
+    u32 opts;
     const char *name;
     struct bq27xxx_dm_reg *dm_regs;
     u32 unseal_key;
