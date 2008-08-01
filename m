From: Matt Helsley <matthltc@us.ibm.com>
Subject: [PATCH 4/6] Container Freezer: Skip frozen cgroups
	during power management resume
Date: Thu, 31 Jul 2008 22:07:03 -0700
Message-ID: <20080801050701.070484831__20637.2196357281$1217568497$gmane$org@us.ibm.com>
References: <20080801050659.924495279@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

When a system is resumed after a suspend, it will also unfreeze
frozen cgroups.

This patchs modifies the resume sequence to skip the tasks which
are part of a frozen control group.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Acked-by: Serge E. Hallyn <serue@us.ibm.com>
Tested-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/power/process.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 444cea8..ce9e280 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/cgroup_freezer.h>
 
 /* 
  * Timeout for stopping processes
@@ -135,6 +136,9 @@ static void thaw_tasks(bool nosig_only)
 		if (nosig_only && should_send_signal(p))
 			continue;
 
+		if (cgroup_frozen(p))
+			continue;
+
 		thaw_process(p);
 	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
-- 
1.5.3.7

-- 
