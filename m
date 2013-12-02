From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: debug: add debug statement for core and step_wise
Date: Mon, 2 Dec 2013 11:20:22 -0400
Message-ID: <529CA536.8000702@ti.com>
References: <529C2092.5070801@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dTQDGL3XQSUkX7pwfEL9mtcgCKvnuewlH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36090 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab3LBPUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Dec 2013 10:20:30 -0500
In-Reply-To: <529C2092.5070801@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, eduardo.valentin@ti.com

--dTQDGL3XQSUkX7pwfEL9mtcgCKvnuewlH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02-12-2013 01:54, Aaron Lu wrote:
> To ease debugging thermal problem, add these dynamic debug statements
> so that user do not need rebuild kernel to see these info.
>=20
> Based on a patch from Zhang Rui for debugging on bugzilla:
> https://bugzilla.kernel.org/attachment.cgi?id=3D98671
>=20
> A sample output after we turn on dynamic debug with the following cmd:
> # echo 'module thermal_sys +fp' > /sys/kernel/debug/dynamic_debug/contr=
ol
> is like:
>=20
> [  355.147627] update_temperature: thermal thermal_zone0: last_temperat=
ure=3D52000, current_temperature=3D55000
> [  355.147636] thermal_zone_trip_update: thermal thermal_zone0: Trip1[t=
ype=3D1,temp=3D79000]:trend=3D2,throttle=3D0
> [  355.147644] get_target_state: thermal cooling_device8: cur_state=3D0=

> [  355.147647] thermal_zone_trip_update: thermal cooling_device8: old_t=
arget=3D-1, target=3D-1
> [  355.147652] get_target_state: thermal cooling_device7: cur_state=3D0=

> [  355.147655] thermal_zone_trip_update: thermal cooling_device7: old_t=
arget=3D-1, target=3D-1
> [  355.147660] get_target_state: thermal cooling_device6: cur_state=3D0=

> [  355.147663] thermal_zone_trip_update: thermal cooling_device6: old_t=
arget=3D-1, target=3D-1
> [  355.147668] get_target_state: thermal cooling_device5: cur_state=3D0=

> [  355.147671] thermal_zone_trip_update: thermal cooling_device5: old_t=
arget=3D-1, target=3D-1
> [  355.147678] thermal_zone_trip_update: thermal thermal_zone0: Trip2[t=
ype=3D0,temp=3D90000]:trend=3D1,throttle=3D0
> [  355.147776] get_target_state: thermal cooling_device0: cur_state=3D0=

> [  355.147783] thermal_zone_trip_update: thermal cooling_device0: old_t=
arget=3D-1, target=3D-1
> [  355.147792] thermal_zone_trip_update: thermal thermal_zone0: Trip3[t=
ype=3D0,temp=3D80000]:trend=3D1,throttle=3D0
> [  355.147845] get_target_state: thermal cooling_device1: cur_state=3D0=

> [  355.147849] thermal_zone_trip_update: thermal cooling_device1: old_t=
arget=3D-1, target=3D-1
> [  355.147856] thermal_zone_trip_update: thermal thermal_zone0: Trip4[t=
ype=3D0,temp=3D70000]:trend=3D1,throttle=3D0
> [  355.147904] get_target_state: thermal cooling_device2: cur_state=3D0=

> [  355.147908] thermal_zone_trip_update: thermal cooling_device2: old_t=
arget=3D-1, target=3D-1
> [  355.147915] thermal_zone_trip_update: thermal thermal_zone0: Trip5[t=
ype=3D0,temp=3D60000]:trend=3D1,throttle=3D0
> [  355.147963] get_target_state: thermal cooling_device3: cur_state=3D0=

> [  355.147967] thermal_zone_trip_update: thermal cooling_device3: old_t=
arget=3D-1, target=3D-1
> [  355.147973] thermal_zone_trip_update: thermal thermal_zone0: Trip6[t=
ype=3D0,temp=3D55000]:trend=3D1,throttle=3D1
> [  355.148022] get_target_state: thermal cooling_device4: cur_state=3D0=

