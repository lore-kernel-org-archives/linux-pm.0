From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Mon, 24 Oct 2016 10:23:31 +0200
Message-ID: <20161024082331.GA13240@amd>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
 <20161007184910.GF19976@amd>
 <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45703 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbcJXIXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 04:23:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Ok can do in next revision
>=20
> > Also... what is it good for?
> >
> > Do you have a device that needs non-standard interval?
>=20
> Basically we need to have the ability to dynamically change the
> intervals. So closer to a battery drain we need to up the reporting
> intervals.

Could you elaborate on that? What intervals do you normally need, what
do you need around empty battery, and why is that?

I'm thinking about adding kernel thread to shut down the system if
battery goes critically empty. It is kernel job to protect the
hardware, and that should include the battery...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgNxQIACgkQMOfwapXb+vLkmQCglbZyScb+zpOHako3XGIT55nK
4iwAniAMdERMc9h3DfGI7wh8yntpeivS
=qQQM
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
