From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Date: Mon, 27 Aug 2018 17:11:40 +0200
Message-ID: <20180827151140.luysp2kfbcq6patg@flea>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zo6ztequdzzl7s7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, moderated list:A
List-Id: linux-pm@vger.kernel.org


--zo6ztequdzzl7s7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 10:35:23AM -0500, Rob Herring wrote:
> On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> =
wrote:
> >
> > Hi Maxime,
> >
> > On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> > > Hi Georgi,
> > >
> > > On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> > >>> There is also a patch series from Maxime Ripard that's addressing t=
he
> > >>> same general area. See "dt-bindings: Add a dma-parent property". We
> > >>> don't need multiple ways to address describing the device to memory
> > >>> paths, so you all had better work out a common solution.
> > >>
> > >> Looks like this fits exactly into the interconnect API concept. I see
> > >> MBUS as interconnect provider and display/camera as consumers, that
> > >> report their bandwidth needs. I am also planning to add support for
> > >> priority.
> > >
> > > Thanks for working on this. After looking at your serie, the one thing
> > > I'm a bit uncertain about (and the most important one to us) is how we
> > > would be able to tell through which interconnect the DMA are done.
> > >
> > > This is important to us since our topology is actually quite simple as
> > > you've seen, but the RAM is not mapped on that bus and on the CPU's,
> > > so we need to apply an offset to each buffer being DMA'd.
> >
> > Ok, i see - your problem is not about bandwidth scaling but about using
> > different memory ranges by the driver to access the same location. So
> > this is not really the same and your problem is different. Also the
> > interconnect bindings are describing a path and endpoints. However i am
> > open to any ideas.
>=20
> It may be different things you need, but both are related to the path
> between a bus master and memory. We can't have each 'problem'
> described in a different way. Well, we could as long as each platform
> has different problems, but that's unlikely.
>=20
> It could turn out that the only commonality is property naming
> convention, but that's still better than 2 independent solutions.

Yeah, I really don't think the two issues are unrelated. Can we maybe
have a particular interconnect-names value to mark the interconnect
being used to perform DMA?

> I know you each want to just fix your issues, but the fact that DT
> doesn't model the DMA side of the bus structure has been an issue at
> least since the start of DT on ARM. Either we should address this in a
> flexible way or we can just continue to manage without. So I'm not
> inclined to take something that only addresses one SoC family.

I'd really like to have it addressed. We're getting bit by this, and
the hacks we have don't work well anymore.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zo6ztequdzzl7s7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluEFKsACgkQ0rTAlCFN
r3Q3rw/9GTXP9K0EFEOmC0zlMe8iH8k32ZPazjghmW/LNDnXa8mr6DPdF4Sn8Xt6
+Y0CoX89XgLR96H9SVhUOVJjTNn14//azdje3vBe+LmMuwTQHsYgqbwtSIF17CUk
TYNiPOPlQ0HNj0WG3PMVFaji5saN2IRQIdoP7FffszPJrHCJrOx421ea9m9f//QN
b38J09/uo9hOLVkzH1ufQR5kQsZUzIOW9X2NspgGK8ZHkms88+DKxliOe/qbqbQT
iC9/XwhpSgxzqtyjbdp5kiwWtjRmkAbmf3EmH09siPhWBGWFPZ+lAkCmH2hTPv+d
/R1jtcfLNFD4XZWdcNsqO5ng8dPJRcSwljzM/Q8CEDd+FpZuFudWjDisYHF6WecP
NbirwCBzQqe32iABFKW6+jdhJts/Xp5wQieuJmhsgE8MzM7o7tJNhb3sml5VTARW
BRZRzlcq4qftUZ7LZ0sjAGVKJs1oUNzUPgc7gB8MgqPrhEDWji2B6oHm55sNJ/y3
Kh2sVdz8dFlFcHu/fc/AiUP8bVppUK/jzzWerKCYD0XJrDKXRo6lbjh7Hm02/fq7
L/ofWv+mLPLSli+B/V7KT7SYzggqVGGHVAXHVs8F0NpSInWmYVitTlbl5uWqW9fc
AOwCLMrF9god3vYhRItTWyCDgo5F/4rr2e0NeLSAgn363M8BB5s=
=qybd
-----END PGP SIGNATURE-----

--zo6ztequdzzl7s7j--
