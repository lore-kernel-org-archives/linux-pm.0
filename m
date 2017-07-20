From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / suspend: Add suspend_target_state()
Date: Thu, 20 Jul 2017 10:03:26 +0200
Message-ID: <20170720080326.GA13103@amd>
References: <2615c143-6cb2-1b89-d453-921306d665b6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55882 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdGTID2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 04:03:28 -0400
Content-Disposition: inline
In-Reply-To: <2615c143-6cb2-1b89-d453-921306d665b6@gmail.com>
 <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-17 13:06:28, Florian Fainelli wrote:
> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via suspend_target_state() in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().
>=20
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwY84ACgkQMOfwapXb+vKF5ACeJTIFwpo4dtQf6sY3miTEJ2eW
YqAAoJriVStVYjPAY3FkpsGX5ykFlzMQ
=QOh3
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
