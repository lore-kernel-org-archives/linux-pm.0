From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: power/supply: Add support for
 xmega16d4-battery
Date: Wed, 15 Mar 2017 22:54:11 +0100
Message-ID: <20170315215411.mychw72dcgo4bdhp@earth>
References: <20170223173812.10740-1-enric.balletbo@collabora.com>
 <20170223173812.10740-2-enric.balletbo@collabora.com>
 <CAFqH_50cRsR=4B9hRinFn_qaUnvUfR0XQ8S60hQXi8_p=6rPyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nz2mupl6lqv4ycko"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753985AbdCOVyh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:54:37 -0400
Content-Disposition: inline
In-Reply-To: <CAFqH_50cRsR=4B9hRinFn_qaUnvUfR0XQ8S60hQXi8_p=6rPyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>


--nz2mupl6lqv4ycko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 23, 2017 at 06:44:59PM +0100, Enric Balletbo Serra wrote:
> Ooops, sorry I forget to add the device tree maintainers so
>=20
> CC'ing Rob Herring and Mark Rutland
>=20
>=20
> 2017-02-23 18:38 GMT+01:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
> > Add the documentation for binding of Toby Churchill SBS battery monitor
> > driver. The device is connected via SPI and is able to report different
> > battery characteristics.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >  .../devicetree/bindings/power/supply/xmega16d4-battery.txt   | 12 ++++=
++++++++
> >  1 file changed, 12 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/xmeg=
a16d4-battery.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/xmega16d4-b=
attery.txt b/Documentation/devicetree/bindings/power/supply/xmega16d4-batte=
ry.txt
> > new file mode 100644
> > index 0000000..c76db67
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.=
txt
> > @@ -0,0 +1,12 @@
> > +Binding for the Toby Churchill SBS battery monitor
> > +
> > +Required properties :
> > + - compatible : "tcl,xmega16d4-battery"

The same naming issue, that I mentioned in the driver patch applies
here. Also you should reference the standard spi binding document
for properties like spi-max-frequency.

-- Sebastian

> > +Example:
> > +
> > +       battery: smart-battery@0 {
> > +               compatible =3D "tcl,xmega16d4-battery";
> > +               reg =3D <0>;
> > +               spi-max-frequency =3D <100000>;
> > +       };

--nz2mupl6lqv4ycko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJuAMACgkQ2O7X88g7
+prwVw//WyCJHOOTapzBSa/zR8auAAVhOjKpohfV8kQ8WQUP44SZ1aPBsNVGtS+0
3Vj8nqzSGoDJkaK6kATgw/lKsYP3N/f49Cwjq8W1bl22RBJ8moJmTfxVXQTYNg3K
kFavSKMAegTp1HrjuAcrHefebiNMwcNkguoD7Pw0nhaPwrX6XrYmNuI+d7dke3+H
M5h2ARn1Wp10HLvc6ksMzt6mE6/9Hc3y+15Fs+/6g4OilJV6c17DN+gcM2X1XwfH
Aqf2GYXNLCGihYLiYFicnKrYo8UNivsW9gZb15+2FElAWOhBrW1aG2WhLl2CDlWl
yGIrjmKD+izJvZYGWUq/N5wgreOql81eAPzgPYtckcIFq6c5+uEnVa0/4zZTklBx
SNC+eTF28WsvUeZUd3fJHnKk9KLkJl4tYcEK8Go/UyRGYvAVTPfcy9R/8iXPz9w2
u02usj5AOzoiQnWdbRfGdZWZ3uHW5ZpAJJgF41LgAZRuJR4OT/UJbchRKt0oNSRS
KaFRZpvrvczqqweTNXqd4LvBcDLDgegyNFvhOjJgiXD3X/mztSkHvZcf8JyJgCAq
kVj6WD/JZtH12inewKM3Wjla1gcBllAocf9nFPH2F6vzmwBKWrbl49urFicx8eYK
AhlHudro7EUs+TVCwCCKwgb7FtF9XcG88m6G2aZ57nPbQFsa+0E=
=fs94
-----END PGP SIGNATURE-----

--nz2mupl6lqv4ycko--
