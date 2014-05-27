From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/8] opp: of_init_opp_table(): return -ENOSYS when feature isn't implemented
Date: Tue, 27 May 2014 17:20:50 +0530
Message-ID: <231be85cd01bcdc00a0a7936cd9ba57ccba52749.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63517 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaE0Lw1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 May 2014 07:52:27 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so9145217pbb.34
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2014 04:52:26 -0700 (PDT)
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

When none of CONFIG_PM_OPP or CONFIG_OF is enabled we use the dummy
implementation of of_init_opp_table() routine, which returns -EINVAL currently.
-EINVAL can confuse the callers a bit as it can have other meanings for the
actual implementation of this routine.

It is more appropriate to return -ENOSYS instead to avoid confusion at caller.

Suggested-and-reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0330217..6668150 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -112,7 +112,7 @@ int of_init_opp_table(struct device *dev);
 #else
 static inline int of_init_opp_table(struct device *dev)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 #endif
 
-- 
2.0.0.rc2

