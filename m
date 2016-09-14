From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 14 Sep 2016 19:50:00 +0200
Message-ID: <87oa3qz7zr.fsf@notabene.neil.brown.name>
References: <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <20160909110727.GI27946@sirena.org.uk> <87pooc7n3t.fsf@notabene.neil.brown.name> <20160912122549.GZ27946@sirena.org.uk> <87inu11c5l.fsf@notabene.neil.brown.name> <20160912152627.GA27946@sirena.org.uk> <877fag1b6r.fsf@notabene.neil.brown.name> <20160914111603.GU27946@sirena.org.uk> <87r38mzi35.fsf@notabene.neil.brown.name> <20160914145703.GX27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753804AbcINRuH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Sep 2016 13:50:07 -0400
In-Reply-To: <20160914145703.GX27946@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m

--=-=-=
Content-Type: text/plain

On Wed, Sep 14 2016, Mark Brown wrote:

> TI do a lot of the more software managed chargers (which I suspect are
> the main thing Felipe will have looked at) if that's what you're
> referring to here?  The device is implementing pretty much the algorithm
> you're describing in that e-mail so I'm a bit confused as to what you're
> saying here.

Ah.... my mistake, sorry.
When earlier you said:
>                                                                 It's a
> current limiter intended to sit in line with the USB power lines to
> ensure the system doesn't go over the maximum current draw (and also
> integrates with the power source selection logic the chip has to pick
> the best available power source for the system).

I assumed that all it did was limit the current to number given.
If it also limits the current to ensure that voltage doesn't drop
unduly, then I agree with your assertion that it just needs to be told
the upper limit.
I hope you'll agree that other drivers might need to know the lower
limit, so reporting both to all drivers is sensible.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2Y3IAAoJEDnsnt1WYoG5294P/iHqyPeIU3zVvrgGjmwWAb2w
AFmzaqfG9u0xCyLczll/FujFKvVjjQUiuRDohLBcKAoinb2lMqkKeX+wyxtz4ZqR
+5yY/qBQSosb3nQs8TqSzDXrcg/3A+ZGtSGV3yNtPHzo4tzkUmAYiToWy6Pi1uMZ
smjaax7A48efPX8WV2B84nIjGppWzH1k0J5BjsqG7o3WBVR8l0cI7cRXk7dolwDe
VgOLyCELbvf5GXcx4zVrSw7cWg5iB7YtfAnK3hXiBaAaGOM2cJn60knHrPd2oZMF
T/sxqx3rwQO4vvK8ixNXrSGF0/aywiwe+NfFbbBziCTH0NwyxCkFxSHn838WvUqt
Ghjqj0oLE8wfrpYJhMbSJw76lM6z8b7gSAKMneUtQ6wSDJGOBkIIYTxNkoJIiheW
vQ7zphFi3VADje+/Y92gh4EsJWRgV/kCKhz4kR/KdiDOZCG+sGbQLKqxXBFozAzp
2lcD/9smgyVKXokW4eIF6uVQmXoPan5BQ3PFfj3tRUgwW3xRySVL+dGUtOp4J5PA
a5doU/16Me37Tt4ODYOaFUymsIrRPMaTL3pT6bwQl8nc07r2GM4F6RfZKsUPQhCK
BcTDJ/UT53ONwPE7N3Eo6eu9vBDFYnsvfzHzPymy09NkH9Oh2DiDdz/m5dK6rU3z
O0rQZ6Trvl8dHrHUuFSP
=HW9B
-----END PGP SIGNATURE-----
--=-=-=--
