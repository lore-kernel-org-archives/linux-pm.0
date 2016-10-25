From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] cpufreq: enable the DT cpufreq driver on the Integrators
Date: Tue, 25 Oct 2016 09:21:24 +0200
Message-ID: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:38975 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbcJYHVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 03:21:30 -0400
Received: by mail-lf0-f43.google.com with SMTP id t133so9572298lff.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 00:21:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>

This enables the generic DT and OPP-based cpufreq driver on the
ARM Integrator/AP and Integrator/CP.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 71267626456b..142a6f615e52 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -26,6 +26,9 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
 
+	{ .compatible = "arm,integrator-ap", },
+	{ .compatible = "arm,integrator-cp", },
+
 	{ .compatible = "hisilicon,hi6220", },
 
 	{ .compatible = "fsl,imx27", },
-- 
2.7.4

