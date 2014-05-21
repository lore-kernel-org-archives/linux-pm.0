From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/7] opp: remove -ENOSYS from dummy implementation of of_init_opp_table()
Date: Wed, 21 May 2014 16:39:59 +0530
Message-ID: <ddf99132a9b2a6aabef61cba20fffbbf56ec0985.1400670427.git.viresh.kumar@linaro.org>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:40294 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEULKZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 07:10:25 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so2874938qga.20
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 04:10:24 -0700 (PDT)
In-Reply-To: <cover.1400670427.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1400670427.git.viresh.kumar@linaro.org>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

When any of CONFIG_PM_OPP or CONFIG_OF isn't enabled we have a dummy
implementation of of_init_opp_table() routine, it returns -EINVAL currently.
-EINVAL can be returned from other places within the real implementations of
of_init_opp_table() and so caller wouldn't be able to differentiate between
those two cases.

Make it return -ENOSYS instead for better handling.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
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

