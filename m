From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 4/4] cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms
Date: Fri, 3 Feb 2017 11:29:29 -0600
Message-ID: <20170203172929.23940-5-d-gerlach@ti.com>
References: <20170203172929.23940-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:28924 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdBCRaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2017 12:30:12 -0500
In-Reply-To: <20170203172929.23940-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lukasz Majewski <lukma@denx.de>

Some TI platforms, specifically those in the am33xx, am43xx, dra7xx, and
am57xx families of SoCs can make use of the ti-cpufreq driver to
selectively enable OPPs based on the exact configuration in use. The
ti-cpufreq is given the responsibility of creating the cpufreq-dt
platform device when the driver is in use so drop am33xx and dra7xx
from the cpufreq-dt-platdev driver so it is not created twice.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7fcaf26e8f81..921b4a6c3d16 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -87,8 +87,6 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "socionext,uniphier-ld11", },
 	{ .compatible = "socionext,uniphier-ld20", },
 
-	{ .compatible = "ti,am33xx", },
-	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.11.0

