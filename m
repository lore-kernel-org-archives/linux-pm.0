From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Date: Thu, 18 Apr 2019 21:47:03 +0200
Message-ID: <20190418194703.ft5rycsrzz3fyxxb@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-3-contact@artur-rojek.eu>
 <20190324153018.2e4011c9@archlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlupxtszm5xqgv3k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190324153018.2e4011c9@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org


--jlupxtszm5xqgv3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2019 at 03:30:18PM +0000, Jonathan Cameron wrote:
> On Sat, 23 Mar 2019 18:28:08 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
> > Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
> >=20
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Looks fine to me.
>=20
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, queued.

-- Sebastian

>=20
> > ---
> >=20
> > Changes:
> >=20
> > v2: no change
> >=20
> >  .../bindings/power/supply/ingenic,battery.txt | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/inge=
nic,battery.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,bat=
tery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.t=
xt
> > new file mode 100644
> > index 000000000000..66430bf73815
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> > @@ -0,0 +1,31 @@
> > +* Ingenic JZ47xx battery bindings
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "ingenic,jz4740-battery".
> > +- io-channels: phandle and IIO specifier pair to the IIO device.
> > +  Format described in iio-bindings.txt.
> > +- monitored-battery: phandle to a "simple-battery" compatible node.
> > +
> > +The "monitored-battery" property must be a phandle to a node using the=
 format
> > +described in battery.txt, with the following properties being required:
> > +
> > +- voltage-min-design-microvolt: Drained battery voltage.
> > +- voltage-max-design-microvolt: Fully charged battery voltage.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/iio/adc/ingenic,adc.h>
> > +
> > +simple_battery: battery {
> > +	compatible =3D "simple-battery";
> > +	voltage-min-design-microvolt =3D <3600000>;
> > +	voltage-max-design-microvolt =3D <4200000>;
> > +};
> > +
> > +ingenic_battery {
> > +	compatible =3D "ingenic,jz4740-battery";
> > +	io-channels =3D <&adc INGENIC_ADC_BATTERY>;
> > +	io-channel-names =3D "battery";
> > +	monitored-battery =3D <&simple_battery>;
> > +};
>=20

--jlupxtszm5xqgv3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly41DcACgkQ2O7X88g7
+prxuQ//dogDbAB6g0ZRjyPjplt7z1BFvF8WcW561216oY8bwMlXn8kw/tzWFD7O
4g1iuFFbdVbySVuEccFdzzdGbjx71+nWvVVy5ucC5mr/W5NGMdnFGzWf74uEUbga
p6UYg+lizs4SAVfJEiCreZQAS0qdbF2IPgs39Wnov6PXra87L/H+0USKIDwZZqUb
cnmQl7TF19w7JDgNNp5j8nPELRtqrRhq00liIS155LBiUGUYjufiot0oCDe58Z/K
MYtxl1suUcKRLLj8f3CjMFJKSkL9XbE0gGnVtwJBIiDAwqahYtmmbzHDjxroiHm2
jzbm05EtTXWBKxze4D9o9RTaTbyjY1wTzyvaM0x9S+PxocOaXGqiLaFGcHTONBDz
SnuczqxylpVLmOYHWLb7ByB8muY++kuFFkOZvcp60aEl9+9nQyaNF48sOOh9+aPB
MyjcjVBOxES5JYIYhFglW4WFRuy8XR3KuUaKLz/DWy+F8/tpQOvR60BSSiMuZ5tM
CW/RqV9J9d6Lc6Ect4EnFtZuEOwdHzuUiDGj7hS3Q6YWwIjzma5RMQjDZdH5SGKW
D6eJIgXJBC+9FXtl9EdCxxDI+yKf7Igsp0rOSxfXkD5w12zCYNEnGhLqnXCCf+x3
QKUOHIFWTwVkH8gKZ75Jg8nDy/jdIDrStMopvWTgHFB6suO1peA=
=iubX
-----END PGP SIGNATURE-----

--jlupxtszm5xqgv3k--
