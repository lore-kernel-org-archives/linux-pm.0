From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/12][v4] x86-32, hibernate: Use temp_pgt as the
 temporary page table
Date: Fri, 21 Sep 2018 13:21:55 +0200
Message-ID: <20180921112155.GA7102@amd>
References: <cover.1537448058.git.yu.c.chen@intel.com>
 <ca2e027db5bd990ffebed9086db3dac335afdf64.1537448058.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ca2e027db5bd990ffebed9086db3dac335afdf64.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-21 14:27:51, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
>=20
> This is to reuse the temp_pgt for both 32bit and 64bit
> system.
>=20
> No functional change.

I'd say this is functional change. "No functional change" normally
means "compiled code has not changed".

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluk1FMACgkQMOfwapXb+vIcSwCeJW25JAqEIDxy7u9CC6ZvLaGm
69oAnRbUEkklgJ4bZl85EcgUZeZYlLgh
=SwTA
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
