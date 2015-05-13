From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 16:16:52 +0100
Message-ID: <20150513151652.GX2761@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com>
 <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com>
 <20150513050559.GE28858@linux>
 <55536719.5050208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v6gilOcl2gU05R9Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37746 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344AbbEMPRM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 11:17:12 -0400
Content-Disposition: inline
In-Reply-To: <55536719.5050208@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


--v6gilOcl2gU05R9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 10:00:41AM -0500, Nishanth Menon wrote:

> What I dont see in the thread, and the point I raised here, why have
> nominal/typical voltage at all? min<->max should be sufficient,
> correct? If the device cannot function at min, then it should not be
> documented as part of valid range at all.

Going for the minimum specified voltage is asking for trouble with
regard to tolerances and so on, see also your concern about process
corners.  If the electrical engineers specify things as X +/- Y the
most conservative thing to do is to try to hit X rather than going
straight for the limits.

--v6gilOcl2gU05R9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU2rjAAoJECTWi3JdVIfQVT0H/jwEtVz9hfDkKV0igf1v3Z4p
pbIoes+V+zwfpswH+YZzIgqHwaUnUF5ZMcjXvfhO1yiENVCcOBSDvaYX4ScFaUr7
Dlkbw5UQ2eOKghY10CF6Pg02KLcyzAm/qnXInb2iV2e13QXdfhB73KHahwExrXjv
bnOy820KJirp8Bd32QQipJwEQwuMgp7hLWWRcdbag7Mu+5qYyyHQc8WCOLwfKDkI
+QaC5Hqiwy0gjzAT9pUayjRQbYzvLXMj+Frkr4VH/dBFScm+l1wyjbt0BVZ1ZpMD
fNGowVjj/opMLXQS01Gwy/i+W88I6hAI0TlO2f8vachBhOVJLtqsrotZ4qd9a9c=
=5CRW
-----END PGP SIGNATURE-----

--v6gilOcl2gU05R9Q--
