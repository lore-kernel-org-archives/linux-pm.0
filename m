From: matthltc@us.ibm.com
Subject: [RFC PATCH 4/4] Container Freezer: Skip frozen cgroups
	during power management resume
Date: Thu, 03 Apr 2008 14:03:20 -0700
Message-ID: <20080403210317.442655956__11151.2559735731$1207256779$gmane$org@us.ibm.com>
References: <20080403210316.397506379@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=cgroup-freezer/cgroup-freezer-do-not-unfreeze-a-frozen-cgroup-when-system-is-resumed.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

When a system is resumed after a suspend, it will also unfreeze 
frozen cgroups. 

This patchs modifies the resume sequence to skip the tasks which 
are part of a frozen control group. 

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Tested-by: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
---
 kernel/power/process.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.25-rc5-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.25-rc5-mm1.orig/kernel/power/process.c
+++ linux-2.6.25-rc5-mm1/kernel/power/process.c
@@ -11,10 +11,11 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/cgroup_freezer.h>
 
 /* 
  * Timeout for stopping processes
  */
 #define TIMEOUT	(20 * HZ)
@@ -150,10 +151,13 @@ static void thaw_tasks(int thaw_user_spa
 			continue;
 
 		if (!p->mm == thaw_user_space)
 			continue;
 
+		if (cgroup_frozen(p))
+			continue;
+
 		thaw_process(p);
 	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 }
 

-- 
