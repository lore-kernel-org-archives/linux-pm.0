From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/4] PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro
Date: Sat, 16 Mar 2019 00:59:28 -0400
Message-ID: <20190316045928.31934-5-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The async_suspend_noirq, async_suspend_late, async_suspend functions
are basically the same. As we have seen:

static void async_xxx(void *data, async_cookie_t cookie)
{
	struct device *dev = (struct device *)data;
	int error;

	error = __device_xxx(dev, pm_transition, true);
	if (error) {
		dpm_save_failed_dev(dev_name(dev));
		pm_dev_err(dev, pm_transition, " async", error);
	}

	put_device(dev);
}

The ASYNC_SUSPEND_FUNC() helper macro can decrease code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 55 ++++++++++++---------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d512bee9d9ca..3882dc5fee9f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1348,20 +1348,22 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	return error;
 }
 
-static void async_suspend_noirq(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend_noirq(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-
-	put_device(dev);
+#define ASYNC_SUSPEND_FUNC(__func, __name)				\
+static void __func(void *data, async_cookie_t cookie)			\
+{									\
+	struct device *dev = (struct device *)data;			\
+	int error;							\
+									\
+	error = __device_ ## __name(dev, pm_transition, true);		\
+	if (error) {							\
+		dpm_save_failed_dev(dev_name(dev));			\
+		pm_dev_err(dev, pm_transition, " async", error);	\
+	}								\
+									\
+	put_device(dev);						\
 }
 
+ASYNC_SUSPEND_FUNC(async_suspend_noirq, suspend_noirq);
 DEVICE_SUSPEND_FUNC(device_suspend_noirq, suspend_noirq);
 
 void dpm_noirq_begin(void)
@@ -1542,19 +1544,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	return error;
 }
 
-static void async_suspend_late(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend_late(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-	put_device(dev);
-}
-
+ASYNC_SUSPEND_FUNC(async_suspend_late, suspend_late);
 DEVICE_SUSPEND_FUNC(device_suspend_late, suspend_late);
 
 /**
@@ -1796,20 +1786,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	return error;
 }
 
-static void async_suspend(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = __device_suspend(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
-
-	put_device(dev);
-}
-
+ASYNC_SUSPEND_FUNC(async_suspend, suspend);
 DEVICE_SUSPEND_FUNC(device_suspend, suspend);
 
 /**
-- 
2.17.0
