From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
Date: Tue, 12 Jun 2018 14:30:30 +0200
Message-ID: <20180612123030.l4ezeaw7674ig5kq@earth.universe>
References: <20180608223655.33565-1-briannorris@chromium.org>
 <20180608223655.33565-2-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h4ysnlvpkncnk5pp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608223655.33565-2-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--h4ysnlvpkncnk5pp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 08, 2018 at 03:36:55PM -0700, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rhyland Klein <rklein@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Please use "sbs,sbs-battery" as fallback, just like sbs-manager and
sbs-charger, see for example:

Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

-- Sebastian

> v2: add Rhyland's Acked-by
> v3: no change
> v4: add Rob's Reviewed-by
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-batte=
ry.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index c40e8926facf..a7a9c3366f82 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -2,7 +2,7 @@ SBS sbs-battery
>  ~~~~~~~~~~
> =20
>  Required properties :
> - - compatible : "sbs,sbs-battery"
> + - compatible : "sbs,sbs-battery" or "ti,bq20z75"
> =20
>  Optional properties :
>   - sbs,i2c-retry-count : The number of times to retry i2c transactions o=
n i2c
> --=20
> 2.18.0.rc1.242.g61856ae69a-goog
>=20

--h4ysnlvpkncnk5pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsfvOMACgkQ2O7X88g7
+ppGjQ/8C5j/WJve+ASLo2oQ2CHvSdAHDBW4I0VWP5mRkdlfgtLMOvAOkHoBvBcT
VZRP7aip9LLQuEdTsy/Dalqs3kzZRXCXY1oFfdweL2NBvM/qevAO1fZ2CYAqVuz/
0fB0w2LFBgXXHzy2MJ+YdFju5wp7FaYkAUFQ7xJAQJIVeJHQiK6qlohw8pOx00TD
QrXcXVO6nnhXTNgT//Kwa0rtdF/cBLr7DhFMUZ7uINcxuHg04nLkAZTQAwlqtSdY
UJ8vo/xfyzfVZ2myXGSRdToa9Cw95TeYER1uLxYm4V3GtIB5zLmC1gOfhQD4ZLMu
11PnfPdm+bMp8cO5RR3wWROmEUmr2XIo4fkyI+JH23dwxpGgv0z0XVoCqEyX2rko
VTyTKGQquXavsIeBAtOtWn2+YzQSAVB6ndurxUA6PBH/ztmNeO7EIl/iGTikacPp
53A4u+sFD1piUEBHTYf2CHYpm8WwBfBM6gMertL/M5SN52s8ZcZS2IjkTOgreAud
Bb/JR1UbExXY6OjsmxOvXwT6CWUQ9tTykctWzIfz08+QCFtoXVOURzN4KT7JPMrX
mJXPk8m5dTvVNG+Vo+XxXnvnPy2rZDpISzOnvO3UtNMEQNG0MqE6hBs8EzaCKeJG
etfKKzZOnmFpRMnh9+G00AqB9PW0w9BrkvJdeNlMD/hUauBGDJQ=
=tLAL
-----END PGP SIGNATURE-----

--h4ysnlvpkncnk5pp--
