From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression] Re: Thinkpad T40p: suspend to ram stopped working
 sometime before 4.14
Date: Mon, 25 Dec 2017 00:22:13 +0100
Message-ID: <20171224232213.GA23103@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
 <20171224153624.GA22377@amd>
 <20171224181740.GA26326@amd>
 <20171224223739.GA24747@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58917 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdLXXWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Dec 2017 18:22:14 -0500
Content-Disposition: inline
In-Reply-To: <20171224223739.GA24747@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, kyle@kernel.org, akpm@linux-foundation.org, mmarek@suse.com, yamada.masahiro@socionext.com, dwmw2@infradead.org, markus@trippelsdorf.de, torvalds@linux-foundation.org
Cc: kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > And it seems bad commit is
> >=20
> > commit 5620a0d1aacd554ebebcff373e31107bb1ef7769
> > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date:   Thu Sep 14 14:23:01 2017 -0700
> >=20
> >     firmware: delete in-kernel firmware
> >=20
> > Unfortuantely, it does not revert cleanly.
>=20
> I can't, because there's df85b2d767aad90fd2746f993fcd66dd322768f8 on
> top of it, partialy reverting it. Seems like 5620 was causing problems
> for other people before.
>=20
> And then there's huge mega-patch called "license cleanup" on top of
> that, which changes 11100 files (!) and makes work harder still.
>=20
> Can we go for full revert?

And revert indeed fixes suspend on T40p on v4.15-rc5.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpANqUACgkQMOfwapXb+vICdgCcClaUr41qYsuFpCAeRnmku1Hp
NLUAnjU7A+ZZ3CTKhaLrD3YFx0NHx0wa
=cl3M
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
