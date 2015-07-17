From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 18/19] ARM: tegra: add GPU power supply to Jetson TK1
 DT
Date: Fri, 17 Jul 2015 11:28:42 +0200
Message-ID: <20150717092841.GE3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-19-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-19-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:56PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Add power supply information which is board dependent for GK20A.
>=20
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dt=
s/tegra124-jetson-tk1.dts
> index ce5961cd0b77..2b355957635c 100644
> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> @@ -1514,7 +1514,7 @@
>  					regulator-always-on;
>  				};
> =20
> -				sd6 {
> +				vdd_gpu: sd6 {
>  					regulator-name =3D "+VDD_GPU_AP";
>  					regulator-min-microvolt =3D <650000>;
>  					regulator-max-microvolt =3D <1200000>;
> @@ -1635,6 +1635,10 @@
>  		};
>  	};
> =20
> +	gpu-power-domain {
> +		vdd-supply =3D <&vdd_gpu>;
> +	};

This doesn't seem to match the path to the original node.

Thierry

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqMrEAAoJEN0jrNd/PrOhD8QP/ij9F1dFueqLw4vAIzphLq+q
lFmKwSXfuaFYqayu1Cxxsqs9TqtpHwYIuibqU8ZYGxEnOMqtAGTKeUNpEHvke+0T
2sibN5x3ZRbzysgY/C8Pvl48v8TFh81bpHCRGfw5Yxc/Lxj4NZrpdWBmYnyATiGw
1dCenldGe1LVLLqnwaqQgwqskP6SVxqZ1poAJVOzsLS07b813yk2eUGYyO9P5moj
9VG4DnteeUiO3nsCQ+wx0NpMELnIh/E0TagjWiGDGqIEMRb6NrfEufSb0M9TGl6t
IGxD/edVSQXt2V0K2PGJbwF3eb8rbjDOG2Z6ru+cwNth9Pt94RwmF09I5AXEhKtv
NvkWGXYj3AnqbuoWW4x9PueRdt6ErNdl6H5hjbS90zrifcYHcu3LQhV5TQ9HcPph
40DCcRXoaRqeSjBbvkC2z5kI8QzDEoBhwywvnJ9bHkM26Bpq0wDxnLzi6raV+aw1
9hbwZE+OsvG3lrAmvrghPhfScd/26/EjYlyDBiqmBdTLOT/0B6FPRZFU78iEku+h
6Cr3UyO8ly6ZRlr32iPN036KurSkaP7w9aUZmCJmyFwJptWSc6QRowYcbBoI/jSU
3ppD5Lbd1pfj0JuWEkl/jSOKaZCzgSwyQH4IHhnL5+g3O4poJd87sr/4PkE62y92
fzp0A6UuOeM+BxeSfFhV
=YPkO
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
