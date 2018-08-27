From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] x86, hibernate: Extract the common code of 64/32 bit
 system
Date: Mon, 27 Aug 2018 11:48:48 +0200
Message-ID: <20180827094848.GB31905@amd>
References: <cover.1535361949.git.kookoo.gu@intel.com>
 <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zhimin <kookoo.gu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Yu Chen <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-08-27 17:42:19, Gu Zhimin wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
>=20
> Reduce the hibernation code duplication between x86-32 and x86-64
> by extracting the common code into hibernate.c.
>=20
> No functional change.
>=20
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>

Thanks a lot for doing this.

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDyQAACgkQMOfwapXb+vKvBgCgq52QQuIk9T1tILCZZp2tjASs
jWQAn0bnY9vx0LapJL8MiWh03Ci9qZpm
=CEYt
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
