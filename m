From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: mark expected switch fall-throughs
Date: Mon, 23 Jul 2018 00:11:36 +0200
Message-ID: <20180722221136.47vme5v3o4lvibeq@earth.universe>
References: <20180717212846.GA13179@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce5nri3u7rvt6hh6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717212846.GA13179@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-pm@vger.kernel.org


--ce5nri3u7rvt6hh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 17, 2018 at 04:28:46PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 1394724 ("Missing break in switch")
> Addresses-Coverity-ID: 114958 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued into power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c   | 1 +
>  drivers/power/supply/cros_usbpd-charger.c | 1 +
>  drivers/power/supply/wm8350_power.c       | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 44f70dc..42001df 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -222,6 +222,7 @@ static int axp20x_usb_power_set_current_max(struct ax=
p20x_usb_power *power,
>  	case 100000:
>  		if (power->axp20x_id =3D=3D AXP221_ID)
>  			return -EINVAL;
> +		/* fall through */
>  	case 500000:
>  	case 900000:
>  		val =3D (900000 - intval) / 400000;
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 3a0c96f..688a16b 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -325,6 +325,7 @@ static int cros_usbpd_charger_get_prop(struct power_s=
upply *psy,
>  		 */
>  		if (ec_device->mkbp_event_supported || port->psy_online)
>  			break;
> +		/* fall through */
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/w=
m8350_power.c
> index a2740cf..15c0ca1 100644
> --- a/drivers/power/supply/wm8350_power.c
> +++ b/drivers/power/supply/wm8350_power.c
> @@ -230,7 +230,8 @@ static irqreturn_t wm8350_charger_handler(int irq, vo=
id *data)
>  	case WM8350_IRQ_EXT_USB_FB:
>  	case WM8350_IRQ_EXT_WALL_FB:
>  		wm8350_charger_config(wm8350, policy);
> -	case WM8350_IRQ_EXT_BAT_FB:   /* Fall through */
> +		/* Fall through */
> +	case WM8350_IRQ_EXT_BAT_FB:
>  		power_supply_changed(power->battery);
>  		power_supply_changed(power->usb);
>  		power_supply_changed(power->ac);
> --=20
> 2.7.4
>=20

--ce5nri3u7rvt6hh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltVARgACgkQ2O7X88g7
+pr9Mg/5AVlLy21NMHQS7ky144rxMyzQmgfH64rWs14c0ycUewCuuqC1BzOWaRFO
WbWNWb4BD5MUOznyhlTsEyhOj2beF46Rt5VCP/p76Hv5WQoG8HmxpjYaVHaf2Vtz
hr2mVSy9w0SHUnHzZZqqYoWe3Py6/mXuSouxaPE9poSpl+TAgJJuJ8Mmf5EK8R6Z
Nk8HOFpRn8VVA3LKs96+npI/7Fbq4M/3lkaCx6LDnICB2Qk+BTruJAEc2xrlgNag
eMfiy+Km5DbK+DgdrFgHDkBH26fSeUIkqppuduwqk1aCU3kcCd5Dtt6uwf8whKMW
9fUBsRnT6iVyrXI1uxJi6c6C18e/T2e3Gcv+yuKJlll5m/qG2w6a9xOZiBZy+47W
P1SZOiLOjbXeC9X6AKG0IhutSuGUNN1XKbGQLi4G96rJtvSOdCPJmnH5NSU40c4G
2P+AOdSm2Q/3/asGvgX6Lt0XS9gvHpXRKd1nCMD9EVXEiRFTprgaS61kcWpJXfnZ
CeE87wuDt5f4LsItc3uN6uMXbX6dQlVXfvSgKkAUF0Tj8cw1VR1LBor99BqTl6x/
gATE32Pdu0KtSXfdYPjxLcjsBv3ceUbaCQ8hVLdX125ul2TMcODpcWe+9WiZ4K4u
+bWDGMs6suNmEwzNQJZwwJ/zdt3YZRYa1bep46XjnKXFZ7+JKMQ=
=qD6s
-----END PGP SIGNATURE-----

--ce5nri3u7rvt6hh6--
