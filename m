From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH V4 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Thu, 9 Apr 2015 15:14:51 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014CFDCF@SHSMSX101.ccr.corp.intel.com>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-4-git-send-email-rui.zhang@intel.com>
 <20150408150420.GB28698@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6661 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbbDIPPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2015 11:15:20 -0400
In-Reply-To: <20150408150420.GB28698@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Wednesday, April 8, 2015 11:04 PM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org
> Subject: Re: [PATCH V4 3/3] Thermal: do thermal zone update after a cooling
> device registered
> Importance: High
> 
> Hello Rui,
> 
> On Tue, Apr 07, 2015 at 10:24:36AM +0800, Zhang Rui wrote:
> > When a new cooling device is registered, we need to update the thermal
> > zone to set the new registered cooling device to a proper state.
> >
> > This fixes a problem that the system is cool, while the fan devices
> > are left running on full speed after boot, if fan device is registered
> > after thermal zone device.
> >
> > CC: <stable@vger.kernel.org> #3.18+
> > Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
> > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > Tested-by: prash <prash.n.rao@gmail.com>
> > Tested-by: amish <ammdispose-arch@yahoo.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index 875a9bb..e37042c 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1140,6 +1140,7 @@ __thermal_cooling_device_register(struct
> device_node *np,
> >  				  const struct thermal_cooling_device_ops *ops)
> {
> >  	struct thermal_cooling_device *cdev;
> > +	struct thermal_instance *pos, *next;
> >  	int result;
> >
> >  	if (type && strlen(type) >= THERMAL_NAME_LENGTH) @@ -1184,6
> +1185,15
> > @@ __thermal_cooling_device_register(struct device_node *np,
> >  	/* Update binding information for 'this' new cdev */
> >  	bind_cdev(cdev);
> >
> > +	list_for_each_entry_safe(pos, next, &cdev->thermal_instances,
> cdev_node) {
> > +			if (next->cdev_node.next == &cdev->thermal_instances)
> {
> > +				thermal_zone_device_update(next->tz);
> > +				break;
> > +			}
> > +			if (pos->tz != next->tz)
> > +				thermal_zone_device_update(pos->tz);
> > +	}
> 
> Maybe the reasoning for not calling only when initialized == false is because at
> this point all instances are initialized == false.
> 
No. 
At this point, only the thermal instances for the current cooling device are initialized=false.
For the cooling devices that have already been registered, their thermal instances are initialized = true.

> Then why not moving this thermal_zone_device_update(tz) to the
> thermal_zone_bind_cooling_device(), where we create the thermal_instance?
> 
The same problem, as there may be multiple thermal instances for the same cooling device and zone, but for different trip point,
If we do thermal_zone_device_update() for every binding, this means that there may be several thermal zone device update when one cooling device is registered.

> > +
> 
> Besides, Can you please elaborate more on why we need to specifically call
> thermal_zone_device_update(tz) here and not simply wait until next
> tz->poll_queue work is called?

If the system boots with low temperature, and the fan devices are turned on in boot phrase by firmware,
there may be not thermal events as the fan is always running in full speed, thus there is no chance to do thermal zone device update.

Actually, on ACPI platform, we have a bug report that the temperature is a bogus value, which is statically 16C,
and the ACPI fan devices are turned on automatically by the acpi_general_pm_domain, the fan device never spins down.
> 
> Any particular reason for the problem not be solved byt the call of
> thermal_zone_device_update(tz) from the poll_queue of each tz?
> 
Because polling delay is not mandatory for every thermal zone, thus some platform thermal driver relies on interrupts instead of polling.

Thanks,
rui
> 
> 
> >  	return cdev;
> >  }
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html
