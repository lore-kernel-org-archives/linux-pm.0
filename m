From: Kyungmin Park <kmpark@infradead.org>
Subject: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen processes
Date: Thu, 07 May 2015 15:45:57 +0900
Message-ID: <20150507064557.GA26928@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-disposition: inline
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some platform uses freezer cgroup for speicial purpose to schedule out some applications. but after suspend & resume, these processes are thawed and running. 

but it's inteneded and don't need to thaw it.

To avoid it, does it possible to modify resume code and don't thaw it when resume? does it resonable?

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 564f786..6eed7df 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -202,7 +202,9 @@ void thaw_processes(void)
 	for_each_process_thread(g, p) {
 		/* No other threads should have PF_SUSPEND_TASK set */
 		WARN_ON((p != curr) && (p->flags & PF_SUSPEND_TASK));
-		__thaw_task(p);
+		/* Don't need to thaw when it's already frozen by userspace */
+		if (!cgroup_freezing(p))
+			__thaw_task(p);
 	}
 	read_unlock(&tasklist_lock);
 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
