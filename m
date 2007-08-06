From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 06 Aug 2007 11:29:51 +0200
Message-ID: <1186392591.28655.35.camel__49219.6879037239$1186392573$gmane$org@johannes.berg>
References: <200708051906.22865.rjw@sisk.pl>
	<20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4932052347595405233=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
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


--===============4932052347595405233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+qbqYYTwXoVvc/ZA0mqh"


--=-+qbqYYTwXoVvc/ZA0mqh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-08-06 at 11:07 +0200, Pavel Machek wrote:
> Hi!
>=20
> > +config SUSPEND_UP_POSSIBLE
> > +	bool
> > +	depends on (X86 && !X86_VOYAGER) || (PPC32 && PPC_MPC52xx) \
> > +		   || (PPC64 && (PPC_PSERIES || PPC_PMAC)) || ARM || BLACKFIN \
> > +		   || MIPS || SUPERH || FRV
> > +	depends on !SMP
> > +	default y
>=20
> I guess I'd rather left SUSPEND_UP_POSSIBLE to allways y (as it always
> was), and let architectures that can't handle it  not return "mem"
> from list of valid states...

Yeah, that's the utterly broken interface we used to have. Until I fixed
it to have no valid states until architectures implement suspend_ops.
Still, I disagree, why bother with compiling code that can't ever be
used?

johannes

--=-+qbqYYTwXoVvc/ZA0mqh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGtuoP/ETPhpq3jKURAtl9AKCZV5oFZ/uHnjhCSL+vgMo6fnub6gCeOiBY
LxfwT9+1NwXAFkhhkWEfHyM=
=oiNh
-----END PGP SIGNATURE-----

--=-+qbqYYTwXoVvc/ZA0mqh--


--===============4932052347595405233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4932052347595405233==--
