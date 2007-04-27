From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 16:39:24 +0200
Message-ID: <1177684764.3565.20.camel__38452.5422043682$1177684834$gmane$org@johannes.berg>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5659052683345084344=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>, suspend2-devel@lists.suspend2.net, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============5659052683345084344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kTx9DZtB5Nmr/BrUDOKk"


--=-kTx9DZtB5Nmr/BrUDOKk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 10:34 -0400, Alan Stern wrote:

> For the sake of argument, let's call the stages of STD and STR by these=20
> names (also noted are the current PSMG values):
>=20
> 	Suspend to disk:
> 	"prepare to create snapshot" (=3D FREEZE)
> 	"continue after snapshot" (=3D RESUME)
>=20
> 	Resume from disk:
> 	"prepare to restore snapshot" (=3D PRETHAW)
> 	"continue after restore" (=3D RESUME)
>=20
> 	Suspend to RAM:
> 	"suspend" (=3D SUSPEND)
> 	"resume" (=3D RESUME)
>=20
> The real reason for adding PRETHAW was that drivers couldn't distinguish
> between "continue after restore" and "resume", other than by examining th=
e
> device's state -- since the PM core doesn't pass any information to the
> resume() method.

That's pretty much what I said about prethaw though, no? Anyway,

> Anyway, based on this analysis it seems reasonable to have Six (6) method=
=20
> pointers.  Suggested names (in the same order as above):
>=20
> 	pre_snaphot()
> 	post_snapshot()
> 	pre_restore()
> 	post_restore()
> 	suspend()
> 	resume()
>=20
> People apparently assume that pre_snapshot() and pre_restore() would=20
> always do the same thing and hence be redundant.  I'm not so sure; time=20
> will tell.  Doing it this way certainly is more clear.

Right. I did assume that pre_snapshot and pre_restore would be
effectively the same since they both have to quiesce the device and
assume not much more. I'm not averse to making it explicit, many drivers
that don't care can just assign the same function.

> Then there's the question of having early_ and late_ versions of some of=20
> these things (i.e., one called with interrupts enabled, the other with=20
> interrupts disabled).  I don't know to what extent that would be=20
> necessary; perhaps the each method call should occur in two phases with=20
> the interrupt-enable status changed in between.  Then the interrupt-enabl=
e=20
> setting could be passed as an argument.

Good point. Though if we go for passing the interrupt-enable setting as
an argument then many drivers will have the same
"if (irqs_disabled()) return" code. Hm. I guess passing it isn't even
strictly necessary.

johannes

--=-kTx9DZtB5Nmr/BrUDOKk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMgsb/ETPhpq3jKURAv1qAJ9a4tqCyMpTI+Yke4BzhI5QmNqfVACdFm3o
RQc5od63ibRWyk5tmGMwou0=
=/F2n
-----END PGP SIGNATURE-----

--=-kTx9DZtB5Nmr/BrUDOKk--


--===============5659052683345084344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5659052683345084344==--
