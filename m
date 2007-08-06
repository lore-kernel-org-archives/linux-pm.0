From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 06 Aug 2007 13:22:42 +0200
Message-ID: <1186399362.28655.72.camel__38988.492874387$1186399298$gmane$org@johannes.berg>
References: <200708051906.22865.rjw@sisk.pl>
	<20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
	<1186392591.28655.35.camel@johannes.berg>
	<20070806102659.GB1875@elf.ucw.cz>
	<1186398917.28655.69.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4088273809572181480=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1186398917.28655.69.camel@johannes.berg>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org


--===============4088273809572181480==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SOplHz4CNfeIuhKF+5Sk"


--=-SOplHz4CNfeIuhKF+5Sk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-08-06 at 13:15 +0200, Johannes Berg wrote:

> config SUSPEND_UP_POSSIBLE
> 	depends on ARCH_SUSPEND_UP_POSSIBLE
>=20
> and then the architecture gets to define that when it can suspend.

In fact, just doing
	depends on (ARCH_SUSPEND_UP_POSSIBLE && !SMP) || (ARCH_SUSPEND_SMP_POSSIBL=
E && SMP)

would probably be good instead of doing the intermediate
SUSPEND_UP_POSSIBLE and SUSPEND_SMP_POSSIBLE. The reason I like this
better is that we don't have a central editing point where patches
conflict causing unnecessary problems. But both are much better than
what we have now anyway :)

johannes

--=-SOplHz4CNfeIuhKF+5Sk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGtwSC/ETPhpq3jKURAsauAJwO1qbIxGXE/0dJnhf0t4fDC0k8eACgtn/3
wdCXqNU8li3blQwkoiLEF6U=
=FL19
-----END PGP SIGNATURE-----

--=-SOplHz4CNfeIuhKF+5Sk--


--===============4088273809572181480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4088273809572181480==--
