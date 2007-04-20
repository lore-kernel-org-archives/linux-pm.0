From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 22:51:08 +0200
Message-ID: <1177102268.5902.36.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420124448.4eaa159c.akpm@linux-foundation.org>
	<1177098713.5902.24.camel@johannes.berg>
	<200704202236.28982.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1664991843900000201=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704202236.28982.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1664991843900000201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/kWmkG1VsnA5n29PfQSN"


--=-/kWmkG1VsnA5n29PfQSN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-20 at 22:36 +0200, Rafael J. Wysocki wrote:

> Well, I can't say why exactly suspend_enter() usues irq_save/restore, but=
 it
> looks like that's not needed.

powerpc works fine just with local_irq_disable/enable, never did
anything else and my new patches just ignore the *flags argument.

> For the suspend to disk we call
> local_irq_disable/enable() in the corresponding places and, for example,
> acpi_pm_enter apparently uses irq_save/restore() itself too.

Why would acpi_pm_enter do that? It can always assume irqs are disabled.
Or does it need to enable them for something (hey, that would mean Ben
is right in that it probably wants to use these new hooks...)

> > The only users of this function are in the power management core code (=
main.c
> > and user.c) and they certainly always call it with interrupts enabled, =
the
> > entry point for other users is pm_suspend() and that surely cannot be c=
alled=20
> > with interrupts disabled. Rafael?
>=20
> That's correct, plus pm_suspend() also uses enter_state().

Sure, but it can't be called with interrupts disabled.

> In fact suspend_enter() has been made extern so that we can call it from
> kernel/power/user.c and no one else is supposed to use it.

Right.

So, any argument against re-spinning this patch, removing the unsigned
long *flags stuff and using local_irq_disable/enable?

johannes

--=-/kWmkG1VsnA5n29PfQSN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKSe8/ETPhpq3jKURAnGhAJ4+3vgW/u3QJHXuDBPtxQFGLLCL7ACeI9c7
QXDPha5j0s/zWOXvZVFos+Y=
=GYDf
-----END PGP SIGNATURE-----

--=-/kWmkG1VsnA5n29PfQSN--


--===============1664991843900000201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1664991843900000201==--
