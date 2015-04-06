From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V3 2/3] Thermal: handle thermal zone device properly
 during system sleep
Date: Mon, 6 Apr 2015 13:59:17 -0700
Message-ID: <20150406205915.GA972@localhost.localdomain>
References: <1427768815-20948-1-git-send-email-rui.zhang@intel.com>
 <1427768815-20948-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35343 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbDFU7K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 16:59:10 -0400
Received: by patj18 with SMTP id j18so55395834pat.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2015 13:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427768815-20948-3-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 10:26:54AM +0800, Zhang Rui wrote:
> Current thermal code does not handle system sleep well because
> 1. the cooling device cooling state may be changed during suspend
> 2. the previous temperature reading becomes invalid after resumed because
>    it is got before system sleep
> 3. updating thermal zone device during suspending/resuming
>    is wrong because some devices may have already been suspended
>    or may have not been resumed.
>=20
> Thus, the proper way to do this is to cancel all thermal zone
> device update requirements during suspend/resume, and after all
> the devices have been resumed, reset and update every registered
> thermal zone devices.
>=20
> This also fixes a regression introduced by
> commit 19593a1fb1f6718406afca5b867dab184289d406
> Author: Aaron Lu <aaron.lu@intel.com>
> Date:   Tue Nov 19 16:59:20 2013 +0800
>=20
>     ACPI / fan: convert to platform driver
>=20
>     Convert ACPI fan driver to a platform driver for the purpose of phasi=
ng
>     out ACPI bus.
>=20
>     Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Because, with the commit applied, all the fan devices are attached
> to the acpi_general_pm_domain, and they are turned on by the pm_domain
> automatically after resume, without the awareness of thermal core.
>=20
> CC: <stable@vger.kernel.org> #3.18+
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D78201
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D91411
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Tested-by: Eduardo Valentin <edubezval@gmail.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 39 ++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9d6f71b..875a9bb 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/of.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
> +#include <linux/suspend.h>
> =20
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal.h>
> @@ -59,6 +60,8 @@ static LIST_HEAD(thermal_governor_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
> =20
> +static atomic_t in_suspend;
> +
>  static struct thermal_governor *def_governor;
> =20
>  static struct thermal_governor *__find_governor(const char *name)
> @@ -491,6 +494,9 @@ void thermal_zone_device_update(struct thermal_zone_d=
evice *tz)
>  {
>  	int count;
> =20
> +	if (atomic_read(&in_suspend))
> +		return;
> +
>  	if (!tz->ops->get_temp)
>  		return;
> =20
> @@ -1823,6 +1829,36 @@ static void thermal_unregister_governors(void)
>  	thermal_gov_user_space_unregister();
>  }
> =20
> +static int thermal_pm_notify(struct notifier_block *nb,
> +				unsigned long mode, void *_unused)
> +{
> +	struct thermal_zone_device *tz;
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		atomic_set(&in_suspend, 1);
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +	case PM_POST_SUSPEND:
> +		atomic_set(&in_suspend, 0);
> +		list_for_each_entry(tz, &thermal_tz_list, node) {
> +			thermal_zone_device_reset(tz);
> +			thermal_zone_device_update(tz);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static struct notifier_block thermal_pm_nb =3D {
> +	.notifier_call =3D thermal_pm_notify,
> +};
> +
>  static int __init thermal_init(void)
>  {
>  	int result;
> @@ -1843,6 +1879,8 @@ static int __init thermal_init(void)
>  	if (result)
>  		goto exit_netlink;
> =20
> +	register_pm_notifier(&thermal_pm_nb);
> +
>  	return 0;
> =20
>  exit_netlink:
> @@ -1862,6 +1900,7 @@ static int __init thermal_init(void)
> =20
>  static void __exit thermal_exit(void)
>  {
> +	unregister_pm_notifier(&thermal_pm_nb);
>  	of_thermal_destroy_zones();
>  	genetlink_exit();
>  	class_unregister(&thermal_class);
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIvOaAAoJEMLUO4d9pOJWoA8H/jXiLAZjAnN1K50cDfbLa3bX
IqpHwaew+5W1rhrsbx9IGYKLzma4KytIjTJy+KZ5FLvMlXxHnIWZzDcAqiHq0olS
qvnWSHRBJKOmFZsLn62uBxr4kTihIuXZtYsMp/aYFoiClzdkHP+V7kbjlf7IR8L9
Bmbn17u1Px99fjhnbr/dJZIee8W6xYjMeJ58tw+UdvjEZuy9Aov7ABZNyfZeUW0k
G+784SPJn3a1vMW4F/ZG4i7J3ooexsizPmZ9bQ+C0a77bMPRUTR1Sv6ePaYBxcxT
hoio1Apqpqyvv3dO3Ac9mwaCGsVOmmNa7Lof6KaM8sGvaRU7F5k+nUjhXkVuN7o=
=EmfJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
