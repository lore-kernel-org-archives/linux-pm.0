From: Liam Breck <liam@networkimprov.net>
Subject: Fwd: [PATCH v11 10/10] power: bq27xxx_battery: Remove duplicate
 register arrays
Date: Tue, 21 Mar 2017 01:58:02 -0700
Message-ID: <CAKvHMgTC3eDhY=d-7obEbG9m7_3aStqBwAvOiyj88TjWNCui9A@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-11-liam@networkimprov.net> <CAKvHMgS9ajgE3ZpseSkT=BiW5yBL03s-8XNFeHE=V0gz7W7x3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35894 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdCUI6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 04:58:04 -0400
Received: by mail-io0-f193.google.com with SMTP id 68so6659791ioh.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 01:58:03 -0700 (PDT)
In-Reply-To: <CAKvHMgS9ajgE3ZpseSkT=BiW5yBL03s-8XNFeHE=V0gz7W7x3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Resend to list...


---------- Forwarded message ----------
Date: Mon, Mar 20, 2017 at 6:23 PM
To: Chris@lapa.com.au
Cc: Matt Ranostay <matt@ranostay.consulting>,
linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian
Reichel <sre@kernel.org>

Chris & Andrew,

Can we make id bq2750x an alias for bq27500 and remove the associated arrays?

This patch does that for three IDs which are dups, although bq2750x &
bq27500 are not exact dups.


