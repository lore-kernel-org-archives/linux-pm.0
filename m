From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 14 Sep 2016 19:02:14 +0100
Message-ID: <20160914180214.GI27974@sirena.org.uk>
References: <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
 <20160912122549.GZ27946@sirena.org.uk>
 <87inu11c5l.fsf@notabene.neil.brown.name>
 <20160912152627.GA27946@sirena.org.uk>
 <877fag1b6r.fsf@notabene.neil.brown.name>
 <20160914111603.GU27946@sirena.org.uk>
 <87r38mzi35.fsf@notabene.neil.brown.name>
 <20160914145703.GX27946@sirena.org.uk>
 <87oa3qz7zr.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60744 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755719AbcINSDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 14:03:12 -0400
Content-Disposition: inline
In-Reply-To: <87oa3qz7zr.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2016 at 07:50:00PM +0200, NeilBrown wrote:
> On Wed, Sep 14 2016, Mark Brown wrote:

> Ah.... my mistake, sorry.
> When earlier you said:

> >                                                                 It's a
> > current limiter intended to sit in line with the USB power lines to

> I assumed that all it did was limit the current to number given.
> If it also limits the current to ensure that voltage doesn't drop
> unduly, then I agree with your assertion that it just needs to be told
> the upper limit.

Oh, I see the gap here - the USB specific bit is only a current limiter
but it works in concert with other bits of the system that try to stop
the voltage from whatever supply is in use from dropping and can't be
used independently of them.  That's why I wasn't clear in what I said!

> I hope you'll agree that other drivers might need to know the lower
> limit, so reporting both to all drivers is sensible.

Yes, absolutely.

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2ZClAAoJECTWi3JdVIfQHQMH/jHS3gYB20vDJ17lsCRZiIJl
MFJgt5uH2gxYrR4HCnh7Ttc1Mie4vSso5J/e9pAratoBfchVn70ZRMXCRe3oxLwv
v0sLmwC9J4un/fwee1o5aE/V3qVt/XKq2/EXwJ0FzaMOIG7cfk+u2RAYP88+edcM
6u4SIZUdSyggWGg03ilqrKm1Bs6E1mNwQRd1Hy3X987yOjJmMCQNzsgcVssm0nXN
klNUnAz4NYrO4yg8QT66iB1oyu69tcbYgWY90O8JnSLnxp7VYDL+rYq8A82ZvwEa
ATMi8xCfrhNnScdW+O4OKRCE7WGme7q9TG6hLuLTrpsSgjkEvHPBcMv6GdG4M4Y=
=HgrO
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
