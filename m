From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 12:54:22 +0100
Message-ID: <20150513115422.GQ3066@sirena.org.uk>
References: <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com>
 <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum>
 <5552510B.9010306@ti.com>
 <20150512194134.GC3066@sirena.org.uk>
 <55525B29.2080307@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3LbzE+0aVzOo6fIw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37022 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933431AbbEMMQt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 08:16:49 -0400
Content-Disposition: inline
In-Reply-To: <55525B29.2080307@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>


--3LbzE+0aVzOo6fIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 02:57:29PM -0500, Nishanth Menon wrote:
> On 05/12/2015 02:41 PM, Mark Brown wrote:
> > On Tue, May 12, 2015 at 02:14:19PM -0500, Nishanth Menon wrote:

> > specifying the currents involved.  For plausible applications these are
> > likely to be ballpark figures rather than anything too accurate - if
> > nothing else the instantaneous current draw normally varies very
> > substantially so realistically you're talking about a maximum here.  If
> > the corners vary that dramatically then I'd expect you'd see different
> > OPP tables being used anyway.

> OK - If we state "worst case", then it is quantifiable (if SoC vendors
> would like to expose such information - I doubt mine ever will ;) ).
> - We might be able to quantify it better by stating worst case(under
> maximum load) steady state current (to avoid including transient
> spikes which are never representative) at ambient temperature(25C).

Qualcomm do.  It kind of depends on the system how worst case it needs
to be - it'll depend on the expected performance of both the system and
potentially the regulator.  For some systems it may be important to have
some accounting for transients.  Equally systems would only need to be
as accurate as the underlying hardware was able to make use of.

--3LbzE+0aVzOo6fIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUztlAAoJECTWi3JdVIfQPAUIAIa933ncmQS3N2im+3J+GvAC
q6muam43R0GNGKPuawNxgfO5ia2J+a4cuw2H8prpXn+/IcSxL5X+i+je0/DzPOLC
YNigdKMBW2xrWpwnZl9TozaPzDPiQXVLry1AmnT6Oe6goxyyIREcOx5xHCHsVL64
fz8evh/nB5Jm1jjiSgb1g/eXUhoKZELFJ/51qHYh5gK8P5xIzSpuAHV0VW8hxb/e
NlS2Zq2VSrG1S4aNQApMLB/g8kiFfBUlCxmG2OaX4+QhJP8oC22Om4DpQt2nvvCZ
H+gL9KnpURlF4M6kC+MIIiqwqwnWOWuWKQmHkSB6cBmM8dYjd+CZSLEB/fVna9g=
=bYf2
-----END PGP SIGNATURE-----

--3LbzE+0aVzOo6fIw--
