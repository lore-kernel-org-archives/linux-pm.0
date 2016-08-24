From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V8 4/4] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 24 Aug 2016 17:09:14 +0200
Message-ID: <20160824150914.GI6887@ulmo.ba.sec>
References: <1459329316-27293-1-git-send-email-jonathanh@nvidia.com>
 <1459329316-27293-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459329316-27293-5-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:15:16AM +0100, Jon Hunter wrote:
> Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
> dependent upon a particular power-domain are only probed when that power
> domain has been powered up, requires that PM is made mandatory for tegra
> 64-bit devices and so select this option for tegra as well.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXvbiYAAoJEN0jrNd/PrOhWjYP/0+m9/aIEDJIz7kRlFRsS2Jx
C9pFN1yuHrCy8XojRsN7nDo0RlRgycj1rvF51Yc0CS96UDNXxXzSPDr6WnhDCpDo
qJmZpNtllqPGkkW9/cBMsYqftx/wjVR+rML01eGlfwuocfb8Ilbg3/otE2N5C16/
T77rjDrbG2qTH3cnR2FYmWcDFGblWVcfWN19o6zEHQKObgXCi0jD1ctu4PE3rekl
T3X+iqKV/FP4VXX+L2xFwCAVkS46eNZyCG4wIeiA1S8h62Q/KHFp4QnnDkZUUXnL
MucA7cNIr+JuU5x3Ry3DyhetMBUKXgB3xqL66UsePKhnMeMI23/xfZeXxNuRUeiC
XOdW1wTxTIha3ELBgy7c3iB9yOW+6uIbQ1K3fmuuo555G4RCdjrSWJ2QU9cf5eqZ
QBcne3QUtaQjVJBK5xVZd5Re0xjAWbmbyA2hifpNSdk3nRCVnqdnP0946Gv7COlF
ZdVuBCtgMZxy2/9xOZXe3H4H4O6/S2aHuGusQUyximzHepNLMz/WtvJA1to6rWFy
E8TiaVqVeVVio0p5TzJJXVmTQdoObfj3CgkGI6POPvLoqOHpOX7zLrp3momMO87i
23l4jH6rVfbguWQvncR0JkrdIuQEDoS78raKyCxDaRDQd4bPRg5asd4MizLr4XO7
qHjJK2lrbhZ3i2Ql6TMO
=TSIN
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
