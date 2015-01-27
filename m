From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Tue, 27 Jan 2015 00:16:29 +0000
Message-ID: <20150127001629.GP21293@sirena.org.uk>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe>
 <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qx/Zgj6HpoLOE58Z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35319 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbA0ARR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 19:17:17 -0500
Content-Disposition: inline
In-Reply-To: <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sebastian Reichel <sre@kernel.org>, Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, Sascha Hauer <kernel@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org


--Qx/Zgj6HpoLOE58Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 08:46:45PM +0100, Stefan Wahren wrote:

> > > Does a common property name exists for the switching frequency or wou=
ld
> > > it be vendor specific?

> > As far as I know most regulators have fixed switching frequencies,
> > so there is no common property name so far. I added regulator
> > framework people, since this property should be regulator specific.

No, it's pretty common for there to be a couple of options - there's
normally a performance tradeoff (power for regulation accuracy and/or
cost) which can be selected.  IIRC it's selected at design time as it
affect the choice of passives on the board.

> okay i understand. But doesn't it need a extra driver to set the switching
> frequency because of the new compatible string?

I don't understand this bit at all, sorry.

>=20
> At this point i think about moving this feature into the bootloader.
>=20
> @Fabio, @Marek:
>=20
> What's your opinion about that?
>=20
> >
> > -- Sebastian
>=20
> Stefan
>=20

--Qx/Zgj6HpoLOE58Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxtjcAAoJECTWi3JdVIfQXYQH/0a/jSZNYPLcM4QNROz8kRyy
KRorHdPmVmRAcoCvlXWL8ambIsWto/p1VsUacm8ZqFCIBfCtRLAkKWljty5N0JUV
D3IE0/vtqwLChmeC8BdouU1/flwRtYKoP5y6zbwt10qhIgBH/IyzLhMx7S5noZcR
XvkN4BqkG04k/F5rekTAbMg42F9Ea1HPaXbX5SKAHlTj5v0j6UPkev5hUscyYUiA
TUDQ4f4CwNWgBtaI+ARLfL5gaMmxrIvrHX662qGviOT+hadFmn9/VEBPYAs1SKCK
9V25dUpgbTte4PXLVnJLpb/xIwKDG5uNWHwiORC9MmmogxIpudS9EUQOXLn9DSg=
=Y1Y2
-----END PGP SIGNATURE-----

--Qx/Zgj6HpoLOE58Z--
