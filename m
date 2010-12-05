From: Thomas Kahle <tomka@gentoo.org>
Subject: Re: Freezes on resume from S2R
Date: Sun, 5 Dec 2010 19:52:03 +0100
Message-ID: <20101205185203.GA2734@denkmatte.mittag-leffler.se>
References: <20101124095618.GC5982@denkmatte.mittag-leffler.se>
	<201011242101.08157.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4987885328808309140=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011242101.08157.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============4987885328808309140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay, only today I was able too look into this again.

On 21:01 Wed 24 Nov     , Rafael J. Wysocki wrote:
> > I'm trying to debug freezes upon resume from suspend-to-RAM on my
> > Thinkpad X61s.  The userland is a mostly stable x86 Gentoo Linux with
> > recent X stack.  The freeze does not occur always, but it is
> > reproducable after a few successful suspend-resume cycles.  I can
> > reproduce it because affected kernels will not complete 10
> > suspend-resume cycles, so this has been my criterion for all the tests I
> > have done.  When the freeze occurs I have seen various things happening.
> > In most instances the X screen comes up in the state before the resume
> > works for a few milliseconds and then freezes.  In this state the
> > computer is not reachable by ssh and the only option is to reboot.  In
> > other instances I have also seen X crashing, dropping me to a console
> > and then freezing.  In one inctance (still with gentoo-sources, before I
> > started testing with mainline) I was able to ssh into the system and
> > found spurious things in the log.  Please see the attachad file
> > 'messages'.  On 12:08:33 I connect via ssh as root.  I see the process X
> > occupying 100% CPU and it cannot be killed (kill -9 has no effect).  I
> > tried to reboot the machine with init x6, but this failed.  Browsing the
> > list archive it might be related to what Linus reported here:
> >=20
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-November/029=
299.html
>=20
> This warning means that resume took more that 10 s, which is suspicious, =
but
> not a bug by itself.
>=20
> > These problems appear to me as a regression since everything is
> > reproducibly fine with kernels <=3D2.6.34, and 2.6.35 seems to be fine =
too
> > (although I have tested that less).  I started a bisect, see below.
>=20
> Well, it would be good if you could find the commit that broke things for
> you, but it might be a few different things - ACPI, PCI, graphics driver,=
 etc.
>=20
> Please check if you can reproduce the symptom using pm_test:
>=20
> # echo core > /sys/power/pm_test
> # echo mem > /sys/power/state
>=20
> (it should simulate a suspend-resume cycle and get back to the command pr=
ompt
> in 5-10 sec).  You can try to run that in a loop and see if that breaks t=
hings.

I tried this and I can reproduce the problem in this way.  Here are some
additional observations:

-) In the tries I did with the debug procedure the problem always
 occurred on exactly the 4th resume.

-) I killed X before doing this to make sure that it is not involved,
 and indeed, the problem persists.

-) When the resume failed I can still switch consoles with Alt+F?, but
 any keys typed into this console are lost, i.e. I can not log in or
 anything.  The machine is not reachable by ssh, on the console where I
 was logged in I do get visual "^C" feedback, although "^C" has no
 effect. Everything is frozen.

Then regarding the bisect, I consider my tries as failed.  Even using
git bisect skip I am constantly running into non-bootable kernels.  How
do people use git bisect?  It seems quite useless to me, as all these
patches depend on each other.  Probably I would have to try to find the
issues of the non-booting kernels, but I'm not very motivated for
debugging the failures during debugging...

What else can I do to track this down?  The failure starts to show
between

625c94df22fb4247c8ccd54635a8ec77cb60d651  (Fri Aug 13) (bad)
and=20
ab69bcd66fb4be64edfc767365cb9eb084961246  (Fri Aug 6) (good)

Thanks,
Thomas


For reference, here is the log again:

