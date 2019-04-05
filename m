From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: charger-manager: fix a potential NULL pointer
 dereference
Date: Fri, 5 Apr 2019 16:00:31 +0200
Message-ID: <20190405140031.6u35e5jd56aqms6o@earth.universe>
References: <20190314060247.7848-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkl3ivocftthn6sa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190314060247.7848-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tkl3ivocftthn6sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2019 at 01:02:47AM -0500, Kangjie Lu wrote:
> In case create_freezable_workqueue fails, the fix return -ENOMEM
> to avoid a potential NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 38be91f21cc4..d29c4f338157 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1987,6 +1987,9 @@ static struct platform_driver charger_manager_drive=
r =3D {
>  static int __init charger_manager_init(void)
>  {
>  	cm_wq =3D create_freezable_workqueue("charger_manager");
> +	if (unlikely(!cm_wq))
> +		return -ENOMEM;
> +
>  	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
> =20
>  	return platform_driver_register(&charger_manager_driver);
> --=20
> 2.17.1
>=20

--tkl3ivocftthn6sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynX34ACgkQ2O7X88g7
+pqT4w//bt8j4QXMjCoJjbStIlmi1jhU7Zq0fcOE/O0PkQyArTOnQJ5cyvnvoDGv
UfcaxNBLas4M1YXXVHZT7cp1GyZI21s/e0dPXvTNxpqd4SkipcdYGtRgkvj1s3yN
+0Olt8vuomRr48a825+5sGL55tXCXJfOe9T5M8GGxvv4urNcy+U2JaO0pidnWZi0
cmVQ0oCRXiqFh24xfwpwJ0AB0O+yIpxqcXEXwTJ6F1nOXrEe+LpgSHginyCDET3s
dvaiDBuYk6d36ZCmsN3rz80LE0jz6m9rZd0iVGi2jVACbSFgPvYlgJmJA8n3Hn+8
yBp2VcHqUrRLGFeLykLSxIRHd1Ahrtugmkn4eH4S920BhqqIdL1esVvnxRtQ7sce
feIrzAPTNpVzS3O38CDExWEQrg9BCLnv6A+6QS3T/ediYH4p1agZSKXQluKIU4gq
niS8142knFXQ2xCNBm8Np44ahjCwftjJ6pAH994fqTvF6kRQ6b5GgiUzjV16EL+i
zdkS75qeNgOcbCrJEUgMcpa76Gk3/Mys5pA+2mq4qxWvejMH9Z2daL8N3zsPZ+Kp
mqImJqaDMiLeQP6srTkuDrUHKQBAuDi+/mgrqLYUNw5HQnq/rDAHnUWvjN1puCDW
FDoMlUlyy2U9o8O/KJjUvdeZX4Ts/OKU/FZOqRQLlTy5SKXV+ks=
=u5jE
-----END PGP SIGNATURE-----

--tkl3ivocftthn6sa--
