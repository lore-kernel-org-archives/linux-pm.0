From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/4] PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
Date: Sat, 16 Mar 2019 00:59:26 -0400
Message-ID: <20190316045928.31934-3-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The devices_suspend_noirq, device_suspend_late, device_suspen functions
are basically the same. As we have seen:

static int device_xxx(struct device *dev)
{
       if (dpm_async_fn(dev, async_xxx))
               return 0;

       return __device_xxx(dev, pm_transition, false);
}

The DEVICE_SUSPEND_FUNC() helper macro can decrease
code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index cb44bb6b2b66..6026bda5e787 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -719,6 +719,15 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 	return false;
 }
 
+#define DEVICE_SUSPEND_FUNC(__func, __name)				\
+static int __func(struct device *dev)					\
+{									\
+	if (dpm_async_fn(dev, async_ ## __name))			\
+		return 0;						\
+									\
+	return __device_ ## __name(dev, pm_transition, false);		\
+}
+
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = (struct device *)data;
@@ -1369,13 +1378,7 @@ static void async_suspend_noirq(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend_noirq(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_noirq))
-		return 0;
-
-	return __device_suspend_noirq(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend_noirq, suspend_noirq);
 
 void dpm_noirq_begin(void)
 {
@@ -1568,13 +1571,7 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend_late(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_late))
-		return 0;
-
-	return __device_suspend_late(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend_late, suspend_late);
 
 /**
  * dpm_suspend_late - Execute "late suspend" callbacks for all devices.
@@ -1829,13 +1826,7 @@ static void async_suspend(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int device_suspend(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend))
-		return 0;
-
-	return __device_suspend(dev, pm_transition, false);
-}
+DEVICE_SUSPEND_FUNC(device_suspend, suspend);
 
 /**
  * dpm_suspend - Execute "suspend" callbacks for all non-sysdev devices.
-- 
2.17.0
