From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 7/9] PM / Domains: allow platform specific data for genpd states
Date: Fri,  3 Mar 2017 12:41:33 -0800
Message-ID: <1488573695-106680-8-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Allow platforms to save a state specific parameter for the genpd state.
The parameter would be used to identify the state when the platform is
called to power off the domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5..183995a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -42,6 +42,7 @@ struct genpd_power_state {
 	s64 power_on_latency_ns;
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
+	u32 param;
 };
 
 struct genpd_lock_ops;
-- 
2.7.4
