From: Mark Brown <broonie@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 02/10] regulator: add support for SY8106A
 regulator
Date: Mon, 24 Jul 2017 16:03:44 +0100
Message-ID: <20170724150344.4zq6md7eidxzikot@sirena.org.uk>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-3-icenowy@aosc.io>
 <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5gqoojor2ovbyeh"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Ondrej Jirman <megous@megous.com>, Carlo Caione <carlo@caione.org>
List-Id: linux-pm@vger.kernel.org


--a5gqoojor2ovbyeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2017 at 11:03:24AM +0800, Chen-Yu Tsai wrote:
> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > SY8106A is an I2C attached single output regulator made by Silergy Corp,
> > which is used on several Allwinner H3/H5 SBCs to control the power
> > supply of the ARM cores.
> >
> > Add a driver for it.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--a5gqoojor2ovbyeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll2DE8ACgkQJNaLcl1U
h9C7VQf/b2DahQnbjczBxvmBFmwk1A8Le9WlFIQQJYSR21dEV+dDRZQlZwlM3MFK
afh47eY0s2UqyXAdV2ttiq+SC6jt5IBYapAGHwIek4NZuUYX8swdyb1rSFRHd4Ca
W+jQl1myU6TjYdJHM8daAxcWRRtDL3A9R03gyZgKyuqfUOBwf7R40zm46NIUTaQ8
oHNnMP7ZkB8U0adyXD5r0pl/Iflt9ONzvzUQs4t33FJcwhIY7/vV6BNmHT4814D4
t/j2Vs5Z5kVuN+R954Z9ibt4aM+lIOrEyMYzUS1vBP/AIY6QrXJFKnr4jeu00u4M
c/cIHZgtIUuTFp2uN7D4i5PrCS4Feg==
=NI9S
-----END PGP SIGNATURE-----

--a5gqoojor2ovbyeh--
