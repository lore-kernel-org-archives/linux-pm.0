From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: fix comment format
Date: Tue, 23 Apr 2013 17:28:44 +0200
Message-ID: <1366730924-20633-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:46188 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab3DWP2x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 11:28:53 -0400
Received: by mail-we0-f178.google.com with SMTP id z53so751132wey.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 08:28:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: santosh.shilimkar@ti.com, linux-pm@vger.kernel.org

Fix comment format for the kernel doc script.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 49e8d30..c3a93fe 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -454,7 +454,7 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
-/*
+/**
  * cpuidle_unregister: unregister a driver and the devices. This function
  * can be used only if the driver has been previously registered through
  * the cpuidle_register function.
-- 
1.7.9.5

