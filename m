From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 7/12] thermal: rename structure
 thermal_cooling_device_instance to thermal_instance
Date: Tue, 12 Jun 2012 17:39:28 +0300
Message-ID: <20120612143928.GG8724@besouro>
References: <1339384821.1492.161.camel@rui.sh.intel.com>
 <1339395696.1492.179.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339395696.1492.179.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Amit Kachhap <amit.kachhap@linaro.org>, eduardo <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Mon, Jun 11, 2012 at 02:21:36PM +0800, Zhang Rui wrote:
> seems this patch is missed. Resend it.
>=20
> On =E4=B8=80, 2012-06-11 at 11:20 +0800, Zhang Rui wrote:
> > Rename structure thermal_cooling_device_instance to thermal_instanc=
e.
> >=20
> > This struct is used to describe the behavior for a thermal
> > cooling device on a certain trip point for a certain thremal zone.

typo

> >=20
> > thermal_cooling_device_instance is not accurate, as a cooling devic=
e
> > can be used for more than one trip point in one thermal zone device=
=2E

'thermal_instance' seams to be a bit misleading though...

It looks a bit too generic. One reading it won't figure it out that
it is supposed the mapping between cooling device vs. trip vs. thermal =
zone...

How about 'thermal_mapping' or 'thermal_binding'?

> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/thermal_sys.c |   18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >=20
> > Index: rtd3/drivers/thermal/thermal_sys.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- rtd3.orig/drivers/thermal/thermal_sys.c
> > +++ rtd3/drivers/thermal/thermal_sys.c
> > @@ -46,7 +46,7 @@ MODULE_LICENSE("GPL");
> >   * a certain cooling device on a certain trip point
> >   * in a certain thermal zone
> >   */
> > -struct thermal_cooling_device_instance {
> > +struct thermal_instance {
> >  	int id;
> >  	char name[THERMAL_NAME_LENGTH];
> >  	struct thermal_zone_device *tz;
> > @@ -388,10 +388,10 @@ static ssize_t
> >  thermal_cooling_device_trip_point_show(struct device *dev,
> >  				       struct device_attribute *attr, char *buf)
> >  {
> > -	struct thermal_cooling_device_instance *instance;
> > +	struct thermal_instance *instance;
> > =20
> >  	instance =3D
> > -	    container_of(attr, struct thermal_cooling_device_instance, at=
tr);
> > +	    container_of(attr, struct thermal_instance, attr);
> > =20
> >  	if (instance->trip =3D=3D THERMAL_TRIPS_NONE)
> >  		return sprintf(buf, "-1\n");
> > @@ -686,7 +686,7 @@ static void thermal_zone_device_passive(
> >  					int temp, int trip_temp, int trip)
> >  {
> >  	int trend =3D 0;
> > -	struct thermal_cooling_device_instance *instance;
> > +	struct thermal_instance *instance;
> >  	struct thermal_cooling_device *cdev;
> >  	long state, max_state;
> > =20
> > @@ -771,8 +771,8 @@ int thermal_zone_bind_cooling_device(str
> >  				     struct thermal_cooling_device *cdev,
> >  				     long upper, long lower)
> >  {
> > -	struct thermal_cooling_device_instance *dev;
> > -	struct thermal_cooling_device_instance *pos;
> > +	struct thermal_instance *dev;
> > +	struct thermal_instance *pos;
> >  	struct thermal_zone_device *pos1;
> >  	struct thermal_cooling_device *pos2;
> >  	unsigned long max_state;
> > @@ -803,7 +803,7 @@ int thermal_zone_bind_cooling_device(str
> >  		return -EINVAL;
> > =20
> >  	dev =3D
> > -	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_K=
ERNEL);
> > +	    kzalloc(sizeof(struct thermal_instance), GFP_KERNEL);
> >  	if (!dev)
> >  		return -ENOMEM;
> >  	dev->tz =3D tz;
> > @@ -868,7 +868,7 @@ int thermal_zone_unbind_cooling_device(s
> >  				       int trip,
> >  				       struct thermal_cooling_device *cdev)
> >  {
> > -	struct thermal_cooling_device_instance *pos, *next;
> > +	struct thermal_instance *pos, *next;
> > =20
> >  	mutex_lock(&tz->lock);
> >  	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
> > @@ -1054,7 +1054,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unr
> >  static void thermal_zone_trip_update(struct thermal_zone_device *t=
z,
> >  				     int trip, long temp)
> >  {
> > -	struct thermal_cooling_device_instance *instance;
> > +	struct thermal_instance *instance;
> >  	struct thermal_cooling_device *cdev =3D NULL;
> >  	unsigned long cur_state, max_state;
> >  	long trip_temp;
> >=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
