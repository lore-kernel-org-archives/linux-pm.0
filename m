From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Date: Mon, 20 Aug 2018 17:32:07 +0200
Message-ID: <20180820153207.xx5outviph7ec76p@flea>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nsqsqzl6ecisbpih"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.ke
List-Id: linux-pm@vger.kernel.org


--nsqsqzl6ecisbpih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Georgi,

On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> > There is also a patch series from Maxime Ripard that's addressing the
> > same general area. See "dt-bindings: Add a dma-parent property". We
> > don't need multiple ways to address describing the device to memory
> > paths, so you all had better work out a common solution.
>=20
> Looks like this fits exactly into the interconnect API concept. I see
> MBUS as interconnect provider and display/camera as consumers, that
> report their bandwidth needs. I am also planning to add support for
> priority.

Thanks for working on this. After looking at your serie, the one thing
I'm a bit uncertain about (and the most important one to us) is how we
would be able to tell through which interconnect the DMA are done.

This is important to us since our topology is actually quite simple as
you've seen, but the RAM is not mapped on that bus and on the CPU's,
so we need to apply an offset to each buffer being DMA'd.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nsqsqzl6ecisbpih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt63vYACgkQ0rTAlCFN
r3TtAw//anYGPzaYAXU2DfIhIP1WNOqjhKjLIXnfx3R/tY+yQzvEmnSGYUWRcwGD
WHtoOg6GYW1mUWWjyq6RFJeTbeBjLTcz2Lm7rYP/Oq78lCBUHO8jPWj/Ry10NuN/
sM4emc7NyLJ4ZHzqLOIUXb5HEay6rN1pCbDKnTPM4eQf0Fewt2guDzr4lv9iCsYY
NL6Xeval9Y/RhEJsaNcgYheMloheJAjmM3zo6CSjItA+PgRaaXI1wGCfLn8ilXty
niTfLSVeJfVOVZ+WTfdUjhmWZ8mkt/jMvka39qLCI8njsvxLz/chwDkUAIIvHCmA
qxvGhRbbLK6gzlW9ccE98bilvB/BcGEqq5SIZ+Uuu5CoO7vzqYbiXSqM4IUZJRCx
VP5C+JXbT0fY6mn9OyvwGCeQ6TTbHPtFHiu7DSEfLg0eK6z9gobOVXWBqUO5o7Iz
t9YyiwH2mU8uVRbhma4BjYghLoaE5v8O/QSNeEM6EyNqRYy0LdWJf4xOCt2szbGX
xI3LYYe8lryCzfyQ9F+D0Rs7SI99KY7TYXEvl33YlszjWb5b8Qrb/YwnnlOybF84
MvyXb8ru1Ku5ZUdn6VEXGqiR0MH9hFHq4aKyBQZQ/5gtxAHelt3zTvq+FMPjjyBa
hdTlTFP/57Sc4s2OOFG/X+kpjrXaoohKoLFvUYMFx9tK9Y61Ook=
=4UZ2
-----END PGP SIGNATURE-----

--nsqsqzl6ecisbpih--
