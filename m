From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Tue, 4 Jul 2017 16:24:05 -0700
Message-ID: <CAKvHMgQr98kEtp6obizO94zy84990uZ=2_iowfn+EFQDUvPHmg@mail.gmail.com>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net> <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
 <20170616103307.bfl6ig66qeq2qvz6@earth> <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
 <20170703164833.govvgqz7xxbeuycv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33555 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdGDXYG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 19:24:06 -0400
Received: by mail-it0-f65.google.com with SMTP id 188so12502205itx.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 16:24:06 -0700 (PDT)
In-Reply-To: <20170703164833.govvgqz7xxbeuycv@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

Hi Sebastian,

On Mon, Jul 3, 2017 at 9:48 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> ...
>> >> >> +     { "bq27621",   (BQ27621   << 16) |  BQ27421   },
>> >> >
>> >> > This is ugly. The proper way to do this is by providing a pointer
>> >> > to a structure with all required information. E.g.:
>> >> >
>> >> > static const struct bq27xxx_pdata chip_info_bq27530 {
>> >> >     .reg_layout = &reg_info_bq27530,
>> >> >     .feature = false,
>> >> >     /* more stuff */
>> >> > };
>> >> >
>> >> > static const struct bq27xxx_pdata chip_info_bq27531 {
>> >> >     .reg_layout = &reg_info_bq27530,
>> >> >     .feature = true,
>> >> >     /* more stuff */
>> >> > };
>> >> >
>> >> > /* ... */
>> >> >
>> >> > static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>> >> > /* ... */
>> >> > { "bq27530", &chip_info_bq27530 },
>> >> > { "bq27531", &chip_info_bq27531 },
>> >> > /* ... */
>> >> > }
>> >>
>> >> How's this...
>> >>
>> >> static const struct bq27xxx_chip_ids[] = {
>> >>   [BQ27425] = { .chip = BQ27421, .real_chip = BQ27425 },
>> >>   ...
>> >> }
>> >>
>> >> static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>> >>   { "bq27425", &bq27xxx_chip_ids[BQ27425] },
>> >> ...
>> >
>> > That's better, but let's get rid of real_chip. Just add the required
>> > information directly to the above struct (e.g. seal_key, ramtype).
>>
>> I don't think the new chip data belongs in bq27*_i2c.c.
>> All the (extensive) existing chip data is in the main file.
>
> Obviously. That's how it works when you supply a chip_id instead
> of a pointer to the chip_info. bq27xxx outgrew being simple enough
> to just provide a chip_id.
>
>> A later patch could rework the chip data scheme; I was trying to
>> minimize changes in this one.
>
> Trying to generate small changes is appreciated, creating hacks is
> not.
>
>> The original i2c table did a real_chip
>> -> chip mapping. Now we're just carrying real_chip forward.
>>
>> The easiest fix would be to define a macro which does << and |
>>
>> { "bq27621",   BQ27XXX_ID_PAIR(BQ27621, BQ27421) },
>
> We do not want the easiest hack adding support, but a clean solution
> acceptable for the mainline kernel. I consider the real_chip stuff
> not very readable^W^W^W a huge mess.

OK, below is a minimal change to bq27xxx_battery.c creating a single
data table for all chips. It can easily be extended with new fields
for my patchset.

This is probably safe to upstream without testing on all the chips, as
it was mostly search/replace. However various conditionals test the
chip ID, so when adding the rest of the IDs (previously only in
real_chip) in the next patch, I'd have to touch that code, but I have
no way of testing all the affected parts. I could use .acts_like =
OTHER_ID in the data table to minimize that risk. Thoughts?


From: Liam Breck <kernel@networkimprov.net>
Subject: [PATCH] power: supply: bq27xxx: create single chip data table

Unify data previously in bq27xxx_regs & bq27xxx_battery_props into a
single table.
There is no functional change to the driver.

---
 drivers/power/supply/bq27xxx_battery.c | 121 ++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c
