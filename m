From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Sun, 25 Sep 2016 20:13:57 +0800
Message-ID: <1474805638-30407-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35151 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966288AbcIYMON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2016 08:14:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id 6so7672152pfl.2
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2016 05:14:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

This driver uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
build failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
v2: fix typo in commit log and also add Chanwoo's Ack.
This one is a build fix, I think it should be for v4.8.
 drivers/devfreq/event/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index 0fdae86..cd94980 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
 	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PM_OPP
+	select REGMAP_MMIO
 	help
 	  This add the devfreq-event driver for Exynos SoC. It provides NoC
 	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
-- 
2.7.4

