From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 12/16] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Thu, 14 Jan 2016 15:41:58 +0100
Message-ID: <20160114144158.GF23082@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-13-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449241037-22193-13-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:13PM +0000, Jon Hunter wrote:
> Add power-domain binding documentation for the NVIDIA PMC driver in
> order to support generic power-domains.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> ---
>=20
> Please note that I have been debating whether I add this
> "nvidia,powergate-clock-disable" property or just leave the clocks
> disabled by default. Some downstream kernels leave the clocks enabled
> for the audio power-domain because the clocks required for powering up
> the power-domain are needed by all modules within the power-domain.
> However are the same time there are other power-domains that may need
> to be on, but not always clocked and so having the ability to specify if
> the clocks should be disabled seems useful. However, I can also remove
> this and just have the appropriate devices turn on the clocks as well.
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 838e1a69ec0a..8e4641db51a9 100644
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
> @@ -69,6 +71,10 @@ Optional properties for hardware-triggered thermal res=
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
> +

pm-domains is a linuxism. Perhaps name this after what Tegra calls this:
"powergates"?

Thierry

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl7O2AAoJEN0jrNd/PrOhDIYP/RnJZDfTEMB/dHdRiFTb0iHt
ayKZa6W7xt39GiWqVZqs0g7T7KrPQKnZTodo57hdwUZMM+kqzEVKCixIdTNwXAcO
foFfVKbLrqR4zt1GvXs/eEIH1M1MxNWEoyJ9XwFu8hwwbP3DuotI4FzJRd4VRB1o
+oeP5Fqe1GvV/7z3obybhXYCW4QJ7gIVN5OxbOK1bPbtMhT829oCWGW4dNsnmFcC
slGbAwA0WOfMu1NRLp7SqV0SlqePC63Cyw+qAuONSyz/JjL833meVzkJXBY/+NYK
iDyAU2lYnIzZnUZAlKrT/eT9Kuwxp6vKUYNmriU7sWqjpkbVqNBs42jAwE4vvSta
uhn/TG+Tw+O99inM9uZTy9ohybtlq/OBsQv3zL7XMB032tfkBfTL5ZsyCFU88sdz
ZhNE5jtpz+KheT+/R8kHqjUMy+28zGfbw15qmRiOcR8hydaUNaSc69Crb+6OSCVr
MZV7i5Ap/ca3INGh92Wd38JMB3OYSOIesIHezHKGqyIQsEc1CjJb1EJZjfPiU47U
p1EPEigAKzZwm88oKmFjPLSGQUut1967F6GLwiDhgZmVJGN2UHwSWfazbAXNbsJt
gENtFKTsjCIi/4BWwJHTepTgxzndSX6VXGTkGSYRqyS09uhE4N1icdomgc3tfWCz
bLzQfXv5XdvR419mr2ow
=9MSY
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
