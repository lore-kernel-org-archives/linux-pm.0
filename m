From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] ACPI/thermal : Remove zone disabled warning
Date: Fri, 27 Sep 2013 17:53:53 -0400
Message-ID: <5245FE71.6020401@ti.com>
References: <1380126590-25809-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QkTRXREJD6PQNjXGXCEwLwQ5brQNH8gid"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41725 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab3I0Vx7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Sep 2013 17:53:59 -0400
In-Reply-To: <1380126590-25809-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, linux-pm@vger.kernel.org

--QkTRXREJD6PQNjXGXCEwLwQ5brQNH8gid
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25-09-2013 12:29, Srinivas Pandruvada wrote:
> Once thermal zone is disabled to move thermal control to user space,
> too many warnings printed in logs. Remove pr_warn from this path,
> instead warn when user mode issues request to disable thermal zone.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>

Although this is actually really under Rui's, I believe this patch makes
sense to me. So, you can add my acked.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/acpi/thermal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 6a03293..92bebb9 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -515,10 +515,9 @@ static void acpi_thermal_check(void *data)
>  {
>  	struct acpi_thermal *tz =3D data;
> =20
> -	if (!tz->tz_enabled) {
> -		pr_warn("thermal zone is disabled \n");
> +	if (!tz->tz_enabled)
>  		return;
> -	}
> +
>  	thermal_zone_device_update(tz->thermal_zone);
>  }
> =20
> @@ -570,9 +569,10 @@ static int thermal_set_mode(struct thermal_zone_de=
vice *thermal,
>  	 */
>  	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
>  		enable =3D 1;
> -	else if (mode =3D=3D THERMAL_DEVICE_DISABLED)
> +	else if (mode =3D=3D THERMAL_DEVICE_DISABLED) {
>  		enable =3D 0;
> -	else
> +		pr_warn("thermal zone will be disabled\n");
> +	} else
>  		return -EINVAL;
> =20
>  	if (enable !=3D tz->tz_enabled) {
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--QkTRXREJD6PQNjXGXCEwLwQ5brQNH8gid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJF/nEACgkQCXcVR3XQvP01jAD9GeCfOLO3LSWIWjJRUwnI18lE
DukKFp/1FJ4lWjDnxLoBAPlpvmtGOYLbxLQlxs5x0q3baxHyOGIJD95U9gPpLrI4
=zuNK
-----END PGP SIGNATURE-----

--QkTRXREJD6PQNjXGXCEwLwQ5brQNH8gid--
