From: tom.leiming@gmail.com
Subject: [PATCH] PM: runtime: return at once for active device in
	rpm_resume
Date: Wed, 15 Jun 2011 00:09:53 +0800
Message-ID: <1308067793-19551-1-git-send-email-tom.leiming@gmail.com>
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
To: rjw@sisk.pl, stern@rowland.harvard.edu
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

This patch moves ahead check for active rpm state of device,
so that rpm_resume can return immediately for device with
active rpm state.

Considered rpm_resume is run in atomic context and is often in
hot path(such as in usbnet, called before transmitting every
network frame), this patch should make sense.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/base/power/runtime.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0d4587b..dcc3008 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -455,6 +455,11 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
  repeat:
+	if (dev->power.runtime_status == RPM_ACTIVE) {
+		retval = 1;
+		goto out;
+	}
+
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
 	else if (dev->power.disable_depth > 0)
@@ -472,11 +477,6 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	if (!dev->power.timer_autosuspends)
 		pm_runtime_deactivate_timer(dev);
 
-	if (dev->power.runtime_status == RPM_ACTIVE) {
-		retval = 1;
-		goto out;
-	}
-
 	if (dev->power.runtime_status == RPM_RESUMING
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
-- 
1.7.4.1
