From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 1/2] freezer, oom: check TIF_MEMDIE on the correct task
Date: Mon, 27 Jun 2016 14:15:18 +0200
Message-ID: <1467029719-17602-2-git-send-email-mhocko@kernel.org>
References: <1467029719-17602-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1467029719-17602-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Miao Xie <miaox@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Michal Hocko <mhocko@suse.com>
List-Id: linux-pm@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

freezing_slow_path is checking TIF_MEMDIE to skip OOM killed
tasks. It is, however, checking the flag on the current task rather than
the given one. This is really confusing because freezing() can be called
also on !current tasks. It would end up working correctly for its main
purpose because __refrigerator will be always called on the current task
so the oom victim will never get frozen. But it could lead to surprising
results when a task which is freezing a cgroup got oom killed because
only part of the cgroup would get frozen. This is highly unlikely but
worth fixing as the resulting code would be more clear anyway.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index a8900a3bc27a..6f56a9e219fa 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -42,7 +42,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
 		return false;
 
-	if (test_thread_flag(TIF_MEMDIE))
+	if (test_tsk_thread_flag(p, TIF_MEMDIE))
 		return false;
 
 	if (pm_nosig_freezing || cgroup_freezing(p))
-- 
2.8.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
