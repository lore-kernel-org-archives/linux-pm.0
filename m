From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Thinkpad T40p: suspend to ram stopped working sometime before
 4.14
Date: Sun, 24 Dec 2017 16:36:24 +0100
Message-ID: <20171224153624.GA22377@amd>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46153 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdLXPgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Dec 2017 10:36:25 -0500
Content-Disposition: inline
In-Reply-To: <20171224152232.GA30077@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-12-24 16:22:32, Pavel Machek wrote:
> On Sun 2017-12-24 13:04:31, Rafael J. Wysocki wrote:
> > On Sunday, December 24, 2017 12:49:21 PM CET Pavel Machek wrote:
> > > Hi!
> > >=20
> > > 4.15-rcX is broken, but that had other problems so lets not go there.
> > >=20
> > > 4.14 is broken.
> >=20
> > And what exactly does happen?
>=20
> Suspend looks ok. I believe there's some reaction to power button, but
> screen stays blank. I'll re-check that.. I'm in the middle of bisect
> now.

Ok, so suspend looks ok. On resume, "moon" LED goes off and power /
bluetooth LEDs go on, but screen is black and no response to anything.

# bad: [eb3b451f8b5a6eb0ebe09ff0f79937977f985a36] Configuration for final v=
4.14
# good: [9fd3408ca15f4018466e87255ab2644f54de1c1c] "Definitely say Y... so =
it should be default."
git bisect start 'my-v4.14' 'my-v4.13'
# good: [088eb54dfadd2cdaeb50969fadda4ecfd8d490c2] Date: Wed, 6 Sep 2017 09=
:03:47 +0300 From: Adrian Hunter <adrian.hunter@intel.com> To: Shawn Lin <s=
hawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>,         linux-mmc@vg=
er.kernel.org 	Cc: kernel list <linux-kernel@vger.kernel.org>, Seraphime 	K=
irkovski <kirkseraph@gmail.com> 	Subject: Re: 4.13 on thinkpad x220: oops w=
hen writing to SD 	card
git bisect good 088eb54dfadd2cdaeb50969fadda4ecfd8d490c2
# good: [15d8ffc96464f6571ecf22043c45fad659f11bdd] Merge tag 'mmc-v4.14' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 15d8ffc96464f6571ecf22043c45fad659f11bdd
# good: [e90937e756938f03d37d4cae7c82316a3a425944] Merge tag 'armsoc-device=
tree' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good e90937e756938f03d37d4cae7c82316a3a425944

(next one is bad).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlo/yXgACgkQMOfwapXb+vKE0gCgqLHa7QPh4QpRq5261e/SD+TO
BQQAn1daip9mAbPF9rUA8FABSZ2Yr0YD
=7q0K
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
