From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 6/9] PM / Domains: Save the fwnode in genpd_power_state
Date: Mon, 24 Oct 2016 15:21:05 -0700
Message-ID: <1477347668-41901-7-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33292 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965705AbcJXWV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 18:21:28 -0400
Received: by mail-pf0-f173.google.com with SMTP id 128so106325478pfz.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 15:21:28 -0700 (PDT)
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Save the fwnode for the genpd state in the state node. PM Domain clients
may use the fwnode to read in the platform specific domain state
properties and associate them with the state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 include/linux/pm_domain.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0e59f1d..f056c80 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1956,6 +1956,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
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

