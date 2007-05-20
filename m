From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.22-rc2 built on ppc (1)
Date: Sun, 20 May 2007 13:43:57 +0200
Message-ID: <1179661437.3590.11.camel@johannes.berg>
References: <20070520110625.GC3253@aragorn.home.lxtec.de>
	<200705201336.05205.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7487822594669624612=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705201336.05205.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Elimar Riesebieter <riesebie@lxtec.de>
List-Id: linux-pm@vger.kernel.org


--===============7487822594669624612==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aIkb5Qg4QI+6sMMun3rD"


--=-aIkb5Qg4QI+6sMMun3rD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > kernel/power/swsusp.c: In function 'swsusp_show_speed':
> > kernel/power/swsusp.c:193: warning: comparison of distinct pointer type=
s lacks a cast
>=20
> Well, this warning doesn't make sense.  In 2.6.22-rc2 line 193 of swsusp.=
c is
>=20
> do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
>=20
> where elapsed_centisecs64 is s64.

yeah, and the do_div64 macro is then comparing (s64*) =3D=3D (u64*) in a
null-statement and tells you that the types are different. I tracked
this a long time ago and figured it wasn't worth thinking about.

johannes

--=-aIkb5Qg4QI+6sMMun3rD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGUDR8/ETPhpq3jKURAofVAJ9bFmQ08dMGrcFRzovEZy+cXsWwUACghnFo
IqlYdqkiXVSaLd0N2Xisoog=
=pwqc
-----END PGP SIGNATURE-----

--=-aIkb5Qg4QI+6sMMun3rD--


--===============7487822594669624612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7487822594669624612==--
