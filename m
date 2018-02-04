From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [PATCH v12 1/4] battery: Add the battery hooking API
Date: Sun, 4 Feb 2018 10:11:38 +0100
Message-ID: <20180204091138.fi4s6665iybcj3hu@thinkpad>
References: <20180103115847.GA10092@thinkpad>
 <5709554.PD1OuOmgsS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5709554.PD1OuOmgsS@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 04, 2018 at 09:52:33AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, January 3, 2018 12:58:47 PM CET Ognjen Galic wrote:
> > This is a patch that implements a generic hooking API for the
> > generic ACPI battery driver.
> > 
> > With this new generic API, drivers can expose platform specific
> > behaviour via sysfs attributes in /sys/class/power_supply/BATn/
> > in a generic way.
> > 
> > A perfect example of the need for this API are Lenovo ThinkPads.
> > 
> > Lenovo ThinkPads have a ACPI extension that allows the setting of
> > start and stop charge thresholds in the EC and battery firmware
> > via ACPI. The thinkpad_acpi module can use this API to expose
> > sysfs attributes that it controls inside the ACPI battery driver
> > sysfs tree, under /sys/class/power_supply/BATN/.
> > 
> > The file drivers/acpi/battery.h has been moved to
> > include/acpi/battery.h and the includes inside ac.c, sbs.c, and
> > battery.c have been adjusted to reflect that.
> > 
> > When drivers hooks into the API, the API calls add_battery() for
> > each battery in the system that passes it a acpi_battery
> > struct. Then, the drivers can use device_create_file() to create
> > new sysfs attributes with that struct and identify the batteries
> > for per-battery attributes.
> > 
> > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> > ---
> > 
> > Notes:
> >     v7:
> >     * Implemented mutual exclusion for hooking methods and battery
> >     callbacks
> >     * Fixed a BUG where errors in other modules would occur when the
> >     modules that depend on battery get unloaded
> >     
> >     v8:
> >     * Use list_for_each_safe instead of list_for_each for the module
> >     exit function where deletion of nodes occurs
> >     
> >     v9:
> >     * No changes in this patch in v9
> >     
> >     v10:
> >     * Fix compiler warnings in Intel's 0-day CI
> >     
> >     v11:
> >     * Fix changelog formatting
> >     * Make lists and mutex static
> >     
> >     v12:
> >     * Change all applicable list_for_each to list_for_each_entry
> >     * Define pr_fmt to include module name for pr_*
> > 
> >  drivers/acpi/ac.c      |   2 +-
> >  drivers/acpi/battery.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/acpi/battery.h |  11 ----
> >  drivers/acpi/sbs.c     |   2 +-
> >  include/acpi/battery.h |  21 +++++++
> >  5 files changed, 171 insertions(+), 16 deletions(-)
> >  delete mode 100644 drivers/acpi/battery.h
> >  create mode 100644 include/acpi/battery.h
> > 
> > diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> > index 47a7ed5..2d8de2f 100644
> > --- a/drivers/acpi/ac.c
> > +++ b/drivers/acpi/ac.c
> > @@ -33,7 +33,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/acpi.h>
> > -#include "battery.h"
> > +#include <acpi/battery.h>
> >  
> >  #define PREFIX "ACPI: "
> >  
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 13e7b56..7089e31 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -21,8 +21,12 @@
> >   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/kernel.h>
> > +#include <linux/list.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/init.h>
> >  #include <linux/types.h>
> >  #include <linux/jiffies.h>
> > @@ -42,7 +46,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/power_supply.h>
> >  
> > -#include "battery.h"
> > +#include <acpi/battery.h>
> >  
> >  #define PREFIX "ACPI: "
> >  
> > @@ -124,6 +128,7 @@ struct acpi_battery {
> >  	struct power_supply_desc bat_desc;
> >  	struct acpi_device *device;
> >  	struct notifier_block pm_nb;
> > +	struct list_head list;
> >  	unsigned long update_time;
> >  	int revision;
> >  	int rate_now;
> > @@ -626,6 +631,142 @@ static const struct device_attribute alarm_attr = {
> >  	.store = acpi_battery_alarm_store,
> >  };
> >  
> > +/*
> > + * The Battery Hooking API
> > + *
> > + * This API is used inside other drivers that need to expose
> > + * platform-specific behaviour within the generic driver in a
> > + * generic way.
> > + *
> > + */
> > +
> > +static LIST_HEAD(acpi_battery_list);
> > +static LIST_HEAD(battery_hook_list);
> > +static DEFINE_MUTEX(hook_mutex);
> > +
> > +void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
> > +{
> > +	struct list_head *position;
> > +	struct acpi_battery *battery;
> > +	/*
> > +	 * In order to remove a hook, we first need to
> > +	 * de-register all the batteries that are registered.
> > +	 */
> > +	if (lock)
> > +		mutex_lock(&hook_mutex);
> > +	list_for_each(position, &acpi_battery_list) {
> > +		battery = list_entry(position, struct acpi_battery, list);
> > +		hook->remove_battery(battery->bat);
> > +	}
> > +	list_del(&hook->list);
> > +	if (lock)
> > +		mutex_unlock(&hook_mutex);
> > +	pr_info("extension unregistered: %s\n", hook->name);
> > +}
> > +
> > +void battery_hook_unregister(struct acpi_battery_hook *hook)
> > +{
> > +	__battery_hook_unregister(hook, 1);
> > +}
> > +EXPORT_SYMBOL_GPL(battery_hook_unregister);
> > +
> > +void battery_hook_register(struct acpi_battery_hook *hook)
> > +{
> > +	struct acpi_battery *battery;
> > +
> > +	mutex_lock(&hook_mutex);
> > +	INIT_LIST_HEAD(&hook->list);
> > +	list_add(&hook->list, &battery_hook_list);
> > +	/*
> > +	 * Now that the driver is registered, we need
> > +	 * to notify the hook that a battery is available
> > +	 * for each battery, so that the driver may add
> > +	 * its attributes.
> > +	 */
> > +	list_for_each_entry(battery, &acpi_battery_list, list) {
> > +		if (hook->add_battery(battery->bat)) {
> > +			/*
> > +			 * If a add-battery returns non-zero,
> > +			 * the registration of the extension has failed,
> > +			 * and we will not add it to the list of loaded
> > +			 * hooks.
> > +			 */
> > +			pr_err("extension failed to load: %s",
> > +					hook->name);
> > +			__battery_hook_unregister(hook, 0);
> > +			return;
> > +		}
> > +	}
> > +	pr_info("new extension: %s\n", hook->name);
> > +	mutex_unlock(&hook_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(battery_hook_register);
> > +
> > +static void battery_hook_add_battery(struct acpi_battery *battery)
> > +{
> > +	/*
> > +	 * This function gets called right after the battery sysfs
> > +	 * attributes have been added, so that the drivers that
> > +	 * define custom sysfs attributes can add their own.
> > +	 */
> > +	struct acpi_battery_hook *hook_node;
> > +
> > +	mutex_lock(&hook_mutex);
> > +	INIT_LIST_HEAD(&battery->list);
> > +	list_add(&battery->list, &acpi_battery_list);
> > +	/*
> > +	 * Since we added a new battery to the list, we need to
> > +	 * iterate over the hooks and call add_battery for each
> > +	 * hook that was registered. This usually happens
> > +	 * when a battery gets hotplugged or initialized
> > +	 * during the battery module initialization.
> > +	 */
> > +	list_for_each_entry(hook_node, &battery_hook_list, list) {
> > +		if (hook_node->add_battery(battery->bat)) {
> > +			/*
> > +			 * The notification of the extensions has failed, to
> > +			 * prevent further errors we will unload the extension.
> > +			 */
> > +			__battery_hook_unregister(hook_node, 0);
> > +			pr_err("error in extension, unloading: %s",
> > +					hook_node->name);
> > +		}
> > +	}
> > +	mutex_unlock(&hook_mutex);
> > +}
> > +
> > +static void battery_hook_remove_battery(struct acpi_battery *battery)
> > +{
> > +	struct acpi_battery_hook *hook;
> > +
> > +	mutex_lock(&hook_mutex);
> > +	/*
> > +	 * Before removing the hook, we need to remove all
> > +	 * custom attributes from the battery.
> > +	 */
> > +	list_for_each_entry(hook, &battery_hook_list, list) {
> > +		hook->remove_battery(battery->bat);
> > +	}
> > +	/* Then, just remove the battery from the list */
> > +	list_del(&battery->list);
> > +	mutex_unlock(&hook_mutex);
> > +}
> > +
> > +static void __exit battery_hook_exit(void)
> > +{
> > +	struct acpi_battery_hook *hook;
> > +	struct acpi_battery_hook *ptr;
> > +	/*
> > +	 * At this point, the acpi_bus_unregister_driver
> > +	 * has called remove for all batteries. We just
> > +	 * need to remove the hooks.
> > +	 */
> > +	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> > +		__battery_hook_unregister(hook, 1);
> > +	}
> > +	mutex_destroy(&hook_mutex);
> > +}
> > +
> >  static int sysfs_add_battery(struct acpi_battery *battery)
> >  {
> >  	struct power_supply_config psy_cfg = { .drv_data = battery, };
> > @@ -647,6 +788,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
> >  	battery->bat = power_supply_register_no_ws(&battery->device->dev,
> >  				&battery->bat_desc, &psy_cfg);
> >  
> > +	battery_hook_add_battery(battery);
> 
> I seem to see a problem here, as this may be called before
> battery_hook_register() in some cases if I'm not mistaken and there seems to
> be nothing to ensure that the "hook" code will actually see the battery then.

There is a mechanism for late-loading of modules.
battery_hook_add_battery adds each battery to a list of batteries:

> static LIST_HEAD(acpi_battery_list);

When the ACPI battery drivers adds a battery to sysfs, the call to
battery_hook_add_battery adds the battery to the list that is being
added.

> ...
>	struct acpi_battery_hook *hook_node;
>
>	mutex_lock(&hook_mutex);
>	INIT_LIST_HEAD(&battery->list);
>	list_add(&battery->list, &acpi_battery_list);
> ...

Then, after adding the battery to the list it notifies the already
existing hooks of the new battery:

>	list_for_each_entry(hook_node, &battery_hook_list, list) {
>		if (hook_node->add_battery(battery->bat)) {
>			__battery_hook_unregister(hook_node, 0);
>			pr_err("error in extension, unloading: %s",
>					hook_node->name);
>		}
>	}

If and and after some module calls battery_hook_register AFTER
the battery has been added, the module is THEN notified of 
ALL the batteries added to sysfs, regardless of loading 
time or hooking of that module.

>	list_for_each_entry(battery, &acpi_battery_list, list) {
>		if (hook->add_battery(battery->bat)) {
>			/*
>			 * If a add-battery returns non-zero,
>			 * the registration of the extension has failed,
>			 * and we will not add it to the list of loaded
>			 * hooks.
>			 */
>			pr_err("extension failed to load: %s",
>					hook->name);
>			__battery_hook_unregister(hook, 0);
>			return;
>		}
>	}

The order is like this for late hook loading:

* battery module loads
* battery constructs a list of batteries
* battery is ready

And some other module that NEEDS the battery hook API *MUST* load
*AFTER* battery, and it will *NOT* load if battery is not loaded. It
fails with a pre-load "symbol missing" error, *NOT* a runtime error.

* thinkpad_acpi loads
* thinkpad_acpi hooks into battery
* battery goes through the list of batteries and registers then in
  thinkpad_acpi
* thinkpad_acpi is ready

I tested this back and forth, removing batteries, adding them, loading
then adding batteries, back and forth and it registers the battery each
time. 

Thanks for the time.
Ognjen

> 
> Thanks,
> Rafael
> 
