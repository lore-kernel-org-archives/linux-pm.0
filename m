From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 4/8] PM / Domains: Add fwnode provider to genpd states
Date: Wed,  5 Oct 2016 14:31:55 -0600
Message-ID: <1475699519-109623-5-git-send-email-lina.iyer@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36140 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755052AbcJEUcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2016 16:32:14 -0400
Received: by mail-pf0-f179.google.com with SMTP id i85so41529443pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Oct 2016 13:32:14 -0700 (PDT)
In-Reply-To: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Save the fwnode for the genpd state in the state node. PM Domain clients
may use the fwnode to read in the rest of the properties for the domain
state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 include/linux/pm_domain.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 368a5b8..52fcdb2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1937,6 +1937,7 @@ static int read_genpd_state(struct genpd_power_state *genpd_state,
 	latency = entry_latency + exit_latency;
 	genpd_state->power_on_latency_ns = 1000 * latency;
 	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->provider = &state_node->fwnode;
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 4c9152d..eacfa71 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -39,6 +39,7 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	struct fwnode_handle *provider;
 };
 
 struct generic_pm_domain {
-- 
2.7.4

