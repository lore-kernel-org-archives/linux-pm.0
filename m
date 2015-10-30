From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 3/3] freezer: warn if anyone is trying to use freezer on
 kthreads
Date: Fri, 30 Oct 2015 14:48:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510301441210.17538@pobox.suse.cz>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

kthread freezing has been deprecated in favor of fs freezing. Issue
a warning if anyone attempts to still use this API.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 include/linux/freezer.h | 2 ++
 kernel/freezer.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 81335f6..c0bc520 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -59,6 +59,8 @@ static inline bool try_to_freeze_unsafe(void)
 
 static inline bool try_to_freeze(void)
 {
+	WARN_ON(current->flags & PF_KTHREAD);
+
 	if (!(current->flags & PF_NOFREEZE))
 		debug_check_no_locks_held();
 	return try_to_freeze_unsafe();
diff --git a/kernel/freezer.c b/kernel/freezer.c
index a8900a3..fe2afb9 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -164,6 +164,7 @@ void __thaw_task(struct task_struct *p)
 bool set_freezable(void)
 {
 	might_sleep();
+	WARN_ON(current->flags & PF_KTHREAD);
 
 	/*
 	 * Modify flags while holding freezer_lock.  This ensures the
-- 
1.9.2
