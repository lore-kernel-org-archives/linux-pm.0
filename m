From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/6] BQ24190 charger fixes
Date: Tue, 17 Jan 2017 04:26:46 +0100
Message-ID: <20170117032646.lf7hfrjsektfsxpk@earth>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rpdvajlutwckbblv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdAQD0w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Jan 2017 22:26:52 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>


--rpdvajlutwckbblv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 16, 2017 at 06:28:28PM -0800, Liam Breck wrote:
> These are misc fixes, tested on a custom OMAP3 board.
>=20
> Changes in v3
>=20
> #1 fixes figure ID to 37
> #5 fixes line over 80 chars
> #* adds Acked-by Tony & Mark

You forgot to fix the whitespace issues Mark mentioned, also
please use "git send-mail" or make sure, that your patchset
is threaded (patch 1-6 are replies to "patch" 0) and the
actual patch is inline and can be applied using "git am"
(which currently complains).

-- Sebastian

--rpdvajlutwckbblv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9jvMACgkQ2O7X88g7
+po4Aw//fr6aKQ6beHLGf9aoLjaawDNrMeGrZOJcT9PcZTV9aVJTw1sWNsETW487
vC8PSYA05lw6gyWRW6AuMJCFO1GsUhQYg69gwMQKzPIGBYhhoMKDeiBeKXKgBcLq
s/qfrleK7GsRxL1awTBJt1/v4wAfYzyvloT6Pbbxhju0uRQ6cn7S46aoLpxTAC/D
c1x4PfV8X2uickakGXPXTpQGifJp3HKsAdbW+/N71RWR8wK1gpMg5LWfK+QIk4fH
b/g9NmgNpBWJrku39ZXNQ4Akgd/Ke3uBQgyFfLOWFUG64eNdsCtWANtiVi7Ea6+0
Um6N7nQ3BeC0/vEP6IkOBmLU0D1oONKXStPb5ihk1Q8kdrDPr2WddOuScMtefhX/
vKVMt6GYCJX70Jm7dsY1JAHeg23CO/Wja1Eqs+ryGzbF921IYW+6Ujv8XsbH0FSD
TiZRaqEPE2SBuzbR1UXFz/DuTbGCm5WI6KLvb2EZI7I72soE3Z3xnq+JmQ4hvqCE
w1U6zfYG9X5bpXXrhSgeI8b7yadhD7tqp7BjZvrsAbdtP1/E/MarEkZcB9L95MEx
bdutHfDeQ/2TOnGgLFjHNSv4k82eIuohxJV+9PIb+lN892KCCHmk2KEZg6chAvjb
FgZFMTq0p1tM7/oFuDKNsI2aNR/cf+cHNZ2mbZeqqRDWFZbkqZE=
=HZ97
-----END PGP SIGNATURE-----

--rpdvajlutwckbblv--
