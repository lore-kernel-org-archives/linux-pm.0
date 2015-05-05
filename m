From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 5 May 2015 11:57:14 +0100
Message-ID: <20150505105714.GA22845@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9MumfqHRHGxgklkB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50841 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbEEK5f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 06:57:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh


--9MumfqHRHGxgklkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 04:18:59PM +0530, Viresh Kumar wrote:
> On 4 May 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:

> >> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
> >> +  regulators.
> >> +
> >> +  A single regulator's current is specified with an array of size one or three.
> >> +  Single entry is for target current and three entries are for <target min max>
> >> +  currents.

> > What is this for - are you trying to define OPPs for current regulators?
> > If you are that's worrying, I can't think of a sensible use case.  If
> > that's not what's happening then the binding needs to be more specific
> > about what this is supposed to mean.

> Its another property of the same voltage regulator we are using in
> opp-microvolt.
> I hope that makes sense ?

No, it doesn't - you're not answering the question about what this is
for.

> But, perhaps I need to write it with more clarity? Or this field doesn't make
> sense ?

To know if this makes sense I need to know what you beleive "setting the
current" does.  If you literally mean setting the current it makes no
sense at all.  If you mean something else that something else should
probably be written into the binding.

--9MumfqHRHGxgklkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSKIJAAoJECTWi3JdVIfQdw0H/3bfWn84ToOCquYyePh3CfWw
IjmSAk769j49AzLcqgU+zBXzjGT6asQ3Pz7NBF6Gbl4tqq1n5581SHyLB40AqdGl
2A9Dym7eBCx4BGEPq0MZ7jcdu5cbpA/9aqsz3KRVcgfpbJnfN1c+WckYCLcbMV6z
+OnZRIuzxOr+HLIu6zq7RirdMWLGNhoV4ejCEseOGvxBXDQyQP6LEHATU0UvgQ9P
1IAGzBYjt9QPnwgyUpKXiCJCk4xRWfOJv4d1r7zWk3/ZMu2R5iT8iFnNacEhhr0F
Up3q6q4nE6W9WeV0FYBNd7J3WRdTXrFu0zUWvNl3wXCrXjU0HO74UouQZn3RA6w=
=uUx5
-----END PGP SIGNATURE-----

--9MumfqHRHGxgklkB--
