From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: Don't needlessly set
 CAPACITY_MODE
Date: Thu, 15 Jun 2017 18:43:27 +0200
Message-ID: <20170615164327.6puhwbzzgdi2tq7v@earth>
References: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
 <1497376406-86470-2-git-send-email-shawnn@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikuh7vqbucwsbllz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45581 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOQnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 12:43:31 -0400
Content-Disposition: inline
In-Reply-To: <1497376406-86470-2-git-send-email-shawnn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Nematbakhsh <shawnn@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org


--ikuh7vqbucwsbllz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2017 at 10:53:26AM -0700, Shawn Nematbakhsh wrote:
> According to the smart battery spec (1), the CAPACITY_MODE bit does not
> influence the value read from RelativeStateOfCharge(), so don't bother
> changing CAPACITY_MODE when doing such a read.
>=20
> (1) - Smart Battery Data Specification, Rev 1.1, Dec. 11, 1998
>=20
> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/sbs-battery.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index d7e68fd97099..4bae210d5a8a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -439,6 +439,11 @@ static int sbs_get_battery_property(struct i2c_clien=
t *client,
>  	} else {
>  		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS)
>  			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		else if (psp =3D=3D POWER_SUPPLY_PROP_CAPACITY)
> +			/* sbs spec says that this can be >100 %
> +			 * even if max value is 100 %
> +			 */
> +			val->intval =3D min(ret, 100);
>  		else
>  			val->intval =3D 0;
>  	}
> @@ -549,12 +554,7 @@ static int sbs_get_battery_capacity(struct i2c_clien=
t *client,
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (psp =3D=3D POWER_SUPPLY_PROP_CAPACITY) {
> -		/* sbs spec says that this can be >100 %
> -		* even if max value is 100 % */
> -		val->intval =3D min(ret, 100);
> -	} else
> -		val->intval =3D ret;
> +	val->intval =3D ret;
> =20
>  	ret =3D sbs_set_battery_mode(client, mode);
>  	if (ret < 0)
> @@ -619,7 +619,6 @@ static int sbs_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -	case POWER_SUPPLY_PROP_CAPACITY:
>  		ret =3D sbs_get_property_index(client, psp);
>  		if (ret < 0)
>  			break;
> @@ -647,6 +646,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +	case POWER_SUPPLY_PROP_CAPACITY:
>  		ret =3D sbs_get_property_index(client, psp);
>  		if (ret < 0)
>  			break;
> --=20
> 2.13.1.508.gb3defc5cc-goog
>=20

--ikuh7vqbucwsbllz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCuSwACgkQ2O7X88g7
+pr86w/+JvdHDx1BcH8u7u/u/NEbU4TZB4qDTBgFOUS9IMG9msnR/lorfxftepxc
F2O0EPoETSNEsOuS9NwD8kFH6xqwi+5jq8qO+ggYmzi0MkQa296NM8U1YBjO1L95
nJuNxGj4LOA+E9MkPfayG8MquqiQk1sZ8ZzVIqWJXLbYXvsf11xf2O7gPxcm/yyg
XhXMy+blVDPl4FNg6YEPIoyhw8f8L5XDivoyGm7VwE0YDf6kIHvdJTZcjzihXvpb
CpvfSzluAScqORdn+LJFYuGhPS0uAfIvumrn2FzcS3SzA/oRpsLKH8VbbGy3LYby
CsfdtboJGcyAxuJP8rVq4poikVBkdtW1zbBUcrEGw500wW0l6vGRpktchevSfJcB
UlH6zjgW5xQZ8D0SWcEOAXL4vwU+nJeIwInfzjc4V78km+iuBhlGfyPirDEWxoFd
OkoCPaKUTlzdv0fE3PkH8MjHr+OV6AEjtp3kg/p8N+V3SQ9i6136+qvjLxcNb80N
RM9xtWJRgzCxYuZWFAir5C1lGZLeI7g6qQAFWgdsUzOpfDa31scjdWAmeT5fB23B
2BpPwWOlxkJmBIuYJyxUGtZs2iguujBwr5ikbqhZK1IJpJV+MNX9++z2vgHYKtyL
QlKO0VtqQriimaFdhCAml7qzyzQCYxHhQ3EkUH7rL2mkpMHbryk=
=GZa4
-----END PGP SIGNATURE-----

--ikuh7vqbucwsbllz--
