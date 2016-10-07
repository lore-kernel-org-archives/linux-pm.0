From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 4/8] PM / Domains: Save the fwnode in genpd_power_state
Date: Fri,  7 Oct 2016 15:36:57 -0700
Message-ID: <1475879821-8035-5-git-send-email-lina.iyer@linaro.org>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32854 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbcJGWhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 18:37:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id 190so29408003pfv.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 15:37:18 -0700 (PDT)
In-Reply-To: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Save the fwnode for the genpd state in the state node. PM Domain clients
may use the fwnode to read in the platform specific domain state
properties and associate them with the state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 include/linux/pm_domain.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4208b67..e0f31fe 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1957,6 +1957,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	genpd_state->power_on_latency_ns = 1000 * exit_latency;
 	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b489496..6a89881 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -39,6 +39,7 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	struct fwnode_handle *fwnode;
 };
 
 struct generic_pm_domain {
-- 
2.7.4

