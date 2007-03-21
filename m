From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 13:31:16 +0100
Message-ID: <1174480277.4230.9.camel@johannes.berg>
References: <1174468281.3769.7.camel@johannes.berg>
	<20070321122820.GA4523@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1858235358=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321122820.GA4523@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1858235358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uBOqlQ2bnoTV72XBp2M7"


--=-uBOqlQ2bnoTV72XBp2M7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 13:28 +0100, Pavel Machek wrote:

> > compat code for the ioctl which shares pointers and structs, is there
> > any way to make it possible?
>=20
> That means that either ioctl is very hw-specific, or you've found a
> bug.

I think I'll just have to give it a try.

johannes

--=-uBOqlQ2bnoTV72XBp2M7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGASWU/ETPhpq3jKURAi6RAJ0Y3UI82E+V+yciOQRXChOIDgM+MgCcCjYy
vMqvCeTUZ9CDnFg8XeMmFLg=
=coQY
-----END PGP SIGNATURE-----

--=-uBOqlQ2bnoTV72XBp2M7--


--===============1858235358==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1858235358==--
