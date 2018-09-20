From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: reset: qcom-pon: Add pms405 pon support
Date: Thu, 20 Sep 2018 11:42:17 +0200
Message-ID: <20180920094217.n3lcyg6k7oj6gxrs@earth.universe>
References: <20180920015044.15686-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igmfdv2znylmvn3z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920015044.15686-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--igmfdv2znylmvn3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 19, 2018 at 06:50:44PM -0700, Bjorn Andersson wrote:
> From: Vinod Koul <vkoul@kernel.org>
>=20
> Update the binding and driver for pms405 pon.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 5 ++++-
>  drivers/power/reset/qcom-pon.c                             | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b=
/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> index 651491bb63b7..5705f575862d 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> @@ -6,7 +6,10 @@ and resin along with the Android reboot-mode.
>  This DT node has pwrkey and resin as sub nodes.
> =20
>  Required Properties:
> --compatible: "qcom,pm8916-pon"
> +-compatible: Must be one of:
> +	"qcom,pm8916-pon"
> +	"qcom,pms405-pon"
> +
>  -reg: Specifies the physical address of the pon register
> =20
>  Optional subnode:
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 0c4caaa7e88f..3fa1642d4c54 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -74,6 +74,7 @@ static int pm8916_pon_probe(struct platform_device *pde=
v)
> =20
>  static const struct of_device_id pm8916_pon_id_table[] =3D {
>  	{ .compatible =3D "qcom,pm8916-pon" },
> +	{ .compatible =3D "qcom,pms405-pon" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
> --=20
> 2.18.0
>=20

--igmfdv2znylmvn3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluja3kACgkQ2O7X88g7
+prVcA/6AtI5k9Dui7cZUevF/k1CJSPBxzK6rHi7vtmgDEebU4+7Nkd1fnZkusWu
nDxOf7ZWksi8rFcfV8csXyivcC+ZLotHgJ+w1sUN8uc1s68yFNMM8cPDsTMMVZsZ
SeeXsGtfDxKlHsQtjcAp5bu3NjVWvXp4nDDa4NUNoN0WrIs7fN8a/y9pMR77ZB5X
GpunyWmUbzeFZwWydUg/646WK0cepE0r334qS2SRudv1mOVlHon80EBHP50wg8VA
QfxOkRQxiYH7GXQTEXh2Jthp8rK8yGkavfirjImN5NtCqcUzqDWOv/Ks7PCfH15e
FQF/yIjtPwXXXQDBKvgR7nGr5+O7xZ12vUVCdl+xO85WNx7mFciMFNkrEusw+pAc
DGqVEsfdUxvddFD6nJRn/q8VvayA/QVRWc9/JPsVaeBClFnqAOz0AGEi0QfX5GIl
PJ0yLbW3XMtWuU/CZvGm8kHx+VjG6sTy+/7iLkGmsStpyFM3gL3nhLuUfmS7DtuK
L/5ir/mgjHQL8RgU7rhUogaxVC+PhFyrTvDxd5RDIj/C3mNfsg3NkRfPnw5E/t1C
1bLEenhNkaNocbEPFUr0PVpGoXvju/suTplAxyWmvPvqkL222pOidOztmqh3ukji
lL+Lt+uZRIbH0UaYh0ZgbJiNZf9lzOPk9CNcYNETlku04usmdoY=
=GXhm
-----END PGP SIGNATURE-----

--igmfdv2znylmvn3z--
