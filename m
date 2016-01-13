From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 13 Jan 2016 18:03:24 +0100
Message-ID: <20160113170324.GO2588@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qa0ccP92Gc0Ko3P8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-17-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Qa0ccP92Gc0Ko3P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
> Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
> dependent upon a particular power-domain are only probed when that power
> domain has been powered up, requires that PM is made mandatory for tegra
> 64-bit devices and so select this option for tegra as well.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 9806324fa215..e0b5bd0aff0f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -93,6 +93,8 @@ config ARCH_TEGRA
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_CLK
>  	select PINCTRL
> +	select PM
> +	select PM_GENERIC_DOMAINS
>  	select RESET_CONTROLLER
>  	help
>  	  This enables support for the NVIDIA Tegra SoC family.

This has potential consequences for multi-platform builds, doesn't it?
All of a sudden any combination of builds that includes Tegra won't be
possible to build without PM support.

Adding linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org for visibility.

Thierry

--Qa0ccP92Gc0Ko3P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWloNZAAoJEN0jrNd/PrOhiSsP/3+9Pa/eT+yiNAJHUw7uVnVT
vsfDIb/2y3O1SKsLpBed8BCgLGES0wNqLKJ2XHeKJs0NE9jKnhsSUIzNMF+wMBHx
nptdWAm4sHkbiYlpYv+fT1Y+WELHl+LwmdTlNnOx25r72dCSu+Hj1XIfwY2A9/1O
cRoRjE5DcEPBBovaJYf2O4lp2vSKWOcA7Xj2PdWv1x73AE7kifK61f6vkXJgE97V
eIzXHHVEZimLLVSy0F72/9ZoLCIWhg/z7Owg/YwvQnEclvHj6V14I4A5edglWSP/
BFLXCq1J0qArE2Ew5DP/A2Mt0ZHNR+2Px53XYzr3s/PaviBK5+j6h+8HZlxRTMoB
UPoz3QjY4B5voKbKlJv06kkXm8eFI5tdOg5/nEg/OWmPRhdImo3tLH71lqK0eO0i
5pDkG0Yu5aSYrY/xYpepiHZeAR9+EjwCE3NsVm+5tlrd/8XirSZUx0nw7TjrlkQs
T+Y2ja1dEr1EkXBMqkvwVuVt4ca3wpbOl2/BG+4aHKaFJaeFVVtyYC7kiYRBlF/0
g55ed5zkDlsOYBwK3PWFQoiwjOqOVt9V5M1h9xdIkHH85anTeC3RVhBdfjgG8bE3
G2NhAIzOVk9bEFwz16J7rZ7TZEJC+dtYj1cMTvCmJQuikDDFBi8X3ymPyf+ECq0N
fLTet+6rQoHIUwQZtrYg
=QG7j
-----END PGP SIGNATURE-----

--Qa0ccP92Gc0Ko3P8--
