From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 14/19] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Fri, 17 Jul 2015 11:38:42 +0200
Message-ID: <20150717093841.GF3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-15-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-15-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:52PM +0100, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 99 ++++++++++++++++=
++++++
>  1 file changed, 99 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 02c27004d4a8..93357a450576 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -1,5 +1,7 @@
>  NVIDIA Tegra Power Management Controller (PMC)
> =20
> +=3D=3D Power Management Controller Node =3D=3D
> +
>  The PMC block interacts with an external Power Management Unit. The PMC
>  mostly controls the entry and exit of the system from different sleep
>  modes. It provides power-gating controllers for SoC and CPU power-island=
s.
> @@ -68,6 +70,10 @@ Optional properties for hardware-triggered thermal res=
et (inside 'i2c-thermtrip'
>                       Defaults to 0. Valid values are described in sectio=
n 12.5.2
>                       "Pinmux Support" of the Tegra4 Technical Reference =
Manual.
> =20
> +Optional nodes:
> +- pm-domains : This node contains a hierarchy of PM domain nodes, which =
should
> +	       match the power-domains on the Tegra SoC.

Perhaps call this simply power-domains to match the property name in
consumer nodes?

> +
>  Example:
> =20
>  / SoC dts including file
> @@ -113,3 +119,96 @@ pmc@7000f400 {
>  	};
>  	...
>  };
> +
> +
> +=3D=3D PM Domain Nodes =3D=3D
> +
> +Each of the PM domain nodes represents a power-domain on the Tegra SoC
> +that can be power-gated by the PMC and should be named appropriately.
> +
> +Required properties:
> +  - clocks:		   Must contain an entry for each clock required by
> +			   the PMC for controlling a power-gate. See
> +			   ../clocks/clock-bindings.txt for details.
> +  - resets:		   Must contain an entry for each reset required by
> +			   the PMC for controlling a power-gate. See
> +			   ../reset/reset.txt for details.
> +  - nvidia,powergate:	   Integer cell that contains an identifier for the
> +			   PMC power-gate that is associated with the
> +			   power-domain. Please refer to the Tegra TRM for
> +			   more details.

I find this really difficult to read. Can we use a more conventional
format such as:

	- clocks: Must contain...
	  ... for details.

?

> +  - #power-domain-cells:   Must be 0.
> +
> +Optional properties:
> +  - nvidia,swgroups:	   Provides details of the software groups that are
> +			   associated with a specific power-domain. The
> +			   software group specifier consists of a phandle
> +			   pointing to the memory controller and a list of
> +			   one or more integer cells for each software group
> +			   associated with the power domain. The length of
> +			   the list of integer cells is specified by
> +			   #nvidia,swgroup-cells.
> +  - #nvidia,swgroup-cells: Must be 1 or more. See nvidia,swgroups for
> +			   more details.

That's not how this usually works. #*-cells properties determine the
number of cells required per <phandle spec> pair. So I think this should
be more along the lines of:

  - #nvidia,swgroups: A list of software groups associated with a
    specific power domain. This consists of a list of phandle and
    SWGROUP ID pairs, where the phandle points to the memory
    controller node.
  - #nvidia,swgroup-cells: Must be 1. The single cell in the specifier
    denotes the ID of the software group.

> +
> +Example:
> +
> +	pmc@0,7000e400 {
> +		compatible =3D "nvidia,tegra124-pmc";
> +		reg =3D <0x0 0x7000e400 0x0 0x400>;
> +		clocks =3D <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
> +		clock-names =3D "pclk", "clk32k_in";
> +
> +		pm-domains {

power-domains would convey more clearly what this is about.

> +			...
> +
> +			pd_sor: sor-power-domain {

I don't think it's useful to repeat the -power-domain suffix for all
these nodes.

Thierry

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqM0hAAoJEN0jrNd/PrOhihUP/RMDsHjKpjGqpqSylrEQALp9
LK3ptXbwvmSOSxivHOcCX+PFeWYoF0Vkckzjn+nN//sUhOZ+eLCOXF1dEqjUqjHh
Y1Z4dz8LRcmkpk6BvPpn6hJDE4ZTbIVFEOlhEIhTmqduy2Omc8Ipdi9ntXxKjiyA
0XwxWw8AOiTN4S6MT7ilYHB+udYco6NFBhOhP32yuj2jQihbn10+KTZnIPECSl1O
HWPJuslaFtaihEvmbStjK70tyHQe+8Nw8Hkk8EBs6hN9OLg79R7NOchp/swj/5DJ
V5YUB50+RLXLp7CEFQhck9x8s9Eb/tS36AvfYB1qhZBmOlH5Cfur0MUMa6aJC5qu
lYY31RPFjcacUugvYWwodSEi6yIY1Qj9p5tNOmZkS5WMnco5rnZJoypF2ktOQ3N0
xwFNoy53TnH/p4kyesMQVWJwSCAazMpxPLphUNIPHAlGzWUA1dZZZd3PaRcNFKoM
QZ1rJ2g9jYXLuLlviTzQAzBP85DaMQ5fbFWGO3f79vwASd0FSC3cgD3z22sS6Xbu
7pDe6EbgezBN9yiFrWh3nUvn5GJ2tEpxKBLCxBlvXuXzwMmW/D46ox5DjoIHoKoa
Hc70X46eNJm9uMyn2BLnI4zh4dCz91Ur4YISczfEdVHx3tn9yeupz2imP5boryAF
AsGQbqwvbYmr5PLt6DTX
=iQ6M
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
