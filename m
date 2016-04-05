From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] cpuidle: Indicate when a device has been unregistered
Date: Tue, 5 Apr 2016 14:05:38 -0500
Message-ID: <1459883138-21136-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbcDETGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 15:06:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>

Currently the 'registered' member of the cpuidle_device struct is set
to 1 during cpuidle_register_device. In this same function there are
checks to see if the device is already registered to prevent duplicate
calls to register the device, but this value is never set to 0 even on
unregister of the device. Because of this, any attempt to call
cpuidle_register_device after a call to cpuidle_unregister_device will
fail which shouldn't be the case.

To prevent this, set registered to 0 when the device is unregistered.

Fixes: c878a52d3c7c ("cpuidle: Check if device is already registered")
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/cpuidle/cpuidle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f996efc56605..c2dd99ab1648 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -433,6 +433,8 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 	list_del(&dev->device_list);
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
 	module_put(drv->owner);
+
+	dev->registered = 0;
 }
 
 static void __cpuidle_device_init(struct cpuidle_device *dev)
-- 
2.7.3

