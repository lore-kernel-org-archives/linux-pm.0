From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/5] gadget: Introduce the notifier functions
Date: Fri, 6 Nov 2015 21:24:39 +0000
Message-ID: <20151106212439.GM18409@sirena.org.uk>
References: <cover.1446807915.git.baolin.wang@linaro.org>
 <acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
 <20151106165644.GA23834@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8RJ6MkOGpKElHlfH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50390 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030323AbbKFVZL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 16:25:11 -0500
Content-Disposition: inline
In-Reply-To: <20151106165644.GA23834@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org


--8RJ6MkOGpKElHlfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 08:56:44AM -0800, Greg KH wrote:
> On Fri, Nov 06, 2015 at 07:35:10PM +0800, Baolin Wang wrote:

> > Thus this patch adds a notifier mechanism for usb gadget to report a
> > event to usb charger when the usb gadget state is changed.

> I thought we said we did not want another notifier chain in the previous
> versions of this patch?

Did we come up with anything better?

--8RJ6MkOGpKElHlfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPRqWAAoJECTWi3JdVIfQf6wH/0/li7EOjjHEHO+toJJyxzsm
fqE558gfG/WDmQ9nxcF671jdlDZ5xjpz8E+6YbP4x5QVyfinJbTxBQkCaNEwy/Me
H0keIO8xD6uHDucYZO5AGwzUOsLVJf8WhUEueYNt3YBVv0kA8qqeIT0gwKjDxO3x
NvShUnAPI0LygXOpY8lCiSLpRk1H+EhXomFwAX1GQwgsEonaJgQT0EKqHdl0k404
ObqBFRYcthqToTaYWlzL5st9BoJkSxliuG2h1R+NKxSzlb781fQQR3d2bNKVYvJS
J0Tp63mV5n2J8iMRNbPxKS/unCmgDTqA1zmmnktuetW28+FWKXmP52uM6NQdMOc=
=7QgH
-----END PGP SIGNATURE-----

--8RJ6MkOGpKElHlfH--
