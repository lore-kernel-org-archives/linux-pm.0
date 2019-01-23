From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to
 read charge voltage
Date: Wed, 23 Jan 2019 21:27:38 +0100
Message-ID: <20190123202738.m6btovysy73i6i3o@earth.universe>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppg2kqqkzwzvt4n3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org


--ppg2kqqkzwzvt4n3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 15, 2019 at 06:32:34PM +0800, Baolin Wang wrote:
> Add one IIO channel named "charge_vol" to read the charge voltage for
> the SC27XX fuel gauge controller.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, patchset is queued to power-supply-next.

-- Sebastian

>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt=
 b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> index fc35ac5..0a5705b 100644
> --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -9,8 +9,8 @@ Required properties:
>    "sprd,sc2731-fgu".
>  - reg: The address offset of fuel gauge unit.
>  - battery-detect-gpios: GPIO for battery detection.
> -- io-channels: Specify the IIO ADC channel to get temperature.
> -- io-channel-names: Should be "bat-temp".
> +- io-channels: Specify the IIO ADC channels to get temperature and charg=
e voltage.
> +- io-channel-names: Should be "bat-temp" or "charge-vol".
>  - nvmem-cells: A phandle to the calibration cells provided by eFuse devi=
ce.
>  - nvmem-cell-names: Should be "fgu_calib".
>  - monitored-battery: Phandle of battery characteristics devicetree node.
> @@ -47,8 +47,8 @@ Example:
>  			compatible =3D "sprd,sc2731-fgu";
>  			reg =3D <0xa00>;
>  			battery-detect-gpios =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> -			io-channels =3D <&pmic_adc 5>;
> -			io-channel-names =3D "bat-temp";
> +			io-channels =3D <&pmic_adc 5>, <&pmic_adc 14>;
> +			io-channel-names =3D "bat-temp", "charge-vol";
>  			nvmem-cells =3D <&fgu_calib>;
>  			nvmem-cell-names =3D "fgu_calib";
>  			monitored-battery =3D <&bat>;
> --=20
> 1.7.9.5
>=20

--ppg2kqqkzwzvt4n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIzjcACgkQ2O7X88g7
+poiSQ//eTUsDovorLNfFNZcdVJl45prcoKfrhJhyu4db1FoCB5UjB3X3mErrTmq
ut2vwv4fY7C/LgLqj+rZA2MyqfWtmHGbRqGP+1TJzRoLgMywCBmCSgwaVM4ZZiKC
woqyp1dRPof9fWCED/SPHs6SQmNF7tkob2qxaE4QioXVq/hhufwGjPrH/Bd7Z7YW
+LCgjnEMVr/fpEAI8hzzuAb1M4JMzFvrOCm6ZP82jdyqxhnGWESRF195Z2tARFab
4xMTHZMH34mGIINsWnvxZXqNsYUMe6/JIIIDKDswK7PE9J+tW4KH1nJth5FCxCEs
dZgMw6nXVY99D3lFqKwdv6/4+/QAV+OB/+Wwko/0zRvWHPagb+Ve2VwRknnHni+b
7ZzXRH2WcJ3Zuu5tXVQIScoXaURB3PDwnKS+9t+MoaTEeEJpCKimfIBU2qxiBhUs
i0Y8Q2Muy8FWa6e8CKw3CpuTHgLx3TMQEJcw0auhIPHH1B5jTMrbnLuHHHqPomC2
PN58Eb3KZm6V+paI/21Lds0O1VVs7nHQbVwR2bgAE3zjFKT6eGc4bqDa/53caW1Z
DE5ClrcPYfqXkVU/uU6r2ugQIxT6wx3l72Bk4kTwiKpKo3xLk4UXQzVnXfyQ7+Gu
FKmstQ4INfKxVopgcxqltjdVqPEQvASQWZdIde/gbYCAtNzKgu8=
=jsuy
-----END PGP SIGNATURE-----

--ppg2kqqkzwzvt4n3--
