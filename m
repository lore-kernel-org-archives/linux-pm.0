From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 1/2] PM / Domains: Make pm_genpd_{add,remove}_subdomain() available to modules
Date: Thu,  1 Oct 2015 12:22:53 -0700
Message-ID: <1443727374-1539-2-git-send-email-sboyd@codeaurora.org>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39822 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbbJATXB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 15:23:01 -0400
In-Reply-To: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Export these symbols so they can be used in loadable kernel
modules.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

 drivers/base/power/domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cf4950d92937..9b0f5a06a82b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1348,6 +1348,7 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
 
 /**
  * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
@@ -1395,6 +1396,7 @@ out:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
 /* Default device callbacks for generic PM domains. */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

