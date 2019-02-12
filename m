From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2] power: supply: ds2782: fix possible use-after-free on
 remove
Date: Tue, 12 Feb 2019 23:30:25 +0100
Message-ID: <20190212223025.ebojrp7o45exwjay@earth.universe>
References: <20190212162149.21583-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjebp2ucozuhcsdx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212162149.21583-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--wjebp2ucozuhcsdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 12, 2019 at 11:21:49AM -0500, Sven Van Asbroeck wrote:
> In remove(), use cancel_delayed_work_sync() to cancel the
> delayed work. Otherwise there's a chance that this work
> will continue to run until after the device has been removed.
>=20
> While we're here, fix the deallocation order in remove(),
> to correspond to the inverse of the probe() allocation
> order. This guarantees that any remaining work can run
> to completion with all driver structures still intact.
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---

Thanks, queued to power-supply's linux-next branch.

-- Sebastian

> v2: fix silly use-after-free in remove()
>=20
>  drivers/power/supply/ds2782_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply=
/ds2782_battery.c
> index 019c58493e3d..04b0fe7d7d62 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -319,17 +319,17 @@ static void ds278x_power_supply_init(struct power_s=
upply_desc *battery)
>  static int ds278x_battery_remove(struct i2c_client *client)
>  {
>  	struct ds278x_info *info =3D i2c_get_clientdata(client);
> +	int id =3D info->id;
> =20
>  	power_supply_unregister(info->battery);
> +	cancel_delayed_work_sync(&info->bat_work);
>  	kfree(info->battery_desc.name);
> +	kfree(info);
> =20
>  	mutex_lock(&battery_lock);
> -	idr_remove(&battery_id, info->id);
> +	idr_remove(&battery_id, id);
>  	mutex_unlock(&battery_lock);
> =20
> -	cancel_delayed_work(&info->bat_work);
> -
> -	kfree(info);
>  	return 0;
>  }
> =20
> --=20
> 2.17.1
>=20

--wjebp2ucozuhcsdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxjSQEACgkQ2O7X88g7
+pre6w/9HgG7GUqtWRoqoYqWKbdJ325YBvq3IkVlzjNUjtp64Oc5X5fegqGK0SeZ
Rw/izfjRN6TrPFrqbZM2GZclhD9k7lif1D/ijhx+zS8LjKkEOFCs73bTWMvBRdlG
nLm8HshcfKTbLEc0lLQFctXlMPEJTDczzPftABlhRBeTDiQqzwDMIi66EY6yjAu2
W6QAtiATvg1O1jy51G3fn90oXqOq97e+P6MqaEUiSTwNNU3QVS9bGc3QNNDnuoWi
05dQsGUKeE5Wn90wsmggJPijHBPu+8VFnfiaFQNF/0ODbpYku14UkllTRJIqZrAz
6kW2h3yKUfjrlKHSWD5/npLxKczYE1GBSP05C5hHBed5OytJXfRi3w12vm0PQFmH
CbmoNwv8RjrBPFZCczWmdD/xSXBjvkw+BJAckGlMGmz2TfamTZrjmejGW1C+FWY/
2LMeTQn09z2ZVEnEN6wh7Z7XAEquPR2U3xvRl8XxUWsYj7sNZINQ9hOcxHcKFWwN
T0oic3Em6puVjwfCP/0xIaYAOiHb3wuYqCtnOhQ7Ub9vLJ2fahqtyoH9SktkfAdC
NKx3vTpQRrSOOMrw8QfXmJGiJ4yrTnUQWScXrIDKzdey79MPIU+7NLC4wI/enfNA
dRPrimkbp27u97RyM/+qol0EdO8AMC07JCRcy0xQ/x4PQkzdesY=
=TWuY
-----END PGP SIGNATURE-----

--wjebp2ucozuhcsdx--
