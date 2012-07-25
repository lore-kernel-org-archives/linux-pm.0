From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/52] cpuidle: remove unused
	hrtimer_peek_ahead_timers() call
Date: Tue, 24 Jul 2012 23:41:08 -0400
Message-ID: <0aeb9cac6f8a6fc68acfb07d30b62ad6106a6384.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

  commit 9a6558371bcd01c2973b7638181db4ccc34eab4f
  Author: Arjan van de Ven <arjan@linux.intel.com>
  Date:   Sun Nov 9 12:45:10 2008 -0800

     regression: disable timer peek-ahead for 2.6.28

     It's showing up as regressions; disabling it very likely just papers
     over an underlying issue, but time is running out for 2.6.28, lets get
     back to this for 2.6.29

 Many years has passed since 2008, so it seems ok to remove whole `#if 0' block.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Trinabh Gupta <g.trinabh@gmail.com>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2f0083a..588b44a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -124,15 +124,6 @@ int cpuidle_idle_call(void)
 	if (!dev || !dev->enabled)
 		return -EBUSY;
 
-#if 0
-	/* shows regressions, re-enable for 2.6.29 */
-	/*
-	 * run any timers that can be run now, at this point
-	 * before calculating the idle duration etc.
-	 */
-	hrtimer_peek_ahead_timers();
-#endif
-
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
 	if (need_resched()) {
-- 
1.7.12.rc0
