From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: Use a more common logging style
Date: Wed, 27 Sep 2017 21:27:37 +0200
Message-ID: <20170927192737.GA30251@amd>
References: <601f12130753cff63677db1655587ad9682f4165.1506532371.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41382 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdI0T1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 15:27:40 -0400
Content-Disposition: inline
In-Reply-To: <601f12130753cff63677db1655587ad9682f4165.1506532371.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-09-27 10:17:57, Joe Perches wrote:
> Convert printks to pr_<level>.
>=20
> Miscellanea:
>=20
> o Use pr_fmt with "PM:" and remove "PM: " from format strings
> o Coalesce format strings and realign format arguments
> o Convert an embedded incorrect function name to "%s: ", __func__
> o Convert a couple multi-line formats to multiple pr_<level> calls
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnL+6kACgkQMOfwapXb+vJBoACgjUthT4X3lPp+nCEkZYCmDbvE
HR0An2DyzTG+Rjp0zUvk93mspyzZs4DQ
=VRt+
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
