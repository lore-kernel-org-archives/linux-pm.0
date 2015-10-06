From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] soc: dove: Let genpd deal with disabling of unused PM domains
Date: Tue,  6 Oct 2015 14:27:30 +0200
Message-ID: <1444134450-17895-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36751 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbJFM1g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 08:27:36 -0400
Received: by laddr2 with SMTP id dr2so25648975lad.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 05:27:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>

Genpd tries from a late_initcall to disable unused PM domains, which makes
it unnecessary to also manage this from any earlier phase when for example
initializing a genpd.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/dove/pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 052aecf..abd0879 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -396,7 +396,6 @@ int __init dove_init_pmu(void)
 
 		__pmu_domain_register(domain, np);
 	}
-	pm_genpd_poweroff_unused();
 
 	/* Loss of the interrupt controller is not a fatal error. */
 	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
-- 
1.9.1

