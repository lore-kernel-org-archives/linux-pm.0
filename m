From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 20:24:58 +0200
Message-ID: <20170716182457.GC14461@amd>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1703157.S2GHVxrQk4@aspire.rjw.lan>
 <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
 <3675920.H2f5xgTCgu@aspire.rjw.lan>
 <20170716133832.mnuaie4jnlwu6dwj@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44206 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGPSY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 14:24:59 -0400
Content-Disposition: inline
In-Reply-To: <20170716133832.mnuaie4jnlwu6dwj@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Florian Fainelli <f.fainelli@gmail.com>, Mason <slash.tmp@free.fr>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There still will be a concern regarding drivers that care about differe=
nces between
> > PM_SUSPEND_MEM and PM_SUSPEND_STANDBY, because those differences are
> > platform-dependent, but let's defer addressing this until we have a dri=
ver
> > that needs to run on different platforms with different definitions for=
 those
> > things.
> >=20
>=20
> We already have the case for drivers/net/ethernet/cadence/ and
> drivers/net/can/m_can/ and many of the at91 drivers. Depending on the
> specific SoC they run on, PM_SUSPEND_MEM may or may not cut VDDcore or
> may or may not change the peripheral clock.

Please please introduce will_vddcore_be_cut_down() or similar helper,
so that we have one place to fix..

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllrr3kACgkQMOfwapXb+vLyZwCgg8lk+DtZzn2FA0ATwNAlK6EM
vAsAoLjWMmWTYro3F6b8XZSaR4di4Am6
=+Baq
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
