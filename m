From: "SUZUKI, Kazuhiro" <kaz@jp.fujitsu.com>
Subject: [PATCH 1/2] Fix hangup after creating checkpoint on Xen.
Date: Mon, 07 Feb 2011 18:08:41 +0900 (JST)
Message-ID: <20110207.180841.1017043963161295322.kaz__7190.39684995568$1297097756$gmane$org@jp.fujitsu.com>
References: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org
Cc: xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

Hi,

This is a pm-linux part patch.

Thanks,
KAZ

Signed-off-by: Kenji Wakamiya <wkenji@jp.fujitsu.com>
Signed-off-by: Kazuhiro Suzuki <kaz@jp.fujitsu.com>
---
 drivers/base/power/main.c |    9 +++++++++
 include/linux/pm.h        |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 8aa2443..e348b5d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -181,6 +181,13 @@ static int pm_op(struct device *dev,
 			suspend_report_result(ops->suspend, error);
 		}
 		break;
+	case PM_EVENT_CANCEL:
+		if (ops->cancel) {
+			error = ops->cancel(dev);
+			suspend_report_result(ops->cancel, error);
+			break;
+		}
+		/* Fall through */
 	case PM_EVENT_RESUME:
 		if (ops->resume) {
 			error = ops->resume(dev);
@@ -293,6 +300,8 @@ static char *pm_verb(int event)
 		return "suspend";
 	case PM_EVENT_RESUME:
 		return "resume";
+	case PM_EVENT_CANCEL:
+		return "cancel";
 	case PM_EVENT_FREEZE:
 		return "freeze";
 	case PM_EVENT_QUIESCE:
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 3b7e04b..d118781 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -198,6 +198,7 @@ struct dev_pm_ops {
 	void (*complete)(struct device *dev);
 	int (*suspend)(struct device *dev);
 	int (*resume)(struct device *dev);
+	int (*cancel)(struct device *dev);
 	int (*freeze)(struct device *dev);
 	int (*thaw)(struct device *dev);
 	int (*poweroff)(struct device *dev);
@@ -291,6 +292,7 @@ struct dev_pm_ops name = { \
 #define PM_EVENT_USER		0x0100
 #define PM_EVENT_REMOTE		0x0200
 #define PM_EVENT_AUTO		0x0400
+#define PM_EVENT_CANCEL		0x0800
 
 #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
 #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
@@ -308,6 +310,7 @@ struct dev_pm_ops name = { \
 #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
 #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
 #define PMSG_RECOVER	((struct pm_message){ .event = PM_EVENT_RECOVER, })
+#define PMSG_CANCEL	((struct pm_message){ .event = PM_EVENT_CANCEL, })
 #define PMSG_USER_SUSPEND	((struct pm_message) \
 					{ .event = PM_EVENT_USER_SUSPEND, })
 #define PMSG_USER_RESUME	((struct pm_message) \
-- 
1.7.3.1
