From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] Freezer: migration_thread should not be freezable (was:
	Re: Re: 2.6.22-rc3-mm1)
Date: Thu, 31 May 2007 23:30:08 +0200
Message-ID: <200705312330.09157.rjw__6433.34273850105$1180646731$gmane$org@sisk.pl>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<465EE9F2.8080905@googlemail.com> <200705312158.26560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705312158.26560.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 31 May 2007 21:58, Rafael J. Wysocki wrote:
> On Thursday, 31 May 2007 17:29, Michal Piotrowski wrote:
> > Hi,
> >=20
> > Andrew Morton napisa=C5=82(a):
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2=
2-rc3/2.6.22-rc3-mm1/
> > >=20
> >=20
> > FYI suspend to disk doesn't work anymore on my box, system hangs afte=
r "Suspending console(s)" message.
> >=20
> > [  186.297753] Shrinking memory...  =08-=08\=08|=08/=08-=08\=08|=08do=
ne (113064 pages freed)
> > [  187.841914] Freed 452256 kbytes in 1.54 seconds (293.67 MB/s)
> > [  187.847730] Suspending console(s)
> >=20
> > http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3-m=
m1/console.log
> > http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3-m=
m1/mm-config
>=20
> Hmm, that might be a couple of things, actually.
>=20
> To see if the patches directly related to hibernation/suspend cause thi=
s, can
> you please test 2.6.22-rc3 with the patch series at
>=20
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/
>=20
> applied?

Ahem, I broke it. :-(

Andrew, the following fix is needed on top of
freezer-make-kernel-threads-nonfreezable-by-default.patch

---
From: Rafael J. Wysocki <rjw@sisk.pl>

migration_thread should not be freezable, or it will break hibernation an=
d
suspend on SMP.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/sched.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6.22-rc3/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc3.orig/kernel/sched.c
+++ linux-2.6.22-rc3/kernel/sched.c
@@ -5157,13 +5157,10 @@ static int migration_thread(void *data)
 	BUG_ON(rq->migration_thread !=3D current);
=20
 	set_current_state(TASK_INTERRUPTIBLE);
-	set_freezable();
 	while (!kthread_should_stop()) {
 		struct migration_req *req;
 		struct list_head *head;
=20
-		try_to_freeze();
-
 		spin_lock_irq(&rq->lock);
=20
 		if (cpu_is_offline(cpu)) {
