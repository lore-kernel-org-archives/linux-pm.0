From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Fri, 18 May 2007 09:20:22 +0200
Message-ID: <1179472822.3658.17.camel@johannes.berg>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
	<200705161534.42740.rjw@sisk.pl> <200705171044.26662.marcus@better.se>
	<20070517092809.GA4608@ucw.cz> <f2i2ho$l8p$1@sea.gmane.org>
	<f2i8i9$p84$1@sea.gmane.org>  <f2igtc$ucu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8745916640534055676=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f2igtc$ucu$1@sea.gmane.org>
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
To: Marcus Better <marcus@better.se>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============8745916640534055676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-F8p2L0V8bZ9n1ieNUglr"


--=-F8p2L0V8bZ9n1ieNUglr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-17 at 23:19 +0200, Marcus Better wrote:
> Marcus Better wrote:
> > Results so far: Commit 7b104bcb8e460e45a1aebe3da9b86aacdb4cab12 is bad,
>=20
> Forget it, the bisection was borked...

fw-ohci is new anyway and I don't think it has seen many revisions
in-tree. It's loaded on my machine too but lost against ohci1394 so it's
not actually in use.

johannes

--=-F8p2L0V8bZ9n1ieNUglr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGTVO1/ETPhpq3jKURAj1ZAKCKsPB8/1H67MacJS8+PQVk+YvHywCeLUGz
pPETQKMRi3dslpFOWyzdZfU=
=1Qg9
-----END PGP SIGNATURE-----

--=-F8p2L0V8bZ9n1ieNUglr--


--===============8745916640534055676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8745916640534055676==--
