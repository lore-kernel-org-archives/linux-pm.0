From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] power management: no	valid	states	w/o	pm_ops
	+ docs
Date: Tue, 13 Feb 2007 19:08:56 +0100
Message-ID: <1171390136.10344.72.camel@johannes.berg>
References: <1171383980.10344.39.camel@johannes.berg>
	<20070213092357.7ea02880.randy.dunlap@oracle.com>
	<1171388184.10344.55.camel@johannes.berg> <45D1F835.9030103@oracle.com>
	<1171389259.10344.62.camel@johannes.berg> <45D1FBEE.2010505@oracle.com>
	<1171389761.10344.66.camel@johannes.berg> <45D1FD8F.1090204@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0251767963=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45D1FD8F.1090204@oracle.com>
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


--===============0251767963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-o+pn8DnmurLhW6dXqQ2X"


--=-o+pn8DnmurLhW6dXqQ2X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-13 at 10:03 -0800, Randy Dunlap wrote:
> Johannes Berg wrote:
> > On Tue, 2007-02-13 at 09:57 -0800, Randy Dunlap wrote:
> >=20
> >> Uh, please try one more thing.  Delete the '*' line between
> >>  * struct pm_ops - Callbacks ...
> >>
> >> and the struct members list and retest that.
> >=20
> > Yeah, that causes the empty description to disappear (which actually is
> > also present in -text output)...
> >=20
> > but doesn't cause the "Callbacks ..." text to appear anywhere in html
> > output.
>=20
> OK, I'll work on it.  Thanks.

Ok. I'll send the patch modified according to your comments in a second.
Thanks.

johannes

--=-o+pn8DnmurLhW6dXqQ2X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF0f64/ETPhpq3jKURAr3KAJ4n2Eiz7YIxNYBPvUWBPN/UAVwgvQCeKLtz
/mAwFMw5lY7xQCBuGo66PV4=
=Nncx
-----END PGP SIGNATURE-----

--=-o+pn8DnmurLhW6dXqQ2X--


--===============0251767963==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0251767963==--
