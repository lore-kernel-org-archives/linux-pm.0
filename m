From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 11/12] thermal: introduce cooling state
	arbitrator
Date: Wed, 20 Jun 2012 14:47:39 +0800
Message-ID: <1340174859.1682.21.camel@rui.sh.intel.com>
References: <1339384839.1492.165.camel@rui.sh.intel.com>
	<20120613142316.GB16714@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120613142316.GB16714@besouro>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: eduardo.valentin@ti.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On =E4=B8=89, 2012-06-13 at 17:23 +0300, Eduardo Valentin wrote:
> Hello Rui,
>=20
> On Mon, Jun 11, 2012 at 11:20:39AM +0800, Zhang Rui wrote:
> >=20
> > Introduce simple arbitrator for setting device cooling state,
> > to fix the problem that a cooling device may be referenced by
> > by multiple trip points in multiple thermal zones.
> >=20
> >=20
> > With this patch, we have two stages for updating a thermal zone,
> > 1. check if a thermal_instance needs to be updated or not
> > 2. update the cooling device, based on the target cooling state
> >    of all its instances.
> >=20
> > Note that, currently, the cooling device is set to the deepest
> > cooling state required.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_sys.c |   41 +++++++++++++++++++++++++++++++=
+++++++---
> >  include/linux/thermal.h       |    1 +
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >=20
> > Index: rtd3/drivers/thermal/thermal_sys.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/drivers/thermal/thermal_sys.c
> > +++ rtd3/drivers/thermal/thermal_sys.c
> > @@ -54,6 +54,7 @@ struct thermal_instance {
> >  	int trip;
> >  	unsigned long upper;	/* Highest cooling state for this trip point *=
/
> >  	unsigned long lower;	/* Lowest cooling state for this trip point */
> > +	unsigned long target;	/* expected cooling state */
> >  	char attr_name[THERMAL_NAME_LENGTH];
> >  	struct device_attribute attr;
> >  	struct list_head tz_node; /* node in tz->instances */
> > @@ -812,6 +813,7 @@ int thermal_zone_bind_cooling_device(str
> >  	dev->trip =3D trip;
> >  	dev->upper =3D upper;
> >  	dev->lower =3D lower;
> > +	dev->target =3D -1;
> > =20
> >  	result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
> >  	if (result)
> > @@ -949,6 +951,7 @@ thermal_cooling_device_register(char *ty
> >  	strcpy(cdev->type, type);
> >  	INIT_LIST_HEAD(&cdev->instances);
> >  	cdev->ops =3D ops;
> > +	cdev->updated =3D 1;
> >  	cdev->device.class =3D &thermal_class;
> >  	cdev->devdata =3D devdata;
> >  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> > @@ -1040,6 +1043,32 @@ void thermal_cooling_device_unregister(s
> >  }
> >  EXPORT_SYMBOL(thermal_cooling_device_unregister);
> > =20
> > +static void thermal_zone_do_update(struct thermal_zone_device *tz)
> > +{
> > +	struct thermal_instance *instance1, *instance2;
> > +	struct thermal_cooling_device *cdev;
> > +	int target;
> > +
> > +	list_for_each_entry(instance1, &tz->instances, tz_node) {
> > +		cdev =3D instance1->cdev;
> > +
> > +		/* cooling device has already been updated*/
> > +		if (cdev->updated)
> > +			continue;
> > +
> > +		target =3D 0;
> > +		/* Make sure cdev enters the deepest cooling state */
> > +		list_for_each_entry(instance2, &cdev->instances, cdev_node) {
> > +			if (instance2->target =3D=3D -1)
> > +				continue;
> > +			if (instance2->target > target)
> > +				target =3D instance2->target;
> > +		}
> > +		cdev->ops->set_cur_state(cdev, target);
> > +		cdev->updated =3D 1;
> > +	}
> > +}
>=20
> I think the above arbitrator solution does not escalate. As I can see,
> the arbitrator takes care of cooling device instances in the same therm=
al zone.
>=20
why?
It parses the thermal instances in one thermal zone to find the cooling
devices, and then parse all the thermal instances for the cooling
devices, no matter which thermal zone it belongs to.

> What if you have a device which expose cooling device instances in diff=
erent
> thermal zones?
>=20
> Besides, the thermal constraint might collide with pm QoS or with setti=
ngs
> coming from user space interfaces.
>=20

> That's actually why I was suggesting to have this 'arbitrator' or const=
raint
> management outside the thermal framework. And managed per device at som=
e
> other abstraction layer.
>=20
Yeah, but I think we can have an incremental patch to handle the pm Qos
constrains. Especially Durga already has the governor patches to move
this out of the thermal framework.
what do you think?

thanks,
rui

> > +
> >  /*
> >   * Cooling algorithm for active trip points
> >   *
> > @@ -1086,19 +1115,24 @@ static void thermal_zone_trip_update(str
> >  				cur_state =3D cur_state > instance->lower ?
> >  				    (cur_state - 1) : instance->lower;
> >  			}
> > -			cdev->ops->set_cur_state(cdev, cur_state);
> > +			instance->target =3D cur_state;
> > +			cdev->updated =3D 0; /* cooling device needs update */
> >  		}
> >  	} else {	/* below trip */
> >  		list_for_each_entry(instance, &tz->instances, tz_node) {
> >  			if (instance->trip !=3D trip)
> >  				continue;
> > =20
> > +			/* Do not use the deacitve thermal instance */
> > +			if (instance->target =3D=3D -1)
> > +				continue;
> >  			cdev =3D instance->cdev;
> >  			cdev->ops->get_cur_state(cdev, &cur_state);
> > =20
> >  			cur_state =3D cur_state > instance->lower ?
> > -				    (cur_state - 1) : instance->lower;
> > -			cdev->ops->set_cur_state(cdev, cur_state);
> > +				    (cur_state - 1) : -1;
> > +			instance->target =3D cur_state;
> > +			cdev->updated =3D 0; /* cooling device needs update */
> >  		}
> >  	}
> > =20
> > @@ -1159,6 +1193,7 @@ void thermal_zone_device_update(struct t
> >  		}
> >  	}
> > =20
> > +	thermal_zone_do_update(tz);
> >  	if (tz->forced_passive)
> >  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> >  					    THERMAL_TRIPS_NONE);
> > Index: rtd3/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/include/linux/thermal.h
> > +++ rtd3/include/linux/thermal.h
> > @@ -86,6 +86,7 @@ struct thermal_cooling_device {
> >  	struct device device;
> >  	void *devdata;
> >  	const struct thermal_cooling_device_ops *ops;
> > +	int updated; /* 1 if the cooling device does not need update */
> >  	struct list_head instances;
> >  	struct list_head node;
> >  };
> >=20
> >=20
