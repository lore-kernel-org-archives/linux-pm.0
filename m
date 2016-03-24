From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: dt: Drop stale comment
Date: Thu, 24 Mar 2016 09:51:57 +0530
Message-ID: <815261ca63befe7070b279b7c7373f0828d0c1bc.1458793308.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33668 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcCXEWV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 00:22:21 -0400
Received: by mail-pa0-f41.google.com with SMTP id fl4so12106436pad.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 21:22:21 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The comment in file header doesn't hold true anymore, drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f951f911786e..5f8dbe640a20 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -4,9 +4,6 @@
  * Copyright (C) 2014 Linaro.
  * Viresh Kumar <viresh.kumar@linaro.org>
  *
- * The OPP code in function set_target() is reused from
- * drivers/cpufreq/omap-cpufreq.c
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-- 
2.7.1.410.g6faf27b

