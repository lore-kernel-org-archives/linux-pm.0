From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3 v2] cpufreq: enable the DT cpufreq driver on the Ux500
Date: Wed, 16 Aug 2017 10:19:12 +0200
Message-ID: <20170816081914.30471-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34750 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdHPITY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 04:19:24 -0400
Received: by mail-lf0-f54.google.com with SMTP id g25so13274162lfh.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2017 01:19:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This enables the generic DT and OPP-based cpufreq driver on the
ST-Ericsson Ux500 series.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1-v2:
- Added Viresh's ACK.

Please apply this to the cpufreq tree.
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c262923fe58..d80300251bc4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -88,6 +88,11 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "socionext,uniphier-ld11", },
 	{ .compatible = "socionext,uniphier-ld20", },
 
+	{ .compatible = "st-ericsson,u8500", },
+	{ .compatible = "st-ericsson,u8540", },
+	{ .compatible = "st-ericsson,u9500", },
+	{ .compatible = "st-ericsson,u9540", },
+
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.13.5
