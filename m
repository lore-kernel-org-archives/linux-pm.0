From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 8/8] cpuidle: Check the device is not already registered
Date: Wed, 12 Jun 2013 15:08:55 +0200
Message-ID: <1371042535-22630-8-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:42860 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3FLNJH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:09:07 -0400
Received: by mail-wg0-f46.google.com with SMTP id c11so3400186wgh.25
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:09:06 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

Add a sanity check for cpuidle_register_device by testing if the device
was already registered or not.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7c3f625..59b697877 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -400,13 +400,16 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
  */
 int cpuidle_register_device(struct cpuidle_device *dev)
 {
-	int ret;
+	int ret = -EBUSY;
 
 	if (!dev)
 		return -EINVAL;
 
 	mutex_lock(&cpuidle_lock);
 
+	if (dev->registered)
+		goto out_unlock;
+
 	ret = __cpuidle_device_init(dev);
 	if (ret)
 		goto out_unlock;
-- 
1.7.9.5

