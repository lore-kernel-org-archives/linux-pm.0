From: Rajat Jain <rajatja@google.com>
Subject: [PATCH 2/2] mfd: intel-lpss: switch to suspend_late()/resume_early()
Date: Wed, 20 Sep 2017 15:31:52 -0700
Message-ID: <20170920223152.100641-2-rajatja@google.com>
References: <20170920223152.100641-1-rajatja@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170920223152.100641-1-rajatja@google.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, furquan@google.com, rajatxjain@gmail.com
Cc: Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

Ref: https://lkml.org/lkml/2017/9/19/649

The intel-lpss hosts the designware i2c controller device, which
needs to be up and running until all its i2c child devices have
suspended (child devices need to be accessible over i2c until
suspend_late() has been called for all those devices).

So lets delay the resetting of the controller until suspend_late().
I thought of renaming function to say *_late / *_early but that
might cause confusion since the same function is also used for runtime
suspend/resume.

Fixes: 0b471aaa0e1a ("Put I2C and SPI controllers into reset state on suspend")
Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/mfd/intel-lpss.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 694116630ffa..865bbeaaf00c 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -38,12 +38,7 @@ int intel_lpss_resume(struct device *dev);
 #ifdef CONFIG_PM_SLEEP
 #define INTEL_LPSS_SLEEP_PM_OPS			\
 	.prepare = intel_lpss_prepare,		\
-	.suspend = intel_lpss_suspend,		\
-	.resume = intel_lpss_resume,		\
-	.freeze = intel_lpss_suspend,		\
-	.thaw = intel_lpss_resume,		\
-	.poweroff = intel_lpss_suspend,		\
-	.restore = intel_lpss_resume,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
 #else
 #define INTEL_LPSS_SLEEP_PM_OPS
 #endif
-- 
2.14.1.821.g8fa685d3b7-goog
