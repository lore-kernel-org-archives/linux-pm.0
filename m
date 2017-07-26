From: =?UTF-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Subject: Re: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 14:54:40 +0200
Message-ID: <1501073680.20056.3.camel@megous.com>
References: <20170723102749.17323-1-icenowy@aosc.io>
         <20170723102749.17323-11-icenowy@aosc.io>
         <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
         <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
         <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
         <82507f40a1ddba8517cf09f51d3afa33@aosc.io>
         <1501064628.14577.1.camel@megous.com>
         <20170726114420.ipirqgbluqmggcjy@flea>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-REyDzSfTfJmwRCLe+i2k"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170726114420.ipirqgbluqmggcjy@flea>
Sender: linux-clk-owner@vger.kernel.org
To: maxime.ripard@free-electrons.com
Cc: icenowy@aosc.io, wens@csie.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-pm@vger.kernel.org


--=-REyDzSfTfJmwRCLe+i2k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxime Ripard p=C3=AD=C5=A1e v St 26. 07. 2017 v 13:44 +0200:
> Hi,
>=20
> On Wed, Jul 26, 2017 at 12:23:48PM +0200, Ond=C5=99ej Jirman wrote:
> > Hi,
> >=20
> > icenowy@aosc.io p=C3=AD=C5=A1e v St 26. 07. 2017 v 15:36 +0800:
> > >=20
> > > > > >=20
> > > > > > Otherwse
> > > > > >=20
> > > > > > > +               regulator-max-microvolt =3D <1400000>;
> > > > > > > +               regulator-ramp-delay =3D <200>;
> > > > > >=20
> > > > > > Is this an actual constraint of the SoC? Or is it a characteris=
tic
> > > > > > of the regulator? If it is the latter, it belongs in the driver=
.
> > > > > > AFAIK the regulator supports varying the ramp delay (slew rate)=
.
> > >=20
> > > I don't know...
> > >=20
> > > Maybe I should ask Ondrej?
> >=20
> > It is probably neither.
> >=20
> > It is used to calculate a delay inserted by the kernel between setting
> > a new target voltage over I2C and changing the frequency of the CPU.
> > The actual delay is calculated by the difference between previous and
> > the new voltage.
> >=20
> > I don't remember seeing anything in the datasheet of the regulator.
> > This is just some low value that works.
> >=20
> > It would probably be dependent on the capacitance on the output of the
> > regulator, actual load (which varies), etc. So it is a board specific
> > value. One could measure it with an oscilloscope if there's a need to
> > optimize this.
>=20
> If this is a reasonable default, then this should be in the
> driver. You can't expect anyone to properly calculate a ramp delay and
> have access to both a scope and the CPU power lines.

It translates to 1ms per 0.2V which is highly conservative. The real
times will be in 1-10us range. So I guess this could be a default in
the driver.

regards,
  o.

> Maxime
>=20
> --=20
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>=20
--=-REyDzSfTfJmwRCLe+i2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmrE4sgaRYhzUz5ICbmQmxnfP7/EFAll4kRAACgkQbmQmxnfP
7/GqCA/+K2EiDc36p+JOPRl52doDVV6V7e/2gyMQzpoGj/n+EsBh3blMoSH1Nsd5
jR1DBREUxLJaRBM6kJ5pvjnknxYBUL4eB12jxzPVhJY2m+o1XRdEGo46EOoVzjB4
S5xEAKJHb8E4eup+gJLOWLc/1X2A/6k+oHcaEj7IV7o45Qt3bvr2F8LrgpddqfdT
HiIpTZQUArxOnyDLDdUj/nPLpI9WXxA5gaLBGApd0LyobsDf6Eti4JxpI84ApWcI
x5JnVOAgVdfG+jDuC+tTcGksIuqg3K7Ss+MPP03/C6E4QMV6ihgRQd4QmL8zUb6K
C5JyfG9ZNodL7mOP5fv5WMylw1zEzYDAr8cpL8IJz0WVjD/1/AlnsUgKgHcs1ILY
yGmrUBhdyHdnxZ7d63TzBYoIup54dUacouKZWhTXiAz4wghTK8Wasl0xJU8sQx+b
hYLUMu6VJXcvfc4U/3qtgwLD7NeiNsPiksZbWp8dk/eLVxEP3Ddl4FdxbnJZjtaI
L77DQTbQgyN6jVBoHdCbc6Zf8MhraqLBwxe5Gv5sv0lHDblg/zFXhOZ7NsKMdtNT
G2M2JxT7A6isxw3iNCr3z+CPB5O/XZsgoJIxGnF7cOQNg7j72TKw8f1FrZaiRwjk
nsCZg4DJHOHMyALL4BYtsonkziMkGraY39nbBUpVJ6qcpdKXW5M=
=IzQR
-----END PGP SIGNATURE-----

--=-REyDzSfTfJmwRCLe+i2k--

