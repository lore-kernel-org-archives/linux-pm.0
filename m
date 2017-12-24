From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Thinkpad T40p: suspend to ram stopped working sometime before
 4.14
Date: Sun, 24 Dec 2017 16:22:32 +0100
Message-ID: <20171224152232.GA30077@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45707 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdLXPWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Dec 2017 10:22:33 -0500
Content-Disposition: inline
In-Reply-To: <58258946.1WsWlzHmoT@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-12-24 13:04:31, Rafael J. Wysocki wrote:
> On Sunday, December 24, 2017 12:49:21 PM CET Pavel Machek wrote:
> > Hi!
> >=20
> > 4.15-rcX is broken, but that had other problems so lets not go there.
> >=20
> > 4.14 is broken.
>=20
> And what exactly does happen?

Suspend looks ok. I believe there's some reaction to power button, but
screen stays blank. I'll re-check that.. I'm in the middle of bisect now.

Is there something in 4.14.X I should try?

> > 4.12 is ok.
> > 4.13 is ok.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlo/xjgACgkQMOfwapXb+vKMrgCfcwVoTITsovvZ5iOGwuJsN9ng
LzEAoJFYUEIcH7wIK0M3qqOzAge7/tTN
=pEZe
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
