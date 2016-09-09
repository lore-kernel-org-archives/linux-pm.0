From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Fri, 9 Sep 2016 12:07:27 +0100
Message-ID: <20160909110727.GI27946@sirena.org.uk>
References: <cover.1470034830.git.baolin.wang@linaro.org>
 <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name>
 <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name>
 <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y4326l44.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vg>
List-Id: linux-pm@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2016 at 09:13:31AM +1000, NeilBrown wrote:

> Conceptually, the PHY is separate from the power manager and a solution
> which recognises that will be more universal.

The wm831x driver in the patch series is an example of such hardware -
it is purely a power manager, it has no USB PHY hardware at all.  It's a
current limiter intended to sit in line with the USB power lines to
ensure the system doesn't go over the maximum current draw (and also
integrates with the power source selection logic the chip has to pick
the best available power source for the system).

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX0pfuAAoJECTWi3JdVIfQ8IsH/2/t2QGomRX5QpPE5gTAbC8i
ZBlxh2v1IUt39/eBn4GHKelDnnhqXfg5CBtXJh2TduEDbZ1682cxKrp45oWWKTzw
cDwDkEpWraar2MqG6z8kt7brBdh41hmnpTqkHcOKpCcyK0lbIF5BbQVByx0wMwz+
BYD5xdw9mXkYTKkuUcFyH9vBkzSMHMR66XJWDLOqy9jsG0pvScYMFmwVpkyaz/tf
7zxFiIoBVTS1hhP9mY/xU1Ik7h1VuN55NwkhWQCFWmc5LgZf/rpi5hL3UhOHWCxD
ZU16CLN8+jeIjRGhsqEXmBC4RX1iFCY6g563a5P/SJck6ZzzJ0TI32Is+u44gWU=
=twcU
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
