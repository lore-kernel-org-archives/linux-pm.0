From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Free more memory
Date: Sun, 22 Apr 2007 09:31:39 +1000
Message-ID: <1177198299.4036.8.camel@nigel.suspend2.net>
References: <200704220002.37083.rjw@sisk.pl> <200704220005.39942.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7489039532506530912=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704220005.39942.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============7489039532506530912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GtuFRV0k4/sVVi3JYEUw"


--=-GtuFRV0k4/sVVi3JYEUw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sun, 2007-04-22 at 00:05 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Move the definition of PAGES_FOR_IO to kernel/power/power.h and introduce
> SPARE_PAGES representing the number of pages that should be freed by the
> swsusp's memory shrinker in addition to PAGES_FOR_IO so that device drive=
rs can
> allocate some memory (up to 1 MB total) in their .suspend() routines with=
out
> causing the suspend to fail.

1MB is not going to be enough for people with DRI. I have a cycle on my
machine recording 3510 extra pages (13 meg) allocated during the atomic
copy, and I know there are others with larger numbers.

Nigel

--=-GtuFRV0k4/sVVi3JYEUw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGKp7bN0y+n1M3mo0RApL+AKDLfd+bh3hpmblMDXZPN3AyqTq43ACgvo/a
0y9NvN6THre+l0hMiT7VyK8=
=Dkkb
-----END PGP SIGNATURE-----

--=-GtuFRV0k4/sVVi3JYEUw--


--===============7489039532506530912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7489039532506530912==--
