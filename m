From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Thu, 10 Dec 2015 14:27:12 +0000
Message-ID: <20151210142712.GM5727@sirena.org.uk>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop>
 <566824AD.4080003@sonymobile.com>
 <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com>
 <566867F1.7000906@sonymobile.com>
 <20151209222044.GB32712@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4mwMARuvUPcmqDvg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41190 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbbLJO1h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 09:27:37 -0500
Content-Disposition: inline
In-Reply-To: <20151209222044.GB32712@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tim Bird <tim.bird@sonymobile.com>, Rob Herring <robh@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, =?iso-8859-1?Q?Andersson=2C_Bj=F6rn?= <Bjorn.Andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>


--4mwMARuvUPcmqDvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 11:20:45PM +0100, Sebastian Reichel wrote:
> On Wed, Dec 09, 2015 at 09:42:09AM -0800, Tim Bird wrote:

> > There are other switches in the charger block that are not
> > exposed yet.  This one handles the the OTG (vbus) charge pathway.
> > Others handle other charge pathways (some of which are used on phones
> > and some are not - they're used, e.g., on the dragonboard).  I'd
> > rather not give it a generic name, because eventually the driver
> > should expose those other switches as something as well.

> otg_regulator: regulator@0 { }
> other_regulator: regulator@1 { }

No, if this is a device with multiple regulators we have a standard way
of exposing that - have a regulators subnode with a collection of named
regulator subnodes in that.  There's support for parsing this in the
framework.

--4mwMARuvUPcmqDvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaYu/AAoJECTWi3JdVIfQcJIH/3iyiwMi/QHF0jc342SF1UI0
1g+ug8yi76eysy7VGgmsHNnmi1xT7DnK3FhWkCTmZiZ9r4IE24/94KrUv8ksd/E7
e/fl78RGKOmfeCtwnbKV8XAJpW8UAQNB3byMK4dUjJhGixQ5BSArsuYKPSVOE+/1
07zO8hQ95qeIe8tYXAiY9KBvPn+xjqRuFfqESJrH6gNGkDFB+toM6e6RuSeIoBBp
AUvE/nGcy6Sg30Kvb6pGNy2sgWhPuo+uTlrIitgIBTqZyA1P/IZ6FTjoWjai/3aA
wU0kzoF6gc7jYpxvX8UfXnQj8cArLc25k4OWqSLqjVKeZk/A01QA6Yx/F2BEnQc=
=VgqW
-----END PGP SIGNATURE-----

--4mwMARuvUPcmqDvg--
