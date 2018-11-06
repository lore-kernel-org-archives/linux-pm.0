From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / QoS: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Tue,  6 Nov 2018 09:38:06 -0500
Message-ID: <20181106143806.8551-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/power/qos.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 86d72ffb811b..b7a82502857a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -184,7 +184,7 @@ static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 	c->target_value = value;
 }
 
-static int pm_qos_dbg_show_requests(struct seq_file *s, void *unused)
+static int pm_qos_debug_show(struct seq_file *s, void *unused)
 {
 	struct pm_qos_object *qos = (struct pm_qos_object *)s->private;
 	struct pm_qos_constraints *c;
@@ -245,18 +245,7 @@ static int pm_qos_dbg_show_requests(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int pm_qos_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pm_qos_dbg_show_requests,
-			   inode->i_private);
-}
-
-static const struct file_operations pm_qos_debug_fops = {
-	.open           = pm_qos_dbg_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pm_qos_debug);
 
 /**
  * pm_qos_update_target - manages the constraints list and calls the notifiers
-- 
2.17.0
