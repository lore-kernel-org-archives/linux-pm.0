From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: SMP suspend broken due to "swsusp: Change
	code	ordering in disk.c" et al.
Date: Sat, 24 Feb 2007 22:07:57 +0100
Message-ID: <1172351277.3870.123.camel@johannes.berg>
References: <1172201385.15769.32.camel@johannes.berg>
	<1172277080.3870.108.camel@johannes.berg>
	<200702240957.22636.rjw@sisk.pl> <200702242154.27167.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2032776942=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702242154.27167.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm@lists.osdl.org, Dave Vasilevsky <djvasi@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============2032776942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oH6Khw/xiXqFTi6k4Sca"


--=-oH6Khw/xiXqFTi6k4Sca
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-02-24 at 21:54 +0100, Rafael J. Wysocki wrote:

> No, this one is better IMO.
>=20
> Appended is the version against 2.6.21-rc1.  It seems to work for me, but=
 I'd
> like someone else to confirm it.

I'll give it a try at the beginning of next week, thanks.

johannes

--=-oH6Khw/xiXqFTi6k4Sca
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF4Kkt/ETPhpq3jKURAtXQAJ9UmrR3kUWjD0nV5CuoohePOgnY3ACeKY5r
nVfEsVNzKu1Q6tyM5S1j31w=
=lrWQ
-----END PGP SIGNATURE-----

--=-oH6Khw/xiXqFTi6k4Sca--


--===============2032776942==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2032776942==--
