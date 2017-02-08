From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Ignore domain-idle-states that are not compatible
Date: Wed,  8 Feb 2017 08:34:51 -0800
Message-ID: <1486571692-33212-3-git-send-email-lina.iyer@linaro.org>
References: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35943 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdBHQfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2017 11:35:44 -0500
Received: by mail-pg0-f53.google.com with SMTP id v184so50217547pgv.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2017 08:35:08 -0800 (PST)
In-Reply-To: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

domain-idle-states property may have phandles to idle state bindings
that may not be compatible with idle state definition defined in [1].
Such phandles would just be ignored and not throw and error when read by
the domain core.

Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt |  4 +++-
 drivers/base/power/domain.c                              | 16 +++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 723e1ad..940707d 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -31,7 +31,9 @@ Optional properties:
 
 - domain-idle-states : A phandle of an idle-state that shall be soaked into a
                 generic domain power state. The idle state definitions are
-                compatible with domain-idle-state specified in [1].
+                compatible with domain-idle-state specified in [1]. phandles
+                that are not compatible with domain-idle-state will be
+                ignored.
   The domain-idle-state property reflects the idle state of this PM domain and
   not the idle states of the devices or sub-domains in the PM domain. Devices
   and sub-domains have their own idle-states independent of the parent
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6b23d82..3825bb9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2065,11 +2065,6 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	int err;
 	u32 residency;
 	u32 entry_latency, exit_latency;
-	const struct of_device_id *match_id;
-
-	match_id = of_match_node(idle_state_match, state_node);
-	if (!match_id)
-		return -EINVAL;
 
 	err = of_property_read_u32(state_node, "entry-latency-us",
 						&entry_latency);
@@ -2118,6 +2113,7 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	int err, ret;
 	int count;
 	struct of_phandle_iterator it;
+	const struct of_device_id *match_id;
 
 	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
 	if (count <= 0)
@@ -2130,6 +2126,9 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
 		np = it.node;
+		match_id = of_match_node(idle_state_match, np);
+		if (!match_id)
+			continue;
 		ret = genpd_parse_state(&st[i++], np);
 		if (ret) {
 			pr_err
@@ -2141,8 +2140,11 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 		}
 	}
 
-	*n = count;
-	*states = st;
+	*n = i;
+	if (!i)
+		kfree(st);
+	else
+		*states = st;
 
 	return 0;
 }
-- 
2.7.4

