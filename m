From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/3][v3] Thermal: do thermal zone update after a cooling
 device registered
Date: Fri, 1 Jan 2016 15:38:38 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028691BF1@shsmsx102.ccr.corp.intel.com>
References: <cover.1446192980.git.yu.c.chen@intel.com>
 <ffb964a5ec9f93e68814071a5d03bb9b65600b62.1446192980.git.yu.c.chen@intel.com>
 <20151231190349.GA14647@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27613 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbcAAPis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 10:38:48 -0500
In-Reply-To: <20151231190349.GA14647@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "javi.merino@arm.com" <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Eduardo,
thanks for your review,

> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Friday, January 01, 2016 3:04 AM
> To: Chen, Yu C
> Cc: Zhang, Rui; javi.merino@arm.com; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 3/3][v3] Thermal: do thermal zone update after a cooling
> device registered
> 
> Hello Chen,
> 
> On Fri, Oct 30, 2015 at 04:32:10PM +0800, Chen Yu wrote:
> > When a new cooling device is registered, we need to update the thermal
> > zone to set the new registered cooling device to a proper state.
> >
> > This fixes a problem that the system is cool, while the fan devices
> > are left running on full speed after boot, if fan device is registered
> > after thermal zone device.
> >
> > Here is the history of why current patch looks like this:
> > https://patchwork.kernel.org/patch/7273041/
> >
> > CC: <stable@vger.kernel.org> #3.18+
> > Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
> > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > Tested-by: prash <prash.n.rao@gmail.com>
> > Tested-by: amish <ammdispose-arch@yahoo.com>
> > Reviewed-by: Javi Merino <javi.merino@arm.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 14 +++++++++++++-
> >  include/linux/thermal.h        |  2 ++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index 9aae767..ba08b55 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1341,6 +1341,7 @@ int thermal_zone_bind_cooling_device(struct
> thermal_zone_device *tz,
> >  	if (!result) {
> >  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
> >  		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> > +		atomic_set(&tz->need_update, 1);
> >  	}
> >  	mutex_unlock(&cdev->lock);
> >  	mutex_unlock(&tz->lock);
> > @@ -1450,6 +1451,7 @@ __thermal_cooling_device_register(struct
> device_node *np,
> >  				  const struct thermal_cooling_device_ops
> *ops)  {
> >  	struct thermal_cooling_device *cdev;
> > +	struct thermal_zone_device *pos = NULL;
> >  	int result;
> >
> >  	if (type && strlen(type) >= THERMAL_NAME_LENGTH) @@ -1494,6
> +1496,12
> > @@ __thermal_cooling_device_register(struct device_node *np,
> >  	/* Update binding information for 'this' new cdev */
> >  	bind_cdev(cdev);
> >
> > +	mutex_lock(&thermal_list_lock);
> > +	list_for_each_entry(pos, &thermal_tz_list, node)
> > +		if (atomic_cmpxchg(&pos->need_update, 1, 0))
> > +			thermal_zone_device_update(pos);
> > +	mutex_unlock(&thermal_list_lock);
> > +
> >  	return cdev;
> >  }
> >
> > @@ -1826,6 +1834,8 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
> >  	tz->trips = trips;
> >  	tz->passive_delay = passive_delay;
> >  	tz->polling_delay = polling_delay;
> > +	/* A new thermal zone needs to be updated anyway. */
> > +	atomic_set(&tz->need_update, 1);
> >
> >  	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> >  	result = device_register(&tz->device); @@ -1921,7 +1931,9 @@
> struct
> > thermal_zone_device *thermal_zone_device_register(const char *type,
> >  	INIT_DELAYED_WORK(&(tz->poll_queue),
> thermal_zone_device_check);
> >
> >  	thermal_zone_device_reset(tz);
> > -	thermal_zone_device_update(tz);
> > +	/* Update the new thermal zone and mark it as already updated. */
> > +	if (atomic_cmpxchg(&tz->need_update, 1, 0))
> > +		thermal_zone_device_update(tz);
> >
> >  	return tz;
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> > 5bcabc7..385d411 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -168,6 +168,7 @@ struct thermal_attr {
> >   * @forced_passive:	If > 0, temperature at which to switch on all ACPI
> >   *			processor cooling devices.  Currently only used by the
> >   *			step-wise governor.
> > + * @need_update:	if equals 1, thermal_zone_device_update needs to
> be invoked.
> >   * @ops:	operations this &thermal_zone_device supports
> >   * @tzp:	thermal zone parameters
> >   * @governor:	pointer to the governor for this thermal zone
> > @@ -195,6 +196,7 @@ struct thermal_zone_device {
> >  	int emul_temperature;
> >  	int passive;
> >  	unsigned int forced_passive;
> > +	atomic_t need_update;
> 
> The only problem I have with the above change is the fact that it does not
> touch thermal_zone_device_update() in any place. Please, remember that
> thermal_zone_device_update() is an exported function. That means that
> anyone can actually call it. And that is what happens today. If you git grep for
> it you will see that there are occurrences inside thermal core and inside
> thermal drivers. And this change do not take care of them. Are you sure you
> don't need to revisit all occurrences?
[Yu] Do you mean this patch should be aware of other places who have already
'updated' the thermal zone for the new device? so we don't need to
update them for the second time? Yes, the current implementation seems 
to be redundant when others have updated the zone for us, but it is to make
sure the updating for this thermal zone will be invoked at least once, if a new
cooling device is added into it. 
> 
> Shouldn't thermal_zone_device_update() unset the need_update bit, given
> it has just updated the zone?
[Yu] If   thermal_zone_device_update takes care of this flag, we might need to make
thermal_zone_device_update a atomic function first. Maybe the name of  need_update
should be renamed to new_device_added.
> 
> Also, what happens to the logic when external changes happens? Say, we
> have writable trip points enabled, and user changes a trip point value?
[Yu] If the user changes a trip point, since currently thermal_zone_device_update is
not atomic, this might bring problems when thermal_zone_device_update is executing parallelly,
 and we might need to make thermal_zone_device_update into a atomic operation in the future.
> 
> 
> BR,
> 
> >  	struct thermal_zone_device_ops *ops;
> >  	struct thermal_zone_params *tzp;
> >  	struct thermal_governor *governor;
> > --
> > 1.8.4.2
> >
thanks and happy new year,
Yu
