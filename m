From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/1] Thermal: spear: Fix compilation error
Date: Thu, 23 May 2013 11:10:02 -0400
Message-ID: <519E314A.80401@ti.com>
References: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2RFVOXXLKELKQEDETATDV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756992Ab3EWPKQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 May 2013 11:10:16 -0400
In-Reply-To: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, Vincenzo Frascino <vincenzo.frascino@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

------enig2RFVOXXLKELKQEDETATDV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21-05-2013 05:20, Sachin Kamat wrote:
> Fixes the following compilation error introduced by commit 253e3ae170
> (Thermal: spear_thermal: convert to devm_ioremap_resource).
> drivers/thermal/spear_thermal.c: In function =E2=80=98spear_thermal_pro=
be=E2=80=99:
> drivers/thermal/spear_thermal.c:123:46: error: =E2=80=98dev=E2=80=99 un=
declared
> (first use in this function)
> stdev->thermal_base =3D devm_ioremap_resource(dev, res);
>=20
> While at it also remove the error message as devm_ioremap_resource()
> provides its own error messages.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> Compile tested and based on linux-next (20130521).

Also compiled tested on same linux-next.

Tested-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/spear_thermal.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_th=
ermal.c
> index fa30918..813add6 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -120,11 +120,9 @@ static int spear_thermal_probe(struct platform_dev=
ice *pdev)
> =20
>  	/* Enable thermal sensor */
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	stdev->thermal_base =3D devm_ioremap_resource(dev, res);
> -	if (IS_ERR(stdev->thermal_base)) {
> -		dev_err(&pdev->dev, "ioremap failed\n");
> +	stdev->thermal_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(stdev->thermal_base))
>  		return PTR_ERR(stdev->thermal_base);
> -	}
> =20
>  	stdev->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(stdev->clk)) {
>=20



------enig2RFVOXXLKELKQEDETATDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGeMUoACgkQCXcVR3XQvP05EwEAsG9gkfyZlV7pJiyXd+pW1jos
JK5dOtGke8+yn32aHHQA/joDXxZ6bzW+S8zgVJcdRy1nokHC1jgEzLy8P65otZus
=VI+z
-----END PGP SIGNATURE-----

------enig2RFVOXXLKELKQEDETATDV--
