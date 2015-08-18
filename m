From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 17 Aug 2015 22:04:05 -0700
Message-ID: <20150818050405.GE10748@sirena.org.uk>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <f3bfd04bc157e97e2d0632b7ed2452f366f66488.1439519413.git.baolin.wang@linaro.org>
 <20150817010707.GC1864@shlinux2>
 <20150817172623.GO10748@sirena.org.uk>
 <20150817235816.GA5621@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ynlhraTE7dg5hjP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [216.4.250.2] ([216.4.250.2]:43246 "EHLO p2012.superclick.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbbHRFFZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Aug 2015 01:05:25 -0400
Content-Disposition: inline
In-Reply-To: <20150817235816.GA5621@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Peter Chen <peter.chen@freescale.com>, Baolin Wang <baolin.wang@linaro.org>, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org


--0ynlhraTE7dg5hjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 06:58:16PM -0500, Felipe Balbi wrote:
> On Mon, Aug 17, 2015 at 10:26:23AM -0700, Mark Brown wrote:
> > On Mon, Aug 17, 2015 at 09:07:08AM +0800, Peter Chen wrote:
> > > On Fri, Aug 14, 2015 at 05:47:46PM +0800, Baolin Wang wrote:

> > > > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {

> > > Where the wm831x_pdata->usb_gadget is initialized?

> > It's platform data, it will be initialised by whatever registers the
> > platform data.

> passing pointers through pdata ?

It's a char * to a name, not a pointer to struct.

--0ynlhraTE7dg5hjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0rzBAAoJECTWi3JdVIfQth4H/0PQVDgwaJYi/7uilaLP9q/t
iTW8OHnai3IT78EtDtXhli+qcG6f2+DoYWeygcBcggG8ah0sapUD+3XCHHTOsEt5
6YKDetCBNoZ9+THFSBRkDJltp6onlcwopkToqCmxBWbhbdP1EJLWg3W0B4Y7zKVK
K/DUH+Mfo4UQ9FJ0+atNuPjmLG53tJBjKGj63BZ0EtS/bwbSUV8smeVnLzyawhxX
oQsBqX+/Lxtszms6UOCaG3K5AUZHjDzZfKbZeitH9Ufs8viW+SNWUh2m20AkaM3R
91YrePY55UXABIFpp+6hpivjLR6blfnGaPjFDi58nNxfwIeHuByV3QUSw068t00=
=ogL1
-----END PGP SIGNATURE-----

--0ynlhraTE7dg5hjP--
