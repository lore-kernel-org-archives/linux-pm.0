From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in disk.c" et al.
Date: Sat, 24 Feb 2007 21:54:26 +0100
Message-ID: <200702242154.27167.rjw@sisk.pl>
References: <1172201385.15769.32.camel@johannes.berg>
	<1172277080.3870.108.camel@johannes.berg>
	<200702240957.22636.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702240957.22636.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm@lists.osdl.org, Dave Vasilevsky <djvasi@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 February 2007 09:57, Rafael J. Wysocki wrote:
> On Saturday, 24 February 2007 01:31, Johannes Berg wrote:
> > Hi,
> > =

> > > Could you please try the appended patch?  It's somewhat hackish, but =
may work.
> > =

> > Not before Monday or Tuesday unfortunately, I'm away from the machine.
> =

> Okay, no big deal.  I think I'll be able to reproduce the problem here. ;=
-)
> =

> > Maybe I can find someone else willing to test who has the same box.
> > =

> > > The idea is to do nothing on CPU unplug if the CPU's worker thread is=
 frozen
> > > and later check in the thread itself if it has been replaced by anoth=
er one.
> > =

> > Yeah that should work. That patch won't apply to my tree though unless I
> > actually go to -mm2 as well :)
> =

> Ah, sorry.  I'll prepare a version against 2.6.21-rc1.  Apart from this, I
> think there's a better solution, but I have to verify that.

No, this one is better IMO.

Appended is the version against 2.6.21-rc1.  It seems to work for me, but I=
'd
like someone else to confirm it.

Greetings,
Rafael

 kernel/workqueue.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc1/kernel/workqueue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc1.orig/kernel/workqueue.c
+++ linux-2.6.21-rc1/kernel/workqueue.c
@@ -376,8 +376,19 @@ static int worker_thread(void *__cwq)
 =

 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
-		if (cwq->freezeable)
-			try_to_freeze();
+		if (try_to_freeze()) {
+			/* We've just left the refrigerator.  If our CPU is
+			 * a nonboot one, we might have been replaced.
+			 * The lock is taken to prevent the race with
+			 * cleanup_workqueue_thread() from happening
+			 */
+			spin_lock_irq(&cwq->lock);
+			if (cwq->thread !=3D current) {
+				spin_unlock_irq(&cwq->lock);
+				break;
+			}
+			spin_unlock_irq(&cwq->lock);
+		}
 =

 		add_wait_queue(&cwq->more_work, &wait);
 		if (list_empty(&cwq->worklist))
@@ -539,6 +550,9 @@ static void cleanup_workqueue_thread(str
 	cwq =3D per_cpu_ptr(wq->cpu_wq, cpu);
 	spin_lock_irqsave(&cwq->lock, flags);
 	p =3D cwq->thread;
+	if (p && frozen(p))
+		p =3D NULL;
+
 	cwq->thread =3D NULL;
 	spin_unlock_irqrestore(&cwq->lock, flags);
 	if (p)
