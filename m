From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 17:21:27 +0100
Message-ID: <20150513162127.GA2761@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com>
 <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com>
 <20150513050559.GE28858@linux>
 <55536719.5050208@ti.com>
 <20150513151652.GX2761@sirena.org.uk>
 <5553784F.7040905@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HwY7O+GdaLKMYOv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37864 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbEMQVx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 12:21:53 -0400
Content-Disposition: inline
In-Reply-To: <5553784F.7040905@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


--+HwY7O+GdaLKMYOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 11:14:07AM -0500, Nishanth Menon wrote:

> To illustrate: What does it mean for a driver using regulator API?
> Attempt X <-> (X+Y), if that fails (example PMIC SMPS max < X), try
> (X-Y)<->(X)? If yes, then we do expect (X-Y)<->(X+Y) should be stable
> for all operating conditions for the device, correct? If this is is
> not stable at (X-Y), then we have a wrong specification for the device
> for claiming X +/- Y is a valid range for the device.

We have an explicit regulator API call for setting by tolerance which
tries to get as close as possible to the target voltage (currently the
implementation is very cheap and nasty but ideally it'll get improved).

--+HwY7O+GdaLKMYOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU3oGAAoJECTWi3JdVIfQylYH/j77uIhdjTiWG7XH3bQhVqVm
MPkVPd30XdbWM4BBcqKEAV+CUzt4DU/j8VWIwOFwLIkmK+QLfHtUf1vIhc6/uTq1
PX4TKtfYuM/Jox1OfGspfmp7Z+gA2RHEdFzTlfSJ7CLCY7gK3s1F3PqRSp1cDoXb
yLrba+x7G4LuE9BwuGvwO4P30lWKxSkQk4sNCcXJ0CtzfeeN3a33u+W41JpPhGO0
BTMNU25LA9+MkHqvn3bXHSl35kweJf4iHfJugEOiVptUh3fxdAu4ULE+0upZvkc8
a0xfnbEoE3blpNImPWFSGZdVrxiTzo5SS8eTO2hGpCFTksd5R2DLBCaO9B8B6LI=
=W9G9
-----END PGP SIGNATURE-----

--+HwY7O+GdaLKMYOv--
