From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [PATCH v12 1/4] battery: Add the battery hooking API
Date: Wed, 3 Jan 2018 15:53:07 +0100
Message-ID: <20180103145307.GA17694@thinkpad>
References: <20180103115847.GA10092@thinkpad>
 <CAHp75Vdj2rasWqdmBKGxNs9Y+Rap=UycoFdOcbG6QgA48Afq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vdj2rasWqdmBKGxNs9Y+Rap=UycoFdOcbG6QgA48Afq5w@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 03, 2018 at 04:25:42PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 3, 2018 at 1:58 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
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
> 
> Thanks for an update. I have couple of minors. Otherwise look pretty much good!
> 
> >  drivers/acpi/battery.h |  11 ----
> >  include/acpi/battery.h |  21 +++++++
> 
> There are -M and -C command line parameters to git format-patch.
> They can take an optional argument (percentage) of threshold.
> 
> Playing with those numbers you can achieve
> 
> rename ...
> 
> line and see actual diff.
> 
> No need to resend because of this. Just an explanation for the future Git work.

I did use thos options. I used the following command:

git format-patch -M -C --notes -v12 -o ~/patches/. @^^^^

I really don't know what you are targeting. :)

> 
> > +void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
> > +{
> > +       struct list_head *position;
> > +       struct acpi_battery *battery;
> 
> Missed empty line?

checkpatch.pl complains if there are NOT empty lines between
declarations and statements.

> 
> > +       /*
> > +        * In order to remove a hook, we first need to
> > +        * de-register all the batteries that are registered.
> > +        */
> > +       if (lock)
> > +               mutex_lock(&hook_mutex);
> 
> > +       list_for_each(position, &acpi_battery_list) {
> > +               battery = list_entry(position, struct acpi_battery, list);
> 
> list_for_each_enrty() ?
> 
> Or I'm missing something why it can't be used?

I missed that one. Bummer.

I mean, it's not game-breaking, its just minor style stuff. I won't be
sending more revisions because of these small issues, as I think its 
uneccessary to flood both Rafael and the mailing lists with patch
revisions that remove or add a few spaces. No offence, it just got old.

:)

> 
> > +               hook->remove_battery(battery->bat);
> > +       }
> 
> > +void battery_hook_register(struct acpi_battery_hook *hook)
> > +{
> > +       struct acpi_battery *battery;
> 
> > +       list_for_each_entry(battery, &acpi_battery_list, list) {
> > +               if (hook->add_battery(battery->bat)) {
> > +                       /*
> > +                        * If a add-battery returns non-zero,
> > +                        * the registration of the extension has failed,
> > +                        * and we will not add it to the list of loaded
> > +                        * hooks.
> > +                        */
> 
> > +                       pr_err("extension failed to load: %s",
> > +                                       hook->name);
> 
> Can it fit 80 characters?
> I mean if it would be one line...

It could, but it does not. :)

> 
> > +                       __battery_hook_unregister(hook, 0);
> > +                       return;
> > +               }
> > +       }
> > +       pr_info("new extension: %s\n", hook->name);
> > +       mutex_unlock(&hook_mutex);
> > +}
> 
> > +static void battery_hook_add_battery(struct acpi_battery *battery)
> > +{
> 
> > +       /*
> > +        * This function gets called right after the battery sysfs
> > +        * attributes have been added, so that the drivers that
> > +        * define custom sysfs attributes can add their own.
> > +        */
> 
> Perhaps it should go before function definition.
> 
> > +       struct acpi_battery_hook *hook_node;
> 
> > +}
> 
> 
> > +static void __exit battery_hook_exit(void)
> > +{
> > +       struct acpi_battery_hook *hook;
> > +       struct acpi_battery_hook *ptr;
> 
> Missed empty line?

See above about the checkpatch.pl stuff.

> 
> > +       /*
> > +        * At this point, the acpi_bus_unregister_driver
> > +        * has called remove for all batteries. We just
> > +        * need to remove the hooks.
> > +        */
> 
> A common pattern to use func() [note parens] when refer to function.

Got it.

> 
> > +       list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> > +               __battery_hook_unregister(hook, 1);
> > +       }
> > +       mutex_destroy(&hook_mutex);
> > +}
> 
> >         battery->bat = power_supply_register_no_ws(&battery->device->dev,
> >                                 &battery->bat_desc, &psy_cfg);
> >
> > +       battery_hook_add_battery(battery);
> > +
> >         if (IS_ERR(battery->bat)) {
> >                 int result = PTR_ERR(battery->bat);
> 
> I'm not sure why you need to add hook when power_supply_register_no_ws() failed.

One could add a hook for other various reasons, not just to add or
remove sysfs attributes. I'm talking stuff like desktop notifications or
notifications to other modules to change power modes or other stuff.

> 
> >         }
> > -
> > +       battery_hook_remove_battery(battery);
> 
> No need to remove an empty line.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
