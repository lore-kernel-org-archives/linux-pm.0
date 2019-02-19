From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 08/10] power: supply: olpc_battery: Allow building the
 driver on non-x86
Date: Wed, 20 Feb 2019 00:17:49 +0100
Message-ID: <20190219231749.b6ydhiq2now3z5fr@earth.universe>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-9-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byb526xt5hk5xygm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110175845.1203986-9-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--byb526xt5hk5xygm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:58:43PM +0100, Lubomir Rintel wrote:
> With the recent changes to the driver and addition of OLPC XO-1.75 EC
> driver it is possible to use this driver on ARM-based XO laptops as
> well.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

This looks simple enough to not cause a big mess when merged
through x86 platform tree:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..66e4d1958de3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -151,7 +151,7 @@ config BATTERY_PMU
> =20
>  config BATTERY_OLPC
>  	tristate "One Laptop Per Child battery"
> -	depends on X86_32 && OLPC
> +	depends on OLPC_EC
>  	help
>  	  Say Y to enable support for the battery on the OLPC laptop.
> =20
> --=20
> 2.20.1
>=20

--byb526xt5hk5xygm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxsjpwACgkQ2O7X88g7
+pr83Q/8Ca1j0ayvype2fj2zz7DiMEXkdtft6NqEhS/u3xrNP6fSaZqMHhMqWbbs
aYzJqKykpIrTvKpF7pvLGNYwV6yQVdVxcemy1AThPrRYenNQCrKErPz/YAsYsxst
G1OEiTM34HG9pdjwQgDACDLrd6y0cUmi/fq6TJJOKIaiM4FEaK5UUg7Yva526uzS
d4snhlUTTDPjMYkvvNPNzMa1idpEoH2J8SI7ZRGRicbklbNNsehPkve3MG5u81MI
v2QAr5v2HnW+R0CmghycE0mrDO3CkFGWOsutytvwxIFEnOcAwyYrIeFnFQFjG7ll
KegWRWOtCRYk9iPqIA8DK7ZFg+ef3APt71fCG7Fb+2GoUduhsokllSF24Q+tygMh
yBgJ98xVkBQAYxlWGNxH370+PaHvcl1ShQ1yMZOVVogtdvqdlCH+7how0XsPIV/b
udGnxBnvUJ+ZWq9ax2bqxGttR53bJlSXGH5uVaRTYl0ElMpfZkvgJehL3TWG4uE6
T2+Km2SDuGLaF+TgxR4IEJ39zquT5lHdlQPyo3obYMy3mFP1XTiMiiw0LfZ90UVk
yqWhFUxyc2hy2WZJbEKsvyEOWASH5LfwDUzhnbE583GWll2aQceQXXQ3w3YTLPAB
MhEsVEUPfEmahjxRFRpZ1Zulvto2r2lCp9sSB7c1+Vhllx/9/l4=
=a6QF
-----END PGP SIGNATURE-----

--byb526xt5hk5xygm--
