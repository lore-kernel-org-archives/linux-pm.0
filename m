From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Thu, 2 Aug 2007 19:02:27 +0200
Message-ID: <200708021902.28379.rjw__49723.6292031177$1186073770$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707212120.04645.rjw@sisk.pl> <20070801092227.GB4808@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801092227.GB4808@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Wednesday, 1 August 2007 11:22, Pavel Machek wrote:
> Hi!
> 
> > > Hmm, wonder why this isn't affecting people with VPNs?  Probably
> > > network mounts over VPN are rare, and ever rarer to have fs activity
> > > on them during suspend.
> > > 
> > > Anyway, I think it's long overdue to stop thinking about how to "fix"
> > > fuse, and concentrate on fixing the underlying problem instead ;)
> > 
> > To conclude this branch of the thread, I have a patch in the works that may
> > help a bit with unfreezable FUSE filesystems and it only affects the freezer.
> > I'll post it when 2.6.23-rc1 is out, because it's on top of some other patches
> > that need to go first.
> 
> I'm interested... which one is that?

Appended, on top of this:
https://lists.linux-foundation.org/pipermail/linux-pm/2007-July/014521.html

Greetings,
Rafael


---
 kernel/power/process.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
===================================================================
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-24 00:14:07.000000000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-24 00:14:17.000000000 +0200
@@ -30,6 +30,14 @@
  */
 #define MAX_WAITS 5
 
+/*
+ * If the freezing of tasks fails, we attempt to thaw tasks that have already
+ * been frozen to give a chance the other tasks to freeze, in case one or more
+ * of them are blocked by the frozen ones.  If this fails MAX_ATTEMPTS times
+ * in a row, we give up.
+ */
+#define MAX_ATTEMPTS 10
+
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
 
@@ -192,14 +200,21 @@ static void cancel_freezing(struct task_
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned int todo, waits;
+	unsigned int todo, waits, attempts;
 	unsigned long ret;
 	struct timeval start, end;
 	s64 elapsed_csecs64;
 	unsigned int elapsed_csecs;
+	char *tick = "-\\|/";
+
+	printk(" ");
+	attempts = 0;
 
 	do_gettimeofday(&start);
 
+ Repeat:
+	printk("\b%c", tick[attempts++ % 4]);
+
 	refrigerator_called = 0;
 	waits = 0;
 	do {
@@ -235,11 +250,43 @@ static int try_to_freeze_tasks(int freez
 		}
 	} while (todo);
 
+	if (todo && attempts <= MAX_ATTEMPTS) {
+		/*
+		 * Some tasks have not been able to freeze.  They might be stuck
+		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
+		 * thaw the tasks that have frozen without clearing the freeze
+		 * requests of the remaining tasks and repeat.
+		 */
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (frozen(p)) {
+				p->flags &= ~PF_FROZEN;
+				wake_up_process(p);
+			}
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+
+		ret = wait_event_timeout(refrigerator_waitq,
+						refrigerator_called, TIMEOUT);
+		if (!ret) {
+			/*
+			 * There is a little hope that we will succeed, but at
+			 * least we want to know which tasks have not been
+			 * frozen.  Thus, we are going to repeat once.
+			 */
+			attempts = MAX_ATTEMPTS;
+		}
+
+		goto Repeat;
+	}
+
 	do_gettimeofday(&end);
 	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
 	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
 	elapsed_csecs = elapsed_csecs64;
 
+	printk("\b");
+
 	if (todo) {
 		/* This does not unfreeze processes that are already frozen
 		 * (we have slightly ugly calling convention in that respect,
