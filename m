From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Thu, 26 Apr 2007 20:40:02 +0200
Message-ID: <1177612802.6814.121.camel__43780.9208677665$1177612900$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <20070426113005.GU17387@elf.ucw.cz>
	<1177605074.6814.93.camel@johannes.berg>
	<200704262040.31760.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4912827458877093985=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704262040.31760.rjw@sisk.pl>
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


--===============4912827458877093985==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lZLPfwsUVRjZkhfGFaId"


--=-lZLPfwsUVRjZkhfGFaId
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-26 at 20:40 +0200, Rafael J. Wysocki wrote:

> >  * it surfaces kernel implementation details about pm_ops and thus make=
s
> >    the whole thing very fragile
>=20
> Can you elaborate?

Well it tells userspace about pm_ops->enter/prepare/finish etc.
Also, it seems that it needs a "release memory now" operation instead of
just releasing it when the fd is closed?

> >  * it has yet another interface (yuck) to determine whether to reboot,
> >    shut down etc, doesn't use /sys/power/disk
>=20
> Yes.  In fact it was meant as a replacement for /sys/power/disk at one po=
int.

Heh.

> >  * I generally had no idea wtf it is doing in some places
>=20
> I could have told you if you had asked. :-)

I was offline ;)

> Do we need hibernate_ops at all?  There's only one user anyway and I'm no=
t
> sure there will be more of them in the future.

I'm pretty sure there won't be, but there's no way to do it cleanly
without pm_ops since even acpi doesn't do this all the time but only
when some set of conditions is true. Hence, it needs to be able to
determine the availability of the platform mode at run time rather than
build time (build time =3D> we could use weak symbols, arch hooks, ...)

johannes

--=-lZLPfwsUVRjZkhfGFaId
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMPIC/ETPhpq3jKURAtaIAKCuVH219VocWWLOCTcozP04ixT7NQCgs9nf
IHsFZ7KIZkHZ9KRWkoAxMLI=
=fvL4
-----END PGP SIGNATURE-----

--=-lZLPfwsUVRjZkhfGFaId--


--===============4912827458877093985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4912827458877093985==--
