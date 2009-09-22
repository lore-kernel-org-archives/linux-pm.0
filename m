From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] make refrigerator cold
Date: Mon, 21 Sep 2009 21:04:16 -0700
Message-ID: <20090921210416.1982bcab@nehalam>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

By marking it cold, then the code path in kernel thread 
usage of try_to_freeze() that is normally used be
selected.

Don't think it matters that much for performance but the
concordance of this patch struck me as humorous.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>


--- a/include/linux/freezer.h	2009-09-21 20:34:17.579233461 -0700
+++ b/include/linux/freezer.h	2009-09-21 20:35:25.724322028 -0700
@@ -47,7 +47,7 @@ static inline bool should_send_signal(st
 /* Takes and releases task alloc lock using task_lock() */
 extern int thaw_process(struct task_struct *p);
 
-extern void refrigerator(void);
+extern void refrigerator(void) __cold;
 extern int freeze_processes(void);
 extern void thaw_processes(void);
 
