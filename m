From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC/RFT 2/2] power_supply: Fix possible NULL pointer dereference
 on early uevent
Date: Tue, 19 May 2015 15:10:59 +0900
Message-ID: <CAJKOXPdCKmcjBF_fKySxQ+Vy8v4L2KMrCinPKDTtnwLDqX910w@mail.gmail.com>
References: <1432013163-20713-1-git-send-email-k.kozlowski@samsung.com>
	<1432013163-20713-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432013163-20713-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

2015-05-19 14:26 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Don't call the power_supply_changed() from power_supply_register() when
> parent is still probing because it may lead to accessing parent too
> early.
>
> In bq27x00_battery this caused NULL pointer exception because uevent of
> power_supply_changed called back the the get_property() method provided
> by the driver. The get_property() method accessed pointer which should
> be returned by power_supply_register().
>
> Starting from bq27x00_battery_probe():
>   di->bat = power_supply_register()
>     power_supply_changed()
>       kobject_uevent()
>         power_supply_uevent()
>           power_supply_show_property()
>             power_supply_get_property()
>               bq27x00_battery_get_property()
>                 dereference of di->bat which is NULL here
>
> The dereference of di->bat (value returned by power_supply_register())
> is the currently visible problem. However calling back the methods
> provided by driver before ending the probe may lead to accessing other
> driver-related data which is not yet initialized.
>
> The call to power_supply_changed() is postponed till probing ends -
> mutex of parent device is released.
>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> ---
>  drivers/power/power_supply_core.c | 48 +++++++++++++++++++++++++++++++++++----
>  include/linux/power_supply.h      |  1 +
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
> index 15da277e0e8d..3a36d2940803 100644
> --- a/drivers/power/power_supply_core.c
> +++ b/drivers/power/power_supply_core.c
> @@ -30,6 +30,8 @@ EXPORT_SYMBOL_GPL(power_supply_notifier);
>
>  static struct device_type power_supply_dev_type;
>
> +#define POWER_SUPPLY_DEFERRED_REGISTER_TIME    msecs_to_jiffies(10)
> +
>  static bool __power_supply_is_supplied_by(struct power_supply *supplier,
>                                          struct power_supply *supply)
>  {
> @@ -121,6 +123,30 @@ void power_supply_changed(struct power_supply *psy)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_changed);
>
> +/*
> + * Notify that power supply was registered after parent finished the probing.
> + *
> + * Often power supply is registered from driver's probe function. However
> + * calling power_supply_changed() directly from power_supply_register()
> + * would lead to execution of get_property() function provided by the driver
> + * too early - before the probe ends.
> + *
> + * Avoid that by waiting on parent's mutex.
> + */
> +static void power_supply_deferred_register_work(struct work_struct *work)
> +{
> +       struct power_supply *psy = container_of(work, struct power_supply,
> +                                               deferred_register_work);

There is an obvious error here. It should be
"deferred_register_work.work". I will make a resend.

Krzysztof