b/drivers/power/supply/bq27xxx_battery.c
index ed44439d0112c..db42e4961c68f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -132,8 +132,8 @@ enum bq27xxx_reg_index {
     [BQ27XXX_DM_CKSUM] = 0x60

 /* Register mappings */
-static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
-    [BQ27000] = {
+static u8
+    bq27000_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -157,7 +157,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
         [BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
     },
-    [BQ27010] = {
+    bq27010_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -181,7 +181,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
         [BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
     },
-    [BQ2750X] = {
+    bq2750x_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -201,7 +201,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ2751X] = {
+    bq2751x_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -221,7 +221,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27500] = {
+    bq27500_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -241,7 +241,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27510G1] = {
+    bq27510g1_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -261,7 +261,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27510G2] = {
+    bq27510g2_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -281,7 +281,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27510G3] = {
+    bq27510g3_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -301,7 +301,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27520G1] = {
+    bq27520g1_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
@@ -321,7 +321,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27520G2] = {
+    bq27520g2_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x36,
@@ -341,7 +341,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27520G3] = {
+    bq27520g3_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x36,
@@ -361,7 +361,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27520G4] = {
+    bq27520g4_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -381,7 +381,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27530] = {
+    bq27530_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x32,
@@ -401,7 +401,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27541] = {
+    bq27541_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -421,7 +421,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27545] = {
+    bq27545_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x06,
         [BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -441,7 +441,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_AP] = 0x24,
         BQ27XXX_DM_REG_ROWS,
     },
-    [BQ27421] = {
+    bq27421_regs[BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_CTRL] = 0x00,
         [BQ27XXX_REG_TEMP] = 0x02,
         [BQ27XXX_REG_INT_TEMP] = 0x1e,
@@ -460,10 +460,9 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
         [BQ27XXX_REG_DCAP] = 0x3c,
         [BQ27XXX_REG_AP] = 0x18,
         BQ27XXX_DM_REG_ROWS,
-    },
-};
+    };

-static enum power_supply_property bq27000_battery_props[] = {
+static enum power_supply_property bq27000_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -485,7 +484,7 @@ static enum power_supply_property
bq27000_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27010_battery_props[] = {
+static enum power_supply_property bq27010_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -505,7 +504,7 @@ static enum power_supply_property
bq27010_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq2750x_battery_props[] = {
+static enum power_supply_property bq2750x_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -523,7 +522,7 @@ static enum power_supply_property
bq2750x_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq2751x_battery_props[] = {
+static enum power_supply_property bq2751x_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -541,7 +540,7 @@ static enum power_supply_property
bq2751x_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27500_battery_props[] = {
+static enum power_supply_property bq27500_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -562,7 +561,7 @@ static enum power_supply_property
bq27500_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27510g1_battery_props[] = {
+static enum power_supply_property bq27510g1_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -583,7 +582,7 @@ static enum power_supply_property
bq27510g1_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27510g2_battery_props[] = {
+static enum power_supply_property bq27510g2_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -604,7 +603,7 @@ static enum power_supply_property
bq27510g2_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27510g3_battery_props[] = {
+static enum power_supply_property bq27510g3_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -622,7 +621,7 @@ static enum power_supply_property
bq27510g3_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27520g1_battery_props[] = {
+static enum power_supply_property bq27520g1_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -642,7 +641,7 @@ static enum power_supply_property
bq27520g1_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27520g2_battery_props[] = {
+static enum power_supply_property bq27520g2_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -663,7 +662,7 @@ static enum power_supply_property
bq27520g2_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27520g3_battery_props[] = {
+static enum power_supply_property bq27520g3_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -683,7 +682,7 @@ static enum power_supply_property
bq27520g3_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27520g4_battery_props[] = {
+static enum power_supply_property bq27520g4_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -700,7 +699,7 @@ static enum power_supply_property
bq27520g4_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27530_battery_props[] = {
+static enum power_supply_property bq27530_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -718,7 +717,7 @@ static enum power_supply_property
bq27530_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27541_battery_props[] = {
+static enum power_supply_property bq27541_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -737,7 +736,7 @@ static enum power_supply_property
bq27541_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27545_battery_props[] = {
+static enum power_supply_property bq27545_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -755,7 +754,7 @@ static enum power_supply_property
bq27545_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-static enum power_supply_property bq27421_battery_props[] = {
+static enum power_supply_property bq27421_props[] = {
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -770,32 +769,32 @@ static enum power_supply_property
bq27421_battery_props[] = {
     POWER_SUPPLY_PROP_MANUFACTURER,
 };

-#define BQ27XXX_PROP(_id, _prop)        \
-    [_id] = {                \
-        .props = _prop,            \
-        .size = ARRAY_SIZE(_prop),    \
-    }
+#define BQ27XXX_DATA(ref) {            \
+    .regs  = ref##_regs,            \
+    .props = ref##_props,            \
+    .props_size = ARRAY_SIZE(ref##_props), }

 static struct {
+    u8 *regs;
     enum power_supply_property *props;
-    size_t size;
-} bq27xxx_battery_props[] = {
-    BQ27XXX_PROP(BQ27000, bq27000_battery_props),
-    BQ27XXX_PROP(BQ27010, bq27010_battery_props),
-    BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
-    BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
-    BQ27XXX_PROP(BQ27500, bq27500_battery_props),
-    BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
-    BQ27XXX_PROP(BQ27510G2, bq27510g2_battery_props),
-    BQ27XXX_PROP(BQ27510G3, bq27510g3_battery_props),
-    BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
-    BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
-    BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
-    BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
-    BQ27XXX_PROP(BQ27530, bq27530_battery_props),
-    BQ27XXX_PROP(BQ27541, bq27541_battery_props),
-    BQ27XXX_PROP(BQ27545, bq27545_battery_props),
-    BQ27XXX_PROP(BQ27421, bq27421_battery_props),
+    size_t props_size;
+} bq27xxx_battery_data[] = {
+    [BQ27000]   = BQ27XXX_DATA(bq27000),
+    [BQ27010]   = BQ27XXX_DATA(bq27010),
+    [BQ2750X]   = BQ27XXX_DATA(bq2750x),
+    [BQ2751X]   = BQ27XXX_DATA(bq2751x),
+    [BQ27500]   = BQ27XXX_DATA(bq27500),
+    [BQ27510G1] = BQ27XXX_DATA(bq27510g1),
+    [BQ27510G2] = BQ27XXX_DATA(bq27510g2),
+    [BQ27510G3] = BQ27XXX_DATA(bq27510g3),
+    [BQ27520G1] = BQ27XXX_DATA(bq27520g1),
+    [BQ27520G2] = BQ27XXX_DATA(bq27520g2),
+    [BQ27520G3] = BQ27XXX_DATA(bq27520g3),
+    [BQ27520G4] = BQ27XXX_DATA(bq27520g4),
+    [BQ27530]   = BQ27XXX_DATA(bq27530),
+    [BQ27541]   = BQ27XXX_DATA(bq27541),
+    [BQ27545]   = BQ27XXX_DATA(bq27545),
+    [BQ27421]   = BQ27XXX_DATA(bq27421),
 };

 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1884,7 +1883,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)

     INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
     mutex_init(&di->lock);
-    di->regs = bq27xxx_regs[di->chip];
+    di->regs = bq27xxx_battery_data[di->chip].regs;

     psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
     if (!psy_desc)
@@ -1892,8 +1891,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)

     psy_desc->name = di->name;
     psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
-    psy_desc->properties = bq27xxx_battery_props[di->chip].props;
-    psy_desc->num_properties = bq27xxx_battery_props[di->chip].size;
+    psy_desc->properties = bq27xxx_battery_data[di->chip].props;
+    psy_desc->num_properties = bq27xxx_battery_data[di->chip].props_size;
     psy_desc->get_property = bq27xxx_battery_get_property;
     psy_desc->external_power_changed = bq27xxx_external_power_changed;
