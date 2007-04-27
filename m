From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 14:46:42 +0200
Message-ID: <1177678002.6024.11.camel__23219.4252698266$1177678306$gmane$org@johannes.berg>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
	<200704271407.00879.rjw@sisk.pl>
	<20070427124029.GH22250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5183451244969025304=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427124029.GH22250@elf.ucw.cz>
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
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============5183451244969025304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pcXzd7RiCtDbVasHyGX3"


--=-pcXzd7RiCtDbVasHyGX3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 14:40 +0200, Pavel Machek wrote:

> > Five callbacks are fine by me, especially if we can define reasonable d=
efaults
> > for the hibernation (and can we?).
>=20
> Well, we still can default to suspend(PMSG_FREEZE) for freeze(), and
> resume() for thaw(). Anything else is just not sane way forward.

I think we should remove the argument to suspend() in the same patch
series. Yes, that would mean porting all drivers that currently use it,
but that's not actually all that many since most drivers are dumbed-down
wrt. power management.

And realistically, resume for thaw makes no sense, nor does suspend for
freeze, so we probably want to change those over to suspend/restart and
use them. or something.

johannes

--=-pcXzd7RiCtDbVasHyGX3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMfCy/ETPhpq3jKURAvgfAKCkr5+8OohXwg+2mpD5/9Ck7bZb9wCdGagf
Lobd27HlV2zLmB2uxffXcaA=
=I2Ch
-----END PGP SIGNATURE-----

--=-pcXzd7RiCtDbVasHyGX3--


--===============5183451244969025304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5183451244969025304==--
