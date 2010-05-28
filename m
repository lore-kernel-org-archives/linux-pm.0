From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] sched: clarify commment for TS_POLLING
Date: Fri, 28 May 2010 02:01:58 -0400
Message-ID: <e45b7fa23097332508730123ac6d59227e7bd7f8.1275026041.git.len.brown__4483.76832432604$1275030404$gmane$org@intel.com>
References: <1275026521-30835-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1275026521-30835-1-git-send-email-lenb@kernel.org>
In-reply-to: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
References: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

TS_POLLING set tells the scheduler an idle_task will poll
need_resched() to look for work.

TS_POLLING clear tells resched_task() and wake_up_idle_cpu()
that the remote CPU's idle_task is now sleeping in idle,
and thus requires a reschedule interrupt notice work.

Update the description of TS_POLLING to reflect how it works.
"idle task polling need_resched, skip sending interrupt"

Wordsmithing-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/thread_info.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index e0d2890..8121869 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -241,8 +241,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TS_USEDFPU		0x0001	/* FPU was used by this task
 					   this quantum (SMP) */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
-#define TS_POLLING		0x0004	/* true if in idle loop
-					   and not sleeping */
+#define TS_POLLING		0x0004	/* idle task polling need_resched,
+					   skip sending interrupt */
 #define TS_RESTORE_SIGMASK	0x0008	/* restore signal mask in do_signal() */
 #define TS_XSAVE		0x0010	/* Use xsave/xrstor */
 
-- 
1.6.0.6
