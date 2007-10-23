From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hibernate fails to freeze tasks
Date: Tue, 23 Oct 2007 14:34:19 +0200
Message-ID: <1193142859.7733.5.camel@johannes.berg>
References: <1193062945.9793.15.camel@johannes.berg>
	<200710230036.37838.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432475738675527462=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710230036.37838.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0432475738675527462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BO+Q5I5qFsckbUzAIFV3"


--=-BO+Q5I5qFsckbUzAIFV3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-23 at 00:36 +0200, Rafael J. Wysocki wrote:

> Please try the patch below.

Now it fails at "freezing remaining freezable tasks" (even tries twice.)
This is due to windfarm using
	if (signal_pending() && !try_to_freeze())
and your commit d5d8c5976d6adeddb8208c240460411e2198b393.

I'll post a fix for windfarm, just tested it and it works now, thanks.

johannes

--=-BO+Q5I5qFsckbUzAIFV3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx3qSqVg1VMiehFYAQLgIhAAvqptJ5bzgTwKd9Ll0o3R/tW4t8YoOxbF
sJL8ixg1etcqsHl3m87WemnOakHlRrOylFKlqqUWtvN2V5xeYjsmy3zFoUdnaYa8
yxLk16GOC/JcYQW7RtEsaMT1af/6QR1Wp1WAk8zmKtzwq34/m/10JyiAdK8RP0lx
jeT622Ev01Ry/QzkyPYvIBESTknzCNtm8Z8SenlHaknvXpBxpV9haZcGvw/xidbk
pg+KrgQxW9xPazXhf4b6bM+I4Lzg9PkDNbeVhq8qKGkpza2ZW3fZNhr/5EPRJLje
n3MWN1W90kqfaWgSgsakyNZWDsfwkh28aZCWDEhgH0fAKfPp8qf9z+OjXGrd8I1L
RVO54kqPK71X8ccfjpl5TMo4uBQ8BjCFZ2LsbABd+aeSyRhTmdyB1tclXgShhKWd
kEMieZVsdQ0x1/61gTs9aODsTGgEr9viLs0Rx68VbtQFGTFCKjNUrGylbeEynxTy
uZyUD7FCXZ65Knb4Q+diQquCpp8V9IVJCix5+9UFac2QhldKb5g9IkrdhxpGzbDg
BkXNnGAYq6q7gaAVLj0LxKlxn9HvPs4pkvXvMHuDnCYowTu3vdOF4EEVIuF59ZW4
xRcbC8XAw+GyUVG6ySecAIG2BIjYq8lBY5lUAwgh+7S92FXsJpNZuNbRgXxw5FXH
4P1JF4aBKfE=
=eZRR
-----END PGP SIGNATURE-----

--=-BO+Q5I5qFsckbUzAIFV3--


--===============0432475738675527462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0432475738675527462==--