On Mar 20, 2017 2:44 AM, "Liam Breck" <liam@networkimprov.net> wrote:
>
> From: Liam Breck <kernel@networkimprov.net>
>
> BQ2751X & BQ27510G3 are identical.
> BQ27500 & BQ27510G1 & BQ27510G2 are identical.
> Make BQ2751X & BQ27510G1/2 category members.
> Remove the duplicate arrays, etc.
>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 148 ++-------------------------------
>  include/linux/power/bq27xxx_battery.h  |  12 +--
>  2 files changed, 11 insertions(+), 149 deletions(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 7f08f36..ccc74e6 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -197,30 +197,6 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>                 [BQ27XXX_DM_DATA] = 0x40,
>                 [BQ27XXX_DM_CKSUM] = 0x60,
>         },
> -       [BQ2751X] = {
> -               [BQ27XXX_REG_CTRL] = 0x00,
> -               [BQ27XXX_REG_TEMP] = 0x06,
> -               [BQ27XXX_REG_INT_TEMP] = 0x28,
> -               [BQ27XXX_REG_VOLT] = 0x08,
> -               [BQ27XXX_REG_AI] = 0x14,
> -               [BQ27XXX_REG_FLAGS] = 0x0a,
> -               [BQ27XXX_REG_TTE] = 0x16,
> -               [BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
> -               [BQ27XXX_REG_TTES] = 0x1a,
> -               [BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> -               [BQ27XXX_REG_NAC] = 0x0c,
> -               [BQ27XXX_REG_FCC] = 0x12,
> -               [BQ27XXX_REG_CYCT] = 0x1e,
> -               [BQ27XXX_REG_AE] = INVALID_REG_ADDR,
> -               [BQ27XXX_REG_SOC] = 0x20,
> -               [BQ27XXX_REG_DCAP] = 0x2e,
> -               [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
> -               [BQ27XXX_DM_CTRL] = 0x61,
> -               [BQ27XXX_DM_CLASS] = 0x3e,
> -               [BQ27XXX_DM_BLOCK] = 0x3f,
> -               [BQ27XXX_DM_DATA] = 0x40,
> -               [BQ27XXX_DM_CKSUM] = 0x60,
> -       },
>         [BQ27500] = {
>                 [BQ27XXX_REG_CTRL] = 0x00,
>                 [BQ27XXX_REG_TEMP] = 0x06,
> @@ -245,54 +221,6 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>                 [BQ27XXX_DM_DATA] = 0x40,
>                 [BQ27XXX_DM_CKSUM] = 0x60,
>         },
> -       [BQ27510G1] = {
> -               [BQ27XXX_REG_CTRL] = 0x00,
> -               [BQ27XXX_REG_TEMP] = 0x06,
> -               [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
> -               [BQ27XXX_REG_VOLT] = 0x08,
> -               [BQ27XXX_REG_AI] = 0x14,
> -               [BQ27XXX_REG_FLAGS] = 0x0a,
> -               [BQ27XXX_REG_TTE] = 0x16,
> -               [BQ27XXX_REG_TTF] = 0x18,
> -               [BQ27XXX_REG_TTES] = 0x1c,
> -               [BQ27XXX_REG_TTECP] = 0x26,
> -               [BQ27XXX_REG_NAC] = 0x0c,
> -               [BQ27XXX_REG_FCC] = 0x12,
> -               [BQ27XXX_REG_CYCT] = 0x2a,
> -               [BQ27XXX_REG_AE] = 0x22,
> -               [BQ27XXX_REG_SOC] = 0x2c,
> -               [BQ27XXX_REG_DCAP] = 0x3c,
> -               [BQ27XXX_REG_AP] = 0x24,
> -               [BQ27XXX_DM_CTRL] = 0x61,
> -               [BQ27XXX_DM_CLASS] = 0x3e,
> -               [BQ27XXX_DM_BLOCK] = 0x3f,
> -               [BQ27XXX_DM_DATA] = 0x40,
> -               [BQ27XXX_DM_CKSUM] = 0x60,
> -       },
> -       [BQ27510G2] = {
> -               [BQ27XXX_REG_CTRL] = 0x00,
> -               [BQ27XXX_REG_TEMP] = 0x06,
> -               [BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
> -               [BQ27XXX_REG_VOLT] = 0x08,
> -               [BQ27XXX_REG_AI] = 0x14,
> -               [BQ27XXX_REG_FLAGS] = 0x0a,
> -               [BQ27XXX_REG_TTE] = 0x16,
> -               [BQ27XXX_REG_TTF] = 0x18,
> -               [BQ27XXX_REG_TTES] = 0x1c,
> -               [BQ27XXX_REG_TTECP] = 0x26,
> -               [BQ27XXX_REG_NAC] = 0x0c,
> -               [BQ27XXX_REG_FCC] = 0x12,
> -               [BQ27XXX_REG_CYCT] = 0x2a,
> -               [BQ27XXX_REG_AE] = 0x22,
> -               [BQ27XXX_REG_SOC] = 0x2c,
> -               [BQ27XXX_REG_DCAP] = 0x3c,
> -               [BQ27XXX_REG_AP] = 0x24,
> -               [BQ27XXX_DM_CTRL] = 0x61,
> -               [BQ27XXX_DM_CLASS] = 0x3e,
> -               [BQ27XXX_DM_BLOCK] = 0x3f,
> -               [BQ27XXX_DM_DATA] = 0x40,
> -               [BQ27XXX_DM_CKSUM] = 0x60,
> -       },
>         [BQ27510G3] = {
>                 [BQ27XXX_REG_CTRL] = 0x00,
>                 [BQ27XXX_REG_TEMP] = 0x06,
> @@ -571,24 +499,6 @@ static enum power_supply_property bq2750x_battery_props[] = {
>         POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>
> -static enum power_supply_property bq2751x_battery_props[] = {
> -       POWER_SUPPLY_PROP_STATUS,
> -       POWER_SUPPLY_PROP_PRESENT,
> -       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -       POWER_SUPPLY_PROP_CURRENT_NOW,
> -       POWER_SUPPLY_PROP_CAPACITY,
> -       POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -       POWER_SUPPLY_PROP_TEMP,
> -       POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -       POWER_SUPPLY_PROP_TECHNOLOGY,
> -       POWER_SUPPLY_PROP_CHARGE_FULL,
> -       POWER_SUPPLY_PROP_CHARGE_NOW,
> -       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -       POWER_SUPPLY_PROP_CYCLE_COUNT,
> -       POWER_SUPPLY_PROP_HEALTH,
> -       POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> -
>  static enum power_supply_property bq27500_battery_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_PRESENT,
> @@ -610,48 +520,6 @@ static enum power_supply_property bq27500_battery_props[] = {
>         POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>
> -static enum power_supply_property bq27510g1_battery_props[] = {
> -       POWER_SUPPLY_PROP_STATUS,
> -       POWER_SUPPLY_PROP_PRESENT,
> -       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -       POWER_SUPPLY_PROP_CURRENT_NOW,
> -       POWER_SUPPLY_PROP_CAPACITY,
> -       POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -       POWER_SUPPLY_PROP_TEMP,
> -       POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -       POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> -       POWER_SUPPLY_PROP_TECHNOLOGY,
> -       POWER_SUPPLY_PROP_CHARGE_FULL,
> -       POWER_SUPPLY_PROP_CHARGE_NOW,
> -       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -       POWER_SUPPLY_PROP_CYCLE_COUNT,
> -       POWER_SUPPLY_PROP_ENERGY_NOW,
> -       POWER_SUPPLY_PROP_POWER_AVG,
> -       POWER_SUPPLY_PROP_HEALTH,
> -       POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> -
> -static enum power_supply_property bq27510g2_battery_props[] = {
> -       POWER_SUPPLY_PROP_STATUS,
> -       POWER_SUPPLY_PROP_PRESENT,
> -       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -       POWER_SUPPLY_PROP_CURRENT_NOW,
> -       POWER_SUPPLY_PROP_CAPACITY,
> -       POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -       POWER_SUPPLY_PROP_TEMP,
> -       POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -       POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> -       POWER_SUPPLY_PROP_TECHNOLOGY,
> -       POWER_SUPPLY_PROP_CHARGE_FULL,
> -       POWER_SUPPLY_PROP_CHARGE_NOW,
> -       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -       POWER_SUPPLY_PROP_CYCLE_COUNT,
> -       POWER_SUPPLY_PROP_ENERGY_NOW,
> -       POWER_SUPPLY_PROP_POWER_AVG,
> -       POWER_SUPPLY_PROP_HEALTH,
> -       POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> -
>  static enum power_supply_property bq27510g3_battery_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_PRESENT,
> @@ -831,10 +699,7 @@ static struct {
>         BQ27XXX_PROP(BQ27000, bq27000_battery_props),
>         BQ27XXX_PROP(BQ27010, bq27010_battery_props),
>         BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
> -       BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
>         BQ27XXX_PROP(BQ27500, bq27500_battery_props),
> -       BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
> -       BQ27XXX_PROP(BQ27510G2, bq27510g2_battery_props),
>         BQ27XXX_PROP(BQ27510G3, bq27510g3_battery_props),
>         BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
>         BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
> @@ -1521,10 +1386,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>  {
>         switch (di->chip) {
>         case BQ2750X:
> -       case BQ2751X:
>         case BQ27500:
> -       case BQ27510G1:
> -       case BQ27510G2:
>         case BQ27510G3:
>         case BQ27520G1:
>         case BQ27520G2:
> @@ -1891,11 +1753,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>         switch(di->chip) {
>         case BQ27000:
>         case BQ27010:
> -       case BQ2750X:
> -       case BQ2751X: break;
> +       case BQ2750X: break;
>         case BQ27500: BQ27XXX_INIT(BQ27500, bq27500_dm_regs, 0x04143672); break;
> -       case BQ27510G1:
> -       case BQ27510G2:
>         case BQ27510G3:
>         case BQ27520G1:
>         case BQ27520G2:
> @@ -1905,7 +1764,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>         case BQ27541: break;
>         case BQ27545: BQ27XXX_INIT(BQ27545, bq27545_dm_regs, 0x04143672); break;
>         case BQ27421: BQ27XXX_INIT(BQ27421, bq27421_dm_regs, 0x80008000); break;
> -       case BQ2752X: di->chip = BQ2751X; break;
> +       case BQ2751X: di->chip = BQ27510G3; break;
> +       case BQ2752X: di->chip = BQ27510G3; break;
> +       case BQ27510G1: di->chip = BQ27500; break;
> +       case BQ27510G2: di->chip = BQ27500; break;
>         case BQ27531: di->chip = BQ27530; break;
>         case BQ27542: di->chip = BQ27541; break;
>         case BQ27546: di->chip = BQ27541; break;
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 014e59f..81f7ffa 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -6,11 +6,8 @@ enum bq27xxx_chip {
>         BQ27000 = 1, /* bq27000, bq27200 */
>         BQ27010, /* bq27010, bq27210 */
>         BQ2750X, /* bq27500 deprecated alias */
> -       BQ2751X, /* bq27510, bq27520 deprecated alias */
> -       BQ27500, /* bq27500/1 */
> -       BQ27510G1, /* bq27510G1 */
> -       BQ27510G2, /* bq27510G2 */
> -       BQ27510G3, /* bq27510G3 */
> +       BQ27500, /* bq27500/1, bq27510G1, bq27510G2 */
> +       BQ27510G3, /* bq27510G3, bq27510, bq27520 */
>         BQ27520G1, /* bq27520G1 */
>         BQ27520G2, /* bq27520G2 */
>         BQ27520G3, /* bq27520G3 */
> @@ -21,7 +18,10 @@ enum bq27xxx_chip {
>         BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>
>         /* members of categories; translate these to category in _setup() */
> -       BQ2752X, /* deprecated alias */
> +       BQ2751X, /* bq27510 deprecated alias */
> +       BQ2752X, /* bq27520 deprecated alias */
> +       BQ27510G1,
> +       BQ27510G2,
>         BQ27531,
>         BQ27542,
>         BQ27546,
> --
> 2.9.3
