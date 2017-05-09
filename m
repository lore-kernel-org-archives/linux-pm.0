From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v13.2 10/11] power: supply: bq27xxx_battery: Flag
 identical register maps when in debug mode
Date: Tue, 9 May 2017 04:27:18 -0700
Message-ID: <CAKvHMgTmxOpr4cCesCPiXqaB1zap72rwqejmWfohGsd-z55QCA@mail.gmail.com>
References: <20170509082123.27592-1-liam@networkimprov.net> <20170509082123.27592-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35592 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEIL1T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 07:27:19 -0400
Received: by mail-io0-f193.google.com with SMTP id o12so4136656iod.2
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2017 04:27:19 -0700 (PDT)
In-Reply-To: <20170509082123.27592-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

Hi Sebastian,

This patch checks for dupes in the large bq27xxx_regs[][] array of
register tables. It's easy to mistakenly add a duplicate table when
supporting a new chip; 3 such dupes were added recently.

Andrew suggested that this code belongs in a separate tools directory
program. That may be overkill for how short this is. Also the dupe
checker needs access to static module data.

What do you think?


On Tue, May 9, 2017 at 1:21 AM, Liam Breck <liam@networkimprov.net> wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> We tie multiple chips to unique register maps. When supporting a new chip,
> it's easy to add a duplicate map by mistake.
>
> In debug mode we now scan the register maps for duplicates.
>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 76cb181..0492f33 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1922,6 +1922,25 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
>         schedule_delayed_work(&di->work, 0);
>  }
>
> +#ifdef DEBUG
> +static void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di)
> +{
> +       const size_t max = ARRAY_SIZE(bq27xxx_regs);
> +       int a, b;
> +
> +       for (a = 1; a < max-1; a++) {
> +               for (b = a+1; b < max; b++) {
> +                       if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
> +                                   sizeof(bq27xxx_regs[0])))
> +                               dev_warn(di->dev,
> +                                       "bq27xxx_regs[%d] & [%d] are identical\n", a, b);
> +               }
> +       }
> +}
> +#else
> +static inline void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di) {}
> +#endif
> +
>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  {
>         struct power_supply_desc *psy_desc;
> @@ -1930,6 +1949,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>                 .drv_data = di,
>         };
>
> +       bq27xxx_battery_dbg_regs_dupes(di);
> +
>         di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
>
>         di->unseal_key = bq27xxx_unseal_keys[di->real_chip];
> --
> 2.9.3
>
