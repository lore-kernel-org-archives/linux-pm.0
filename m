From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/8] power: power_supply: add battery information
 struct
Date: Sun, 29 Jan 2017 19:23:51 +0100
Message-ID: <20170129182351.h4qp44oy7i525rji@earth>
References: <20170122071404.9654-1-matt@ranostay.consulting>
 <20170122071404.9654-4-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppqc3mj4b2uev5lk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170122071404.9654-4-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ppqc3mj4b2uev5lk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 21, 2017 at 11:13:59PM -0800, Matt Ranostay wrote:
> Add power_supply_battery_info structure that is used to
> enumerate battery state machine settings.
>=20
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  include/linux/power_supply.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 3965503315ef..59674a257d5e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -288,6 +288,18 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
> =20
> +/*
> + * This is the recommended struct to specify static battery parameters.
> + * Power supply class itself doesn't use this, but it implements access
> + * that most platform drivers should use for consistency.
> + */
> +
> +struct power_supply_battery_info {
> +	int energy;		/* uWh */
> +	int power;		/* uAh */
> +	int nominal_voltage;	/* uV */
> +};
> +
>  extern struct atomic_notifier_head power_supply_notifier;
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);

You can merge this into the next patch, which adds the API
for using this struct.

-- Sebastian

--ppqc3mj4b2uev5lk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOMzUACgkQ2O7X88g7
+ppdGA/+OdJwXRkkuCCzsFW+gChs+8/0rgt4FNqY9rwmUHhjrQGWRp/DMqQEaM20
vs7q27C5VLH1fVhyA5PVjPJciDFpQoOCQK4e2BkmjdWzGkK0QV3sWU1+xVRv+Jms
HZSuYhU9m7P5P/mhp0GdL7sYGF0A/55TQQJ7R+AkB9g7BD74fQ3jAiXegdCJCMhX
ntx2OzkNc4WgsCTgZy0wW7xJKtG6oZdJYTUZgiFxIYzN4aXm6E7uJ7aufHbLluiv
xUCXeY/ydlK+ohEOnF5Z9Zrkr6um5MLdZ5jI3IZvEDlChVDidwgF7bzdy83bnoHW
VXuhx7iEbDPAhZpReggJipF8KYGc2jbRa/29EeE6pvKTMszrsMJY1DD79eqEUk15
XoS3/eeDYXncQvQOpRTOnBMbpj1pheaH+6UOue1uLwqDoB5PljVR/KvXnSm69Nno
EkkS555Ukw087AnBQ760B09JKtUeB0CBqbPokv9pWccj65A4Tq/HoCpDq807UUxC
IwXWkoJZ0AmipPHsKcvRxyT5sxNZ+nuyq7mtHqDWuTVb3by9paa+iiCtEQvNKicy
crHqinoQUzR1x+moPDziGEDrdPcNrHB1YCHNfpQ8hFFCAfTvsjXi9BwOhTBqjiZl
3B6sVq9z0N4ffi6dXaaBYnDTsaobQb6OsGumKBDNl9XffvqARMc=
=6vlN
-----END PGP SIGNATURE-----

--ppqc3mj4b2uev5lk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
