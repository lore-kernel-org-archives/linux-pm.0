From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
Date: Mon, 22 Sep 2014 12:00:34 +0200
Message-ID: <20140922100033.GC1406@katana>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
 <20140920122318.GC3850@katana>
 <20140922095253.GO1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48655 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbaIVKAX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Sep 2014 06:00:23 -0400
Content-Disposition: inline
In-Reply-To: <20140922095253.GO1786@lahna.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 12:52:53PM +0300, Mika Westerberg wrote:
> On Sat, Sep 20, 2014 at 02:23:19PM +0200, Wolfram Sang wrote:
> > On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> > > Previously only the ACPI PM domain was supported by the i2c bus.
> > >=20
> > > Let's convert to the common attach/detach functions for PM domains,
> > > which currently means we are extending the support to include the
> > > generic PM domain as well.
> > >=20
> > > Cc: linux-i2c@vger.kernel.org
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Reviewed-by: Kevin Hilman <khilman@linaro.org>
> >=20
> > Looks good to me, but I'd like to give Mika a chance to look at it,
> > since he does ACPI with I2C. Adding to CC.
>=20
> Looks fine to me.

Thanks! So:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUH/NBAAoJEBQN5MwUoCm2ZicP/2lZDckidVBryENydPPD+566
Y7aPhIngEirxJ64E0ukHQDtEMZgZHN0bfniANlK5fPFcQetZRwOv9WQWS31fTbq3
+mT6rSHY/WXFJVw3C3Ldqlh8ojPf8TDroiA0EeTjvwQdLZ8kkV7LP89EVic0YY2Z
eT9eWTMziynsIjOo56FQGUk6+DVZJwO92egBePbn2GPKjajmI/fKaL8e85yCcBso
LTFziCpB8M3UHKWIxVIaGyRnZAFgj221Gw88NBXu9zYF0gn3u9WY1wLDFAwUaAz8
jPHKA8TrJWsR0+nXJ6TW47p0oCzzCFci71ytMYiubhSjRygqtMtHIUZiGW7eqspc
HZquFskDoAp/k9qA35MK/L/5Zu6flH1z07DCJzdlA5pRKOVNDk/QUQBsmFCDAzaQ
99QBLoEN3CavGqxVRoxQnK1OdD/NZsnU8aeWiESUacjKAtt+9M32vDkabLuT1Ds4
i+ppDGl1F3fNKBYjN0fxEbDghFNuY53oi3brE2mD285E946T0O01CJ4i3KPGXW/S
61N9tcsZcHIGPgBuidCxazaJ1GrVPFSp1gleElcmNWHJxj+7GNPc0G4121FEpihf
/addqf2bQtI5YdG7cZ947OOI1M5ITbqwH8QMvGvq6UNNBtpxU7QlPTTFqNAD5b+v
2C+/IR792rWyoYFIZwWC
=Qq1w
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