$ git bisect log
git bisect start
# bad: [3561d43fd289f590fdae672e5eb831b8d5cf0bf6] Linux 2.6.37-rc3
git bisect bad 3561d43fd289f590fdae672e5eb831b8d5cf0bf6
# good: [9fe6206f400646a2322096b56c59891d530e8d51] Linux 2.6.35
git bisect good 9fe6206f400646a2322096b56c59891d530e8d51
# bad: [a126681810a327bee60a58ac5ad77f4518cf7a5f] [media] staging/lirc: ioc=
tl portability fixups
git bisect bad a126681810a327bee60a58ac5ad77f4518cf7a5f
# skip: [faa38b5e0e092914764cdba9f83d31a3f794d182] Merge branch 'for-linus'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
git bisect skip faa38b5e0e092914764cdba9f83d31a3f794d182
# good: [0aa094331b19e54f928e2ac083285ff68d91c69b] [SCSI] be2iscsi: Remove =
debug print in IO path
git bisect good 0aa094331b19e54f928e2ac083285ff68d91c69b
# good: [c14c643b3d91cc741425c058968672228c310927] e1000e: update driver ve=
rsion number
git bisect good c14c643b3d91cc741425c058968672228c310927
# skip: [d71048e22f47725a5808ea2e4e1e72fa36c1a788] Merge branch 'omap-for-l=
inus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
git bisect skip d71048e22f47725a5808ea2e4e1e72fa36c1a788
# bad: [06c10884486a63a1e4ff657aaa51e848e64b9dc3] ARM: relax ioremap prohib=
ition (309caa9) for -final and -stable
git bisect bad 06c10884486a63a1e4ff657aaa51e848e64b9dc3
# bad: [625c94df22fb4247c8ccd54635a8ec77cb60d651] [S390] dasd: fix format s=
tring types
git bisect bad 625c94df22fb4247c8ccd54635a8ec77cb60d651
# good: [ab69bcd66fb4be64edfc767365cb9eb084961246] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/gregkh/driver-core-2.6
git bisect good ab69bcd66fb4be64edfc767365cb9eb084961246
# skip: [9e0ba741aabdf129d561e62d207c75146adef5e8] drivers/char/vt.c:vc_do_=
resize(): local var `end' should be unsigned long
git bisect skip 9e0ba741aabdf129d561e62d207c75146adef5e8
# skip: [6b8e8282611ea35845dcff0cb321a7d735fc3155] drivers/hwmon/coretemp.c=
: remove unneeded #ifdef CONFIG_HOTPLUG_CPU
git bisect skip 6b8e8282611ea35845dcff0cb321a7d735fc3155
# good: [b0c983375df8aafdddf250009a7bb929225e6011] Staging: dt3155: Change =
include to linux header
git bisect good b0c983375df8aafdddf250009a7bb929225e6011
# skip: [5f248c9c251c60af3403902b26e08de43964ea0b] Merge branch 'for-linus'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6
git bisect skip 5f248c9c251c60af3403902b26e08de43964ea0b
# skip: [b70a3e0702dee2ed9435e06a8bde7d9fa2228895] All filesystems that nee=
d invalidate_inode_buffers() are doing that explicitly
git bisect skip b70a3e0702dee2ed9435e06a8bde7d9fa2228895
# skip: [c2fab1242a16f8e66b680d664322c3811e7b003d] ARM: 6306/1: fix inverte=
d MMC card detect in U300
git bisect skip c2fab1242a16f8e66b680d664322c3811e7b003d


--=20
Thomas Kahle
http://dev.gentoo.org/~tomka/

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iJwEAQEIAAYFAkz731MACgkQQYXt1pFHaaENdQQAwPSvZNg+GDHgEIZlb3rXPhG4
25MH6nW7fmmYhcNshKPPD9j82PfhlnFN6U/KYxYLL4aYYcH6qi/4ZAHY2IW13uxe
gqhDkV64prSKbj2UQkrzOOUUIg6HjJ99lToKRquWvrOoOWE3nd2MZQnaSA6yv3N+
vjApgiMVf1toIzYzSFE=
=QHhg
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============4987885328808309140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4987885328808309140==--
