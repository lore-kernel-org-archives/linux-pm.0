From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: [PATCH 2/3 v6] battery: Add the ThinkPad "Not Charging" quirk
Date: Sat, 16 Dec 2017 09:48:50 +0100
Message-ID: <20171216084850.GA19033@thinkpad>
References: <20171215165750.GA6282@thinkpad>
 <CAJZ5v0ida0RTUBdtpCK4rAXfdukadpTyxD0Rpp4R=kKcukyjKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ida0RTUBdtpCK4rAXfdukadpTyxD0Rpp4R=kKcukyjKA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 16, 2017 at 01:33:55AM +0100, Rafael J. Wysocki wrote:
> On Fri, Dec 15, 2017 at 5:57 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> > of "Unknown" when the battery is between the charge start and
> > charge stop thresholds. On Windows, it reports "Not Charging"
> > so the quirk has been added to also report correctly.
> >
> > Now the "status" attribute returns "Not Charging" when the
> > battery on ThinkPads is not physicaly charging.
> >
> > Tested-by: Kevin Locke <kevin@kevinlocke.name>
> > Tested-by: Christoph Böhmwalder <christoph@boehmwalder.at>
> > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> 
> It doesn't look like this is related to the [1/3] and [3/3], so why do
> you make it part of the series?
> 

I made it the same series because it is practically the same feature
set. Without this patch and with 1/3 and 3/3 applied, there is a bug
where the status attribute would show "Unknown" for a battery that is
between the start and stop thresholds while attached to AC.

> > ---
> >  drivers/acpi/battery.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 2951d07..81e9b4e 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -71,6 +71,7 @@ static async_cookie_t async_cookie;
> >  static bool battery_driver_registered;
> >  static int battery_bix_broken_package;
> >  static int battery_notification_delay_ms;
> > +static int battery_quirk_thinkpad_notcharging;
> 
> Drop "thinkpad" from this name as somebody may need to use the quirk
> for a machine from a different vendor in the future.
> 
> >  static unsigned int cache_time = 1000;
> >  module_param(cache_time, uint, 0644);
> >  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> > @@ -222,6 +223,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
> >                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
> >                 else if (acpi_battery_is_charged(battery))
> >                         val->intval = POWER_SUPPLY_STATUS_FULL;
> > +               /*
> > +                * On the Lenovo ThinkPad ACPI implementation, when
> > +                * neither bits 0 or 1 are set, that state is
> > +                * considered as "Not Charging".
> > +                */
> > +               else if (battery_quirk_thinkpad_notcharging)
> > +                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> >                 else
> >                         val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> >                 break;
> > @@ -1301,6 +1309,13 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
> >         return 0;
> >  }
> >
> > +static int __init
> > +battery_quirk_not_charging(const struct dmi_system_id *d)
> 
> Don't break the above line (it will be over 80 chars long, but that's fine).
> 
> > +{
> > +       battery_quirk_thinkpad_notcharging = 1;
> > +       return 0;
> > +}
> > +
> >  static const struct dmi_system_id bat_dmi_table[] __initconst = {
> >         {
> >                 .callback = battery_bix_broken_package_quirk,
> > @@ -1318,6 +1333,14 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
> >                         DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
> >                 },
> >         },
> > +       {
> 
> Add a comment to describe this quirk (which it is needed in the first place).
> 
> > +               .callback = battery_quirk_not_charging,
> > +               .ident = "Lenovo ThinkPad",
> > +               .matches = {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> > +               },
> > +       },
> >         {},
> >  };
> >
> > --
> 
> Thanks,
> Rafael
