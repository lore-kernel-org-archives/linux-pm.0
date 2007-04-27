From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 17:24:21 +0200
Message-ID: <1177687461.3565.38.camel__4694.13641044429$1177687614$gmane$org@johannes.berg>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<200704271712.10437.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2207529496777987232=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704271712.10437.rjw@sisk.pl>
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
Cc: Nick Piggin <npiggin@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============2207529496777987232==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-INcQ7+TQSCuO2zSTGcof"


--=-INcQ7+TQSCuO2zSTGcof
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 17:12 +0200, Rafael J. Wysocki wrote:

> How do we differentiate between post_snapshot() and post_restore()?
> I mean, after the restore we're entering the same code path as after the
> snapshot, so do we use a global var for this purpose?

That's pretty easy to do though, we already know at which point we are
so we just put an if(...) invoke_post_snapshot() else
invoke_post_restore().

johannes

--=-INcQ7+TQSCuO2zSTGcof
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMhWk/ETPhpq3jKURAgNxAJ47oSJKr42rumptaXtODIh0MDXRrgCeJtPO
mjoso3FT4UVzC4rLOMpwL2Y=
=rIX7
-----END PGP SIGNATURE-----

--=-INcQ7+TQSCuO2zSTGcof--


--===============2207529496777987232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2207529496777987232==--
