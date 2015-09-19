From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/16] PM / OPP: Add 'opp-microvolt-triplets' binding
Date: Sat, 19 Sep 2015 08:39:56 -0700
Message-ID: <20150919153956.GB30445@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <254dd353453a495bb0921fa23e430428484f36fa.1441972771.git.viresh.kumar@linaro.org>
 <55F72E65.6000205@kernel.org>
 <20150915033027.GJ32551@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150915033027.GJ32551@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 09:00:27AM +0530, Viresh Kumar wrote:

> [+Cc Mark, I thought I cc'd him earlier, but no, I cc'd him only for
> the first patch]

I'm reading this on a plane so have no other context and to be honest
I'm struggling to understand what is being discussed here.  It would be
really helpful if you were to describe in words what proposed bindings
are intended to do as well as presenting examples, the examples by
themselves require the reader to reverse engineer what the semantics are
intended to be.

> But if we can define something like:

> supply0: regulator@f8000000 {
>         regulator-cells or microvolt-cells = 1 or 3;
>         ...
> }

As far as I can tell this is proposing adding something to the regulator
binding specifying if users must present either a single value or a
min/target/max triplet.  This is obviously problematic since regulators
can be shared - the needs of one user may not match the needs of another
user, and of course most users should not be specifying voltages at all
in the device tree in the first place.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YHLAAoJECTWi3JdVIfQOBUH/1cZY0IKlsHJ3WdHQ1y06Onn
xBBnmjp+EDrGPng7m9Lf6Y4dh0+8vKIPMDdsNnKQA53s6P688w1eu25fKpP7sbMZ
y6M2P9pmy7aQ4XI66XPufzjYK+EeATUzXMfwDbHrACBBnRmqTuedpb5s6HwvxMJ/
Lp+iaspSxisNVZjz8hPRzVomh3QXlUbgHJygbZnkd+wKb/5B6TqkZbgqvxxN8HwA
69rIbUMepEhxdHXmowTuiuIYDGhOQXTJVKn3BVTVju62wVQu8LXYKIy3NOmc85dh
uXTH/gxmceUY/T58aXGhZ6CGpKLSmygVJ2kwJfD2pS3yS4s9wpFUOXGKtgZh/vM=
=CCMY
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
