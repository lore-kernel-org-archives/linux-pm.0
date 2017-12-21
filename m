From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3 v8] thinkpad_acpi: Add support for battery thresholds
Date: Thu, 21 Dec 2017 15:53:10 +0200
Message-ID: <CAHp75Vc2MYDLanvZmqaPkmFVfNbyBQoPwbRDDFmKDtSPAmfj9w@mail.gmail.com>
References: <20171221100051.GA30647@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171221100051.GA30647@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 21, 2017 at 12:00 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> thinkpad_acpi registers two new attributes for each battery:
>
> 1) Charge start threshold
> /sys/class/power_supply/BATN/charge_start_threshold
>
> Valid values are [0, 99]. A value of 0 turns off the
> start threshold wear control.
>
> 2) Charge stop threshold
> /sys/class/power_supply/BATN/charge_stop_threshold
>
> Valid values are [1, 100]. A value of 100 turns off
> the stop threshold wear control. This must be
> configured first.
>
> This patch depends on the following patches:
>
> "battery: Add the battery hooking API"

Sorry, didn't notice earlier some things commented below.

>  #include <acpi/video.h>
>
> +
>  /* ThinkPad CMOS commands */

Redundant change.

> +enum {
> +       /* Error condition bit */
> +       METHOD_ERR = (1 << 31),

bitops.h but no BIT() use?

BIT(31) ?

> +};

> +static int tpacpi_battery_set(int what, int battery, int value)
> +{

> +

Redundant.

> +       int param = 0x0, ret = 0xFFFFFFFF;

Useless assignment for param, not sure abour ret.

> +
> +       /* The first 8 bits are the value of the threshold */
> +       param = value;
> +       /* The battery ID is in bits 8-9, 2 bits */
> +       param |= battery << 8;
> +
> +       switch (what) {
> +
> +       case THRESHOLD_START:
> +
> +               if (tpacpi_battery_acpi_eval(SET_START, &ret, param)) {
> +                       pr_err("failed to set charge threshold on battery %d",
> +                                       battery);
> +                       return -ENODEV;
> +               }
> +
> +               return 0;
> +
> +       case THRESHOLD_STOP:
> +
> +               if (tpacpi_battery_acpi_eval(SET_STOP, &ret, param)) {
> +                       pr_err("failed to set charge stop threshold: %d", battery);
> +                       return -ENODEV;
> +               }
> +
> +               return 0;
> +
> +       default:
> +               pr_crit("wrong parameter: %d", what);
> +               return -EINVAL;
> +       }

> +

Redundant.

> +}

> +
> +static int tpacpi_battery_probe(int battery)
> +{
> +       int ret = 0;
> +

> +       /* Reset the struct */

Useless.

> +       memset(&battery_info, 0, sizeof(struct tpacpi_battery_driver_data));

> +}

> +static ssize_t tpacpi_battery_store(struct device *dev,
> +                                  struct device_attribute *devattr,
> +                                  const char *buf, size_t count)
> +{
> +       int attr, battery;
> +       unsigned long value;
> +       struct power_supply *supply = to_power_supply(dev);

Can you use reverse xmas tree, esp. put assignments first.

> +       if (!supply) {

How this could be possible?!

> +               pr_err("Can't upcast to power_supply!");
> +               return -ENODEV;
> +       }

> +       if (kstrtoul(buf, 10, &value))
> +               return -EINVAL;

Don't shadow an error code from kstrtoul().

> +static ssize_t tpacpi_battery_show(struct device *dev,
> +                                 struct device_attribute *devattr,
> +                                 char *buf)
> +{
> +       int ret = 0x0, attr, battery;
> +       struct power_supply *supply = to_power_supply(dev);

> +       if (!supply) {

How this could be possible?!

> +               pr_crit("Can't upcast to power_supply!");
> +               return -ENODEV;
> +       }

> +       return sprintf(buf, "%d\n", ret);
> +}
> +
> +DEVICE_ATTR(charge_start_threshold, 0644,
> +               tpacpi_battery_show, tpacpi_battery_store);
> +DEVICE_ATTR(charge_stop_threshold, 0644,
> +       tpacpi_battery_show, tpacpi_battery_store);

DEVICE_ATTR_RW().

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

This one sounds to me as a separate change.

At the same time you may convert the current user of it to make sense
of the change.
drivers/power/supply/power_supply_core.c:671:

I think I pointed to this out once.

-- 
With Best Regards,
Andy Shevchenko
