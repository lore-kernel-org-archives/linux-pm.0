From: Len Brown <lenb@kernel.org>
Subject: [PATCH-v2 5/8] sched: clarify commment for TS_POLLING
Date: Thu, 27 May 2010 01:53:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005270152460.8496__41850.5692658529$1274939733$gmane$org@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<4a831611847e8965ed5f3328e52fe8758115b951.1274926772.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <4a831611847e8965ed5f3328e52fe8758115b951.1274926772.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, linux-pm@lists.linux-foundation.org
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>
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
