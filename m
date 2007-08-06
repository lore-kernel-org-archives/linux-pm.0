From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 06 Aug 2007 13:15:17 +0200
Message-ID: <1186398917.28655.69.camel__20098.2808987193$1186398864$gmane$org@johannes.berg>
References: <200708051906.22865.rjw@sisk.pl>
	<20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
	<1186392591.28655.35.camel@johannes.berg>
	<20070806102659.GB1875@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1597610723216401532=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806102659.GB1875@elf.ucw.cz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============1597610723216401532==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mrJELG6XDpXKm7avtq0/"


--=-mrJELG6XDpXKm7avtq0/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-08-06 at 12:26 +0200, Pavel Machek wrote:

> Well, so that it does not bitrot? This is few bytes, I'd say, and I
> believe we have too many config options already.

This is not an option the user is ever going to see. I think I'd prefer
having two new per-ARCH config symbols though:
config SUSPEND_UP_POSSIBLE
	depends on ARCH_SUSPEND_UP_POSSIBLE

and then the architecture gets to define that when it can suspend.

johannes

--=-mrJELG6XDpXKm7avtq0/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGtwLF/ETPhpq3jKURAlcOAJ9oVWMuve3lFO+jNDAUNnkXwDeGYQCeIQJR
dXZuA0J+Jvb26OhTFAnG2Mc=
=nD1a
-----END PGP SIGNATURE-----

--=-mrJELG6XDpXKm7avtq0/--


--===============1597610723216401532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1597610723216401532==--
