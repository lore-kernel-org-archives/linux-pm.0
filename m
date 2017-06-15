From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v7 02/10] power: supply: bq24735: remove incorrect
 le16_to_cpu calls
Date: Thu, 15 Jun 2017 16:50:15 +0200
Message-ID: <20170615145015.knusjwnaqjlm3bmw@earth>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dl6lvgsoyshq3man"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497535178-12001-3-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--dl6lvgsoyshq3man
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 15, 2017 at 09:59:30PM +0800, Phil Reid wrote:
> i2c_smbus commands handle the correct byte order for smbus transactions
> internally. This will currently result in incorrect operation on big
> endian systems.
>=20
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24735-charger.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index eb01453..6931e1d 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -81,14 +81,12 @@ static int bq24735_charger_property_is_writeable(stru=
ct power_supply *psy,
>  static inline int bq24735_write_word(struct i2c_client *client, u8 reg,
>  				     u16 value)
>  {
> -	return i2c_smbus_write_word_data(client, reg, le16_to_cpu(value));
> +	return i2c_smbus_write_word_data(client, reg, value);
>  }
> =20
>  static inline int bq24735_read_word(struct i2c_client *client, u8 reg)
>  {
> -	s32 ret =3D i2c_smbus_read_word_data(client, reg);
> -
> -	return ret < 0 ? ret : le16_to_cpu(ret);
> +	return i2c_smbus_read_word_data(client, reg);
>  }
> =20
>  static int bq24735_update_word(struct i2c_client *client, u8 reg,
> --=20
> 1.8.3.1
>=20

--dl6lvgsoyshq3man
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCnqYACgkQ2O7X88g7
+pqAWBAAiiwpm2bak7/FXPSkHj4t6zQoATl7jjXIY4bRifFSK91I+vA0C7XJsfS+
+CEgM5jvH9FnEtGNeSp8D8K21ylov08LhXDbqbDYsXMJmIJeORwvcQoVXPMOWEa3
Rpi6N/g/i6smAi1F36Q6y6c//wd0P6fVILhqhUXI9Uxhm3r3yemD7MdO49LYS4uM
uXBZ9p76REix+imARcGmvShg8RL4P1W82A5jFk2+NZqEwdFfKB0R1bpqAfbSsqxn
biVSjSb5ygmzvTiLOEoO88b+Lr57ui1H1iTQS9dk0jN7ZvuYVF5xa1lGqEAceULV
+NLZW5kFMTQ9HA6Tu+HBnfcamYF+vXCYOcv5+3m8KhVy77WCeS9g8t8ONljCHl+c
/kZPsJT2noN/MPOgToMNIn/DY2P891La0ACVt3uw0syqUSlim6c+4P8C6JPlVqVx
Q87Kd6L0ePdffJnsCf4lY4VUwEuMvGbQxiJXA9FnCVGNs4bkUo+HB+7oBoTCyqWq
xrpbu77dKzthRdykkxAomswUYJQaZ3jNPck9FWIB3TeVX6TgeQ1L3rwCaHoukmcH
SoCOoa6dpukhBoytoS93hv9mIM2FaPUaYbSVyxNhaTCLOMlmsFHnVll2sfcUp0wh
MKPLezbCqnoTrD8gCxNJmjsxv5Xn8R1aBhSRCafpbCEXmXb6xqg=
=GZO6
-----END PGP SIGNATURE-----

--dl6lvgsoyshq3man--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
