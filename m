From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 2.6.22-rc2 built on ppc (1)
Date: Sat, 9 Jun 2007 19:06:47 +0200
Message-ID: <20070609170647.GA5358@frodo.home.lxtec.de>
References: <20070520110625.GC3253@aragorn.home.lxtec.de>
	<200705201336.05205.rjw@sisk.pl>
	<1179661437.3590.11.camel@johannes.berg>
	<20070609141421.GC3397@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4434002763508610220=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070609141421.GC3397@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============4434002763508610220==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 09 Jun 2007 the mental interface of
Pavel Machek told:

> Hi!
>=20
> > > > kernel/power/swsusp.c: In function 'swsusp_show_speed':
> > > > kernel/power/swsusp.c:193: warning: comparison of distinct pointer =
types lacks a cast
> > >=20
> > > Well, this warning doesn't make sense.  In 2.6.22-rc2 line 193 of sws=
usp.c is
> > >=20
> > > do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
> > >=20
> > > where elapsed_centisecs64 is s64.
> >=20
> > yeah, and the do_div64 macro is then comparing (s64*) =3D=3D (u64*) in a
> > null-statement and tells you that the types are different. I tracked
> > this a long time ago and figured it wasn't worth thinking about.
>=20
> Elimar, can you modify the code to=20
>=20
> do_div(elapsed_centisecs64, (s64) NSEC_PER_SEC / 100);
>=20
> ...to see if the warning goes away?

Same warning :(

Elimar

--=20
  It's a good thing we don't get all=20
  the government we pay for.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGat4n3Ig8bsVPf7ARAmh/AKChslabNWGx5CKWA0W1VUOXQt65xACdF2iy
F0WT5fvlDbbgv80vK8vFXl4=
=Yw43
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

--===============4434002763508610220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4434002763508610220==--
