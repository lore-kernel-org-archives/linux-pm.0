From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] clk: Provide notifier stubs when !COMMON_CLK
Date: Tue, 28 Jun 2016 08:20:33 +0200
Message-ID: <1467094833-7553-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58095 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcF1GVB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 02:21:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The clk notifier symbols are hidden by COMMON_CLK.  However on some
platforms HAVE_CLK might be set while COMMON_CLK not which leads to
compile test build errors like:

$ make.cross ARCH=sh
   drivers/devfreq/tegra-devfreq.c: In function 'tegra_actmon_rate_notify_cb':
>> drivers/devfreq/tegra-devfreq.c:391:16: error: 'POST_RATE_CHANGE' undeclared (first use in this function)
     if (action != POST_RATE_CHANGE)
                   ^
   drivers/devfreq/tegra-devfreq.c: In function 'tegra_devfreq_probe':
>> drivers/devfreq/tegra-devfreq.c:654:8: error: implicit declaration of function 'clk_notifier_register' [-Werror=implicit-function-declaration]
     err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
           ^

Export the macros and data type declarations outside of COMMON_CLK ifdef
and provide stubs to fix the compile testing.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Reported when testing patch [1] on ARCH=sh. I don't have the sh cross
compile toolchain so I cannot verify whether this fixes reported issue.

[1] http://www.gossamer-threads.com/lists/linux/kernel/2471798
---
 include/linux/clk.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 834179f3fa72..c83b8a9ffc14 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -20,8 +20,6 @@ struct device;
 
 struct clk;
 
-#ifdef CONFIG_COMMON_CLK
-
 /**
  * DOC: clk notifier callback types
  *
@@ -61,6 +59,8 @@ struct clk_notifier {
 	struct list_head		node;
 };
 
+#ifdef CONFIG_COMMON_CLK
+
 /**
  * struct clk_notifier_data - rate data to pass to the notifier callback
  * @clk: struct clk * being changed
@@ -140,6 +140,18 @@ bool clk_is_match(const struct clk *p, const struct clk *q);
 
 #else
 
+static inline int clk_notifier_register(struct clk *clk,
+					struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int clk_notifier_unregister(struct clk *clk,
+					  struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
 static inline long clk_get_accuracy(struct clk *clk)
 {
 	return -ENOTSUPP;
-- 
1.9.1

