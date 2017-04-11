From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 2/2] power: supply: ltc2941-battery-gauge: Add OF
 device ID table
Date: Tue, 11 Apr 2017 16:29:17 +0200
Message-ID: <20170411142917.udh4cl4qw27dqte5@earth>
References: <20170329160057.8298-1-javier@osg.samsung.com>
 <20170329160057.8298-2-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zi2v6czqackkf7cm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbdDKO3V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 10:29:21 -0400
Content-Disposition: inline
In-Reply-To: <20170329160057.8298-2-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org


--zi2v6czqackkf7cm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 29, 2017 at 12:00:57PM -0400, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, queued.

-- Sebastian

--zi2v6czqackkf7cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs6DwACgkQ2O7X88g7
+prVjA/6Aqp3SiTcXuAiAq9lK4kjco7AmR3FPe2EaDCki8LmBfj3n4HCuWFdGBax
IYuduIwTwGITICF6indC3ty6V7/3y7nPtnAI25M3Xh3wygsx/y/JzxMUaur9Ys3K
idJJXvRh3tYRhVJF163uu+9gEG408I70S9njmwNub9MZZv7Sm85gw8foAmhw8x78
B3QsnC0OshbUY8y1oor2QMhCavBz9yhCBZH3euE11tHoIB0Bhq3FrjFbxJOprJDV
TilhAV5TYXjW5cFNIuPT7TGBTMAFmDaJ7MxPjdOeuPzJKic2Sg53sCxmFywK62tg
uzlTDvYofd4vhft5hvUFObCW8Y5od9jpcUBM6J0Vn4dEtzklPyF+kKWXWDA98vJN
ECrNvAkjKKid5UiFbEz9zXDLAMXSjO5fBNmOAE51NXkItBGW5UHsvhZiTZKliaVF
RJWXSt9B334jnh4Ina0VHQ1lWbqe7wyrAPECA71TkWn3XW3+RDshkt0i9UW182Lv
BYp61dwnX1OVVTAdg53fAG8BTtzl48NxDoQo7DgPOE1enjqaqItPbeTOghgZMTQX
E5794raSTmK7OnVDMR4jlXVOwxNP0OR59KVFMAj26+Xt5J0FIDjs96ixS0G4YIV6
Z2G97ZwiTQkz7sEmoIrqu5cBH/yC7Rch6RNJX9JcWZ+xFz1gOHo=
=iHF2
-----END PGP SIGNATURE-----

--zi2v6czqackkf7cm--
