From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 3/12] thermal: set upper and lower limits when
 binding
Date: Wed, 13 Jun 2012 08:51:18 +0800
Message-ID: <1339548678.1973.59.camel@rui.sh.intel.com>
References: <1339384801.1492.156.camel@rui.sh.intel.com>
	 <20120612095215.GA3837@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120612095215.GA3837@besouro>
Sender: linux-acpi-owner@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Amit Kachhap <amit.kachhap@linaro.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On =E4=BA=8C, 2012-06-12 at 12:52 +0300, Eduardo Valentin wrote:
> Hello Rui,
>=20
> On Mon, Jun 11, 2012 at 11:20:01AM +0800, Zhang Rui wrote:
> >=20
> > Set upper and lower limits when binding
> > a thermal cooling device to a thermal zone device.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/thermal.c         |   34 ++++++++++++++++++++++++----=
------
> >  drivers/platform/x86/acerhdf.c |    2 +-
> >  drivers/thermal/thermal_sys.c  |   20 ++++++++++++++------
> >  include/linux/thermal.h        |    3 ++-
> >  4 files changed, 41 insertions(+), 18 deletions(-)
> >=20
> > Index: rtd3/drivers/thermal/thermal_sys.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/drivers/thermal/thermal_sys.c
> > +++ rtd3/drivers/thermal/thermal_sys.c
> > @@ -248,7 +248,7 @@ passive_store(struct device *dev, struct
> >  				     sizeof("Processor")))
> >  				thermal_zone_bind_cooling_device(tz,
> >  								 THERMAL_TRIPS_NONE,
> > -								 cdev);
> > +								 cdev, -1, -1);
> >  		}
> >  		mutex_unlock(&thermal_list_lock);
> >  		if (!tz->passive_delay)
> > @@ -760,7 +760,8 @@ static void thermal_zone_device_check(st
> >   */
> >  int thermal_zone_bind_cooling_device(struct thermal_zone_device *t=
z,
> >  				     int trip,
> > -				     struct thermal_cooling_device *cdev)
> > +				     struct thermal_cooling_device *cdev,
> > +				     long upper, long lower)
> >  {
> >  	struct thermal_cooling_device_instance *dev;
> >  	struct thermal_cooling_device_instance *pos;
> > @@ -784,6 +785,15 @@ int thermal_zone_bind_cooling_device(str
> >  	if (tz !=3D pos1 || cdev !=3D pos2)
> >  		return -EINVAL;
> > =20
> > +	cdev->ops->get_max_state(cdev, &max_state);
> > +
> > +	/* lower default 0, upper default max_state */
> > +	lower =3D lower < 0 ? 0 : lower;
> > +	upper =3D upper < 0 ? max_state : upper;
> > +
> > +	if (lower > upper || upper > max_state)
> > +		return -EINVAL;
> > +
>=20
> From this version of the code, I assume we want to:
> a. Allow cooling binding instances to have ranges overlapping.

yep.

> b. Allow a binding with only one state (lower =3D=3D upper).
>=20
yep.


> Is this the expected behavior?
>=20
yes. :)

thanks,
rui

> >  	dev =3D
> >  	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_K=
ERNEL);
> >  	if (!dev)
> > @@ -791,10 +801,8 @@ int thermal_zone_bind_cooling_device(str
> >  	dev->tz =3D tz;
> >  	dev->cdev =3D cdev;
> >  	dev->trip =3D trip;
> > -
> > -	cdev->ops->get_max_state(dev, &max_state);
> > -	dev->upper =3D max_state;
> > -	dev->lower =3D 0;
> > +	dev->upper =3D upper;
> > +	dev->lower =3D lower;
> > =20
> >  	result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
> >  	if (result)
> > Index: rtd3/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/include/linux/thermal.h
> > +++ rtd3/include/linux/thermal.h
> > @@ -143,7 +143,8 @@ struct thermal_zone_device *thermal_zone
> >  void thermal_zone_device_unregister(struct thermal_zone_device *);
> > =20
> >  int thermal_zone_bind_cooling_device(struct thermal_zone_device *,=
 int,
> > -				     struct thermal_cooling_device *);
> > +				     struct thermal_cooling_device *,
> > +				     long, long);
> >  int thermal_zone_unbind_cooling_device(struct thermal_zone_device =
*, int,
> >  				       struct thermal_cooling_device *);
> >  void thermal_zone_device_update(struct thermal_zone_device *);
> > Index: rtd3/drivers/acpi/thermal.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/drivers/acpi/thermal.c
> > +++ rtd3/drivers/acpi/thermal.c
> > @@ -729,11 +729,9 @@ static int thermal_notify(struct thermal
> >  	return 0;
> >  }
> > =20
> > -typedef int (*cb)(struct thermal_zone_device *, int,
> > -		  struct thermal_cooling_device *);
> >  static int acpi_thermal_cooling_device_cb(struct thermal_zone_devi=
ce *thermal,
> >  					struct thermal_cooling_device *cdev,
> > -					cb action)
> > +					int bind)
> >  {
> >  	struct acpi_device *device =3D cdev->devdata;
> >  	struct acpi_thermal *tz =3D thermal->devdata;
> > @@ -758,7 +756,14 @@ static int acpi_thermal_cooling_device_c
> >  			handle =3D tz->trips.passive.devices.handles[i];
> >  			status =3D acpi_bus_get_device(handle, &dev);
> >  			if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -				result =3D action(thermal, trip, cdev);
> > +				if (bind)
> > +					result =3D
> > +						thermal_zone_bind_cooling_device(
> > +							thermal, trip, cdev, -1, -1);
> > +				else
> > +					result =3D
> > +						thermal_zone_unbind_cooling_device(
> > +							thermal, trip, cdev);
> >  				if (result)
> >  					goto failed;
> >  			}
> > @@ -775,7 +780,13 @@ static int acpi_thermal_cooling_device_c
> >  			handle =3D tz->trips.active[i].devices.handles[j];
> >  			status =3D acpi_bus_get_device(handle, &dev);
> >  			if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -				result =3D action(thermal, trip, cdev);
> > +				if (bind)
> > +					result =3D
> > +						thermal_zone_bind_cooling_device(
> > +							thermal, trip, cdev, -1, -1);
> > +				else
> > +					result =3D thermal_zone_unbind_cooling_device(
> > +							thermal, trip, cdev);
> >  				if (result)
> >  					goto failed;
> >  			}
> > @@ -786,7 +797,12 @@ static int acpi_thermal_cooling_device_c
> >  		handle =3D tz->devices.handles[i];
> >  		status =3D acpi_bus_get_device(handle, &dev);
> >  		if (ACPI_SUCCESS(status) && (dev =3D=3D device)) {
> > -			result =3D action(thermal, -1, cdev);
> > +			if (bind)
> > +				result =3D thermal_zone_bind_cooling_device(thermal,
> > +								-1, cdev, -1, -1);
> > +			else
> > +				result =3D thermal_zone_unbind_cooling_device(thermal,
> > +								-1, cdev);
> >  			if (result)
> >  				goto failed;
> >  		}
> > @@ -800,16 +816,14 @@ static int
> >  acpi_thermal_bind_cooling_device(struct thermal_zone_device *therm=
al,
> >  					struct thermal_cooling_device *cdev)
> >  {
> > -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> > -				thermal_zone_bind_cooling_device);
> > +	return acpi_thermal_cooling_device_cb(thermal, cdev, 1);
> >  }
> > =20
> >  static int
> >  acpi_thermal_unbind_cooling_device(struct thermal_zone_device *the=
rmal,
> >  					struct thermal_cooling_device *cdev)
> >  {
> > -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> > -				thermal_zone_unbind_cooling_device);
> > +	return acpi_thermal_cooling_device_cb(thermal, cdev, 0);
> >  }
> > =20
> >  static const struct thermal_zone_device_ops acpi_thermal_zone_ops =
=3D {
> > Index: rtd3/drivers/platform/x86/acerhdf.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/drivers/platform/x86/acerhdf.c
> > +++ rtd3/drivers/platform/x86/acerhdf.c
> > @@ -329,7 +329,7 @@ static int acerhdf_bind(struct thermal_z
> >  	if (cdev !=3D cl_dev)
> >  		return 0;
> > =20
> > -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
> > +	if (thermal_zone_bind_cooling_device(thermal, 0, cdev, -1, -1)) {
> >  		pr_err("error binding cooling dev\n");
> >  		return -EINVAL;
> >  	}
> >=20
> >=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
