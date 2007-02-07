From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
Date: Wed, 07 Feb 2007 13:22:13 +0100
Message-ID: <1170850933.6798.29.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206011949.GA15434@lixom.net>
	<1170726767.30959.30.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1066335362=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170726767.30959.30.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============1066335362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3WsPrBcdIIadqCoKjBUQ"


--=-3WsPrBcdIIadqCoKjBUQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-06 at 02:52 +0100, Johannes Berg wrote:
> How's this? Needs to go along with the correct changes in the code that
> uses it, of course.
>=20
> I can't use a local void * as you suggested because it needs to be added
> to as an unsigned long, but I can use a local unsigned long.
>=20
> Not even compiled yet.

which showed, it didn't compile but I sorted it out, will resend.

johannes

--=-3WsPrBcdIIadqCoKjBUQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD4DBQBFycR1/ETPhpq3jKURAoMdAJj/GT6pf6UBnC+cdA9eG+ZobrCQAJ4mLVM5
JNq1eZ3rZi12R6+o87LaSw==
=9aJr
-----END PGP SIGNATURE-----

--=-3WsPrBcdIIadqCoKjBUQ--


--===============1066335362==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1066335362==--
