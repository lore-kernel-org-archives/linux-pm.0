From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/4] power: bq25890_charger.c: Read back the current
 battery voltage
Date: Thu, 26 Jul 2018 09:03:50 +0200
Message-ID: <CAJKOXPc1amTiPKNU02OruOpw+GA6DrZgv1+HhqZ14OZYpA2-YA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-5-angus@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725194630.10414-5-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The part has the capability of reading the current battery voltage
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index f4cf2987996b..60ccd6c2b7ad 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -464,6 +464,20 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>                 break;
>
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               if (!state.online) {
> +                       val->intval = 0;
> +                       break;
> +               }

You use state from cached value (from last interrupt) but the voltage
is read directly from registers. The driver follows this convention in
few other places so maybe it is okay. It depends how accurately the
interrupts are generated - on every change? IOW, is always guaranteed
that state will be consistent with values read below?

Best regards,
Krzysztof

> +
> +               ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> +               val->intval = 2304000 + ret * 20000;
> +               break;
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -672,6 +686,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>
>  static char *bq25890_charger_supplied_to[] = {
> --
> 2.17.1
>
