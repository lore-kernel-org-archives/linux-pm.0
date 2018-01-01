From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 1/5] battery: Add the battery hooking API
Date: Mon, 1 Jan 2018 11:53:16 +0200
Message-ID: <CAHp75VeQGyzf6oSGgkcuuZ6zmsr2eac5MdBFHVQVrstKFG=nzA@mail.gmail.com>
References: <20171231141631.GA4589@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171231141631.GA4589@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 31, 2017 at 4:16 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> This is a patch that implements a generic hooking API for the
> generic ACPI battery driver.
>
> With this new generic API, drivers can expose platform specific
> behaviour via sysfs attributes in /sys/class/power_supply/BATn/
> in a generic way.
>
> A perfect example of the need for this API are Lenovo ThinkPads.
>
> Lenovo ThinkPads have a ACPI extension that allows the setting of
> start and stop charge thresholds in the EC and battery firmware
> via ACPI. The thinkpad_acpi module can use this API to expose
> sysfs attributes that it controls inside the ACPI battery driver
> sysfs tree, under /sys/class/power_supply/BATN/.
>
> The file drivers/acpi/battery.h has been moved to
> include/acpi/battery.h and the includes inside ac.c, sbs.c, and
> battery.c have been adjusted to reflect that.
>
> When drivers hooks into the API, the API calls add_battery() for
> each battery in the system that passes it a acpi_battery
> struct. Then, the drivers can use device_create_file() to create
> new sysfs attributes with that struct and identify the batteries
> for per-battery attributes.

Thanks for an update. Few comments below.

(Keep in mind, please, that we are not expecting new version
immediately, and Rafael might also apply this one without changes,
since they are minors)

>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
> @@ -30,6 +31,7 @@
>  #include <linux/dmi.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/list.h>

Just a nit: perhaps add this before module.h ?

> +void __battery_hook_unregister(struct acpi_battery_hook *hook, int force)
> +{
> +       struct list_head *position;
> +       struct acpi_battery *battery;
> +
> +       /*
> +        * In order to remove a hook, we first need to
> +        * de-register all the batteries that are registered.
> +        */
> +
> +       if (!force)

I'm not sure force is a good name here, perhaps "locked"?
Btw, would it be boolean?

> +               mutex_lock(&hook_mutex);

> +       list_for_each(position, &acpi_battery_list) {
> +               battery = list_entry(position, struct acpi_battery, list);
> +               hook->remove_battery(battery->bat);
> +       }

list_for_each_entry()

> +
> +       /* Then, just remove the hook */
> +
> +       list_del(&hook->list);
> +
> +       if (!force)
> +               mutex_unlock(&hook_mutex);
> +
> +       pr_info("battery: extension unregistered: %s\n", hook->name);
> +}

> +void battery_hook_register(struct acpi_battery_hook *hook)
> +{

> +       list_for_each(position, &acpi_battery_list) {
> +               battery = list_entry(position, struct acpi_battery, list);

list_for_each_entry()

> +                       __battery_hook_unregister(hook, 1);
> +                       return;
> +

Perhaps you meant empty line followed by return statement.

> +               }
> +       }
> +
> +       pr_info("battery: new extension: %s\n", hook->name);

Perhaps move "battery:" to pr_fmt() ?
I have counted already 3 prints with it and see more below.

> +       list_for_each(position, &battery_hook_list) {
> +               hook_node = list_entry(position, struct acpi_battery_hook, list);

list_for_each_entry()

> +       list_for_each(position, &battery_hook_list) {
> +               hook = list_entry(position, struct acpi_battery_hook, list);

Ditto.

> +       list_for_each_safe(position, temp, &battery_hook_list) {
> +               hook = list_entry(position, struct acpi_battery_hook, list);

Ditto.

> --- a/drivers/acpi/battery.h
> +++ /dev/null
Apparently you didn't apply -M -C (perhaps with some non-default
threshold) to avoid such thing in the patch.

> --- /dev/null
> +++ b/include/acpi/battery.h

Ditto.

-- 
With Best Regards,
Andy Shevchenko
