From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v12 2/4] pm: add to_power_supply macro to the API
Date: Wed, 3 Jan 2018 16:34:34 +0200
Message-ID: <CAHp75VctRMxMS8EUMYQ-B9s5TRDnHeeM1NvKNRmLezLbQc6cdQ@mail.gmail.com>
References: <20180103115905.GA10115@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180103115905.GA10115@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 3, 2018 at 1:59 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> This patch adds the to_power_supply macro to upcast
> a device to a power_supply struct.
>
> This is needed because the same piece of code using
> container_of is used in various other places, so we
> abstract away such low-level operations via a macro.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

It took me a while to understand if those private implementations are
equivalent to what you introduced.
Looks so sysfs_create_group() adds the attributes to power supply
device kobject, thus the struct device pointer in the callback will be
power supply child, not the actual hardware which seems correct.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>
> Notes:
>     v9:
>     * Split the pm changes from the thinkpad_acpi patch
>     into its own patch
>
>     v10:
>     * No changes in this patch in v10
>
>     v11:
>     * Fix changelog formatting
>
>     v12:
>     * Fix build issues in ds2781 and ds2780 battery drivers
>
>  drivers/power/supply/ds2780_battery.c    | 5 -----
>  drivers/power/supply/ds2781_battery.c    | 5 -----
>  drivers/power/supply/power_supply_core.c | 2 +-
>  include/linux/power_supply.h             | 2 ++
>  4 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
> index e5d81b4..370e910 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -56,11 +56,6 @@ to_ds2780_device_info(struct power_supply *psy)
>         return power_supply_get_drvdata(psy);
>  }
>
> -static inline struct power_supply *to_power_supply(struct device *dev)
> -{
> -       return dev_get_drvdata(dev);
> -}
> -
>  static inline int ds2780_battery_io(struct ds2780_device_info *dev_info,
>         char *buf, int addr, size_t count, int io)
>  {
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
> index efe83ef..d1b5a19 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -54,11 +54,6 @@ to_ds2781_device_info(struct power_supply *psy)
>         return power_supply_get_drvdata(psy);
>  }
>
> -static inline struct power_supply *to_power_supply(struct device *dev)
> -{
> -       return dev_get_drvdata(dev);
> -}
> -
>  static inline int ds2781_battery_io(struct ds2781_device_info *dev_info,
>         char *buf, int addr, size_t count, int io)
>  {
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 82f998a..feac7b0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
>
>  static void power_supply_dev_release(struct device *dev)
>  {
> -       struct power_supply *psy = container_of(dev, struct power_supply, dev);
> +       struct power_supply *psy = to_power_supply(dev);
>         dev_dbg(dev, "%s\n", __func__);
>         kfree(psy);
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3..f0139b4 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -371,6 +371,8 @@ devm_power_supply_register_no_ws(struct device *parent,
>  extern void power_supply_unregister(struct power_supply *psy);
>  extern int power_supply_powers(struct power_supply *psy, struct device *dev);
>
> +#define to_power_supply(device) container_of(device, struct power_supply, dev)
> +
>  extern void *power_supply_get_drvdata(struct power_supply *psy);
>  /* For APM emulation, think legacy userspace. */
>  extern struct class *power_supply_class;
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
