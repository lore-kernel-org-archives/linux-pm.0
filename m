From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Fri, 23 Oct 2015 01:30:52 +0900
Message-ID: <20151022163052.GW8232@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RMorpr61ug7CvG36"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org


--RMorpr61ug7CvG36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 05:31:57PM +0530, Viresh Kumar wrote:

> +- supply-names: This is a required property, only if multiple supplies are
> +  available for the device. Otherwise it is optional.
> +
> +  This list is used to pass names of all the device supplies. The order of names
> +  present here is important, as that should match the order in which values are
> +  present in 'opp-microvolt' and 'opp-microamp' properties.

If we were going to add something like this (which I'm really not that
thrilled about due to their encouragement of bad practice as previously
discussed) it seems wrong to add it at the level of a specific binding
rather than as a general facility.  I think I'm not entirely sold on
this use case though, I'll follow up to a later message in this
thread...

--RMorpr61ug7CvG36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKQ87AAoJECTWi3JdVIfQWe4H/RQDcctlBFVAi9U5euO3pHTv
ofFDIZ9GBKzFJH/QX2xElyvp5cfhJCA5b6x5uII/x/hRI4rtSqvKjSSEVmBrjqu6
Dvf+2stIM9bVyn50F4GgVp2yBamXP4FgIq/SyoU53jcLz8Lv9OupRDLvamcxLUao
vksK67PCALyKYTfGAuakpooryc3AARoy2Trw5HfqtdzKvkZ0y/dfthJrH/h7f3MV
RrabmJJ21+aCm/NMNUou5lNAG7gTmNXc9EqCdqNahO8Q5+G0uqHEg00tX6dMYKCZ
ELFLlvqTQyEvx61EX9cJQ6Ob7BWzOJBTnRcexv5BkF49AtC0kLWJNVWzmSfpwp4=
=hRCS
-----END PGP SIGNATURE-----

--RMorpr61ug7CvG36--
