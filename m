From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Sat, 28 Apr 2007 08:18:16 +1000
Message-ID: <1177712296.4737.182.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427145212.GO22250@elf.ucw.cz>
	<1177709523.4737.157.camel@nigel.suspend2.net>
	<20070427221234.GE2994@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0764341946853417753=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427221234.GE2994@elf.ucw.cz>
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
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0764341946853417753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VHc5rBd0pcxBSfXwN+sO"


--=-VHc5rBd0pcxBSfXwN+sO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 00:12 +0200, Pavel Machek wrote:
> Hi!
>=20
> > > NAK. This slows down regular operation, at it is 30 lines for what
> > > should have been one (or five).
> >=20
> > Count them. It is one line (an if statement) plus seven lines of
> > comment.
>=20
> You count them. Hint... you'll need to read original patch.

Ah. You're assuming this is the only use of freezer_is_on().

> > > Just place avenrun[0] =3D avenrun[1] =3D avenrun[2] =3D 0 at strategi=
c place
> > > if you feel strongly about this. Additional points for using Rafael's
> > > "suspend done" notifier so that you don't have to modify suspend core=
.
> >=20
> > =3D0 might not be right. If you did have a high load average prior to
> > suspending, not delivering email would be the right thing to do.
>=20
> Ok, so =3D0 is not right, but it is better than adding 30lines of junk
> to the kernel.
>=20
> NAK on this patch. Original behaviour is acceptable.

to someone who IIRC correctly recently said he doesn't even use the
code.

Nigel

--=-VHc5rBd0pcxBSfXwN+sO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMnaoN0y+n1M3mo0RAivTAKDKBLS+VDB6Z35w4k64Wv6QRggnZACcCCbW
fZ39rlNGcY3Dm+M/jQgZZt4=
=+sTX
-----END PGP SIGNATURE-----

--=-VHc5rBd0pcxBSfXwN+sO--


--===============0764341946853417753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0764341946853417753==--
