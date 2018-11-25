From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: sc27xx: Save last battery capacity
Date: Sun, 25 Nov 2018 22:48:23 +0100
Message-ID: <20181125214823.GB9913@amd>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Our charger manager can optimize the battery capacity periodically, so
> we can save last battery capacity into registers. Then next system
> power-on, we can read the last saved battery capacity as the initial
> battery capacity, which can make the battery capacity more accurate.
>=20
> Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c |  143 ++++++++++++++++++++++++=
+++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>=20

> +static int sc27xx_fgu_set_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D sc27xx_fgu_save_last_cap(data, val->intval);
> +		if (ret < 0)
> +			dev_err(data->dev, "failed to save battery capacity\n");
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +	return ret;

if (psp !=3D ....) return -EINVAL; And you can do that outside
lock...

Ok, OTOH this is easier to extend in future. Do you expect more
writable properties?

> +static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
> +					    enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		return 1;
> +
> +	default:
> +		return 0;
> +	}
> +}


Same here. return psp =3D=3D POWER_SUPPLY_PROP_CAPACITY; really looks
strange written like this.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7GKcACgkQMOfwapXb+vJz8QCaA9Ld/LHJlKBMeAS7juHWIl4g
25sAn2HVSfhXQMz9n3HTxTTORvQ42RQd
=kMZ1
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
