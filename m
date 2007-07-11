From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/7] Freezer: Do not sync
	filesystems from freeze_processes
Date: Thu, 12 Jul 2007 00:42:18 +0200
Message-ID: <20070711224218.GB11127@elf.ucw.cz>
References: <200707120006.50095.rjw@sisk.pl> <200707120010.44482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707120010.44482.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-07-12 00:10:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> The syncing of filesystems from within the freezer is generally not nee=
ded.
> Also, if there's an ext3 filesystem loopback-mounted from a FUSE one, t=
he
> syncing results in writes to it and deadlocks. =A0Similarly, it will de=
adlock if
> FUSE implements sync.
>=20
> Change freeze_processes() so that it doesn't execute sys_sync() and mak=
e the
> suspend and hibernation code paths sync filesystems independently of th=
e
> freezer.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. Nice to see the fuse problem to disappear.
								Pavel

> Index: linux-2.6.22-rc6-mm1/kernel/power/user.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc6-mm1.orig/kernel/power/user.c	2007-07-11 20:48:05.0=
00000000 +0200
> +++ linux-2.6.22-rc6-mm1/kernel/power/user.c	2007-07-11 20:48:23.000000=
000 +0200
> @@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
>  		mutex_lock(&pm_mutex);
>  		error =3D pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
>  		if (!error) {
> +			printk("Syncing filesystems ... ");
> +			sys_sync();
> +			printk("done.\n");
> +
>  			error =3D freeze_processes();
>  			if (error)
>  				thaw_processes();

I see this is back-compatible, but can we do the sync in userspace,
instead?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
