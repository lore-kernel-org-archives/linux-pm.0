From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and
 alert SOC changes
Date: Sun, 16 Sep 2018 13:45:20 +0200
Message-ID: <20180916114520.4375nr2gv3y4ghzv@earth.universe>
References: <20180723040816.19455-1-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k533wzevwisygjeg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--k533wzevwisygjeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matheus,

Did I miss a v2 of this patchset, that solves the issues
found by Krzysztof?

-- Sebastian

On Mon, Jul 23, 2018 at 12:08:12AM -0400, Matheus Castello wrote:
> This series add IRQ handler for low level SOC alert, define a devicetree=
=20
> binding attribute to configure the alert level threshold and check for ch=
anges
> in SOC for send uevents.
>=20
> Max17040 have a pin for alert host about low level state of charge and th=
is=20
> alert can be configured in a threshold from 1% up to 32% of SOC.
>=20
> Tested on Raspberry Pi Zero W, with a SparkFun Lipo Fuel Gauge module bas=
ed on
> MAXIM MAX17043.
>=20
> Matheus Castello (4):
>   power: supply: max17040: Add IRQ handler for low SOC alert
>   power: supply: max17040: Config alert SOC low level threshold from FDT
>   dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
>   power: supply: max17040: Send uevent in SOC changes
>=20
>  .../bindings/power/supply/max17040_battery.txt     | 24 ++++++
>  drivers/power/supply/max17040_battery.c            | 95 ++++++++++++++++=
++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max170=
40_battery.txt
>=20
> --=20
> 2.13.3
>=20

--k533wzevwisygjeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueQlAACgkQ2O7X88g7
+ppLrg/7BYjg6/pKDHyZ+vtYMvAJDd4hrJpRJ93dyzVNteZscXRWhaRj1JjQB2SY
pJi0IzL62/RwGT0Irtv5yetlYVtOv651sXa4ICY07OInLFMW3StSFGbR5NlnF2QF
YLhg4KUkGM08KbwIwPkVLWjKCyloUYIeRKAJnODhWuIH5FX3EH/sLUQCMvFHc1M2
wtnPPiOdGHOEZmzB0zEwJku6Ts0CkuYh4+UL95C3NkFQNJ1TPo9XVj18ovpGFIgF
LLpQY51Iz4EZeLvGmQvUt2u6tI45g93+LU7RBOyqFc9pSwhx0PDS8ZYz5ajPLL58
9GEeO79kD23T8ys6RJiBSUL3YLkMGuyukQJsTCO2eI8D7iX/L/yFjXkLTSmb7+a1
g0zQwDFtwiFypdJgvMR78h4hZdTK07SlDF3rUUcKxUONkJeekx26HE6Xjtv348e5
vtjLp9u6rrfvANPujIw2QF0VFWqaA/1TIwPtUgDivbHZo/BKHvAu3tUezIzfGUUM
XZTf7D6441KHHnM2/PnaPMjCvjxBnxatnCBiCX7n7oCRDiEzGkMG+YiYWp+ADLVy
lJ1ZSCboQbwPSnpW7ckcccyRLjExu78YVgVK+KaVC5YOxwp306bhRU1aApGNwLHN
YHeWVeK7s3rQJWSywQ6ObhI3jxylekC4FuHkggjDTWrTdgAiSVs=
=IHXf
-----END PGP SIGNATURE-----

--k533wzevwisygjeg--
