From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Wed, 25 Mar 2015 02:27:31 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014BA9AD@SHSMSX101.ccr.corp.intel.com>
References: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
 <1427174490-7974-4-git-send-email-rui.zhang@intel.com>
 <20150324151249.GD29155@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150324151249.GD29155@developer.hsd1.ca.comcast.net>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Tuesday, March 24, 2015 11:13 PM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
> device registered
> Importance: High
> 
> Hi,
> 
> On Tue, Mar 24, 2015 at 01:21:30PM +0800, Zhang Rui wrote:
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
> > b/drivers/thermal/thermal_core.c index 9c03561..7cef579 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1141,6 +1141,7 @@ __thermal_cooling_device_register(struct
> device_node *np,
> >  				  const struct thermal_cooling_device_ops *ops)
> {
> >  	struct thermal_cooling_device *cdev;
> > +	struct thermal_instance *pos, *next;
> >  	int result;
> >
> >  	if (type && strlen(type) >= THERMAL_NAME_LENGTH) @@ -1185,6
> +1186,15
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
> 
> Shouldn't we simply trigger a thermal_zone_device_update(pos->tz) ? I mean,
> we are adding a new cooling device to the zone, so, it might make sense to
> update it anyway.
> 
We may have a couple of themal instances for the same cdev and thermal zone, but for different trips.
And the code above ignore the duplicate thermal_zone_device_update() for the same thermal zone.

Thanks,
rui
> > +	}
> 
> 
> > +
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
