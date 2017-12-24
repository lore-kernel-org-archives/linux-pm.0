From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression] Re: Thinkpad T40p: suspend to ram stopped working
 sometime before 4.14
Date: Sun, 24 Dec 2017 23:37:40 +0100
Message-ID: <20171224223739.GA24747@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
 <20171224153624.GA22377@amd>
 <20171224181740.GA26326@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57864 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdLXWhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Dec 2017 17:37:41 -0500
Content-Disposition: inline
In-Reply-To: <20171224181740.GA26326@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, kyle@kernel.org, akpm@linux-foundation.org, mmarek@suse.com, yamada.masahiro@socionext.com, dwmw2@infradead.org, markus@trippelsdorf.de, torvalds@linux-foundation.org
Cc: kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > 4.15-rcX is broken, but that had other problems so lets not go th=
ere.
> > > > >=20
> > > > > 4.14 is broken.
> > > >=20
> > > > And what exactly does happen?
> > >=20
> > > Suspend looks ok. I believe there's some reaction to power button, but
> > > screen stays blank. I'll re-check that.. I'm in the middle of bisect
> > > now.
> >=20
> > Ok, so suspend looks ok. On resume, "moon" LED goes off and power /
> > bluetooth LEDs go on, but screen is black and no response to
> > > > > anything.
>=20
> And it seems bad commit is
>=20
> commit 5620a0d1aacd554ebebcff373e31107bb1ef7769
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Thu Sep 14 14:23:01 2017 -0700
>=20
>     firmware: delete in-kernel firmware
>=20
> Unfortuantely, it does not revert cleanly.

I can't, because there's df85b2d767aad90fd2746f993fcd66dd322768f8 on
top of it, partialy reverting it. Seems like 5620 was causing problems
for other people before.

And then there's huge mega-patch called "license cleanup" on top of
that, which changes 11100 files (!) and makes work harder still.

Can we go for full revert?

Changelog=20

"""    The last firmware change for the in-kernel firmware source code
was back
    in 2013.  Everyone has been relying on the out-of-tree
    linux-firmware
    package for a long long time."""

does not really explain what is going on there, and I'd certainly not
expect silent breakage of suspend/resume. Clearly 5620a0 patch did not
get nearly enough testing.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpALDMACgkQMOfwapXb+vIOZwCghu9mXNHN4o6DXqNfX4X5CMI6
UOIAn32pm4VAtXQuZEffclOR+7ESkOF4
=9LWA
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
