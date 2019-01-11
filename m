From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Date: Fri, 11 Jan 2019 12:39:13 +0000
Message-ID: <20190111123913.GA2804@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 10:24:26AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 09.01.2019 18:57, Mark Brown wrote:

> > regulator state which feels fragile.  But based on the cover letter
> > that's kind of like what the initial proposal about target states was so
> > perhaps this is the way we end up going...=20

> Are you talking about [1] ?

I can't follow that link right now, I'm working offline.

> I can get rid of this patch, take advantage of [3] and [4] and introduce
> also the regulator standby states. In this case, no matter the mapping b/w
> Linux power saving modes and AT91 SoC's power saving modes, we will be
> covered on misconfiguration (at least on SAMA5D2 Xplained board).

> And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
> thing would be that in case of no input for regulator's state in
> mem/standby the board could not properly suspended/resumed), if any.

> What do you think about this?

Like I say I'm working offline so I can't check the links but it sounds
like you're saying that the existing suspend mode configuration features
are enough for your systems?  If so that's great - certainly what you're
saying above sounds sensible to me but it's possible I misunderstood
something based on not having the links.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw4jm4ACgkQJNaLcl1U
h9Ccswf+NULiFYb7x7jPouVeC7CIJLiKxHhaBH5KaCJsAITd15esv74wkfRHqf+A
sI52Sg6uJA4Cxt68zZz9EAMslHECb1wdMcgLfj1C1GKP0mjiF2IQmbG0jlAwbjLX
gt69eODFF9sWJs7FyCQsH605yavOv1jVYEPblgT9efgmJYZEm2FkVLDwUrGbI9rU
ARsLuXTfJ0t0RWOvYr/H81P76EJgE95+x0tD9KygwNWENzx/u5nRBpZJmSbB9x3h
C8HkW3ftkWZWU2KmgySOw0t+k7UM6/H8WmA0sUi/gHEocPtqIgPiu6BMOVqNwLuA
Yf+vPlQk2zChUP2bfLqcxwdtmXCkfg==
=uQKs
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
