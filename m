From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] devfreq: Fix build break of devfreq-event class
Date: Fri, 30 Jan 2015 13:54:08 +0900
Message-ID: <1422593648-18151-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24299 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbA3EyT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 23:54:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, myungjoo.ham@samsung.com
Cc: kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

This patch fixes the build break of the exynos-ppmu driver because Makefile
in drivers/devfreq don't include the entry of devfreq-event.c driver.

The original patch[1] includes the entry to build devfreq-event.c without
the build break. This build break is generated in the process of merging the
patch.
[1] https://lkml.org/lkml/2015/1/25/579
- [PATCH v10 1/7] devfreq: event: Add new devfreq_event class to provide basic
                  data for devfreq governor

CC      init/version.o
LD      init/built-in.o
drivers/built-in.o: In function `exynos_ppmu_probe':
binder.c:(.text+0x4447ec): undefined reference to `devm_devfreq_event_add_edev'
make: *** [vmlinux] Error 1

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 9256c35..5134f9e 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq.o
+obj-$(CONFIG_PM_DEVFREQ_EVENT)	+= devfreq-event.o
 obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
-- 
1.8.5.5

