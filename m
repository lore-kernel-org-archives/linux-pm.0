From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH TRIVIAL] PM / wakeup: only recommend "call"ing device_init_wakeup() once
Date: Mon, 18 Dec 2017 15:30:48 -0800
Message-ID: <20171218233048.156954-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

I'll admit admit it: I've written bad driver code that tries to
configure a device's wake IRQ without having called device_init_wakeup()
first. But do you really have to ask ask me twice?

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/base/power/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 38559f04db2c..cb72965b3281 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -298,7 +298,7 @@ int device_wakeup_attach_irq(struct device *dev,
 
 	ws = dev->power.wakeup;
 	if (!ws) {
-		dev_err(dev, "forgot to call call device_init_wakeup?\n");
+		dev_err(dev, "forgot to call device_init_wakeup?\n");
 		return -EINVAL;
 	}
 
-- 
2.15.1.504.g5279b80103-goog
