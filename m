From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 12 Sep 2016 13:25:49 +0100
Message-ID: <20160912122549.GZ27946@sirena.org.uk>
References: <cover.1470034830.git.baolin.wang@linaro.org>
 <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
 <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name>
 <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name>
 <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
 <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JefYhWJ8RkX3aR0a"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52340 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756103AbcILM0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 08:26:33 -0400
Content-Disposition: inline
In-Reply-To: <87pooc7n3t.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vg>


--JefYhWJ8RkX3aR0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 10, 2016 at 07:57:26AM +1000, NeilBrown wrote:
> On Fri, Sep 09 2016, Mark Brown wrote:

> > The wm831x driver in the patch series is an example of such hardware -
> > it is purely a power manager, it has no USB PHY hardware at all.  It's a

> The "probe" routine calls

>  +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);

> Presumably wm831x_pdata is initialised by a board file?

Yes.

> I strongly suspect it is initialized to  "usb-charger.0" because the
> names given to usb chargers are "usb-charger.%d" in discovery order.
> I don't see this being at all useful if there is ever more than one
> usb-charger.
> Do you?

It's no worse than any other board file situation - if someone has that
problem they get to fix it.

> So how can this wm831x driver actually find out what sort of charger is
> connected and so set the power limit?  I just don't see this working *at*
> *all*.

The whole point from the point of view of the wm831x driver is that it
just wants something to tell it how much current it's allowed to draw, I
appreciate that doesn't change your analysis of the bit in the middle
but the consumer driver bit seems fine here.

--JefYhWJ8RkX3aR0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX1p7MAAoJECTWi3JdVIfQevUH+wb49xtgiBRTWwlMRdROLu8V
iLV7Iyji39xD3FtNjU5M+quJ6VUh09WpZwCgVlPT25FKVJs8wbwAJQQp9KYi/5Ah
jKGMGMyqwOIMdtYmP0x56Td1WBwnLnWZLsosuCwIoSs8QnULbvNOIFrw594Z2XvX
9d/yV22CMmOXjzkW5qfXIYgDwv6ydVZIzr3xYHfXaKEwMlKyk3YBsULDgKQ8o669
/dXjOo/HzouqKAlwXZy3gtUYtPI/nR9rfNHCdF19Ur1Dlh6VBKgPnAop1uuq7ZlR
kfSKaE/ycbrZ9FH8a2kVxZGgZxr2KHWlyJAnDRPDEwcYnosqdr/PeuiA/HWxFJA=
=Gnrr
-----END PGP SIGNATURE-----

--JefYhWJ8RkX3aR0a--
