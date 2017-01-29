From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 5/8] power: bq27xxx_battery: add BQ27425 chip id
Date: Sun, 29 Jan 2017 16:35:12 +0100
Message-ID: <20170129153512.eyaqj7mhuwlqkiu7@earth>
References: <20170122071404.9654-1-matt@ranostay.consulting>
 <20170122071404.9654-6-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oovqbb3gjl6hewet"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdA2PfX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 10:35:23 -0500
Content-Disposition: inline
In-Reply-To: <20170122071404.9654-6-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: linux-pm@vger.kernel.org, tony@atomide.com


--oovqbb3gjl6hewet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I queued this into power-supply's for-next branch. I fixed up
the patch subject & description:

power: supply: bq27xxx: add BQ27425 chip id
   =20
This fixes over- & undertemperature detection of BQ27425.

-- Sebastian

On Sat, Jan 21, 2017 at 11:14:01PM -0800, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 23 ++++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
>  include/linux/power/bq27xxx_battery.h      |  3 ++-
>  3 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 398801a21b86..12ecea308186 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -417,6 +417,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x18,
>  	},
> +	[BQ27425] =3D {
> +		[BQ27XXX_REG_CTRL] =3D 0x00,
> +		[BQ27XXX_REG_TEMP] =3D 0x02,
> +		[BQ27XXX_REG_INT_TEMP] =3D 0x1e,
> +		[BQ27XXX_REG_VOLT] =3D 0x04,
> +		[BQ27XXX_REG_AI] =3D 0x10,
> +		[BQ27XXX_REG_FLAGS] =3D 0x06,
> +		[BQ27XXX_REG_TTE] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTF] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D 0x08,
> +		[BQ27XXX_REG_FCC] =3D 0x0e,
> +		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SOC] =3D 0x1c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x18,
> +	},
>  };
> =20
>  static enum power_supply_property bq27000_battery_props[] =3D {
> @@ -752,6 +771,7 @@ static struct {
>  	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
>  	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
>  	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
> +	BQ27XXX_PROP(BQ27425, bq27421_battery_props),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1015,6 +1035,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx=
_device_info *di, u16 flags)
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	case BQ27530:
>  	case BQ27421:
> +	case BQ27425:
>  		return flags & BQ27XXX_FLAG_OT;
>  	default:
>  		return false;
> @@ -1026,7 +1047,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx=
_device_info *di, u16 flags)
>   */
>  static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u1=
6 flags)
>  {
> -	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
> +	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421 || di->chip =3D=
=3D BQ27425)
>  		return flags & BQ27XXX_FLAG_UT;
> =20
>  	return false;
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index c68fbc3fe50a..2ea2d0b06948 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -167,9 +167,9 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27742", BQ27541 },
>  	{ "bq27545", BQ27545 },
>  	{ "bq27421", BQ27421 },
> -	{ "bq27425", BQ27421 },
>  	{ "bq27441", BQ27421 },
>  	{ "bq27621", BQ27421 },
> +	{ "bq27425", BQ27425 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index b312bcef53da..3f265dbf11af 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -17,7 +17,8 @@ enum bq27xxx_chip {
>  	BQ27530, /* bq27530, bq27531 */
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +	BQ27421, /* bq27421, bq27441, bq27621 */
> +	BQ27425, /* bq27425 */
>  };
> =20
>  /**
> --=20
> 2.10.2
>=20

--oovqbb3gjl6hewet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOC64ACgkQ2O7X88g7
+ppWHA//Rw5IGT+bPwq4VjJWP41TRACsEMP03cQi0nZhPvMiHoA0BRrqVoJZLWI8
q8bpBd+lU/C0AtSXkrx/R6H+Wys9J6Z3Kpl8ONOokNiZsqixeHAPmGYfTfZDgYoV
KUqiy0ClF4IjcE0eVCHRNybxYTwxkt1axb1S0Xc0fWNP5reD1LZE5ffYac+Yjh+4
Uy5yRPq3ClZ9Cb07ujIq+tzDUM3bzo0CklXVZFL9BD/wFYaUaG+r2u50bqKwfo8g
ZkF0LynXTg1HwkfVFiqbhsqhO2SlNdh0EiCT2+uVm3gJflXMmtx5MJSKV5acYLnC
E+4cQhAROSrcsn05nj/bt50itHK6JkssDOd3vq23qDS2HaWSuZvMVph4yv97FcQa
KHkeAAPwaDUMqbDDXb1fN+eHeCOye3LQJ3fLHTbVfgxRE3VPDTy5SyOzzig/3yA9
YoJ+RU15EbCif9JxyKNbyRKEMwduyMFsTJDUo/SzxaRMwGI+6hw85PXYJKqMsrvm
ORw80sL+RVCPO6uX5oQHWDGLAyYIi0guDcs4UdNUBMypmAHu0/DwXPkQyonmAw4v
s0EcSynkzK3BrCLBM1VanvuI29y1zZ20xaEI4x3ObiXunuQGz9Smu2jpGbsM5i5D
UrpPAcYSLZwlUaFpSxqb0gdYB/zPzljwQ6B2ov42iC+FzstKC8U=
=8puH
-----END PGP SIGNATURE-----

--oovqbb3gjl6hewet--
