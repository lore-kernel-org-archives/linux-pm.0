From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.22-rc2 built on ppc (1)
Date: Mon, 11 Jun 2007 10:26:50 +0200
Message-ID: <1181550410.3566.45.camel@johannes.berg>
References: <20070520110625.GC3253@aragorn.home.lxtec.de>
	<200705201336.05205.rjw@sisk.pl>
	<1179661437.3590.11.camel@johannes.berg>
	<20070609141421.GC3397@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5308819649690818742=="
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
Cc: linux-pm@lists.linux-foundation.org, Elimar Riesebieter <riesebie@lxtec.de>
List-Id: linux-pm@vger.kernel.org


--===============5308819649690818742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Pt6RpoTMJ53TjGIbMjiG"


--=-Pt6RpoTMJ53TjGIbMjiG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-06-09 at 16:14 +0200, Pavel Machek wrote:

> Elimar, can you modify the code to=20
>=20
> do_div(elapsed_centisecs64, (s64) NSEC_PER_SEC / 100);

That wouldn't help since the u64 is hardcoded. Changing
elapsed_centisecs64 to s64 should help but doesn't seem right either.
The warning is just bogus.

johannes

--=-Pt6RpoTMJ53TjGIbMjiG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGbQdK/ETPhpq3jKURAkpaAKCwJ1nUEhkUm9ZbW8Up3OTFcEqxygCgqS4q
Iy4HNkTmEO5eRWTz/gxGElc=
=q7yY
-----END PGP SIGNATURE-----

--=-Pt6RpoTMJ53TjGIbMjiG--


--===============5308819649690818742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5308819649690818742==--
