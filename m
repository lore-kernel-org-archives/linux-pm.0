From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] power: Print wakeup_count instead of event_count in the sysfs attribute.
Date: Fri,  1 Jun 2018 19:32:15 -0700
Message-ID: <20180602023215.176521-1-ravisadineni@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, chenhong3@huawei.com, ravisadineni@chromium.org, pavel@ucw.cz, ravisadineni@google.com, dtor@google.com, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: tbroch@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rajatja@google.com, bleung@google.com
List-Id: linux-pm@vger.kernel.org

Currently we show event_count instead of wakeup_count as part of per
device wakeup_count sysfs attribute. Change it to wakeup_count to make
it more meaningful.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/base/power/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 0f651efc58a1a..d713738ce7967 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -353,7 +353,7 @@ static ssize_t wakeup_count_show(struct device *dev,
 
 	spin_lock_irq(&dev->power.lock);
 	if (dev->power.wakeup) {
-		count = dev->power.wakeup->event_count;
+		count = dev->power.wakeup->wakeup_count;
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-- 
2.17.1.1185.g55be947832-goog
