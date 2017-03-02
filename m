From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
Date: Thu, 2 Mar 2017 15:11:05 +0100
Message-ID: <20170302141105.5fr3ru72rtdyv4pd@lukather>
References: <20170301190220.2EgSha6N@smtp3o.mail.yandex.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3484156029276456338=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301190220.2EgSha6N@smtp3o.mail.yandex.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3484156029276456338==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i34s57vrtc3ypnob"
Content-Disposition: inline


--i34s57vrtc3ypnob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 12:02:13AM +0800, Icenowy Zheng wrote:
>=20
> 2017=E5=B9=B43=E6=9C=881=E6=97=A5 23:56=E4=BA=8E Maxime Ripard <maxime.ri=
pard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Mar 01, 2017 at 06:20:51PM +0800, Icenowy Zheng wrote:=20
> > >=20
> > > 2017=E5=B9=B43=E6=9C=881=E6=97=A5 18:14=E4=BA=8E Maxime Ripard <maxim=
e.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A=20
> > > >=20
> > > > On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote:=20
> > > > >=20
> > > > > 2017=E5=B9=B42=E6=9C=8828=E6=97=A5 14:44=E4=BA=8E Maxime Ripard <=
maxime.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A=20
> > > > > >=20
> > > > > > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:=
=20
> > > > > > > From: Ondrej Jirman <megous@megous.com>=20
> > > > > > >=20
> > > > > > > Allwinner SoCs from H3 (including H5, A64, etc) have a new ve=
rsion of=20
> > > > > > > thermal sensor, and needs a new driver for it.=20
> > > > > > >=20
> > > > > > > Add such a driver.=20
> > > > > > >=20
> > > > > > > Currently only H3 is supported, but other SoCs are easily to =
be=20
> > > > > > > supported by adding new formula and set the sensor number.=20
> > > > > > >=20
> > > > > > > Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>=20
> > > > > > > [Icenowy: extend to support further multiple-sensor SoCs, cha=
nge commit=20
> > > > > > >=C2=A0 message]=20
> > > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>=20
> > > > > >=20
> > > > > > There's no need to create a new driver for that. This can be ha=
ndled=20
> > > > > > by the GPADC driver we already have.=20
> > > > >=20
> > > > > sun8i-ths is not GPADC at all.=20
> > > > >=20
> > > > > The latest SoC I know that use GPADC as thermal sensor is A33.=20
> > > >=20
> > > > It's not called the same way, but it definitely is an evolution of =
the=20
> > > > same controller. There's no need for a new driver, only reworking w=
hat=20
> > > > is already there.=20
> > >=20
> > > I don't think so -- here's some evidence:=20
>=20
> But the H3 THS have many new IRQs, functions, different sampling
> rate set method and a quite different register layout.
>=20
> Doing this in GPADC driver is possible but meaningless.
>=20
> > >=20
> > > 1. The old GPADC do not have module clock.=20
> >
> > The A33 could use a PLL.=20
>=20
> But it's a dedicated mod clk on new generation THS.

And all of this really are evolutions. The block is still driven in
the exact same way. And this is where there is value in having the
same driver: you share the logic, which is mostly common, instead of
duplicating it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--i34s57vrtc3ypnob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuCf5AAoJEBx+YmzsjxAgC9oQALtC/LLqoaQWsvfcW+yDGufC
yuvlT4x2scMowamowC+1XVIG3S7NeGmQQayS6x3juJpmCNa88SAfLm1mukLGL4Gm
+lI+MyRfLUoKyul7BjKs0QT3hRegq2vKd/kiwNodx7soYDyQFQ2Yjxl5XHkgPnZ7
wQKTW1rC2uRZP96nOJzmOcwUhinM9gPw99QzOzqjCfmwZ8ewOk5fm4JGV98ljh8J
SYU3fC8MZpD4L8jEDK3V3pzFmaNuhg4auMHNIR/hPcBWFwUq89gfvzEi3c+w9cxs
7YJjuRPGABSdLrs9MAToVWfn7K8G8P1Yno3TxQ1/e/EIWrHMzUMhotE0NigS97zg
Zmjk3xhZ343hvLhuhBjiC8xv9cGBROibRy0urBbJImZTpE9c+8Y9hpFr79jW7/Wh
g/C+IxYVKyEwhxB8VntvLEg4+Js55v4Ewpkr1EP3MPAfNw3G6vKjs68OjWiR6Nzu
HZsajAblA8BwmhKK/2la/PHyHCAkzq8wAdSw4K5RW4jWmoC9vh6mm9s6NISxL9oq
kJzhItijrv2cQ5FxPRxz75dQ4zPuFYhF5GOum7V9i7zpIa5ziRhFNnlLAlAjGT+9
w3YFI6UuetOKQHvdMEa9tRVojGVcREo6mGg0MbDpv51vzu6axNtDjDsmMaazfOW6
CGkqiUfpH1IRzZ8deaOL
=3Ase
-----END PGP SIGNATURE-----

--i34s57vrtc3ypnob--


--===============3484156029276456338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3484156029276456338==--
