From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] PM / Domains: Fix a warning message
Date: Thu, 10 Nov 2016 17:33:31 +0100
Message-ID: <20161110163331.GC28832@amd>
References: <20161110125215.GA18664@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56269 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934104AbcKJQdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 11:33:41 -0500
Content-Disposition: inline
In-Reply-To: <20161110125215.GA18664@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-11-10 15:52:15, Dan Carpenter wrote:
> The first argument of WARN() is the condition, followed by the message.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgkoVsACgkQMOfwapXb+vLa9gCdFfUAil7/xUrv212yznNwQeEJ
SlsAnA5zcSLRH49JveK1jvBQceyjnPOa
=VCFk
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
