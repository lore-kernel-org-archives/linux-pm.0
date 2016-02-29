From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 05/10] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Mon, 29 Feb 2016 08:22:21 +0100
Message-ID: <20160229072221.GH23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-6-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501724-28477-6-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:39PM +0000, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 53aa5496c5cf..0c383a9e720e 100644
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
> @@ -70,6 +72,11 @@ Optional properties for hardware-triggered thermal res=
et (inside 'i2c-thermtrip'
>                       Defaults to 0. Valid values are described in sectio=
n 12.5.2
>                       "Pinmux Support" of the Tegra4 Technical Reference =
Manual.
> =20
> +Optional nodes:
> +- powergates : This node contains a hierarchy of power domain nodes, whi=
ch
> +	       should match the powergates on the Tegra SoC. See "Powergate
> +	       Nodes" below.
> +
>  Example:
> =20
>  / SoC dts including file
> @@ -115,3 +122,57 @@ pmc@7000f400 {
>  	};
>  	...
>  };
> +
> +
> +=3D=3D Powergate Nodes =3D=3D
> +
> +Each of the powergate nodes represents a power-domain on the Tegra SoC
> +that can be power-gated by the PMC and should be named appropriately.
> +
> +Required properties:
> +  - reg: Contains an integer value that identifies the PMC power-gate.
> +    Please refer to the Tegra TRM for more details. The parent node
> +    must contain the following two properties:
> +    - #address-cells: Must be 1,
> +    - #size-cells: Must be 0.
> +  - clocks: Must contain an entry for each clock required by the PMC for
> +    controlling a power-gate. See ../clocks/clock-bindings.txt for detai=
ls.
> +  - resets: Must contain an entry for each reset required by the PMC for
> +    controlling a power-gate. See ../reset/reset.txt for details.
> +  - #power-domain-cells: Must be 0.
> +
> +Example:
> +
> +	pmc: pmc@0,7000e400 {
> +		compatible =3D "nvidia,tegra210-pmc";
> +		reg =3D <0x0 0x7000e400 0x0 0x400>;
> +		clocks =3D <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> +		clock-names =3D "pclk", "clk32k_in";
> +
> +		powergates {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			pd_audio: aud {
> +				reg =3D <TEGRA_POWERGATE_AUD>;
> +				clocks =3D <&tegra_car TEGRA210_CLK_APE>,
> +					 <&tegra_car TEGRA210_CLK_APB2APE>;
> +				resets =3D <&tegra_car 198>;
> +				#power-domain-cells =3D <0>;
> +			};
> +		};
> +	};

Should we not spell out the list of supported power domains per SoC
here? The example gives only one, but we have a bunch of others. If they
can be referred to by phandle I'd expect there to be a list of them. I'm
not sure if this was discussed earlier, but does it perhaps make sense
to tie names to IDs, such that we don't need the reg property? That'd be
analogous to how PMICs define regulators.

The reason why I'm asking is that in the above example it's possible to
have this:

			pd_audio: pcie {
				reg =3D <TEGRA_POWERGATE_SOR>;
				...
			};

And there'd be no way to sanity check other than by human inspection.
Perhaps I'm being overly paranoid and we can easily filter these out
during code review.

I suppose that if Rob's fine with it, I can be too.

Thierry

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0/GtAAoJEN0jrNd/PrOhORcP/1RqnsC2QVaYgPUKbIdU8dih
+MbnnJHMEyXSt0HMqqNi5GBeKIPaMYpxWsCLnXXCUHb386FNccyVLu8E0ZWH89YF
PuSxMVQ0ttv8dZtjmeWBSi9F5nT6WwjrPJOh2Jp94zNBeB/Kg7BRTZhzYBK/d+4H
FVxnBro2cQSZimHINiT8M1BhipQYwcqcqKLDfSVNeEAHYzVJVIJkLQz7aqZXyDXy
MFajNzW+WHwsSY14ZJxKuXsSyX1QC/Tkbh9Erag+Jfl+FTnqpzwM6e7g1hXRcZ26
C1CDi8Mjm/B7sLf/X9rx7HMLyu0ITMOgDZTkZyj9D5lNlYv9yUM+cDfNsEeqXqja
qIl+d2UuN4xxHBZVXgvGV3K+/h8IDoQDFWXC9JKJQ8R3rArf/tjw/EOf9JanWWFP
8eEmAMHf90ddc+5/DNQQJhRF7y/MyMMjma2qM1w/8y96VjDvoWBCyvossF2DGPvm
HiLMAD+7I+dQPehyUHVRV8hIB5JkI2N1hS0Fg8VbAYCj1RqVJixmvc8lKsHmznQE
9XRuJlwsXZHWLd2A5uKRlMP4uh3ErXgxlNFVlRaLrBIS5ed3PG7AQ4LdA2+rkq1e
S6UwORYaEUXSqfiIVVdBzthltWM/dUA398HcAdlOnVi18wTU23SZbjJPB+laR3BA
86w+SwzDTJmEr5E8HLyq
=m4vP
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
