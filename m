From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 03/27] PM / Domain: Add additional state specific param
Date: Tue, 17 Nov 2015 15:37:27 -0700
Message-ID: <1447799871-56374-4-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36360 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbbKQWiW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:22 -0500
Received: by pacdm15 with SMTP id dm15so22071636pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:22 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

Allow domain states to hold additional state related data in a u32
value. This may be used by the platform driver.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 drivers/base/power/domain.c                              | 6 ++++++
 include/linux/pm_domain.h                                | 1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index e2f542e..ecfaf44 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -67,6 +67,12 @@ have the following properties -
 		If omitted, this is assumed to be equal to:
 			entry-latency-us + exit-latency-us
 
+	- state-param:
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value as defined by the state. May be used
+		by the driver to hold state related u32 data.
+
 Example:
 
 	power: power-controller@12340000 {
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index fe1be88..3fb4c93 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1245,6 +1245,7 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
 			st[i].power_on_latency_ns;
 		genpd->states[i].power_off_latency_ns =
 			st[i].power_off_latency_ns;
+		genpd->states[i].param = st[i].param;
 	}
 
 	/*
@@ -1527,6 +1528,7 @@ static int of_get_genpd_power_state(struct genpd_power_state *genpd_state,
 	const struct of_device_id *match_id;
 	int err = 0;
 	u32 latency;
+	u32 param;
 
 	match_id = of_match_node(power_state_match, state_node);
 	if (!match_id)
@@ -1567,6 +1569,10 @@ static int of_get_genpd_power_state(struct genpd_power_state *genpd_state,
 		return -EINVAL;
 	}
 
+	err = of_property_read_u32(state_node, "state-param", &param);
+	if (!err)
+		genpd_state->param = param;
+
 	genpd_state->power_off_latency_ns = 1000 * latency;
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e425911..15df24c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -41,6 +41,7 @@ struct genpd_power_state {
 	char *name;
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
+	u32 param;
 };
 
 struct generic_pm_domain {
-- 
2.1.4

