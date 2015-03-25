From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/8] ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function
Date: Wed, 25 Mar 2015 10:07:11 +0100
Message-ID: <1427274436-21916-3-git-send-email-daniel.lezcano@linaro.org>
References: <55127A53.8050206@linaro.org>
 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37511 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbCYJH0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 05:07:26 -0400
Received: by wixw10 with SMTP id w10so28757861wix.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 02:07:24 -0700 (PDT)
In-Reply-To: <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com

Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspend function
which is specific to ARM64.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Rob Herring <robherring2@gmail.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle-arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 39a2c62..0cea244 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
-		ret = cpu_suspend(idx);
+		arm_cpuidle_suspend(idx);
 
 		cpu_pm_exit();
 	}
-- 
1.9.1

