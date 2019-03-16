From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/4] PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
Date: Sat, 16 Mar 2019 00:59:27 -0400
Message-ID: <20190316045928.31934-4-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The async_resume_noirq, async_resume_early, async_resume functions
are basically the same. As we have seen:

static void async_xxx(void *data, async_cookie_t cookie)
{
	struct device *dev = (struct device *)data;
	int error;

	error = device_xxx(dev, pm_transition, true);
	if (error)
		pm_dev_err(dev, pm_transition, " async", error);
	put_device(dev);
}

The ASYNC_RESUME_FUNC() helper macro can decrease code duplication.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 46 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 6026bda5e787..d512bee9d9ca 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -728,18 +728,21 @@ static int __func(struct device *dev) 					\
 	return __device_ ## __name(dev, pm_transition, false);		\
 }
 
-static void async_resume_noirq(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_noirq(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-
-	put_device(dev);
+#define ASYNC_RESUME_FUNC(__func, __name)				\
+static void __func(void *data, async_cookie_t cookie)			\
+{									\
+	struct device *dev = (struct device *)data;			\
+	int error;							\
+									\
+	error = device_ ## __name(dev, pm_transition, true);		\
+	if (error)							\
+		pm_dev_err(dev, pm_transition, " async", error);	\
+									\
+	put_device(dev);						\
 }
 
+ASYNC_RESUME_FUNC(async_resume_noirq, resume_noirq);
+
 void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -876,17 +879,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	return error;
 }
 
-static void async_resume_early(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_early(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-
-	put_device(dev);
-}
+ASYNC_RESUME_FUNC(async_resume_early, resume_early);
 
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
@@ -1035,16 +1028,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	return error;
 }
 
-static void async_resume(void *data, async_cookie_t cookie)
-{
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
-	put_device(dev);
-}
+ASYNC_RESUME_FUNC(async_resume, resume);
 
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
-- 
2.17.0
