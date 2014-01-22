From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 11:42:32 +0000
Message-ID: <20140122114232.GB20247@sirena.org.uk>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57944 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367AbaAVLnP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 06:43:15 -0500
Content-Disposition: inline
In-Reply-To: <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>, Charl


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 01:31:48PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 21, 2014 at 11:16:46AM +0000, Vincent Guittot wrote:

> > > +       - psci-power-state
> > > +               Usage: Required if entry-method property value is set to
> > > +                      "psci".
> > > +               Value type: <u32>
> > > +               Definition: power_state parameter to pass to the PSCI
> > > +                           suspend call to enter the C-state.

> > Why psci has got a dedicated field and not vendor methods ? can't you
> > make that more generic ?

> If anyone provides me with an example usage why not, for now I know I
> need that parameter for PSCI, I can call it differently, define it for PSCI
> and leave it as optional for other methods.

Would it not be sensible to define a PSCI binding that extends this and
other bindings - ISTR some other properties getting scattered into
bindings for it?

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS366lAAoJELSic+t+oim96uMP/1hO0YCkYIwkhjx5IBzQ923D
ecuKxfHm65yRSoCJvCXvXJ2iRpmuQGocSn5wn7saq8xpgrmPIsyNMlwubt4F4elD
l7HKamgEpa83CP4EYKYn9zUJRgohVYgQPfa8Pyv5it8LrTKGtbP2Didhwo6aYhZ+
rUzbIoYivy0pxPKA4+fIAAOPl4LuFoA5LZFmK0ng+vby+BMkTWSzMLddTXfueLuM
zC2xvW0KeZV12rEqB+hPvgbirz0TlcZRJ6IyvtJDxeZnBKO4YvI0i0/FlRx8WnBy
c4On+nNGsC1CIxrS4diVtfgh8a8s7RYXm16Pb9F23cIdNuyRmbWdjpPrqCNc9STT
rVa2nRnSYBb2YvgZB6MC+n6OKn4s5Zud5RSzQi0bBGwLu3paeBlEOPEgmBrMftD0
UcsTtw+hc+xd9fZP5NDR63HAjetZbVBDucCiN1xd3Npq3pj8xa4JlLUWbZXyPvGs
Q0V8RjU7cPVptcMIYUJ/DGVbLXhm/JGBydOCHyGbxCkWO6UQ4YgKNkPAkabt0NPz
1TJInawzq5XLqSynq21oq1177HGuc5M4ilE7VREivhXpgjVxPxn9K5IbpKj7cGKU
owmWKKC3RuyL1F687osjc/r063qrsUT4NHlw1MpGHP4bxXBeLZXsYR14gpaeSXy2
r2gmxNowV12TpxCW7M5+
=GJe1
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
