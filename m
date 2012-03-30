From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/76] cpuidle: use the driver's state_count as default
Date: Fri, 30 Mar 2012 06:13:52 -0400
Message-ID: <fc850f39ea54c760ce438a601cfea8ab80c4898e.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

If the state_count is not initialized for the device use
the driver's state count as the default. That will prevent
to add it manually in the cpuidle driver initialization
routine and will save us from duplicate line of code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 drivers/cpuidle/driver.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 77304b6..f7cab5e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -268,7 +268,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
 	if (!dev->state_count)
-		return -EINVAL;
+		dev->state_count = drv->state_count;
 
 	if (dev->registered == 0) {
 		ret = __cpuidle_register_device(dev);
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 284d7af..40cd3f3 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -47,7 +47,7 @@ static void __cpuidle_register_driver(struct cpuidle_driver *drv)
  */
 int cpuidle_register_driver(struct cpuidle_driver *drv)
 {
-	if (!drv)
+	if (!drv || !drv->state_count)
 		return -EINVAL;
 
 	if (cpuidle_disabled())
-- 
1.7.10.rc2.19.gfae9d
