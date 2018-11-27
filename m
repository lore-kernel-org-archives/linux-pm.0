From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 10/14] regulator: dts: set proper lradc vref on OLinuXino
 Lime2
Date: Tue, 27 Nov 2018 10:47:30 +0100
Message-ID: <20181127094730.dewrb5ri6uyebl2e@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
 <20181127093735.amfqfcsxzreajte4@flea>
 <CAGb2v66odUU9OOwon4URR-+P_jFw2rV+8PLVzrnLmFpKtqT8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hldriuc2m2xqr5kq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66odUU9OOwon4URR-+P_jFw2rV+8PLVzrnLmFpKtqT8gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Priit Laes <plaes@plaes.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Oliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--hldriuc2m2xqr5kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 05:41:10PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 5:37 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Mon, Nov 26, 2018 at 05:27:51PM +0200, Priit Laes wrote:
> > > From: Olliver Schinagl <oliver@schinagl.nl>
> > >
> > > The lradc's analog reference voltage is set to 3.0 volt in the
> > > hardware. This is more or less set in copper for at least lradc0. Set=
 the
> > > property in the dts to ensure the lradc is referenced properly.
> > >
> > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> >
> > I'm not sure why that patch is part of this series, but I applied
> > it. Thanks!
>=20
> Please help fix up the subject. Should read
>=20
> "ARM: dts: sun7i: set proper lradc vref on OLinuXino Lime2"
>=20
> or
>=20
> "ARM: dts: sun7i: olinoxino-lime2: set proper lradc vref"

Yes, I've noticed it while applying, and this is already fixed :)

Thanks for the reminder!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hldriuc2m2xqr5kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0SsgAKCRDj7w1vZxhR
xXITAQDbWa/mzPFfiJALRj6XfjXQSresZPgzPppLQh2uz7waawD/QmzIbaTdQJch
HKeJlhuKNx1wUUNTe7mPbqun+NcIVwY=
=GjQp
-----END PGP SIGNATURE-----

--hldriuc2m2xqr5kq--
