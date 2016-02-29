From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 05/10] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Mon, 29 Feb 2016 12:01:00 +0100
Message-ID: <20160229110100.GB674@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-6-git-send-email-jonathanh@nvidia.com>
 <20160229072221.GH23745@ulmo>
 <56D41F60.6010504@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D41F60.6010504-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 29, 2016 at 10:37:20AM +0000, Jon Hunter wrote:
>=20
> On 29/02/16 07:22, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Feb 26, 2016 at 03:48:39PM +0000, Jon Hunter wrote:
> >> Add power-domain binding documentation for the NVIDIA PMC driver in
> >> order to support generic power-domains.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> ---
> >>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 +++++++++++++=
+++++++++
> >>  1 file changed, 61 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra2=
0-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.=
txt
> >> index 53aa5496c5cf..0c383a9e720e 100644
> >> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.t=
xt
> >> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.t=
xt
> >> @@ -1,5 +1,7 @@
> >>  NVIDIA Tegra Power Management Controller (PMC)
> >> =20
> >> +=3D=3D Power Management Controller Node =3D=3D
> >> +
> >>  The PMC block interacts with an external Power Management Unit. The P=
MC
> >>  mostly controls the entry and exit of the system from different sleep
> >>  modes. It provides power-gating controllers for SoC and CPU power-isl=
ands.
> >> @@ -70,6 +72,11 @@ Optional properties for hardware-triggered thermal =
reset (inside 'i2c-thermtrip'
> >>                       Defaults to 0. Valid values are described in sec=
tion 12.5.2
> >>                       "Pinmux Support" of the Tegra4 Technical Referen=
ce Manual.
> >> =20
> >> +Optional nodes:
> >> +- powergates : This node contains a hierarchy of power domain nodes, =
which
> >> +	       should match the powergates on the Tegra SoC. See "Powergate
> >> +	       Nodes" below.
> >> +
> >>  Example:
> >> =20
> >>  / SoC dts including file
> >> @@ -115,3 +122,57 @@ pmc@7000f400 {
> >>  	};
> >>  	...
> >>  };
> >> +
> >> +
> >> +=3D=3D Powergate Nodes =3D=3D
> >> +
> >> +Each of the powergate nodes represents a power-domain on the Tegra SoC
> >> +that can be power-gated by the PMC and should be named appropriately.
> >> +
> >> +Required properties:
> >> +  - reg: Contains an integer value that identifies the PMC power-gate.
> >> +    Please refer to the Tegra TRM for more details. The parent node
> >> +    must contain the following two properties:
> >> +    - #address-cells: Must be 1,
> >> +    - #size-cells: Must be 0.
> >> +  - clocks: Must contain an entry for each clock required by the PMC =
for
> >> +    controlling a power-gate. See ../clocks/clock-bindings.txt for de=
tails.
> >> +  - resets: Must contain an entry for each reset required by the PMC =
for
> >> +    controlling a power-gate. See ../reset/reset.txt for details.
> >> +  - #power-domain-cells: Must be 0.
> >> +
> >> +Example:
> >> +
> >> +	pmc: pmc@0,7000e400 {
> >> +		compatible =3D "nvidia,tegra210-pmc";
> >> +		reg =3D <0x0 0x7000e400 0x0 0x400>;
> >> +		clocks =3D <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> >> +		clock-names =3D "pclk", "clk32k_in";
> >> +
> >> +		powergates {
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <0>;
> >> +
> >> +			pd_audio: aud {
> >> +				reg =3D <TEGRA_POWERGATE_AUD>;
> >> +				clocks =3D <&tegra_car TEGRA210_CLK_APE>,
> >> +					 <&tegra_car TEGRA210_CLK_APB2APE>;
> >> +				resets =3D <&tegra_car 198>;
> >> +				#power-domain-cells =3D <0>;
> >> +			};
> >> +		};
> >> +	};
> >=20
> > Should we not spell out the list of supported power domains per SoC
> > here? The example gives only one, but we have a bunch of others. If they
> > can be referred to by phandle I'd expect there to be a list of them. I'm
> > not sure if this was discussed earlier, but does it perhaps make sense
> > to tie names to IDs, such that we don't need the reg property? That'd be
> > analogous to how PMICs define regulators.
>=20
> So the supported power-domains per SoC are described in the header
> "include/dt-bindings/power/tegra-powergate.h" (see patch #8). Perhaps, I
> can move patch #8 to before this patch and add a reference to the header
> file for a list of supported power-domains. However ...
>=20
> > The reason why I'm asking is that in the above example it's possible to
> > have this:
> >=20
> > 			pd_audio: pcie {
> > 				reg =3D <TEGRA_POWERGATE_SOR>;
> > 				...
> > 			};
>=20
> ... if we eliminate the "reg" property and just use the name, then yes
> it would make sense to move the list of support power-domains into the
> binding doc.
>=20
> It all depends on whether we want to define the IDs in the binding or in
> the PMC driver. Right now we have a static list of power-domains in the
> PMC driver per SoC and I had thought that in the long term we would be
> able to get rid of these and just rely on the binding. But ...
>=20
> > And there'd be no way to sanity check other than by human inspection.
> > Perhaps I'm being overly paranoid and we can easily filter these out
> > during code review.
>=20
>  ... that would mean that we have to rely on the binding being correct
> and inspect manually. On the other hand, if we don't have the IDs in the
> binding we still need to inspect the static arrays in the PMC driver and
> so far I have found a few errors with these. So does it really
> change/improve anything?

I've always considered per-SoC invariant data to not belong into
bindings. That is, constants such as power partition IDs or SMMU client
IDs should be defined via tables in drivers, and DT should be used to
hook them up to devices.

Defining the existing power domains in DT seems rather brittle to me. A
compatible string would imply the set of supported power domains anyway
and having that set specified in DT would technically require us to add
code in the driver to validate that the DT is sane, which would entail
the addition of a very similar table anyway.

One further reason why I prefer not to have these things specified (as
opposed to "glued" together) in DT is that the DT is ABI, so if we ever
happen to ship a broken DT we won't be able to easily fix it. Driver
code, on the other hand, can always easily be fixed.

Thierry

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1CTsAAoJEN0jrNd/PrOhjrYP/1UK11DAF1RZWJLP9LaL1BGx
F9EFotDAkABP/skKW4ET/vr3XYgYuPHCqU/GzZKAp2faLKQbJ+Yg6Vu8OBww+8kH
+UtUdEdjhvRWaDQ50eoOnDsYRHWE7+Dj+X21laUGhOqyIZxnslrx8sjwyUDeDvXB
0nCmgZPfnSaoPZF7eoON+aL/EYILFN1tOhQxnn5Rf/fgCL7yUR1plo++itfZz43w
ha7DA4HEZxvmu2kS7kogLhys9W2uAYXLj5iHbOF/Gj0MTTHzyOCYQXmg6oosEXJs
+bwGxGPwoDafX0gVcgJ+6offIGHpec/QGG0lTLDulJ9O8InPr2ckJaXxjg63ev+n
MN224APGwaZqR7dwHMh5i1K9hTI2QCt50h4B5bwtkXZlIVNTskAVQ4rhWI6c51XY
68icQD3Q117JpVOmVuNU5NlM1J/xkovhR0BrTQ6CymMRqe9cYvHSe9v0e3IeScwz
kVDf8z7RWi996ybW4RNxU7M2pDdi98EUJT/JkXJtXKz9J1hJeQv7Y1pDGz1RROrT
rP/JwniXB9zhG/yP4r5KAQHy5P3327O4i0y/6gVeafTjE29z+nWeovPnGlJGiciR
OOrhOV6QamjGmPpxAE+3KA+i4MwwOADc3HcLvKHiRaPzPG+mnMc6uZiHcbI8IZrc
ofJuywJTTcYHqstHQUF9
=VNEW
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
