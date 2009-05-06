From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 4/19] TuxOnIce: Add support for just thawing
	kernel threads.
Date: Thu,  7 May 2009 00:39:00 +1000
Message-ID: <1241620755-22133-5-git-send-email-nigel__13107.578297104$1241621183$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

Create a function that just thaws kernel threads (not userspace), so
that TuxOnIce can use it when allocating storage to bmap the space
obtained, without having the potential for significant changes in the
characteristics of an image (which would make preparing an image even
more of an iterative process than it can be now). We also
thaw_kernel_threads when seeking to free memory.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 include/linux/freezer.h |    3 +++
 kernel/power/process.c  |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 5a361f8..4f50655 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -121,6 +121,8 @@ static inline void set_freezable(void)
 	current->flags &= ~PF_NOFREEZE;
 }
 
+extern void thaw_kernel_threads(void);
+
 /*
  * Tell the freezer that the current task should be frozen by it and that it
  * should send a fake signal to the task to freeze it.
@@ -172,6 +174,7 @@ static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
 
 static inline int try_to_freeze(void) { return 0; }
+static inline void thaw_kernel_threads(void) { }
 
 static inline void freezer_do_not_count(void) {}
 static inline void freezer_count(void) {}
diff --git a/kernel/power/process.c b/kernel/power/process.c
index ca63401..d464ef7 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -152,3 +152,7 @@ void thaw_processes(void)
 	printk("done.\n");
 }
 
+void thaw_kernel_threads(void)
+{
+	thaw_tasks(true);
+}
-- 
1.5.6.3
