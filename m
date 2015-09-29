From: Mark Brown <broonie@kernel.org>
Subject: Re: Voltage setting on chained regulators, how?
Date: Tue, 29 Sep 2015 16:00:17 +0100
Message-ID: <20150929150017.GR30445@sirena.org.uk>
References: <20150925090724.GH7858@pengutronix.de>
 <20150925164726.GI30445@sirena.org.uk>
 <20150929080044.GS7858@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="25AjPoXvrcQXrjmi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53885 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbI2PAZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 11:00:25 -0400
Content-Disposition: inline
In-Reply-To: <20150929080044.GS7858@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>


--25AjPoXvrcQXrjmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 10:00:44AM +0200, Sascha Hauer wrote:
> On Fri, Sep 25, 2015 at 09:47:26AM -0700, Mark Brown wrote:

> > I suspect you always want the LDO in there to clean the supply up, it's
> > just a more serious issue when more power is being drawn.

> I just had a look at the i.MX6 datasheets and saw that while it's
> possible to put the LDOs in bypass mode the expected lifetime of the SoC
> decreases without the LDOs. So it seems better to let them enabled and
> just make the voltage drop as small as possible.

Yeah, that sounds pretty standard.  It would be really good to get
support for minimising the voltage drop over the LDO, there are going to
be quite a few systems which could get a power consumption benefit from
dynamically tuning the voltages of DCDCs like this.

--25AjPoXvrcQXrjmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWCqeBAAoJECTWi3JdVIfQrA0H/RV2X4xFg20mPtDq+VBXGM1w
p4fLr42w6n2X66LVl+7f91X/Mi+B3Nf4M5F/vAMhFHSKBiahhCT66lT7L5QjTUkd
6AVUMl2GBkuzPEmGve9rtP2nOzWeB6GnfCDnW5VDyZKQ4e085zS059o3H3o3DRMQ
XSyrZiBjItdlR9JdUsin0JUzzMtho9dlM7MpKQQDAh8Yo9uiTaKEAfhJ/HwQVqjA
I0jhW0ZPfP52xI21YP03e/6BZISQvNVPU4Ucd5Mpfq9b8cG51gVi+uCufh5IktkD
WAOU4NDx9mXXOt09JawTK2lhoBjMiI4cePw2dE52uJsRUf/II+FTmn2jtbW/tF4=
=aD7d
-----END PGP SIGNATURE-----

--25AjPoXvrcQXrjmi--
