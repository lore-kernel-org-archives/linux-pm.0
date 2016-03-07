From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 2/4] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Mon, 7 Mar 2016 11:28:17 +0100
Message-ID: <20160307102817.GJ31189@ulmo.nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
 <1457094186-15786-3-git-send-email-jonathanh@nvidia.com>
 <20160305043104.GG13525@rob-hp-laptop>
 <56DD515A.4020207@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W13SgbpmD6bhZUTM"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56DD515A.4020207-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--W13SgbpmD6bhZUTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 10:00:58AM +0000, Jon Hunter wrote:
>=20
> On 05/03/16 04:31, Rob Herring wrote:
> > On Fri, Mar 04, 2016 at 12:23:04PM +0000, Jon Hunter wrote:
> >> Add power-domain binding documentation for the NVIDIA PMC driver in
> >> order to support generic power-domains.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 80 +++++++++++++=
+++++++++
> >>  1 file changed, 80 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra2=
0-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.=
txt
> >> index 53aa5496c5cf..7d52bbe99709 100644
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
> >> @@ -115,3 +122,76 @@ pmc@7000f400 {
> >>  	};
> >>  	...
> >>  };
> >> +
> >> +
> >> +=3D=3D Powergate Nodes =3D=3D
> >> +
> >> +Each of the powergate nodes represent a power-domain on the Tegra SoC
> >> +that can be power-gated by the Tegra PMC. The name of the powergate n=
ode
> >> +should be one of the below. Note that not every powergate is applicab=
le
> >> +to all Tegra devices and the following list shows which powergates are
> >> +applicable to which devices. Please refer to the Tegra TRM for more
> >> +details on the various powergates.
> >> +
> >> + Name		Description			Devices Applicable
> >> + 3d		3D Graphics			Tegra20/114/124/210
> >> + 3d0		3D Graphics 0			Tegra30
> >> + 3d1		3D Graphics 1			Tegra30
> >> + aud		Audio				Tegra210
> >> + dfd		Debug				Tegra210
> >> + dis		Display A			Tegra114/124/210
> >> + disb		Display B			Tegra114/124/210
> >> + heg		2D Graphics			Tegra30/114/124/210
> >> + iram		Internal RAM			Tegra124/210
> >> + mpe		MPEG Encode			All
> >> + nvdec		NVIDIA Video Decode Engine	Tegra210
> >> + nvjpg		NVIDIA JPEG Engine		Tegra210
> >> + pcie		PCIE				Tegra20/30/124/210
> >> + sata		SATA				Tegra30/124/210
> >> + sor		Display interfaces		Tegra124/210
> >> + ve2		Video Encode Engine 2		Tegra210
> >> + venc		Video Encode Engine		All
> >> + vdec		Video Decode Engine		Tegra20/30/114/124
> >> + vic		Video Imaging Compositor	Tegra124/210
> >> + xusba		USB Partition A			Tegra114/124/210
> >> + xusbb		USB Partition B 		Tegra114/124/210
> >> + xusbc		USB Partition C			Tegra114/124/210
> >> +
> >> +Required properties:
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
> >=20
> > Just pmc@7000e400. We were erronously using commas for 64-bit addresses=
=20
> > briefly, but the correct usage is when there are distinct fields in reg=
=20
> > like PCI bus,dev,func.
>=20
> Ok. Looks like we use this style quite widely across all Tegra 32-bit
> and 64-bit devices for all peripheral devices.
>=20
> Thierry, Stephen,
>=20
> Do we need to correct this for existing devices?

"Need" is perhaps a little strong. It's unfortunate that back at the
time the existing format was deemed best practice, and now we're told
to have been doing it wrong all along. There's also the issue that in
practice somebody might use the node name for some sort of lookup in
userspace or whatever, and they'd have every right to do so, because
the DT is an ABI after all.

Technically removing the 0, from the unit address would be breaking
that ABI, but in practice I'd hope that we wouldn't really break the
world for any users. If this gets us on the same page as everyone
else, I'm fine with taking this risk. I've already begun to convert
existing device trees.

Fingers crossed that best practices won't change again...

Thierry

--W13SgbpmD6bhZUTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3VfBAAoJEN0jrNd/PrOhD3MQAKgvDJpmPbeFqKUMavu4Buyf
CPz8YA2a22kBa0FkmLPuRXYhkoV1ymMB+YSy+Fl8RVXWc45srCpdLbY7N5OoEzV4
sX+EjIgQD/QwR9oLIPvNeYSi3iXogO/FdEZstXZsop9IGIFBZ4e5PLPgp2Oz1Tgs
iv0Apmszfdmlx7GCHkBCqagIfiLHM6q4d39/AWCEP7OhK76/laxqLimN0ecI3H6o
CiTf1YLALXzowbDk5KbmfgIg0Iq7Pzn+Zj6gYeQGVVY8GFSim2m4zS1j+2DKThf2
SurTRWm3VV6//FP/hMPnfaX2BKGDXK6CqUj6cGXk8oDGZau9jkBIWGriYJe/hB/c
P99+ZzRwyj/tS4M3+3tIOS4SdMWGEJdKSNBBxlIOZdkGduyJHmLOpP8wfNHqkLtK
ZxEdKtqei2llaqZ0Bg0RKl74jILJNQmN/Q8SDjXIu8pF6n7/9VICz1PZzSeMp3sY
+e1Q2Ys/r6i0w75X/K3YpRUL2OHBrdyafPsTFmrh8oQjPww7lt/yRnlrQl6sXiRy
N8RVFyb90zyuR5rBQBuxYc7NUsMR6Y4Sgz5CiFyZgqQkP1eJmlGFDkPtMwn4EJSg
spplfZuwwwxW/iIrBI45D3Z1iBtRepA2AGUeewN5kUM4KwBMsFdtGYneFRTSISVo
5wGU8YcCT/wxdiTqW5rI
=Z43a
-----END PGP SIGNATURE-----

--W13SgbpmD6bhZUTM--