> [  355.148025] thermal_zone_trip_update: thermal cooling_device4: old_t=
arget=3D-1, target=3D1
> [  355.148036] thermal_cdev_update: thermal cooling_device4: zone0->tar=
get=3D1
> [  355.169279] thermal_cdev_update: thermal cooling_device4: set to sta=
te 1

This patch is slightly different from what is posted by Rui.

We are missing here the function names. dev_dbg does not include
function name by default, does it?

Apart from the above, you can add my:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


>=20
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

> ---
>  drivers/thermal/step_wise.c    | 6 ++++++
>  drivers/thermal/thermal_core.c | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index d89e781b0a18..f251521baaa2 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -60,6 +60,7 @@ static unsigned long get_target_state(struct thermal_=
instance *instance,
>  	 */
>  	cdev->ops->get_cur_state(cdev, &cur_state);
>  	next_target =3D instance->target;
> +	dev_dbg(&cdev->device, "cur_state=3D%ld\n", cur_state);
> =20
>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
> @@ -131,6 +132,9 @@ static void thermal_zone_trip_update(struct thermal=
_zone_device *tz, int trip)
>  	if (tz->temperature >=3D trip_temp)
>  		throttle =3D true;
> =20
> +	dev_dbg(&tz->device, "Trip%d[type=3D%d,temp=3D%ld]:trend=3D%d,throttl=
e=3D%d\n",
> +				trip, trip_type, trip_temp, trend, throttle);
> +
>  	mutex_lock(&tz->lock);
> =20
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> @@ -139,6 +143,8 @@ static void thermal_zone_trip_update(struct thermal=
_zone_device *tz, int trip)
> =20
>  		old_target =3D instance->target;
>  		instance->target =3D get_target_state(instance, trend, throttle);
> +		dev_dbg(&instance->cdev->device, "old_target=3D%d, target=3D%d\n",
> +					old_target, (int)instance->target);
> =20
>  		if (old_target =3D=3D instance->target)
>  			continue;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index f1d511a9475b..30a02add9e2e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -450,6 +450,9 @@ static void update_temperature(struct thermal_zone_=
device *tz)
>  	tz->last_temperature =3D tz->temperature;
>  	tz->temperature =3D temp;
>  	mutex_unlock(&tz->lock);
> +
> +	dev_dbg(&tz->device, "last_temperature=3D%d, current_temperature=3D%d=
\n",
> +				tz->last_temperature, tz->temperature);
>  }
> =20
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
> @@ -1207,6 +1210,8 @@ void thermal_cdev_update(struct thermal_cooling_d=
evice *cdev)
>  	mutex_lock(&cdev->lock);
>  	/* Make sure cdev enters the deepest cooling state */
>  	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> +		dev_dbg(&cdev->device, "zone%d->target=3D%lu\n",
> +				instance->tz->id, instance->target);
>  		if (instance->target =3D=3D THERMAL_NO_TARGET)
>  			continue;
>  		if (instance->target > target)
> @@ -1215,6 +1220,7 @@ void thermal_cdev_update(struct thermal_cooling_d=
evice *cdev)
>  	mutex_unlock(&cdev->lock);
>  	cdev->ops->set_cur_state(cdev, target);
>  	cdev->updated =3D true;
> +	dev_dbg(&cdev->device, "set to state %lu\n", target);
>  }
>  EXPORT_SYMBOL(thermal_cdev_update);
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--dTQDGL3XQSUkX7pwfEL9mtcgCKvnuewlH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKcpTkACgkQCXcVR3XQvP0ZMAEAhZhFz1YockuuyVutC59Fg7i1
3Npe8RWu5lI5poSLxmIA/R8dcqRFbqYQNt+LXWWMDuLZd/3wx1JTq4ymEs9uuq65
=rfSS
-----END PGP SIGNATURE-----

--dTQDGL3XQSUkX7pwfEL9mtcgCKvnuewlH--
