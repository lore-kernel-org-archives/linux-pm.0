From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 6 Apr 2016 10:01:31 -0700
Message-ID: <20160406170131.GO1924@sirena.org.uk>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <20160405064637.GA31351@shlinux2.ap.freescale.net>
 <CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
 <20160405081222.GC31351@shlinux2.ap.freescale.net>
 <20160405165305.GD1924@sirena.org.uk>
 <20160406011526.GB6301@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48448 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbcDFRCI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 13:02:08 -0400
Content-Disposition: inline
In-Reply-To: <20160406011526.GB6301@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2016 at 09:15:26AM +0800, Peter Chen wrote:

> > > No, this comment is common one, but only for SW detection. Eg, when
> > > the PMIC tells you it is a SDP, you can't notify to charger IC about
> > > 500mA at once, you need to do it after host allows you to do it.

> > Note that this isn't just the charger device that needs to constrain
> > current consumption - it's the entire system.  You can't charge to the
> > limit for system power draw if the USB controller is supplying the main
> > system rail.

> Sorry, I can't catch up you. USB Host (SDP or CDP) supplies power for
> USB device (not only USB controller, it is the whole system), it can
> supply more power after set configuration. See 1.4.13 from BC 1.2.

You're saying we need to notify the charger.  The charger does not in
general control the overall system current draw.

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBUDoAAoJECTWi3JdVIfQFUgH/j2XE0TyDrVymZdsP64S8D3P
5ZdxMXKlPKhGxunk/LyTr3mbRbQjEfgh4B/qrzLjvP1KmigNFxvXKFL1w/6eLBnH
mESNH4eBdgY8lwbmhRGFokEGMdOC3J67Ircx9b6sIrbHsCOh7xAtup0/1FuEAyp1
f+Pu9iFuWvGx5m7QYO0zP8cVU0cKzNWBIrc4tvUTUHxxpazicZZK33bUrnFLeM1I
6GHqxcjRafheAAihH5YlQgBFsXAI91Cqm+jFK6ROe0pV5iqgg8eanJC4H0O8bZTd
FQT5gFznghoL7NUlQXyfiA2GikEaIQGlV2FBOVUH6KgcO2ZBjgbbru7A+WUV6Bo=
=gxLV
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
