From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] cpuidle: add missing header include
Date: Fri, 26 Oct 2012 13:30:07 +0900
Message-ID: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10145 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2JZEaJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Oct 2012 00:30:09 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

This patch adds missing device.h header to fix build warnings as below:

drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared inside parameter list [enabled by default]
drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this definition or declaration, which is probably not what you want
[enabled by default]
drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared inside parameter list [enabled by default]
In file included from drivers/cpuidle/driver.c:15:0:
drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared inside parameter list [enabled by default]
drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this definition or declaration, which is probably not what you want
[enabled by default]
drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared inside parameter list [enabled by default]

This build warning is introduced by commit efeca1b
"cpuidle / sysfs: change function parameter".

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index a5bbd1c..2120d9e 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -5,6 +5,8 @@
 #ifndef __DRIVER_CPUIDLE_H
 #define __DRIVER_CPUIDLE_H
 
+#include <linux/device.h>
+
 /* For internal use only */
 extern struct cpuidle_governor *cpuidle_curr_governor;
 extern struct list_head cpuidle_governors;
-- 
1.7.1


