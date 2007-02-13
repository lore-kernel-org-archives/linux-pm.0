From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] power management: no valid	states	w/o	pm_ops
	+ docs
Date: Tue, 13 Feb 2007 19:02:41 +0100
Message-ID: <1171389761.10344.66.camel@johannes.berg>
References: <1171383980.10344.39.camel@johannes.berg>
	<20070213092357.7ea02880.randy.dunlap@oracle.com>
	<1171388184.10344.55.camel@johannes.berg> <45D1F835.9030103@oracle.com>
	<1171389259.10344.62.camel@johannes.berg> <45D1FBEE.2010505@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1989409269=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45D1FBEE.2010505@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1989409269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9AstJEN2jHf1QINXsm5a"


--=-9AstJEN2jHf1QINXsm5a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-13 at 09:57 -0800, Randy Dunlap wrote:

> Uh, please try one more thing.  Delete the '*' line between
>  * struct pm_ops - Callbacks ...
>=20
> and the struct members list and retest that.

Yeah, that causes the empty description to disappear (which actually is
also present in -text output)...

but doesn't cause the "Callbacks ..." text to appear anywhere in html
output.

johannes

--=-9AstJEN2jHf1QINXsm5a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF0f1B/ETPhpq3jKURAhamAKCOZgSDHFQ/DB4+YTTL5skJkeAtbACePkIX
Ejz788C9uBfpO/THF+lhHZs=
=beC/
-----END PGP SIGNATURE-----

--=-9AstJEN2jHf1QINXsm5a--


--===============1989409269==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1989409269==--
