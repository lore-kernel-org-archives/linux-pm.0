From: Chenhui Zhao <chenhui.zhao@nxp.com>
Subject: [PATCH] cpuidle: remove cpu_pm calls when entering a idle state
Date: Fri, 21 Oct 2016 17:32:57 +0800
Message-ID: <1477042377-13485-1-git-send-email-chenhui.zhao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:31840
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932469AbcJUJsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 05:48:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Cc: z.chenhui@gmail.com, Chenhui Zhao <chenhui.zhao@nxp.com>

The functions, cpu_pm_enter and cpu_pm_exit, assume that CPU would
be reset when entering and exiting a idle state. If that is not the
case, they would cause issue.

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 include/linux/cpuidle.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..063af89 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -261,12 +261,7 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 		return idx;					\
 	}							\
 								\
-	__ret = cpu_pm_enter();					\
-	if (!__ret) {						\
-		__ret = low_level_idle_enter(idx);		\
-		cpu_pm_exit();					\
-	}							\
-								\
+	__ret = low_level_idle_enter(idx);			\
 	__ret ? -1 : idx;					\
 })
 
-- 
1.9.1

