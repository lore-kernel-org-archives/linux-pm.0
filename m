From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [RESEND PATCH] PM / devfreq: Propagate error from devfreq_add_device()
Date: Sun,  5 Nov 2017 21:27:41 -0800
Message-ID: <20171106052741.445-1-bjorn.andersson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:49558 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKFF1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 00:27:46 -0500
Received: by mail-pf0-f196.google.com with SMTP id i5so6925539pfe.6
        for <linux-pm@vger.kernel.org>; Sun, 05 Nov 2017 21:27:45 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org

Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
rather than statically returning ENOMEM. This makes it slightly faster
to pinpoint the cause of a returned error.

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Resending with Chanwoo's ack, Fixes and Cc stable

 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 78fb496ecb4e..99c4021fc33b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -737,7 +737,7 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
-- 
2.12.0
