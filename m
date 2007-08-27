From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot
	kernel support on x86_64
Date: Mon, 27 Aug 2007 13:09:47 +0200
Message-ID: <1188212987.7837.5.camel@johannes.berg>
References: <200708241206.57178.rjw@sisk.pl>
	<20070824162346.ec57f508.akpm@linux-foundation.org>
	<1188069225.9529.23.camel@johannes.berg>
	<200708271306.46778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9016208574516653883=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708271306.46778.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Pavel@smtp2.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============9016208574516653883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-a8szxdRAbelrfnnUkXO7"


--=-a8szxdRAbelrfnnUkXO7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-08-27 at 13:06 +0200, Rafael J. Wysocki wrote:

> Well, I don't like the "weak symbols" stuff, but I have managed to limit =
the
> number of additional #ifdefs in snapshot.c to just one.
>=20
> The "generic" patch is now the following:

Fine with me, I was just throwing out ideas anyway :)

johannes

--=-a8szxdRAbelrfnnUkXO7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG0rD7/ETPhpq3jKURAkH5AJoD/5QoDWUKD+z+Zbxtmt+Y/0UwcACdGORZ
Xdlc9B58E0uQZ2076XKXmM8=
=Sl+6
-----END PGP SIGNATURE-----

--=-a8szxdRAbelrfnnUkXO7--


--===============9016208574516653883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9016208574516653883==--
