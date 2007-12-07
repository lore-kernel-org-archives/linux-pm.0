From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Fri, 7 Dec 2007 18:51:34 +0100
Message-ID: <20071207175134.GA18916@elte.hu>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071207151150.GB24254@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> thanks for tracking it down. Does the patch below help?

oops, that should be the patch below. Otherwise the watchdog kernel 
threads will just loop around.

	Ingo

---
 kernel/softlockup.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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
 
@@ -213,8 +217,9 @@ static int watchdog(void *__bind_cpu)
 	 * debug-printout triggers in softlockup_tick().
 	 */
 	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		touch_softlockup_watchdog();
-		msleep_interruptible(10000);
+		schedule();
 
 		/*
 		 * Only do the hung-tasks check on one CPU:
