From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] PM / Domains: Make pm_genpd_init() available to modules
Date: Thu, 13 Aug 2015 11:51:57 +0530
Message-ID: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51856 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbHMGWL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 02:22:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org, geert@linux-m68k.org, Rajendra Nayak <rnayak@codeaurora.org>

Export symbol pm_genpd_init so it can be used in loadable
kernel modules

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0ee43c1..578d121 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1952,6 +1952,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
 }
+EXPORT_SYMBOL_GPL(pm_genpd_init);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

