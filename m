From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 3/12] thermal: set upper and lower limits when binding
Date: Mon, 11 Jun 2012 09:57:49 +0530
Message-ID: <CAK44p21ZtBR_ubDr4y9i4c81cBVRyBkr=T=CyWrwS=csQjtnfw@mail.gmail.com>
References: <1339384801.1492.156.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1339384801.1492.156.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "R, Durgadoss" <durgadoss.r@intel.com>, eduardo <eduardo.valentin@ti.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

Sorry for sending one incomplete mail before.
I like this approach of multiple cooling states for ACTIVE type cooling=
 devices.
Some comments added.

On 11 June 2012 08:50, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Set upper and lower limits when binding
> a thermal cooling device to a thermal zone device.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> =A0drivers/acpi/thermal.c =A0 =A0 =A0 =A0 | =A0 34 ++++++++++++++++++=
++++++----------
> =A0drivers/platform/x86/acerhdf.c | =A0 =A02 +-
> =A0drivers/thermal/thermal_sys.c =A0| =A0 20 ++++++++++++++------
> =A0include/linux/thermal.h =A0 =A0 =A0 =A0| =A0 =A03 ++-
> =A04 files changed, 41 insertions(+), 18 deletions(-)
>
> Index: rtd3/drivers/thermal/thermal_sys.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/drivers/thermal/thermal_sys.c
> +++ rtd3/drivers/thermal/thermal_sys.c
> @@ -248,7 +248,7 @@ passive_store(struct device *dev, struct
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 sizeof("Processor")))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0therma=
l_zone_bind_cooling_device(tz,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 THERMAL_TRIPS_=
NONE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cdev, -1, -=
1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&thermal_list_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!tz->passive_delay)
> @@ -760,7 +760,8 @@ static void thermal_zone_device_check(st
> =A0*/
> =A0int thermal_zone_bind_cooling_device(struct thermal_zone_device *t=
z,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int trip,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct thermal_cooling_device *cdev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct thermal_cooling_device *cdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0long upper, long lower)
> =A0{
> =A0 =A0 =A0 =A0struct thermal_cooling_device_instance *dev;
> =A0 =A0 =A0 =A0struct thermal_cooling_device_instance *pos;
> @@ -784,6 +785,15 @@ int thermal_zone_bind_cooling_device(str
> =A0 =A0 =A0 =A0if (tz !=3D pos1 || cdev !=3D pos2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 cdev->ops->get_max_state(cdev, &max_state);
> +
> + =A0 =A0 =A0 /* lower default 0, upper default max_state */
> + =A0 =A0 =A0 lower =3D lower < 0 ? 0 : lower;
> + =A0 =A0 =A0 upper =3D upper < 0 ? max_state : upper;
> +
> + =A0 =A0 =A0 if (lower > upper || upper > max_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0dev =3D
> =A0 =A0 =A0 =A0 =A0 =A0kzalloc(sizeof(struct thermal_cooling_device_i=
nstance), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!dev)
> @@ -791,10 +801,8 @@ int thermal_zone_bind_cooling_device(str
> =A0 =A0 =A0 =A0dev->tz =3D tz;
> =A0 =A0 =A0 =A0dev->cdev =3D cdev;
> =A0 =A0 =A0 =A0dev->trip =3D trip;
> -
> - =A0 =A0 =A0 cdev->ops->get_max_state(dev, &max_state);
> - =A0 =A0 =A0 dev->upper =3D max_state;
> - =A0 =A0 =A0 dev->lower =3D 0;
> + =A0 =A0 =A0 dev->upper =3D upper;
> + =A0 =A0 =A0 dev->lower =3D lower;
Also some check can be added here like this,
          cdev->ops->get_max_state(cdev, &cur_state);
          if (cur_state !=3D  lower) {
              print_err("Set the initial state of the cooling device
to lower\n");
              return -EINVAL;
           }
           This is needed because in your thermal_zone_update
implementation the state change is from lower - upper.
>
> =A0 =A0 =A0 =A0result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
> =A0 =A0 =A0 =A0if (result)
> Index: rtd3/include/linux/thermal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/include/linux/thermal.h
> +++ rtd3/include/linux/thermal.h
> @@ -143,7 +143,8 @@ struct thermal_zone_device *thermal_zone
> =A0void thermal_zone_device_unregister(struct thermal_zone_device *);
>
> =A0int thermal_zone_bind_cooling_device(struct thermal_zone_device *,=
 int,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct thermal_cooling_device *);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct thermal_cooling_device *,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0long, long);
> =A0int thermal_zone_unbind_cooling_device(struct thermal_zone_device =
*, int,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct thermal_cooling_device *);
> =A0void thermal_zone_device_update(struct thermal_zone_device *);
> Index: rtd3/drivers/acpi/thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/drivers/acpi/thermal.c
> +++ rtd3/drivers/acpi/thermal.c
> @@ -729,11 +729,9 @@ static int thermal_notify(struct thermal
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -typedef int (*cb)(struct thermal_zone_device *, int,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_device *);
> =A0static int acpi_thermal_cooling_device_cb(struct thermal_zone_devi=
ce *thermal,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct thermal_cooling_device *cdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cb action)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int bind)
> =A0{
> =A0 =A0 =A0 =A0struct acpi_device *device =3D cdev->devdata;
> =A0 =A0 =A0 =A0struct acpi_thermal *tz =3D thermal->devdata;
> @@ -758,7 +756,14 @@ static int acpi_thermal_cooling_device_c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle =3D tz->trips.p=
assive.devices.handles[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D acpi_bus_ge=
t_device(handle, &dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_SUCCESS(statu=
s) && (dev =3D=3D device)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =
=3D action(thermal, trip, cdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bin=
d)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 result =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 thermal_zone_bind_cooling_device(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal, trip, cdev, -1, -1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 result =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 thermal_zone_unbind_cooling_device(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal, trip, cdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (re=
sult)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0goto failed;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -775,7 +780,13 @@ static int acpi_thermal_cooling_device_c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle =3D tz->trips.a=
ctive[i].devices.handles[j];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D acpi_bus_ge=
t_device(handle, &dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_SUCCESS(statu=
s) && (dev =3D=3D device)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =
=3D action(thermal, trip, cdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bin=
d)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 result =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 thermal_zone_bind_cooling_device(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal, trip, cdev, -1, -1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 result =3D thermal_zone_unbind_cooling_device(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal, trip, cdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (re=
sult)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0goto failed;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -786,7 +797,12 @@ static int acpi_thermal_cooling_device_c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle =3D tz->devices.handles[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D acpi_bus_get_device(handle,=
 &dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_SUCCESS(status) && (dev =3D=3D=
 device)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D action(therm=
al, -1, cdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bind)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =
=3D thermal_zone_bind_cooling_device(thermal,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -1, cdev, -1, =
-1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =
=3D thermal_zone_unbind_cooling_device(thermal,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -1, cdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto f=
ailed;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -800,16 +816,14 @@ static int
> =A0acpi_thermal_bind_cooling_device(struct thermal_zone_device *therm=
al,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct thermal_cooling_device *cdev)
> =A0{
> - =A0 =A0 =A0 return acpi_thermal_cooling_device_cb(thermal, cdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal=
_zone_bind_cooling_device);
> + =A0 =A0 =A0 return acpi_thermal_cooling_device_cb(thermal, cdev, 1)=
;
> =A0}
>
> =A0static int
> =A0acpi_thermal_unbind_cooling_device(struct thermal_zone_device *the=
rmal,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct thermal_cooling_device *cdev)
> =A0{
> - =A0 =A0 =A0 return acpi_thermal_cooling_device_cb(thermal, cdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal=
_zone_unbind_cooling_device);
> + =A0 =A0 =A0 return acpi_thermal_cooling_device_cb(thermal, cdev, 0)=
;
> =A0}
>
> =A0static const struct thermal_zone_device_ops acpi_thermal_zone_ops =
=3D {
> Index: rtd3/drivers/platform/x86/acerhdf.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/drivers/platform/x86/acerhdf.c
> +++ rtd3/drivers/platform/x86/acerhdf.c
> @@ -329,7 +329,7 @@ static int acerhdf_bind(struct thermal_z
> =A0 =A0 =A0 =A0if (cdev !=3D cl_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 0, cdev))=
 {
> + =A0 =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 0, cdev, =
-1, -1)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("error binding cooling dev\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
