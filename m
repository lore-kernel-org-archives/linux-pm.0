From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
Date: Wed, 8 Jun 2016 06:59:19 +0200
Message-ID: <20160608045919.GA28205@earth>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com>
 <20160603023853.GD8921@earth>
 <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
 <20160607015017.GA25073@earth>
 <CAMsMSK9X2ME=nyBhD4q8MvdYrqe7h+SmVstD++1OfBn-uvuSHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59946 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbcFHE7Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jun 2016 00:59:25 -0400
Content-Disposition: inline
In-Reply-To: <CAMsMSK9X2ME=nyBhD4q8MvdYrqe7h+SmVstD++1OfBn-uvuSHA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Brand <chris.brand@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2016 at 12:40:41PM -0700, Chris Brand wrote:
> On Mon, Jun 6, 2016 at 6:50 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Mon, Jun 06, 2016 at 09:42:03AM -0700, Chris Brand wrote:
> >> On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wro=
te:
> >> > Feel free to queue it via arm-soc with
> >> >
> >> > Acked-By: Sebastian Reichel <sre@kernel.org>
> >> >
> >> > If I didn't overlook it, it's missing DT documentation, though.
> >>
> >> Thanks, Sebastian. Because this is effectively a move of code from
> >> arch/arm rather than new code, there's already dt documentation in
> >> Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt
> >
> > Ok. That directory is usually used for periphal reset controller.
> > Board/System reset controllers are usually documented in
> > .../bindings/power/reset (following kernel strucuture
> > [drivers/reset and drivers/power/reset]).
> >
> > -- Sebastian
>=20
> Would you like me to send a separate patch to move that file ?

That would nice, thanks!

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXV6YkAAoJENju1/PIO/qa36AP/iGzBYlG9IuGGWLKf3x62XOe
DfQLTQq28tN1d+/b/BPPMD2podIhCMzRG7dum1rXnu6QveXJFVUQya61myW8f+Pm
iYx/1XRrEfFHAearAtNCcQYiW3Qiv4Sxv6HOCKR3uumO4nVVSOkLA740J7VCq6FD
9vd90tmCPXXvJ5qWrfRntT91bVz5k2e8Fn7tO0q//TZ4AhMJ740Mynem8DAkpPdH
AGBnYPDD2QkhrO8UVvp5CxoJxxq4R08OcfzKoP+WNzeqJee9n5e4SoLJU8AMFzRZ
sG7j7BGG14+v6ZgjpRnbLkd6N18h7F+eAtwZUtBHC5aFKiqIGKd8TUfNhh/Tspnk
x5r9GkKm7kw7N27gQTLaiUydmpbjoe4A/TDEPfBN1RdLdLkFDRuRYlWB0LvaRXEE
54Xce+fEMBKtbcYAGSzVBCxAs09NxSi59aq5r1rZfY/8Y9+yRZ5QLUugys9QlQK9
NOKhN/x+DcqbAo0+LJQ/to+FG6HpotslozJ4u25S2Di6QFmHNWBTy9zHN32/aWpo
jrxlYvYcr0KT5xxU4TUSJBmXXzRaKyZItI1spTetq+Ws9K9gjK7iJL7dANVT01mL
VD6pbKKFmxf4CBsBQTCYQ9TortAkB+dZ7y6F7yKCCy5v49j5N+u4fyGiLQqgFZvA
gKmH4iTZ3vqlirqxWSXG
=KnyX
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
