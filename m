From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 14:14:49 +0200
Message-ID: <20150714121449.GA22124@earth>
References: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
 <20150714101948.GA17240@earth>
 <mqd1tgb816o.fsf@c203.arch.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60378 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbbGNMOy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 08:14:54 -0400
Content-Disposition: inline
In-Reply-To: <mqd1tgb816o.fsf@c203.arch.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 14, 2015 at 12:48:31PM +0200, Johannes Thumshirn wrote:
> Sebastian Reichel <sre@kernel.org> writes:
> > On Tue, Jul 14, 2015 at 11:16:14AM +0200, Johannes Thumshirn wrote:
> >> Destroy IDRs on module exit, freeing the resources for
> >> * bq2415x_charger.c
> >> * ds2782_battery.c
> >> * ltc2941-battery-gauge.c
> >
> > You missed bq27x00_battery.c. Maybe a coccinelle script should be
> > written?
>=20
> I already did this one that last week (I think), it should've been in
> your INBOX (I hope).

Right. I marked that one as read assuming you would write a new
version of the patch changing all drivers. Please change all drivers
in one patch in the next version.

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVpP00AAoJENju1/PIO/qa054P/1900f3lQaBW5lEin5UN565j
LOfjilVnT/bYrz9hNFRacb2JO3G4JJawQ+D+7pcgAv8wX65odNy6J6hjOrmeCrhL
nYFhrJJ/tpvTkVFbYCvSQi8hIc5kd8PWEUy7C9qPledCp3UxfC+dfQACl4KMs6Zn
lLMItmxsmpix4ShQx1naK5l42su35OAC2ZVCJIlBaB9g+7wHmOCAGKDn9jttOpIc
jVaSq8EYXo0wvNysI8ynqxt1KQCuIwwgYADvAbJcmkeeYRdBjHWtapOIYvL5D8+4
ALX/2nARvUro2eHE3mXJU36QzEvmXQbH+SVgVnDJHYpzl4gVgs/8TazDODU3E79q
zUUcsSxchbkTgQ+EjkfpB8WzG6Ba4gvFVrwxOZjrOo18NgkgLUi8oERoYXYuM7eh
stxQ/aO8hH4o4XKfJv0h6KRL/K1RWDe99NkWHVyMTMaqLsOXGkxflh1zibjLKEMK
L8EX5TPctFMuaIKSjRnwkJQrxwS9F0ofFPFMCLdZp+NXg3cvF2KX98g0NsXt+PPY
1gRz6p+Jy2AjkY+6WZddAQ3F/VkOpY1JwY9UEAo5pAfgAFrz70Upt5ZxFs1jFy4W
trNQitX+ddj4URkWLNys4cMifKgFD8txfih8BD+x3sWq5pFgZirVD3DgWQAi/s/H
oF2dgbilawJEzhNU+pgB
=XFUd
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
