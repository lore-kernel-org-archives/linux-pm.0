From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Sat, 08 Dec 2007 18:34:23 +0100
Message-ID: <475AD59F.3010509__26983.2171769396$1197135351$gmane$org@gmail.com>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071208152447.GA30270@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 12/08/2007 04:24 PM, Ingo Molnar wrote:
> i'm wondering why it had no effect now - the new code is in essence a 
> NOP over what we had. Could you send me your current (modified) 
> kernel/softlockup.c code?

Only these changes:
diff --git a/kernel/softlockup.c b/kernel/softlockup.c
index e50b44a..7011549 100644
--- a/kernel/softlockup.c
+++ b/kernel/softlockup.c
@@ -25,7 +25,7 @@ static DEFINE_PER_CPU(unsigned long, print_timestamp);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);

 static int did_panic;
-int softlockup_thresh = 60;
+int softlockup_thresh = 10;

 static int
 softlock_panic(struct notifier_block *this, unsigned long event, void *ptr)
@@ -101,7 +101,11 @@ void softlockup_tick(void)

        now = get_timestamp(this_cpu);

-       /* Warn about unreasonable delays: */
+       /* Wake up the high-prio watchdog task every second: */
+       if (now > (touch_timestamp + 1))
+               wake_up_process(per_cpu(watchdog_task, this_cpu));
+
+       /* Warn about unreasonable 10+ seconds delays: */
        if (now <= (touch_timestamp + softlockup_thresh))
                return;

@@ -213,8 +217,9 @@ static int watchdog(void *__bind_cpu)
         * debug-printout triggers in softlockup_tick().
         */
        while (!kthread_should_stop()) {
+               set_current_state(TASK_INTERRUPTIBLE);
                touch_softlockup_watchdog();
-               msleep_interruptible(10000);
+               schedule();

                /*
                 * Only do the hung-tasks check on one CPU:


Whole file:
http://www.fi.muni.cz/~xslaby/sklad/softlockup.c
