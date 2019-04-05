From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Date: Fri, 5 Apr 2019 17:43:17 +0200
Message-ID: <20190405154317.suqovb4u2bgceqf7@earth.universe>
References: <20190226150437.3704-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgrrqna5ih6dueed"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226150437.3704-1-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org


--lgrrqna5ih6dueed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 26, 2019 at 04:04:36PM +0100, Artur Rojek wrote:
> Add documentation for the "status-gpios" property.
> Update the "gpios" property with a valid example.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Changes:
>=20
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
>=20
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..999cc245543c 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -14,12 +14,16 @@ Required properties :
>       usb-cdp (USB charging downstream port)
>       usb-aca (USB accessory charger adapter)
> =20
> +Optional properties:
> + - status-gpios: GPIO indicating whether a battery is charging.

I think it's better to name this charge-status-gpios, since charger
may provide all kind of status GPIOs. For example the existing
gpios property (also bad name, but cannot be changed easily now),
which provides AC online status.

Otherwise the binding and the driver patch looks good to me.

-- Sebastian

--lgrrqna5ih6dueed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynd44ACgkQ2O7X88g7
+prPzw//XO6mDUEhOYJsXTr2FPrYOHrHWEs0rLyj3x+5rOaOuVTb5LXAPtE2iCNZ
8J5/tZ48z9gAm4K16h5N6LIyMewU29E43ouzDDVZ60/k28gOFsZ/tSDT/lgUZiQg
irKv/yjn1txoQcQbb+aHRdHpXp/SBKFcU4T1iDT8EsU7bN4a3GW4WZQJPpSvAQhh
eQCWBiPAadNIyfJcQjmnUPtG8YQT3TCVDV8cXjMwV9nfc+3FKkMtZXW7rrsqdrVC
pukRRokwok4ogfJ5UF8UPJ/KkDO7aerKJ1vu2Ms8u+Mkz7k+OJAlUffTevlUXJX8
agi+XJHumq0OelOvgr4jowJ+Yh0Y2jcGX2iaw4DomNC7UPVXkzwhdMzIsdUKfULE
vxaznLsAOjRODTCJ+Dnd6te3qFNmMIP3v2K/8dmrQinfUEJheuxGrxVyRalSRVtX
B1yO1c6aHdiRAuxxIx+UlDOgHv4xzhbL4lzCxCFVXz5jj9H4jwPpwyI/YblLpu/p
njCBTlwpffeDwzWubkbxm3qyvqJcQgab3Wr7B0Y182djl8URipKqzeCGHc55V1In
7s2SE7ViXp4dUe2BeO963FpFDL0HKmFDq/wDpy2ix3yPPZyISmnRBwcFPPO50/ue
Mn5VCHi50BMIZegBPUQsGoKh03TbrmPa+0XmdW8qeOiIYi+M9t4=
=SUiH
-----END PGP SIGNATURE-----

--lgrrqna5ih6dueed--
