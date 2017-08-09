From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
Date: Wed, 9 Aug 2017 23:56:34 +0200
Message-ID: <20170809215634.GA16992@amd>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <15027171.LoAvHuklGv@aspire.rjw.lan>
 <20170809064231.GA19118@amd>
 <25469991.213uJSqkO8@aspire.rjw.lan>
 <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38742 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdHIV4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 17:56:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hisashi T Fujinaka <htodd@twofifty.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, intel-wired-lan@lists.osuosl.org, Linux PM <linux-pm@vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >[You seem to have a stale linux-pm address in your address book,
> >I replaced it with the current one in the CC list.]

Thanks, fixed.

> >>ACPI S3, right. Machine still wakes up properly when I hit a key on
> >>USB keyboard.
> >
> >OK, so my guess would be a driver issue.  What driver is this, igb?
> >
> >>Does wake on LAN work on you, on any hardware?
> >
> >Yes it does, I checked two machines earlier today, both work.
> >
> >Can you enable dynamic debug in device_pm.c and send a dmesg output
> >with that covering a suspend-resume cycle?
>=20
> 82579 is e1000e

Thanks for all the help.

I now realized what was going on: I had badly inserted ethernet
cable; machine just connected to wifi, and everything worked... except
wake on LAN.

Sorry for the noise,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmLhRIACgkQMOfwapXb+vJYDACfalkLEAwNh2ZPvLoHMKdGF5HH
0bIAniuBS3Lf5H1qzmZQnf7p+TWQXsmh
=8Y/i
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
