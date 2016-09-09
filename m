From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies
 tracking support
Date: Fri, 9 Sep 2016 13:06:21 +0100
Message-ID: <20160909120621.GP27946@sirena.org.uk>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <2169291.li0uc2Ryoq@vostro.rjw.lan>
 <CAPDyKFpTeB8MLXihpTnyk9RerVC_PNp8ogXG6aATLT2xLkp9mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sj9mcRtP+pTWLOo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55444 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbcIIMGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 08:06:38 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpTeB8MLXihpTnyk9RerVC_PNp8ogXG6aATLT2xLkp9mA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>


--6sj9mcRtP+pTWLOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2016 at 10:25:30AM +0200, Ulf Hansson wrote:

> BTW, as I am mostly working on DT based platforms, I guess we would
> later on need to discuss with the DT maintainers how to describe
> device links.

I think the expectation had been that since DT tends to get right down
to the hardware details we already have the information in there in
order to use things so the problem becomes figuring out how/when we
parse the existing bindings to tell the driver core about links.

--6sj9mcRtP+pTWLOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX0qW8AAoJECTWi3JdVIfQCB4H/205aTmMSFyYcqbYn7zryO3f
VQ2l31JF/nP0UDxu36Uc5fCaePbR0117R4KcGCKjFXSAnA9JnjeEFf9huJGgxGnr
aVMzF7bFHBmKNu6eeaAyHFxF4HowypRhUx2zv3G1F1BK6ajbHSN/V6xdsUGN/kRB
icUSxibweTv/K2gyxcm5B8L5gi7QAaRZngTze3a4KXdNg9rVSaMoRCe2S7Gh6/it
WssElDLioJjmdounj9B7pvaJC/eL3XYLMN/skSpfvVFGuVOqN7rT1kUqkgUbk+OB
gxg1117E1D2v2YLUF8EFvdsGzpjqVk2/8HM13BMu2+CtsSEg3s/KCQD/SBs37nk=
=vm0d
-----END PGP SIGNATURE-----

--6sj9mcRtP+pTWLOo--
