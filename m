From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Hibernate: use rb_entry instead of container_of
Date: Mon, 19 Dec 2016 21:08:45 +0100
Message-ID: <20161219200845.GB7135@amd>
References: <c479dd32fab44ad1cda6dc4f2e0d70e617608afe.1482159675.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40361 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcLSUIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 15:08:48 -0500
Content-Disposition: inline
In-Reply-To: <c479dd32fab44ad1cda6dc4f2e0d70e617608afe.1482159675.git.geliangtang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-12-19 23:03:11, Geliang Tang wrote:
> To make the code clearer, use rb_entry() instead of container_of() to
> deal with rbtree.
>=20
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhYPk0ACgkQMOfwapXb+vJ/NgCgg8xJAkJluMy9H7IcXRWqIpWq
3vYAoMD32M8E4Avg7VvmwXU8DgmbxfPZ
=H2FO
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
