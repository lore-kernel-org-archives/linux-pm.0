From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 10/10] ARM: dts: sun8i: Add SY8106A
 regulator to Orange Pi PC
Date: Wed, 26 Jul 2017 13:44:20 +0200
Message-ID: <20170726114420.ipirqgbluqmggcjy@flea>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-11-icenowy@aosc.io>
 <CAGb2v66AGjazHT-+hWVLyNBLDw=DJ5yTmNxF-_=BtZFfjnni-A@mail.gmail.com>
 <25C8A89C-8495-4787-934C-8E9667CD70BF@aosc.io>
 <CAGb2v64xXOmC44TKrSDZFAh6i_rgFEccCHj4EG+1fxFJd9fjjw@mail.gmail.com>
 <82507f40a1ddba8517cf09f51d3afa33@aosc.io>
 <1501064628.14577.1.camel@megous.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tpwlf6xvobw3hsae"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39164 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdGZLoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 07:44:32 -0400
Content-Disposition: inline
In-Reply-To: <1501064628.14577.1.camel@megous.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Cc: icenowy@aosc.io, wens@csie.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>


--tpwlf6xvobw3hsae
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 26, 2017 at 12:23:48PM +0200, Ond=C5=99ej Jirman wrote:
> Hi,
>=20
> icenowy@aosc.io p=C3=AD=C5=A1e v St 26. 07. 2017 v 15:36 +0800:
> >=20
> > > > >=20
> > > > > Otherwse
> > > > >=20
> > > > > > +               regulator-max-microvolt =3D <1400000>;
> > > > > > +               regulator-ramp-delay =3D <200>;
> > > > >=20
> > > > > Is this an actual constraint of the SoC? Or is it a characteristic
> > > > > of the regulator? If it is the latter, it belongs in the driver.
> > > > > AFAIK the regulator supports varying the ramp delay (slew rate).
> >=20
> > I don't know...
> >=20
> > Maybe I should ask Ondrej?
>=20
> It is probably neither.
>=20
> It is used to calculate a delay inserted by the kernel between setting
> a new target voltage over I2C and changing the frequency of the CPU.
> The actual delay is calculated by the difference between previous and
> the new voltage.
>=20
> I don't remember seeing anything in the datasheet of the regulator.
> This is just some low value that works.
>=20
> It would probably be dependent on the capacitance on the output of the
> regulator, actual load (which varies), etc. So it is a board specific
> value. One could measure it with an oscilloscope if there's a need to
> optimize this.

If this is a reasonable default, then this should be in the
driver. You can't expect anyone to properly calculate a ramp delay and
have access to both a scope and the CPU power lines.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--tpwlf6xvobw3hsae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZeICUAAoJEBx+YmzsjxAgnDgP/jvGHNkgGXAkd3SWUgBf3Rqk
4rOyU+/OnTtKBYWImQ+PYHGvL5dNTJtGRIzRVGaL50ZjUT8GbMTaUOrwJu51c3kP
Psbt2w4TQCrjbw/Qe/KoePCPsI9nT6JWnAsdYSQTiN0M9FUF6JQBS6dxSjeBpP6s
sY+1ogf5qlQf/Pe5FNkeNgmuVC03Pthsl68Ua13X0YSjIsjEFNrnExDGhG8W9ZVW
MLcOTTNjpwMLdLUUWOa44RI1ud/x/h1ejyOArbRBiwoDNG66y2cwEBojjHXYMNu+
LScMmvq6dICFRsOGd71aUNm57NiW5T1lKLuWfL0uOXLMZmnOuwyAJtIt983dfEJt
xkRjjaBmY+nfTNZsZwzp/5dfLS/btHKig676oeHVbHuTy+qVJqTni9oKKhKQxfFw
7WJ5RpYo7/DcQDf6G2mSrh1iKp9ypA4Y2Olz+orECuGkjAWvO138BgIXRwNkxlQZ
5RMIPyzRxiCmndaxSF3Jp6OFtGUGlPhH2Wxv3TwDRteOWELlmEC2MDVM1tUDy8pl
o6qVuPzJU/dntWYg7DovJLcVxQDSDKuyJQLIun1dCgKE+erdMuDxh+1wwuiKoCnt
S8FL+K0VZG+hVHM9fwVX47TijDI+FORTnZFYjIUutWJv/CN/tN+svrPi11+PgO5k
P+OodljiTEvlm/sOqeoh
=qLeE
-----END PGP SIGNATURE-----

--tpwlf6xvobw3hsae--
