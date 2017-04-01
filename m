From: Liam Breck <liam@networkimprov.net>
Subject: Re: [RFC] power: power_supply: Add power_supply_prop_precharge/endcharge
Date: Sat, 1 Apr 2017 06:07:34 -0700
Message-ID: <CAKvHMgQzJogAzcL9dLDCE6Hz3FshcnmengpbvfCMJkH0DmzcDw@mail.gmail.com>
References: <20170329063055.4517-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33866 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdDANHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 09:07:36 -0400
Received: by mail-it0-f66.google.com with SMTP id e75so4391561itd.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 06:07:36 -0700 (PDT)
In-Reply-To: <20170329063055.4517-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Sebastian,

I'm blocked on this question...

This is a draft of the power_supply_prop_precharge/endcharge_current
patch for my charger patchset. It highlights charge_term_current with
a cosmetic change. Is that the same as the proposed endcharge_current?

BTW the _get_battery_info() & bq27xxx_battery series (dependency of
above) is now at 17 revisions, counting partial series posts. Andrew's
been sending feedback since v7. The _battery_info part is stable.

Thanks



On Tue, Mar 28, 2017 at 11:30 PM, Liam Breck <liam@networkimprov.net> wrote=
:
> Battery chargers allow get/set of:
> POWER_SUPPLY_PROP_PRECHARGE_CURRENT
> POWER_SUPPLY_PROP_ENDCHARGE_CURRENT
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>
> Hi Sebastian,
> This is a RFC draft of the power_supply property patch for my bq24190_cha=
rger
> series. It also highlights charge_term_current with a cosmetic change. Is=
 this
> the same as the proposed endcharge_current?
>
>  Documentation/power/power_supply_class.txt | 10 ++++++++--
>  drivers/power/supply/power_supply_sysfs.c  |  2 ++
>  include/linux/power_supply.h               |  4 ++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/p=
ower/power_supply_class.txt
> index dc92c77..ccffdad 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -119,13 +119,19 @@ CHARGE_COUNTER - the current charge counter (in =C2=
=B5Ah).  This could easily
>  be negative; there is no empty or full value.  It is only useful for
>  relative, time-based measurements.
>
> +PRECHARGE_CURRENT - the maximum charge current during precharge phase
> +of charge cycle (typically 20% of battery capacity).
> +ENDCHARGE_CURRENT - charge cycle terminates when battery voltage is
> +above recharge threshold, and charge current is below this setting
> +(typically 10% of battery capacity).
> +
>  CONSTANT_CHARGE_CURRENT - constant charge current programmed by charger.
>  CONSTANT_CHARGE_CURRENT_MAX - maximum charge current supported by the
>  power supply object.
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicat=
es
>  the current drawn from a charging source.
> -CHARGE_TERM_CURRENT - Charge termination current used to detect the end =
of charge
> -condition.
> +CHARGE_TERM_CURRENT - Charge termination current used to detect the end =
of
> +charge condition.
>
>  CALIBRATE - battery or coulomb counter calibration status
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index bcde8d1..7b091c9 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -165,6 +165,8 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>         POWER_SUPPLY_ATTR(charge_now),
>         POWER_SUPPLY_ATTR(charge_avg),
>         POWER_SUPPLY_ATTR(charge_counter),
> +       POWER_SUPPLY_ATTR(precharge_current),
> +       POWER_SUPPLY_ATTR(endcharge_current),
>         POWER_SUPPLY_ATTR(constant_charge_current),
>         POWER_SUPPLY_ATTR(constant_charge_current_max),
>         POWER_SUPPLY_ATTR(constant_charge_voltage),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f1e4b30..b909935 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -115,6 +115,8 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_CHARGE_NOW,
>         POWER_SUPPLY_PROP_CHARGE_AVG,
>         POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +       POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_ENDCHARGE_CURRENT,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> @@ -379,6 +381,8 @@ static inline bool power_supply_is_amp_property(enum =
power_supply_property psp)
>         case POWER_SUPPLY_PROP_CHARGE_NOW:
>         case POWER_SUPPLY_PROP_CHARGE_AVG:
>         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +       case POWER_SUPPLY_PROP_ENDCHARGE_CURRENT:
>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
> --
> 2.9.3
>
