From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Fri, 22 Apr 2016 08:46:51 +0530
Message-ID: <a825b531b34b15615791f40610c151e3f1ce2fb4.1461294917.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35689 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbcDVDRA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 23:17:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id fs9so35284701pac.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 20:17:00 -0700 (PDT)
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

Some of the routines have use -ENOSYS, which is supposed to be used only
for syscalls. Replace that with -EINVAL.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I am including this patch into the series and this one will be the first
patch of the series. Also, later patches will be updated to *not* use
-ENOSYS.

I will send out the series again once some sort of reviews are done.

 include/linux/pm_opp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cccaf4a29e9f..2605ed66f1bd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -199,7 +199,7 @@ static inline void dev_pm_opp_of_remove_table(struct device *dev)
 
 static inline int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -EINVAL;
 }
 
 static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
@@ -208,12 +208,12 @@ static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 
 static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -EINVAL;
 }
 
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
-	return -ENOSYS;
+	return -EINVAL;
 }
 #endif
 
-- 
2.7.1.410.g6faf27b

