From: Roger Lu <roger.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] PM / suspend: show workqueue state in suspend flow
Date: Fri, 1 Jul 2016 11:05:02 +0800
Message-ID: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Lu <roger.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lai Jiangshan <jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

If freezable workqueue aborts suspend flow, show
workqueue state for debug purpose.

Signed-off-by: Roger Lu <roger.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
Changes in v2:
- remove prints in show_workqueue_state().
---
 kernel/power/process.c | 3 +++
 kernel/workqueue.c     | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index df058be..6eef250 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -89,6 +89,9 @@ static int try_to_freeze_tasks(bool user_only)
 		       elapsed_msecs / 1000, elapsed_msecs % 1000,
 		       todo - wq_busy, wq_busy);
 
+		if (wq_busy)
+			show_workqueue_state();
+
 		if (!wakeup) {
 			read_lock(&tasklist_lock);
 			for_each_process_thread(g, p) {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e1c0e99..619e80c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4369,8 +4369,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 /**
  * show_workqueue_state - dump workqueue state
  *
- * Called from a sysrq handler and prints out all busy workqueues and
- * pools.
+ * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * all busy workqueues and pools.
  */
 void show_workqueue_state(void)
 {
-- 
2.6.4
