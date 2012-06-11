From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 6/12] thermal: introduce active cooling
	algorithm
Date: Mon, 11 Jun 2012 10:21:08 +0530
Message-ID: <CAK44p227RorAEGcikmXSYHJizxVvwbQkZY9fSS0MvpsA4XyATQ@mail.gmail.com>
References: <1339384817.1492.160.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1339384817.1492.160.camel@rui.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11 June 2012 08:50, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Introduce thermal_zone_trip_update() to update the cooling state
> of all the cooling devices that are binded to an active trip point.
>
> This will be used for passive cooling as well, in the future patches.
> as both active and passive cooling can share the same algorithm,
> which is
>
> 1. if the temperature is higher than a trip point,
> =A0 a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> =A0 =A0 =A0state for this trip point
> =A0 b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> =A0 =A0 =A0state for this trip point
>
> 2. if the temperature is lower than a trip point, use lower
> =A0 cooling state for this trip point.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> =A0drivers/acpi/thermal.c =A0 =A0 =A0 =A0| =A0 =A07 ++-
> =A0drivers/thermal/thermal_sys.c | =A0 91 ++++++++++++++++++++++++++++++-=
-----------
> =A02 files changed, 71 insertions(+), 27 deletions(-)
>
> Index: rtd3/drivers/thermal/thermal_sys.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/drivers/thermal/thermal_sys.c
> +++ rtd3/drivers/thermal/thermal_sys.c
> @@ -1035,6 +1035,70 @@ void thermal_cooling_device_unregister(s
> =A0}
> =A0EXPORT_SYMBOL(thermal_cooling_device_unregister);
>
> +/*
> + * Cooling algorithm for active trip points
> + *
> + * 1. if the temperature is higher than a trip point,
> + * =A0 =A0a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> + * =A0 =A0 =A0 state for this trip point
> + * =A0 =A0b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> + * =A0 =A0 =A0 state for this trip point
> + *
> + * 2. if the temperature is lower than a trip point, use lower
> + * =A0 =A0cooling state for this trip point
> + *
> + * Note that this behaves the same as the previous passive cooling
> + * algorithm.
> + */
> +
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int trip, long temp)
> +{
> + =A0 =A0 =A0 struct thermal_cooling_device_instance *instance;
> + =A0 =A0 =A0 struct thermal_cooling_device *cdev =3D NULL;
> + =A0 =A0 =A0 unsigned long cur_state, max_state;
> + =A0 =A0 =A0 long trip_temp;
> + =A0 =A0 =A0 enum thermal_trend trend;
> +
> + =A0 =A0 =A0 tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +
> + =A0 =A0 =A0 if (temp >=3D trip_temp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal_get_trend(tz, trip, &trend);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(instance, &tz->cooling_=
devices, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (instance->trip !=3D tri=
p)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D instance->cdev;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->get_cur_state(cd=
ev, &cur_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->get_max_state(cd=
ev, &max_state);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trend =3D=3D THERMAL_TR=
END_RAISING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_state =
=3D cur_state < instance->upper ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (cur_state + 1) : instance->upper;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (trend =3D=3D THE=
RMAL_TREND_DROPPING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_state =
=3D cur_state > instance->lower ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cu=
r_state - 1) : instance->lower;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cd=
ev, cur_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else { =A0 =A0 =A0 =A0/* below trip */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(instance, &tz->cooling_=
devices, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (instance->trip !=3D tri=
p)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
Can we use the trend callback here even if the current temperature is
less than the trip temperature. Basically according to trend it should
deactivate the cooling devices as done for activating cooling devices.
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D instance->cdev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->get_cur_state(cd=
ev, &cur_state);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_state =3D cur_state > i=
nstance->lower ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cu=
r_state - 1) : instance->lower;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cd=
ev, cur_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return;
> +}
> =A0/**
> =A0* thermal_zone_device_update - force an update of a thermal zone's sta=
te
> =A0* @ttz: =A0 =A0 =A0 the thermal zone to update
> @@ -1045,9 +1109,6 @@ void thermal_zone_device_update(struct t
> =A0 =A0 =A0 =A0int count, ret =3D 0;
> =A0 =A0 =A0 =A0long temp, trip_temp;
> =A0 =A0 =A0 =A0enum thermal_trip_type trip_type;
> - =A0 =A0 =A0 struct thermal_cooling_device_instance *instance;
> - =A0 =A0 =A0 struct thermal_cooling_device *cdev;
> - =A0 =A0 =A0 unsigned long cur_state, max_state;
>
> =A0 =A0 =A0 =A0mutex_lock(&tz->lock);
>
> @@ -1083,29 +1144,7 @@ void thermal_zone_device_update(struct t
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0tz->ops->notify(tz, count, trip_type);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(instanc=
e, &tz->cooling_devices,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (instanc=
e->trip !=3D count)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D in=
stance->cdev;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->=
get_cur_state(cdev, &cur_state);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->=
get_max_state(cdev, &max_state);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp >=
=3D trip_temp)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cur_state =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 cur_state < instance->upper ?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (cur_state + 1) :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 instance->upper;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cur_state =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 cur_state > instance->lower ?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (cur_state - 1) :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 instance->lower;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->=
set_cur_state(cdev, cur_state);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal_zone_trip_update(tz=
, count, temp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (temp >=3D trip_temp ||=
 tz->passive)
> Index: rtd3/drivers/acpi/thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rtd3.orig/drivers/acpi/thermal.c
> +++ rtd3/drivers/acpi/thermal.c
> @@ -717,7 +717,12 @@ static int thermal_get_trend(struct ther
> =A0 =A0 =A0 =A0if (thermal_get_trip_type(thermal, trip, &type))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 /* Only PASSIVE trip points need TREND */
> + =A0 =A0 =A0 if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* aggressive active cooling */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *trend =3D THERMAL_TREND_RAISING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (type !=3D THERMAL_TRIP_PASSIVE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
>
>
