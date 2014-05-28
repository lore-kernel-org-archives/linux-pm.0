From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/4] PM: unregister the wakeup source when disabling a device' wakeup capability
Date: Wed, 28 May 2014 15:23:35 +0800
Message-ID: <1401261818-2978-2-git-send-email-rui.zhang@intel.com>
References: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaE1HXo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 May 2014 03:23:44 -0400
In-Reply-To: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, anton@enomsg.org, Zhang Rui <rui.zhang@intel.com>

When enabling a device' wakeup capability, a wakeup source
is created for the device automatically. But the wakeup source
is not unregistered when disabling the device' wakeup capability.

This results in zombie wakeup sources, after devices/drivers are unregistered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/power/wakeup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 2d56f41..030b069 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -318,10 +318,15 @@ int device_init_wakeup(struct device *dev, bool enable)
 {
 	int ret = 0;
 
+	if (!dev)
+		return -EINVAL;
+
 	if (enable) {
 		device_set_wakeup_capable(dev, true);
 		ret = device_wakeup_enable(dev);
 	} else {
+		if (dev->power.can_wakeup)
+			device_wakeup_disable(dev);
 		device_set_wakeup_capable(dev, false);
 	}
 
-- 
1.8.3.2

