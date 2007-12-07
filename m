From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Fri, 7 Dec 2007 16:11:50 +0100
Message-ID: <20071207151150.GB24254__36554.772014688$1197040436$gmane$org@elte.hu>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47595A0A.5000502@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> On 12/05/2007 06:17 AM, Andrew Morton wrote:
> >   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc4/2.6.24-rc4-mm1/
> 
> >  git-sched.patch
> 
> breaks suspend here since -rc3-mm2. More precisely, this one:
> softlockup: automatically detect hung TASK_UNINTERRUPTIBLE tasks
> 
> 2.6.24-rc4-mm1 minus this one works just fine. Otherwise disks stop, graphics
> stops and then it hangs not powering down.
> 
> Core 2 Duo, SMP kernel, voluntary preempt, 250 HZ, SLUB, 64 bit.
> 
> Ideas?

thanks for tracking it down. Does the patch below help?

	Ingo

---
 kernel/softlockup.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
@@ -101,7 +101,11 @@ void softlockup_tick(void)
 
 	now = get_timestamp(this_cpu);
 
-	/* Warn about unreasonable delays: */
+	/* Wake up the high-prio watchdog task every second: */
+	if (now > (touch_timestamp + 1))
+		wake_up_process(per_cpu(watchdog_task, this_cpu));
+
+	/* Warn about unreasonable 10+ seconds delays: */
 	if (now <= (touch_timestamp + softlockup_thresh))
 		return;
 
@@ -214,7 +218,7 @@ static int watchdog(void *__bind_cpu)
 	 */
 	while (!kthread_should_stop()) {
 		touch_softlockup_watchdog();
-		msleep_interruptible(10000);
+		schedule();
 
 		/*
 		 * Only do the hung-tasks check on one CPU:
