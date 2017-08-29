From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] cpufreq: dt-platdev: drop socionext,uniphier-ld6b from whitelist
Date: Wed, 30 Aug 2017 00:37:03 +0900
Message-ID: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:23588 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdH2Phv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 11:37:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

As you see arch/arm/boot/dts/uniphier-ld6b.dtsi, it includes
uniphier-pxs2.dtsi, which uses "operating-points-v2" property
and whose cpufreq device is automatically created.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a020da7940d6..c344fc1c4eb8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -83,8 +83,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
 
-	{ .compatible = "socionext,uniphier-ld6b", },
-
 	{ .compatible = "st-ericsson,u8500", },
 	{ .compatible = "st-ericsson,u8540", },
 	{ .compatible = "st-ericsson,u9500", },
-- 
2.7.4
