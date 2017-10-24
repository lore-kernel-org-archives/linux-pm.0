From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
Date: Tue, 24 Oct 2017 10:34:32 +0200
Message-ID: <20171024083432.j3xqepkvprbvg2p4@sirena.org.uk>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
 <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
 <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
 <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
 <CAMuHMdWnJwMk5DrnAQebKB23X2WJGPQ2m-0OX8-AC2QYguTQ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mz6i3b6at34h24x4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbdJXIeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2017 04:34:46 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWnJwMk5DrnAQebKB23X2WJGPQ2m-0OX8-AC2QYguTQ5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--mz6i3b6at34h24x4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2017 at 01:28:30PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 18, 2017 at 1:24 PM, Mark Brown <broonie@kernel.org> wrote:

> >> Hence you cannot enable wakeup mode while suspending, as the proper
> >> system suspend/resume procedure is:
> >>   1. Enable backup mode in the PMIC,
> >>   2. Switch ACC off (no-op as backup mode has been enabled),
> >>   3. Suspend to RAM (PSCI suspend) => system suspends,
> >>   4. Switch ACC on => system wakes up.
> >> If you would combine steps 1 and 3, you can no longer do step 2 in between.

> >> Yes, it's complicated :-(

> > I'm confused, I thought this was a physical switch but that's talking
> > about this as something software controlled (at least in step 2)?

> The ACC switch is a physical switch.
> Steps 1 and 3 are performed by software running on the board's SoC.
> Steps 2 and 4 are performed by the external user (human or remote board
> farm control hookup).

That's horrible.  There's still the question about potentially using the
existing wakeup file to manage if the device is a wakeup source but
otherwise I guess the only other thing that'd make sense would be just
having a property in the DT.

--mz6i3b6at34h24x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnu+xcACgkQJNaLcl1U
h9D1lAf+I4hTwsFZI5IG+E3xe7XPLek8QNAOlBLzwp5/GZHnmQo+ZuMqCdNBrkbg
i4roSkcOswqsXDkX/IGA+Fmc07DSEzS3wDdHNl/w/JbpAkn526RvumTeaKuOXhBs
9dBh0Oar8RQfY8ow4C+zJ0QPp8HKLFu0aP3GTDfjGc0VJg3yB14v727+utOuB5Z/
P/EqjPVnYUZCJ5pqqfrhA2u+RlsuukFOhlPNB+G9SqMuEyq5AxR4TkIeGrZwgsu+
SUC0GeiTloDLQPOjJs8TqAxCuzLnRuR0l9USEGaVf8ZG3Snh7buihUBgg/t5SSGi
5FP/mvdmjZ8U4htv6jawKr2crCzQLg==
=4SeF
-----END PGP SIGNATURE-----

--mz6i3b6at34h24x4--
