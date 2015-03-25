From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 2/3] Thermal: handle thermal zone device properly during
 system sleep
Date: Wed, 25 Mar 2015 02:25:06 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014BA997@SHSMSX101.ccr.corp.intel.com>
References: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
 <1427174490-7974-3-git-send-email-rui.zhang@intel.com>
 <20150324150647.GC29155@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150324150647.GC29155@developer.hsd1.ca.comcast.net>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Tuesday, March 24, 2015 11:07 PM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 2/3] Thermal: handle thermal zone device properly during
> system sleep
> Importance: High
> 
> Hey Rui
> 
> On Tue, Mar 24, 2015 at 01:21:29PM +0800, Zhang Rui wrote:
> > Current thermal code does not handle system sleep well because 1. the
> > cooling device cooling state may be changed during suspend 2. the
> > previous temperature reading becomes invalid after resumed because
> >    it is got before system sleep
> > 3. updating thermal zone device during suspending/resuming
> >    is wrong because some devices may have already been suspended
> >    or may have not been resumed.
> >
> > Thus, the proper way to do this is to cancel all thermal zone device
> > update requirements during suspend/resume, and after all the devices
> > have been resumed, reset and update every registered thermal zone
> > devices.
> >
> > This also fixes a regression introduced by commit
> > 19593a1fb1f6718406afca5b867dab184289d406
> > Author: Aaron Lu <aaron.lu@intel.com>
> > Date:   Tue Nov 19 16:59:20 2013 +0800
> >
> >     ACPI / fan: convert to platform driver
> >
> >     Convert ACPI fan driver to a platform driver for the purpose of phasing
> >     out ACPI bus.
> >
> >     Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >
> > Because, with the commit applied, all the fan devices are attached to
> > the acpi_general_pm_domain, and they are turned on by the pm_domain
> > automatically after resume, without the awareness of thermal core.
> >
> > CC: <stable@vger.kernel.org> #3.18+
> > Reference: https://bugzilla.kernel.org/show_bug.cgi?id=78201
> > Reference: https://bugzilla.kernel.org/show_bug.cgi?id=91411
> > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > Tested-by: prash <prash.n.rao@gmail.com>
> > Tested-by: amish <ammdispose-arch@yahoo.com>
> > Tested-by: Matthias <morpheusxyz123@yahoo.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 37
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index 9d6f71b..9c03561 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/of.h>
> >  #include <net/netlink.h>
> >  #include <net/genetlink.h>
> > +#include <linux/suspend.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/thermal.h>
> > @@ -59,6 +60,9 @@ static LIST_HEAD(thermal_governor_list);  static
> > DEFINE_MUTEX(thermal_list_lock);  static
> > DEFINE_MUTEX(thermal_governor_lock);
> >
> > +static struct notifier_block thermal_pm_nb; static bool
> > +no_thermal_update;
> 
> Should this variable be considered to be accessed using a lock?
> 
Hmmm, why?
It is set once when entering suspend, and cleared once when resuming,
and this whole process is protected by the pm_mutex lock, right?

> > +
> >  static struct thermal_governor *def_governor;
> >
> >  static struct thermal_governor *__find_governor(const char *name) @@
> > -491,6 +495,9 @@ void thermal_zone_device_update(struct
> > thermal_zone_device *tz)  {
> >  	int count;
> >
> > +	if (no_thermal_update)
> > +		return;
> > +
> >  	if (!tz->ops->get_temp)
> >  		return;
> >
> > @@ -1823,6 +1830,33 @@ static void thermal_unregister_governors(void)
> >  	thermal_gov_user_space_unregister();
> >  }
> >
> > +static int thermal_notify(struct notifier_block *nb,
> > +				unsigned long mode, void *_unused)
> 
> I believe thermal_pm_notify sounds a better naming for this case.
> 
Okay, will change it to thermal_pm_notify in next version.

> > +{
> > +	struct thermal_zone_device *tz;
> > +
> > +	switch (mode) {
> > +	case PM_HIBERNATION_PREPARE:
> > +	case PM_RESTORE_PREPARE:
> > +	case PM_SUSPEND_PREPARE:
> > +		no_thermal_update = true;
> > +		break;
> > +	case PM_POST_HIBERNATION:
> > +	case PM_POST_RESTORE:
> > +	case PM_POST_SUSPEND:
> > +		no_thermal_update = false;
> > +		list_for_each_entry(tz, &thermal_tz_list, node) {
> > +			thermal_zone_device_reset(tz);
> > +			thermal_zone_device_update(tz);
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return 0;
> > +}
> > +
> > +
> >  static int __init thermal_init(void)
> >  {
> >  	int result;
> > @@ -1843,6 +1877,9 @@ static int __init thermal_init(void)
> >  	if (result)
> >  		goto exit_netlink;
> >
> > +	thermal_pm_nb.notifier_call = thermal_notify;
> 
> I believe you can declare thermal_pm_nb already with the callback
> initialized:
> 
> 
> 
> static struct notifier_block thermal_pm_nb = {
> 	.notifier_call = thermal_notify,
> };
> 
Yes, will do this.

Thanks,
rui
> 
> just put it after the thermal_notify function.
> 
> > +	register_pm_notifier(&thermal_pm_nb);
> > +
> >  	return 0;
> >
> >  exit_netlink:
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html
