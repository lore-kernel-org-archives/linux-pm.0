From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 29 Mar 2016 10:23:14 -0700
Message-ID: <20160329172314.GZ2350@sirena.org.uk>
References: <cover.1458822334.git.baolin.wang@linaro.org>
 <20160325070937.GA22398@peterchendt>
 <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
 <20160328071351.GC3302@peterchendt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lKbk9CFItQTD29wm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52246 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbcC2RXf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 13:23:35 -0400
Content-Disposition: inline
In-Reply-To: <20160328071351.GC3302@peterchendt>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>


--lKbk9CFItQTD29wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 28, 2016 at 03:13:51PM +0800, Peter Chen wrote:
> On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:

> > > I am afraid I still not find the user (udc driver) for this framework, I would
> > > like to see how udc driver block the enumeration until the charger detection
> > > has finished, or am I missing something?

> > It is not for udc driver but for power users who want to negotiate
> > with USB subsystem.

> Then, where is the code the test user to decide what kinds of USB charger
> (SDP, CDP, DCP) is connecting now?

Even without detection of CDP and DCP we have configurability within SDP
- there's the 2.5mA suspended limit, the 100mA default limit and the
higher 500mA limit which can be negotiated.

--lKbk9CFItQTD29wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+roBAAoJECTWi3JdVIfQ/rcH/22FLDoOaSmiQpVJQ+DePHuH
a7t/vzmpWT+g/ksPB81g+oLyUow8m+EOSr9Zfg202JHn2E7rWYmwMEb+d5p3SqQg
hy+N03VZBIcVnihJ+nPiU0MvLtA5zS/x4Q1kSK3mJHfHyzGWs/7+FE2hGJfqW/Lt
2vGcgn3YRjaCV3g0GbJoqKz0GqMG/VzehNskIStS6h550g+3ofdhi2m+uXHi6opp
uanEx+Rw+8xDleQSduvI6fvqL09frPbL6ZGikzwobHTQ5ZnMnD3P7uB4lKHR4AdQ
QnZEaDw5F+AcLYmMk+LPahVB0afNDL7cjLNJxxTkKLmkFkhWMUCMHwK+K70SrpY=
=bsXw
-----END PGP SIGNATURE-----

--lKbk9CFItQTD29wm--
