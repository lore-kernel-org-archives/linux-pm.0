From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add bindings for
 nvidia,tegra186-ccplex-cluster
Date: Mon, 3 Apr 2017 16:06:17 +0200
Message-ID: <20170403140617.GA22966@ulmo.ba.sec>
References: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
 <1491223345-24386-2-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33669 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdDCOGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 10:06:20 -0400
Content-Disposition: inline
In-Reply-To: <1491223345-24386-2-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 03:42:24PM +0300, Mikko Perttunen wrote:
> The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra186-ccplex-cluster.txt   | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,te=
gra186-ccplex-cluster.txt
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-=
ccplex-cluster.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,teg=
ra186-ccplex-cluster.txt
> new file mode 100644
> index 000000000000..50cd615219e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-=
cluster.txt
> @@ -0,0 +1,22 @@
> +NVIDIA Tegra CCPLEX_CLUSTER area
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +  - "nvidia,tegra186-ccplex-cluster": for Tegra186
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "a57": Public aperture for A57 CPU cluster
> +  - "denver": Public aperture for Denver CPU cluster
> +- nvidia,bpmp: Phandle to BPMP device that can be queried for OPP tables

"phandle"

> +Example:
> +
> +	ccplex@e000000 {
> +		compatible =3D "nvidia,tegra186-ccplex-cluster";
> +		reg =3D <0x0 0x0e060000 0x0 0x1000>,
> +		      <0x0 0x0e070000 0x0 0x1000>;
> +		reg-names =3D "a57", "denver";
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +	};

Where's the information about the register offsets coming from? The TRM
says that CCPLEX_CLUSTER has a single aperture from 0x0e000000 to
0x0e3fffff.

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljiVtUACgkQ3SOs138+
s6EXWg/+OFksuW+8LtdYGlcR8zVFkAvtfbSt2dMzhPtfiiA6BloS6cKyQZjXShTW
O9i98bKmR8w1lr6Qu3/YdEdwpXBOseRlGqaZcOatCjqeI1PPI/skFShVlO8hC/5k
FMJ+xBmVXDLzvsdqKdayLAVScU2giNDcdgjylkmzpMCEBOsOMY6aduxYX9CNjrbg
NFLaCy5Fb9Y/FAQpjr21AeTZvtmJDss8tlPd8afyZuHngJsW9xisxLZw5bJwQJgC
aRJK6CKco/BKAWVJDl02UpUgSie3rOKYDSa/naCk/zPUqTbOJ+yilvAa8viRWf0h
Xn0/yNHMz3b3f8EU5AJ6FoCY1LZbauwS8g0qnfQirTE602DTWBuyin+IdYxAiMyO
MO4HzIlJJICFLNGoZd5Zgs1mZnX+uhWX3jpM1+hTCrfFaEMYlXjFUrSiXhhvmUVH
wxfDBX8izhcTiplF42DIalgGdInhVBAFeNLosVNV/xFlGVqtRw3jvqMklJEgka1F
kh8sLVf1rBiT4/Bi/JEg1PnTSeGx0OxRqUcJKfsBdovVTQb65rG9VailgVA1XIfh
p/BG1xSbjEscEI3fKGvDGCXDBRYpeOxH+nii4FuAGWG7jYySp53g4sZMNDm6ymyL
ByMH3eoQlMBOFvdXSL8xf+HWpu0f7wNPB19ujE0+eqJvBrgvW3k=
=h41V
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
