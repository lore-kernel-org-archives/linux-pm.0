From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Thu, 31 Mar 2016 11:15:05 +0300
Message-ID: <87egargj1y.fsf@intel.com>
References: <cover.1458822334.git.baolin.wang@linaro.org> <20160325070937.GA22398@peterchendt> <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com> <AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com> <AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com> <AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLY8vO5qnkuY+kv91zKpdxBBSDeLZXFvD1LjnS3R3UccA@mail.gmail.com> <AM4PR04MB1665E85D823D5AB59B54B56D89980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLxfEr_cOa0F-Qh+Mo+dEVGWx+YPZ_=yb9FVwWdJd8viQ@mail.gmail.com> <HE1PR04MB167436923F9920CB4417FD5989
 990@HE1PR04MB1674.eurprd04.prod.outlook.com> <CAMz4ku+Vdnv9aeE944=V=cx1rAHBVMvUehwA-ZLCNr6vzvyQgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46906 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbcCaIRi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 04:17:38 -0400
In-Reply-To: <CAMz4ku+Vdnv9aeE944=V=cx1rAHBVMvUehwA-ZLCNr6vzvyQgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Jun Li <jun.li@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Baolin,

Baolin Wang <baolin.wang@linaro.org> writes:
>>> >> Make sense. In our company's solution, charger detection can be done
>>> >> by hardware from PMIC at first, then it will not affect the DP/DM
>>> >> line when gadget starts to enumeration.
>>> >
>>> > I see, charger type detection is done automatically by PMIC when VBUS
>>> > is detected in your case, you just assume the process is complete
>>> > before SW do gadget connect. To make the framework common, you may do
>>> one time charger type check when vbus is on, and save it to avoid repeat
>>> charger type check.
>>>
>>> OK. I'll add one judgement to check if the charger type is set in
>>> 'usb_charger_detect_type()' function.
>>
>> Just adding a judgement isn't enough here, your framework should make su=
re
>> usb_charger_detect_type() is called before gadget connect, with that, the
>> existing caller place just gets the charger type from the saved value.
>> The real charger type detection done by usb_charger_detect_type() can
>> be called only when vbus is on.
>> e.g. maybe in usb_udc_vbus_handler() before usb_udc_connect_control().
>
> Yeah, Like Felipe suggested, I think we need to introduce one
> 'charger_detect()' method to do the SW charger type detection at the
> right gadget state. Thanks for your comments.

Just to be clear, we add ->charger_detect() when we know of a platform
which needs to manually detect the charger type. Until then, we ignore
that situation. It might be a good idea, however, do document this in
comments on your structure definition stating that if we need to detect
charger type, a new method should be added ;-)

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/NyKAAoJEIaOsuA1yqREZCcP/2/yTlS9yQQd/rv7RI4+UeYS
fLpEqcLSb6rY3os178c47K9e/UpWr2XRcQ+PoZaqGgcIHM4wRd3Rs7RsWrKyZGY4
1VBUOQL2Gz/TnZM/yJwC8uSYvf3NsLHTtPAQpOBnd2n8wwkiSnfnMVvuKxyUgHOS
fx6HDIeGVhp61XihTFh4HQ2e+JXsHy7/kT7/vGFHXA6Gk9dTQqj8Hyb+VHAM7J9+
sPmRsHfbCXgXG42Xys76e3z0AdRnyN7hWaRiUu0yJvnhhM53v6qftDxBReX6oiTC
aSIe4/uxJjdNe5dieSmE/q9KKX4Apl0VTd84RgzP6iJN8zLHlVQon+bwU5RK6cFr
7PJSDuGwMIIqCshLNWU/HvArvfFOP3rAZxKBxehiGwXJfIaxjl+r+G808wekCrzI
CZ47P0gA0loO/KMftQ2z4HapcOoqs8nsdJrKm89rvBjLp4B2NqvmYBedSL5NlNzj
Xl7HmrbpQ/b+n43GSeM9Yrr58D2j5wpKIzY2TplYKW/h2IqfLyPcouoU7lffO8U6
6uXJ5cF92kInipt1+ZYp6VJCWyOzG/iIZLS32wkZICyGxfEwV7/JbrHJcw5+prK6
Wvmt2Aqq8d2daNx0Z8uNRbMHRBzsDUs1mpXyuRAxo8lvzWl5uNKurA0oxHlykrDi
alo4z99woas9XsdJGxGw
=iZLE
-----END PGP SIGNATURE-----
--=-=-=--
