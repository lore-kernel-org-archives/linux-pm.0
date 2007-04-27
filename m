From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 17:27:18 +0200
Message-ID: <1177687638.3565.42.camel__20518.251139629$1177687763$gmane$org@johannes.berg>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<1177684764.3565.20.camel@johannes.berg>
	<1177685391.3565.22.camel@johannes.berg>
	<200704271720.08150.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811077807960666157=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704271720.08150.rjw@sisk.pl>
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
Cc: Nick Piggin <npiggin@suse.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============2811077807960666157==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-osp2hhg194W4i3Vhs4fx"


--=-osp2hhg194W4i3Vhs4fx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 17:20 +0200, Rafael J. Wysocki wrote:

> I think we can use 'stages' and pass them as arguments to the functions.
>=20
> In that case we can have two callbacks for the hibernation (I'd prefer to=
 say
> 'hibernation' instead of 'suspend to disk' from now on), one 'quiesce' ca=
llback
> and one 'activate' callback that can be called many times in one
> snapshot/restore cycle with different arguments, for example:

But you're not proposing to add suspend/resume to this interface too, I
hope :)

> quiesce(PREPARE) -- that may be needed for drivers that allocate much mem=
ory
> before quiescing devices (if any)
> ...
> quiesce(PRE_SNAPSHOT)
> ...
> quiesce(PRE_SNAPSHOT_IRQ_OFF)
> ...
> activate(POST_SNAPSHOT_IRQ_OFF)
> ...
> activate(POST_SNAPSHOT)
> ...
> activate(FINISH)

I'm still not sure I like having to switch on the argument for every
implementation. Is it really worth it?

johannes

--=-osp2hhg194W4i3Vhs4fx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMhZW/ETPhpq3jKURAjCcAKCLAlJhQHeG4dnh1E0Wo7XnhNY/CACghT5L
RTKQbNIAYC7XxiC1X6AN8W8=
=XxdO
-----END PGP SIGNATURE-----

--=-osp2hhg194W4i3Vhs4fx--


--===============2811077807960666157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811077807960666157==--
