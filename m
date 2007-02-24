From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in disk.c" et al.
Date: Sat, 24 Feb 2007 01:01:11 +0100
Message-ID: <200702240101.12846.rjw@sisk.pl>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231425.38217.rjw@sisk.pl>
	<1172262219.3870.63.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1172262219.3870.63.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 23 February 2007 21:23, Johannes Berg wrote:
> Hi,
> =

> > In that case the fastest fix would be to revert the commit in question =
(and
> > some others too),
> =

> Yeah, the same thing exists for uswsusp and regular suspend-to-ram
> afaict.

Exactly.

> > but I don't think it will be satisfactory for the people with
> > the ACPI issues related to the resume code ordering.  Moreover, it real=
ly
> > is more reasonable to disable nonboot CPUs after tasks have been frozen
> > (I think it's also necessary for the CPU hotplugging with the help of t=
he
> > freezer; see below).
> > =

> > I'll try to find a better solution later today.
> =

> Great.

I'm looking at it right now, but this is quite complicated.

Could you please try the appended patch?  It's somewhat hackish, but may wo=
rk.

The idea is to do nothing on CPU unplug if the CPU's worker thread is frozen
and later check in the thread itself if it has been replaced by another one.

Greetings,
Rafael


 kernel/workqueue.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.20-mm2/kernel/workqueue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-mm2.orig/kernel/workqueue.c	2007-02-23 22:48:50.000000000 =
+0100
+++ linux-2.6.20-mm2/kernel/workqueue.c	2007-02-24 00:58:57.000000000 +0100
@@ -316,7 +316,13 @@ static int worker_thread(void *__cwq)
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 =

 	for (;;) {
-		try_to_freeze();
+		if (try_to_freeze()) {
+			/* We've just exited the refrigerator.  If our CPU is
+			 * a nonboot one, we might have been replaced.
+			 */
+			if (cwq->thread !=3D current)
+				break;
+		}
 =

 		prepare_to_wait(&cwq->more_work, &wait, TASK_INTERRUPTIBLE);
 		if (!cwq->should_stop && list_empty(&cwq->worklist))
@@ -713,7 +719,7 @@ static void cleanup_workqueue_thread(str
 	int alive =3D 0;
 =

 	spin_lock_irq(&cwq->lock);
-	if (cwq->thread !=3D NULL) {
+	if (cwq->thread !=3D NULL && !frozen(cwq->thread)) {
 		insert_wq_barrier(cwq, &barr, 1);
 		cwq->should_stop =3D 1;
 		alive =3D 1;
