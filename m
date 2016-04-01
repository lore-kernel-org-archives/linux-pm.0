From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Fri, 1 Apr 2016 07:16:43 -0700
Message-ID: <20160401141643.GX2350@sirena.org.uk>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160331170635.GH2350@sirena.org.uk>
 <87d1q9anpt.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FkhOn4hPPRcnTymj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35564 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbcDAORU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 10:17:20 -0400
Content-Disposition: inline
In-Reply-To: <87d1q9anpt.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>


--FkhOn4hPPRcnTymj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 08:43:10AM +0300, Felipe Balbi wrote:
> Mark Brown <broonie@kernel.org> writes:

> > IIRC Greg didn't want new classes?

> good point. Still, this doesn't seem to fit a but_type IMO.

It does in this new world order.  IIRC on an earlier round of review
there was some code that didn't use a bus but that got complaints that
it was trying to reimplement the bus functionality.

--FkhOn4hPPRcnTymj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/oFFAAoJECTWi3JdVIfQRfsH/1LJaJLnZAiiycpq+Amg/bph
reLxOFQBGadzW2eriOt+2RDSvpE9hv1VYO4j1JaUmennKTavq7usG5dISVAsYmZ9
OYyY4SMEU6UayfMfOOOH1VDl/N+S8aejWslqTWpHdxlEVMR+WQ7SAQbTOu67huJR
qklYgU4LrPkhg1rXEd6NlK4IC8jyTH3JrfUtZIQ3uoh2Olo1MYvLToawZ5ruWuUW
GkqQvae21EexPgeSmJlaT1kC2xebeo7cKZcpOtVVyG2qxVXaE855vuGQSGhX6LuX
np5M2cUAfR42fPkpsuTK8zJrqIPjLB6JB4Ay5YzQ8veRTr8W/eaGuBoIUEU93d4=
=ll/o
-----END PGP SIGNATURE-----

--FkhOn4hPPRcnTymj--
