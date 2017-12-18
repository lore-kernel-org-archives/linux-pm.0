From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3 v6] battery: Add the battery hooking API
Date: Mon, 18 Dec 2017 19:04:07 +0100
Message-ID: <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
References: <20171215165654.GA6209@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171215165654.GA6209@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 15, 2017 at 5:56 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
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
>
> Tested-by: Kevin Locke <kevin@kevinlocke.name>
> Tested-by: Christoph B=C3=B6hmwalder <christoph@boehmwalder.at>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> ---
>  drivers/acpi/ac.c      |   2 +-
>  drivers/acpi/battery.c | 139 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/acpi/battery.h |  11 ----
>  drivers/acpi/sbs.c     |   2 +-
>  include/acpi/battery.h |  21 ++++++++
>  5 files changed, 160 insertions(+), 15 deletions(-)
>  delete mode 100644 drivers/acpi/battery.h
>  create mode 100644 include/acpi/battery.h
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 47a7ed5..2d8de2f 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -33,7 +33,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/acpi.h>
> -#include "battery.h"
> +#include <acpi/battery.h>
>
>  #define PREFIX "ACPI: "
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 13e7b56..2951d07 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -30,6 +30,7 @@
>  #include <linux/dmi.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/list.h>
>  #include <linux/suspend.h>
>  #include <asm/unaligned.h>
>
> @@ -42,7 +43,7 @@
>  #include <linux/acpi.h>
>  #include <linux/power_supply.h>
>
> -#include "battery.h"
> +#include <acpi/battery.h>
>
>  #define PREFIX "ACPI: "
>
> @@ -124,6 +125,7 @@ struct acpi_battery {
>         struct power_supply_desc bat_desc;
>         struct acpi_device *device;
>         struct notifier_block pm_nb;
> +       struct list_head list;
>         unsigned long update_time;
>         int revision;
>         int rate_now;
> @@ -626,6 +628,137 @@ static const struct device_attribute alarm_attr =3D=
 {
>         .store =3D acpi_battery_alarm_store,
>  };
>
> +/*
> + * The Battery Hooking API
> + *
> + * This API is used inside other drivers that need to expose
> + * platform-specific behaviour within the generic driver in a
> + * generic way.
> + *
> + */
> +
> +LIST_HEAD(acpi_battery_list);
> +LIST_HEAD(battery_hook_list);
> +
> +void battery_hook_unregister(struct acpi_battery_hook *hook)
> +{
> +
> +       struct list_head *position;
> +       struct acpi_battery *battery;
> +
> +       /*
> +        * In order to remove a hook, we first need to
> +        * de-register all the batteries that are registered.
> +        */
> +
> +       list_for_each(position, &acpi_battery_list) {
> +               battery =3D list_entry(position, struct acpi_battery, lis=
t);
> +               hook->remove_battery(battery->bat);
> +       }
> +
> +       /* Then, just remove the hook */
> +
> +       list_del(&hook->list);
> +       pr_info("battery: extension unregistered: %s\n", hook->name);
> +
> +}
> +EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +
> +void battery_hook_register(struct acpi_battery_hook *hook)
> +{
> +       struct list_head *position;
> +       struct acpi_battery *battery;
> +
> +       INIT_LIST_HEAD(&hook->list);
> +       list_add(&hook->list, &battery_hook_list);
> +
> +       /*
> +        * Now that the driver is registered, we need
> +        * to notify the hook that a battery is available
> +        * for each battery, so that the driver may add
> +        * its attributes.
> +        */
> +       list_for_each(position, &acpi_battery_list) {
> +               battery =3D list_entry(position, struct acpi_battery, lis=
t);
> +               if (hook->add_battery(battery->bat)) {
> +
> +                       /*
> +                        * If a add-battery returns non-zero,
> +                        * the registration of the extension has failed,
> +                        * we will unload it.
> +                        */
> +                       pr_err("battery: extension failed to load: %s",
> +                                       hook->name);
> +                       battery_hook_unregister(hook);
> +                       return;
> +
> +               }
> +       }
> +
> +       pr_info("battery: new extension: %s\n", hook->name);
> +
> +}
> +EXPORT_SYMBOL_GPL(battery_hook_register);
> +
> +static void battery_hook_add_battery(struct acpi_battery *battery)
> +{
> +
> +       /*
> +        * This function gets called right after the battery sysfs
> +        * attributes have been added, so that the drivers that
> +        * define custom sysfs attributes can add their own.
> +        */
> +
> +       struct list_head *position;
> +       struct acpi_battery_hook *hook_node;
> +
> +       INIT_LIST_HEAD(&battery->list);
> +       list_add(&battery->list, &acpi_battery_list);
> +
> +       /*
> +        * Since we added a new battery to the list, we need to
> +        * iterate over the hooks and call add_battery for each
> +        * hook that was registered. This usually happens
> +        * when a battery gets hotplugged or initialized
> +        * during the battery module initialization.
> +        */
> +
> +       list_for_each(position, &battery_hook_list) {
> +               hook_node =3D list_entry(position, struct acpi_battery_ho=
ok, list);
> +               if (hook_node->add_battery(battery->bat)) {
> +
> +                       /*
> +                        * The notification of the extensions has failed,=
 to
> +                        * prevent further errors we will unload the exte=
nsion.
> +                        */
> +                       battery_hook_unregister(hook_node);
> +                       pr_err("battery: error in extension, unloading: %=
s",
> +                                       hook_node->name);
> +               }
> +       }
> +
> +}
> +
> +static void battery_hook_remove_battery(struct acpi_battery *battery)
> +{
> +       struct list_head *position;
> +       struct acpi_battery_hook *hook;
> +
> +       /*
> +        * Before removing the hook, we need to remove all
> +        * custom attributes from the battery.
> +        */
> +       list_for_each(position, &battery_hook_list) {
> +               hook =3D list_entry(position, struct acpi_battery_hook, l=
ist);
> +               hook->remove_battery(battery->bat);
> +       }
> +
> +       /* Then, just remove the battery from the list */
> +
> +       list_del(&battery->list);
> +
> +}
> +
>  static int sysfs_add_battery(struct acpi_battery *battery)
>  {
>         struct power_supply_config psy_cfg =3D { .drv_data =3D battery, }=
;
> @@ -647,6 +780,8 @@ static int sysfs_add_battery(struct acpi_battery *bat=
tery)
>         battery->bat =3D power_supply_register_no_ws(&battery->device->de=
v,
>                                 &battery->bat_desc, &psy_cfg);
>
> +       battery_hook_add_battery(battery);

What if a module registering the hook is loaded after
sysfs_add_battery() has run for the battery object in question?

What if it attempts to register a hook while this code is running?

What if two entities try to add or remove hooks simultaneously?

Don't you think any locking or other synchronization is necessary?

Also, what if someone attempts to add a hook when the ACPI battery
module is not loaded?  Will that still work?

Thanks,
Rafael
