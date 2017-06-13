From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: Don't needlessly set CAPACITY_MODE
Date: Tue, 13 Jun 2017 11:17:50 -0700
Message-ID: <CABXOdTcrYNpFswn6L7+jXpRwjxjaSvJNjEDoFuWz+7GYF-xjjQ@mail.gmail.com>
References: <1497376406-86470-1-git-send-email-shawnn@chromium.org> <1497376406-86470-2-git-send-email-shawnn@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497376406-86470-2-git-send-email-shawnn@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Nematbakhsh <shawnn@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 13, 2017 at 10:53 AM, Shawn Nematbakhsh <shawnn@chromium.org> wrote:
> According to the smart battery spec (1), the CAPACITY_MODE bit does not
> influence the value read from RelativeStateOfCharge(), so don't bother
> changing CAPACITY_MODE when doing such a read.
>
> (1) - Smart Battery Data Specification, Rev 1.1, Dec. 11, 1998
>
> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/power/supply/sbs-battery.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index d7e68fd97099..4bae210d5a8a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -439,6 +439,11 @@ static int sbs_get_battery_property(struct i2c_client *client,
>         } else {
>                 if (psp == POWER_SUPPLY_PROP_STATUS)
>                         val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +               else if (psp == POWER_SUPPLY_PROP_CAPACITY)
> +                       /* sbs spec says that this can be >100 %
> +                        * even if max value is 100 %
> +                        */
> +                       val->intval = min(ret, 100);
>                 else
>                         val->intval = 0;
>         }
> @@ -549,12 +554,7 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
>         if (ret < 0)
>                 return ret;
>
> -       if (psp == POWER_SUPPLY_PROP_CAPACITY) {
> -               /* sbs spec says that this can be >100 %
> -               * even if max value is 100 % */
> -               val->intval = min(ret, 100);
> -       } else
> -               val->intval = ret;
> +       val->intval = ret;
>
>         ret = sbs_set_battery_mode(client, mode);
>         if (ret < 0)
> @@ -619,7 +619,6 @@ static int sbs_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_CHARGE_NOW:
>         case POWER_SUPPLY_PROP_CHARGE_FULL:
>         case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -       case POWER_SUPPLY_PROP_CAPACITY:
>                 ret = sbs_get_property_index(client, psp);
>                 if (ret < 0)
>                         break;
> @@ -647,6 +646,7 @@ static int sbs_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>         case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>         case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +       case POWER_SUPPLY_PROP_CAPACITY:
>                 ret = sbs_get_property_index(client, psp);
>                 if (ret < 0)
>                         break;
> --
> 2.13.1.508.gb3defc5cc-goog
>
