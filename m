From: jean.pihet@newoldbits.com
Subject: [PATCH 1/3] perf: add calls to suspend trace point
Date: Fri, 10 Dec 2010 20:51:59 +0100
Message-ID: <1292010721-17426-2-git-send-email-j-pihet__3793.30080836571$1292010972$gmane$org@ti.com>
References: <1292010721-17426-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292010721-17426-1-git-send-email-j-pihet@ti.com>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Uses the machine_suspend trace point, called from the
generic kernel suspend_enter function.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
CC: Thomas Renninger <trenn@suse.de>
---
 kernel/power/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ecf7705..0650596 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -164,7 +165,9 @@ static int suspend_enter(suspend_state_t state)
 	error = sysdev_suspend(PMSG_SUSPEND);
 	if (!error) {
 		if (!suspend_test(TEST_CORE) && pm_check_wakeup_events()) {
+			trace_machine_suspend(state);
 			error = suspend_ops->enter(state);
+			trace_machine_suspend(PWR_EVENT_EXIT);
 			events_check_enabled = false;
 		}
 		sysdev_resume();
-- 
1.7.2.3
