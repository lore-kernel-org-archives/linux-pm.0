From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 05:29:18 +0100
Message-ID: <20070703042916.GA17240__18354.3043131523$1183437254$gmane$org@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
a screaming nightmare - either the suspend fails because syslog (for 
instance) can't be frozen, or the machine deadlocks for some other 
reason I haven't tracked down. We could "fix" fuse, or alternatively we 
could do what we do for suspend to RAM on other platforms (PPC and APM) 
and just not use the freezer.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 8812985..5f109d5 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -19,7 +19,6 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/resume-trace.h>
-#include <linux/freezer.h>
 #include <linux/vmstat.h>
 
 #include "power.h"
@@ -81,11 +80,6 @@ static int suspend_prepare(suspend_state_t state)
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
-		error = -EAGAIN;
-		goto Thaw;
-	}
-
 	if ((free_pages = global_page_state(NR_FREE_PAGES))
 			< FREE_PAGE_NUMBER) {
 		pr_debug("PM: free some memory\n");
@@ -93,7 +87,7 @@ static int suspend_prepare(suspend_state_t state)
 		if (nr_free_pages() < FREE_PAGE_NUMBER) {
 			error = -ENOMEM;
 			printk(KERN_ERR "PM: No enough memory\n");
-			goto Thaw;
+			goto Restore_console;
 		}
 	}
 
@@ -118,8 +112,7 @@ static int suspend_prepare(suspend_state_t state)
 	device_resume();
  Resume_console:
 	resume_console();
- Thaw:
-	thaw_processes();
+ Restore_console:
 	pm_restore_console();
 	return error;
 }
@@ -170,7 +163,6 @@ static void suspend_finish(suspend_state_t state)
 	pm_finish(state);
 	device_resume();
 	resume_console();
-	thaw_processes();
 	pm_restore_console();
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
