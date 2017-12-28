From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression] Re: Thinkpad T40p: suspend to ram stopped working
 sometime before 4.14
Date: Thu, 28 Dec 2017 13:19:20 +0100
Message-ID: <20171228121919.GC854@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
 <20171224153624.GA22377@amd>
 <20171224181740.GA26326@amd>
 <20171224223739.GA24747@amd>
 <20171225084748.GA246@x4>
 <20171225095423.GA7858@amd>
 <20171225100514.GB246@x4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38474 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdL1MTV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Dec 2017 07:19:21 -0500
Content-Disposition: inline
In-Reply-To: <20171225100514.GB246@x4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, kyle@kernel.org, akpm@linux-foundation.org, mmarek@suse.com, yamada.masahiro@socionext.com, dwmw2@infradead.org, torvalds@linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > > Ok, so suspend looks ok. On resume, "moon" LED goes off and pow=
er /
> > > > > > bluetooth LEDs go on, but screen is black and no response to
> > > > > > > > > anything.
> > > > >=20
> > > > > And it seems bad commit is
> > > > >=20
> > > > > commit 5620a0d1aacd554ebebcff373e31107bb1ef7769
> > > > > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Date:   Thu Sep 14 14:23:01 2017 -0700
> > > > >=20
> > > > >     firmware: delete in-kernel firmware
> > > > >=20
> > > > > Unfortuantely, it does not revert cleanly.
> > > >=20
> > > > I can't, because there's df85b2d767aad90fd2746f993fcd66dd322768f8 on
> > > > top of it, partialy reverting it. Seems like 5620 was causing probl=
ems
> > > > for other people before.
> > > >=20
> > > > And then there's huge mega-patch called "license cleanup" on top of
> > > > that, which changes 11100 files (!) and makes work harder still.
> > > >=20
> > > > Can we go for full revert?
> > >=20
> > > No, it does not make any sense.=20
> > > Could you please post your config?=20
> >=20
> > Well.. neither makes the original commit message any sense :-(.
> >=20
> > CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> > CONFIG_FW_LOADER=3Dy
> > CONFIG_FIRMWARE_IN_KERNEL=3Dy
> > CONFIG_EXTRA_FIRMWARE=3D"radeon/R700_rlc.bin iwlwifi-1000-5.ucode"
> > CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
>=20
> Looks like a pilot error to me. You have a R200 card, but you load R700
> firmware. Try:
> CONFIG_EXTRA_FIRMWARE=3D"radeon/R200_cp.bin iwlwifi-1000-5.ucode"
> instead.

So... With modified extra firmware line, it works for me. Good.

But... it worked before. So that's still a regression and hard to
debug one, and probably going to happen to more users than just
me. Yeah, pilot landed on wrong runway, but this should not lead to
his engines exploding and black box being erased.

What is going on there? Why did it work before?

Is there way we could warn during boot (or suspend) "hey, you need
this firmware for resume"?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpE4UcACgkQMOfwapXb+vLZ+wCfYQu/aTP6+Mb4Tq9GvKCGLZk+
nRQAniPP2V1Br6MYEQiRBsaVLeZpYpk/
=x3qY
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
