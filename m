From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 12:19:39 +0200
Message-ID: <1177669179.7828.53.camel__41273.5198428438$1177669258$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <200704262102.38568.rjw@sisk.pl>
	<1177666915.7828.35.camel@johannes.berg>
	<200704271218.07120.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5061976192703363177=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704271218.07120.rjw@sisk.pl>
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


--===============5061976192703363177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PPoA1Xdr2HRvlmnBzvQd"


--=-PPoA1Xdr2HRvlmnBzvQd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 12:18 +0200, Rafael J. Wysocki wrote:

> 1) We define platform_hibernation if CONFIG_ACPI is set.

Let's just define it always then in the common code so we don't have
even more magic bits platforms need to define even if they don't care at
all. And please don't put #ifdef CONFIG_ACPI into the common code ;)
Maybe #ifdef CONFIG_ARCH_NEEDS_HIBERNATE_HOOKS or something.

> 2) In the ACPI code we do
>=20
> if (can do S4)
> 	platform_hibernation =3D 1;

Gotcha.

> 3) We have functions arch_platform_prepare()/finish()/enter() that are de=
fined
> to be noops for anything but ACPI systems and for ACPI systems they are
> defined like this:
>=20
> int arch_platform_enter(void)
> {
> 	if (!platform_hibernation)
> 		return 0;
>=20
> 	...
> }
>=20
> I think it should work.

You could reduce code churn in all other platforms by making these weak
symbols like the irq hooks I did for pm_ops. It looks like it can work
and possibly is even less intrusive than my hibernate_ops patch. Though
then again my hibernate_ops patch removed a lot of stuff that is now no
longer necessary, and also completely removed the PM_SUSPEND_DISK foo...
we probably want that regardless of how we invoke ACPI.

johannes

--=-PPoA1Xdr2HRvlmnBzvQd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMc47/ETPhpq3jKURApT3AKCvsw0rdN8AcI2acGjXpaVcL/kVawCeNtDc
wG82YWBcPGLNJE3xghRDpN8=
=w9fF
-----END PGP SIGNATURE-----

--=-PPoA1Xdr2HRvlmnBzvQd--


--===============5061976192703363177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5061976192703363177==--
