From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 11:41:55 +0200
Message-ID: <1177666915.7828.35.camel__21665.7735327773$1177667200$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <200704262040.31760.rjw@sisk.pl>
	<1177612802.6814.121.camel@johannes.berg>
	<200704262102.38568.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3151674759677673979=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704262102.38568.rjw@sisk.pl>
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
Cc: Nick Piggin <npiggin@suse.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============3151674759677673979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sx0pN/4AmYPOBo7ZlVak"


--=-sx0pN/4AmYPOBo7ZlVak
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-26 at 21:02 +0200, Rafael J. Wysocki wrote:

> Yes.  That's because we want to be able to repeat creating the image
> without closing the fd in some situations.

Oh yeah, I just checked and it's not in fact necessary. I'm just
confused.

> Still, we could use a global var 'platform_hibernation' or something like=
 this,
> I think.  Then, we can do
>=20
> #define platform_hibernation	0
>=20
> on the architectures that don't need it and make ACPI use it instead of t=
his
> "dynamic linking".

No, because acpi doesn't know at build time whether it can actually do
S4 or not.

johannes

--=-sx0pN/4AmYPOBo7ZlVak
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMcVj/ETPhpq3jKURAmB6AKCpfdLNEeTvIqeZrHsehiRh+q545wCgo1nU
i/lNjbTZPhyGSdDmbHpra5w=
=TVqT
-----END PGP SIGNATURE-----

--=-sx0pN/4AmYPOBo7ZlVak--


--===============3151674759677673979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3151674759677673979==--
