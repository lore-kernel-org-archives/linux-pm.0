From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH RFC] introduce pm_call() macro to get rid of most
	#ifdef	CONFIG_PM
Date: Mon, 3 Mar 2008 02:43:08 +0300
Message-ID: <20080302234308.GA10116__16746.1161887788$1204560739$gmane$org@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Currently drivers handle CONFIG_PM this way:

#ifdef CONFIG_PM
drv_suspend() {}
drv_resume() {}
#else
#define drv_suspend NULL
#define drv_resume NULL
#endif

struct driver drv = {
	.suspend = drv_suspend,
	.resume = drv_resume,
};

With this patch, the code above converts into:

drv_suspend() {}
drv_resume() {}

struct driver drv = {
	.suspend = pm_call(drv_suspend),
	.resume = pm_call(drv_resume),
};

GCC will optimize away suspend/resume calls if they're really
not used.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 include/linux/pm.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 015b735..6e0b9c2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -114,6 +114,13 @@ typedef struct pm_message {
 	int event;
 } pm_message_t;
 
+#ifdef CONFIG_PM
+#define pm_call(x) (x)
+#else
+/* avoid `defined but not used' warning */
+#define pm_call(x) ((x) - 1 ? NULL : NULL)
+#endif /* CONFIG_PM */
+
 /*
  * Several driver power state transitions are externally visible, affecting
  * the state of pending I/O queues and (for drivers that touch hardware)
-- 
1.5.4.3
