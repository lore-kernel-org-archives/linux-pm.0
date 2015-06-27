From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 06/16] arm: domain: Make CPU genpd IRQ safe
Date: Fri, 26 Jun 2015 21:02:26 -0600
Message-ID: <1435374156-19214-7-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35870 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbF0DCy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:54 -0400
Received: by pdcu2 with SMTP id u2so84846312pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:53 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Generic PM domains that support runtime suspend/resume in IRQ safe
contexts should define GENPD_FLAG_IRQ_SAFE flag for the genpd.

CPUIdle powers off the CPUs in an IRQ safe context and therefore CPU
domains that use CPUIlde for runtime suspend/resume would need to
operate as IRQ safe domains. Define GENPD_FLAG_IRQ_SAFE for CPU domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 3248409..a27f825 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -90,6 +90,7 @@ static int arm_domain_init(void)
 		pd->genpd.name = kstrdup(np->name, GFP_KERNEL);
 		pd->genpd.power_off = arm_pd_power_down;
 		pd->genpd.power_on = arm_pd_power_up;
+		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
 		platform_set_drvdata(pdev, pd);
 
 		dev_dbg(dev, "adding as generic power domain.\n");
-- 
2.1.4

