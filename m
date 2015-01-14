From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 05/16] thermal: dts: Enable TMU at Exynos4412 based
 Odroid U3 device
Date: Wed, 14 Jan 2015 14:48:17 -0400
Message-ID: <20150114184815.GD3672@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:59715 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbANSs2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 13:48:28 -0500
Content-Disposition: inline
In-Reply-To: <1421242874-3425-6-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 02:41:03PM +0100, Lukasz Majewski wrote:
> This commit enables TMU IP block on the Exynos4412 Odroid U3
> device.
>=20

The comment about the patch subject applies here too. I would use "arm:
dts: ..." instead of "thermal: dts" ...".

> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> Changes for v3:
> - None
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/b=
oot/dts/exynos4412-odroid-common.dtsi
> index 0adb57c..c7517fc 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -396,6 +396,11 @@
>  	ehci: ehci@12580000 {
>  		status =3D "okay";
>  	};
> +
> +	tmu@100C0000 {
> +		vtmu-supply =3D <&ldo10_reg>;
> +		status =3D "okay";
> +	};
>  };
> =20
>  &pinctrl_1 {
> --=20
> 2.0.0.rc2
>=20

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUtrnnAAoJEMLUO4d9pOJWCAIH/RhRHLbbgkG7pIg3031SExf1
cwSdUYOVhIlixFZNR1GAWxwNqvafWQtrswvxgnkgZdy612qZJorvqryIASzSgA6x
6ulRPCBprzYLg62uN9Fwb/aGfKyTTEUYfzKpqMA+/ZOiwDM5vCvinsGGd6tn4E6N
qXiHRVFhfemaw+C2HrD0cML/sGdVY6SN/qvXLJZbwcF+PU/TELjXXgC6h/mJpVs5
HHaWMmlBatVy+S+O8iNO+KgRX89RinfAks3BJCOsN176ki0cO6KIVJnfEtxT3LpM
QEhaDFZEBFToSt+SnnxurUcXEeUa4MSkR5tUQYiyjqHcxtPQH4Qr7HcAdV07URg=
=qZrs
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
