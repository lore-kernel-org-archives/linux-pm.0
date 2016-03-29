From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 29 Mar 2016 10:14:12 -0700
Message-ID: <20160329171412.GY2350@sirena.org.uk>
References: <cover.1458822334.git.baolin.wang@linaro.org>
 <20160325070937.GA22398@peterchendt>
 <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
 <20160328071351.GC3302@peterchendt>
 <CAMz4kuK33mfiO9OttbRF9yVbQE1DFeuOtwyUWkCa5iPYbE-H8g@mail.gmail.com>
 <HE1PR04MB145070EE7CAC373C00C539478B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <CAMz4kuJxJbd8LOKNbduoGdQdByB0r0aU_2z9oAbsZB3RPPOjbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iIOavGAISvUeFFLW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52102 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849AbcC2ROh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 13:14:37 -0400
Content-Disposition: inline
In-Reply-To: <CAMz4kuJxJbd8LOKNbduoGdQdByB0r0aU_2z9oAbsZB3RPPOjbg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Peter Chen <peter.chen@nxp.com>, Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>


--iIOavGAISvUeFFLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 10:05:23AM +0800, Baolin Wang wrote:

> Yes, The user 'wm831x_power' did not implement any callbacks in
> 'usb_charger_detect_type()' function, but in
> 'usb_charger_detect_type()' function it just supplies different
> callbacks to get the charger type with simple logic. Anyway we can try
> to implement one callback to get the charger type and test the API.

The wm831x doesn't have any charger detection features, what it does
have is hardware for implementing a current limit on the power drawn
=66rom USB.  What it's looking for from this framework is for something to
tell it how much current it should draw from USB so it can program the
hardware appropriately to impose that limit.

--iIOavGAISvUeFFLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rfiAAoJECTWi3JdVIfQZd4H/3omY61Hj4mr8vYVCj9ZDZ7x
7u6/fsLzXJgq3CbJXi8HvLlj20rYncH9i++yNeVSVegYsuRvBY91stUcSenJwz2b
Baz3dLRJ0E3nDxej8isxBdNObh863a7hPaWhDJE58jTy9ASCvzFuvonH86C8tW/a
bSDMAkbHzvHcvRP/wftKc6MIemKCXFIz0eKEWFS5Rv30Y9XpfejJqg8IF2GE70D2
H8/heSuhHR70m0n+nAtnGtcyq9xB5QxLucrPn55HJDHnX/pEmGxleyD4W1URDkgK
qWEKka43HtNPv67QMljp/BT94xbQCbdak8tAQZoewnFBYDfkg51GYGWtD7U1W3M=
=FRjf
-----END PGP SIGNATURE-----

--iIOavGAISvUeFFLW--
