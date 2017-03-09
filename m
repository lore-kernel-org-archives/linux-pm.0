From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
Date: Thu, 9 Mar 2017 15:27:12 +0100
Message-ID: <20170309142712.tfmfrbbhagskrtaf@lukather>
References: <20170301190220.2EgSha6N@smtp3o.mail.yandex.net>
 <20170302141105.5fr3ru72rtdyv4pd@lukather>
 <8250311489019784@web18g.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7681161870769237948=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8250311489019784@web18g.yandex.ru>
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
Cc: Ondrej Jirman <megous@megous.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============7681161870769237948==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mzgialstztho4mk3"
Content-Disposition: inline


--mzgialstztho4mk3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 08:36:24AM +0800, Icenowy Zheng wrote:
>=20
>=20
> 02.03.2017, 22:11, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Thu, Mar 02, 2017 at 12:02:13AM +0800, Icenowy Zheng wrote:
> >> =C2=A02017=E5=B9=B43=E6=9C=881=E6=97=A5 23:56=E4=BA=8E Maxime Ripard <=
maxime.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >> =C2=A0>
> >> =C2=A0> On Wed, Mar 01, 2017 at 06:20:51PM +0800, Icenowy Zheng wrote:
> >> =C2=A0> >
> >> =C2=A0> > 2017=E5=B9=B43=E6=9C=881=E6=97=A5 18:14=E4=BA=8E Maxime Ripa=
rd <maxime.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >> =C2=A0> > >
> >> =C2=A0> > > On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wr=
ote:
> >> =C2=A0> > > >
> >> =C2=A0> > > > 2017=E5=B9=B42=E6=9C=8828=E6=97=A5 14:44=E4=BA=8E Maxime=
 Ripard <maxime.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >> =C2=A0> > > > >
> >> =C2=A0> > > > > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zhen=
g wrote:
> >> =C2=A0> > > > > > From: Ondrej Jirman <megous@megous.com>
> >> =C2=A0> > > > > >
> >> =C2=A0> > > > > > Allwinner SoCs from H3 (including H5, A64, etc) have=
 a new version of
> >> =C2=A0> > > > > > thermal sensor, and needs a new driver for it.
> >> =C2=A0> > > > > >
> >> =C2=A0> > > > > > Add such a driver.
> >> =C2=A0> > > > > >
> >> =C2=A0> > > > > > Currently only H3 is supported, but other SoCs are e=
asily to be
> >> =C2=A0> > > > > > supported by adding new formula and set the sensor n=
umber.
> >> =C2=A0> > > > > >
> >> =C2=A0> > > > > > Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>
> >> =C2=A0> > > > > > [Icenowy: extend to support further multiple-sensor =
SoCs, change commit
> >> =C2=A0> > > > > >=C2=A0 message]
> >> =C2=A0> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> =C2=A0> > > > >
> >> =C2=A0> > > > > There's no need to create a new driver for that. This =
can be handled
> >> =C2=A0> > > > > by the GPADC driver we already have.
> >> =C2=A0> > > >
> >> =C2=A0> > > > sun8i-ths is not GPADC at all.
> >> =C2=A0> > > >
> >> =C2=A0> > > > The latest SoC I know that use GPADC as thermal sensor i=
s A33.
> >> =C2=A0> > >
> >> =C2=A0> > > It's not called the same way, but it definitely is an evol=
ution of the
> >> =C2=A0> > > same controller. There's no need for a new driver, only re=
working what
> >> =C2=A0> > > is already there.
> >> =C2=A0> >
> >> =C2=A0> > I don't think so -- here's some evidence:
> >>
> >> =C2=A0But the H3 THS have many new IRQs, functions, different sampling
> >> =C2=A0rate set method and a quite different register layout.
> >>
> >> =C2=A0Doing this in GPADC driver is possible but meaningless.
> >>
> >> =C2=A0> >
> >> =C2=A0> > 1. The old GPADC do not have module clock.
> >> =C2=A0>
> >> =C2=A0> The A33 could use a PLL.
> >>
> >> =C2=A0But it's a dedicated mod clk on new generation THS.
> >
> > And all of this really are evolutions. The block is still driven in
> > the exact same way. And this is where there is value in having the
> > same driver: you share the logic, which is mostly common, instead of
> > duplicating it.
>=20
> After some thinking, I can accept a common driver for A23/A33 thermal
> sensor and H3/A64/H5 ones, but I cannot accept use iio-sun4i-gpadc
> driver for it, as now H3/A64/H5 thermal sensors are not just an ADC --
> they features hardware alarm levels, and in some SoC it become a
> multiple channel thermal sensor.

The A23 and A33 is trivial to support on the already existing GPADC
driver. If you have it already working on the A33, then the amount of
work for your driver to support the A33, or for the GPADC to support
the newer SoC is strictly the same.

Except in one case, we have a common, debugged, already reviewed and
already merged driver. In the other case, we have no such things.

> I will insist on doing a dedicated driver for it, or if you like, I can a=
dd
> A23/A33 support to this driver. (Considering no one have already posted
> any patches for A23/A33 thermal sensor, except my old ones, so my
> work at least won't conflict with anything merged)

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474821.=
html

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--mzgialstztho4mk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYwWY8AAoJEBx+YmzsjxAgoMYP/0N81x3wd/RApEmTKcpQG0fx
M5MxuU+zNjDgXkl1jQWTnKAgcGi8VxhEKvhA5jHn4FPvAmpoDmc1KNYXYXxs15Le
tdiVFpejcjp0UT+Wi8Jd29KEOGcey6fwLkiYSMsop5t/6KrNEySooffMD9LRvHoy
B34EZ0xb7XZt4ZH4lZ4+hfCW7O6SDECr3/IUMEZrX8CVj2myfQdGQQRHnnOwgxTw
if/CqxdSSepfEZcWTbwrrytbqPl1BcpIikUgBUOUvQbg9EPL3M+GloB+/bNvmCNc
Xc/aOl35wg+grLeaFPLg3GqnqwwHxZ+bSwo/qlmdF1BSZehYtmfO0Ot7vVXHDqJA
pbDxlByQDI9Pjl5AmKstLF/bsWn5NaYJ/hl8CGCpg1w880sgHXql7Cs3WpHXbLYw
wJN41Yg5IUWvWgUCSiQYwjxgbwGPzU1IX90TH1I/R5ypZE/95OLwcn/FFyeA9aUG
kCLQJYrt73XiCxlGo34wZqtb5Q2+zU3sqIGcn+2OasWORQS+Tev1FH0MHwGnZu00
xz0V85r9AKCbnz/HTijpmBjw/VMspfsnXq1SpYVbVWXOuIEdvHRPJAHPcDfy7csq
FVdR+wyrMCEqRdEe0a4igiggCYt5vA7IqghqkgdA/dP/106Z2173l9ou32p+eKnP
lWlw9UBUXOxMhbuNGj3o
=6Mot
-----END PGP SIGNATURE-----

--mzgialstztho4mk3--


--===============7681161870769237948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7681161870769237948==--
