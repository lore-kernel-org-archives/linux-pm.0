From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 04 Apr 2016 13:47:50 +0300
Message-ID: <877fgd7iqx.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <20160331170635.GH2350@sirena.org.uk> <87d1q9anpt.fsf@intel.com> <20160401141643.GX2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35825 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbcDDKuv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Apr 2016 06:50:51 -0400
In-Reply-To: <20160401141643.GX2350@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Mark Brown <broonie@kernel.org> writes:
> On Fri, Apr 01, 2016 at 08:43:10AM +0300, Felipe Balbi wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > IIRC Greg didn't want new classes?
>
>> good point. Still, this doesn't seem to fit a but_type IMO.
>
> It does in this new world order.  IIRC on an earlier round of review
> there was some code that didn't use a bus but that got complaints that
> it was trying to reimplement the bus functionality.

fair enough, I'll wait for Greg to have some time to comment on
this. Bottomline is that there is *no* real bus. Charger ICs will use
SPI or I2C and that's a real bus, $subject is not.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAkZXAAoJEIaOsuA1yqREdHsP/2knzrys9jx8e9ipS70Pka/f
JqYhtEj1sxATBRcf1Z1rYDMeowGSVczlCelyfHzld4wboguzCFS+MPgnMT0YgTM2
37O6PCmb5Xsc8g9omxCfXvAozkcpRo+f7U+i2gEx2fIfl73D0kLihacqEqiaWxU+
9Qp3+SvN1oENeqseC7pe+AAHFL9wtIujLvCTEoIa7MsafEJ0CH0vaKs9UgF9e042
K3MMTxKP2leLORfuV5+8tYCD9TOr5RRKOe5V1pxvR3A7tKpnMK2Lr/6KJ8wASfrN
CBH0czLVWsIMIDodXJFrY9w6IjUL3OrbdWHMEbIO4sDZliIW7REqejGY+gkIZDGO
w/WCc+/POQ01kFGVugFGeHua2CoN8q+mzvEYnISNLUXWRheE+sPSj9ebZnk8uSfW
6lkmV9ysBh1mtFKhEH/aCB3K32zcYedLD/jjBOivhal//3OSiKgxhl7ph6IqJSGR
6+fLgpEvh9QzdTKsVL8gPgklyoVB9g9kMNhuX/5EwQJuoFYmLhM8KtBVEoHwkbn6
wVFkK3H77nPonGvFFrCJTlnHvL6JFlGxRo2XRR4cyLx69iQzQEGguTiuigQSL5vy
t+lQUGOf3u8N/RE/M7nLiodinowQ7lfqSAGGeScbYI0AW7FXM3gYemydRaGGWgRk
M0gW6dMkvoYsbMbfwa/9
=UY6W
-----END PGP SIGNATURE-----
--=-=-=--
