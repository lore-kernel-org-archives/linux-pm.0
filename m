From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] PM / Domains: Fixup domain-idle-states OF parsing
Date: Tue, 23 Jan 2018 21:43:08 +0100
Message-ID: <1516740188-3580-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45790 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeAWUnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jan 2018 15:43:17 -0500
Received: by mail-lf0-f67.google.com with SMTP id x196so2288658lfd.12
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2018 12:43:16 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: khilman@kernel.org, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>

The commit b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are
not compatible"), made it possible to ignore non-compatible
domain-idle-states OF nodes. However, in case that happens while doing the
OF parsing, the number of elements in the allocated array would exceed the
numbers actually needed, thus wasting memory.

Fix this by pre-iterating the genpd OF node and counting the number of
compatible domain-idle-states nodes, before doing the allocation. While
doing this, it makes sense to rework the code a bit to avoid open coding,
of parts responsible for the OF node iteration.

Let's also take the opportunity to clarify the function header for
of_genpd_parse_idle_states(), about what is being returned in case of
errors.

Fixes: b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are not compatible")
Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog to clarify the problem is really about avoiding to
	waste memory, according to comment from Lina.

---
 drivers/base/power/domain.c | 76 +++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 528b241..1ea0e25 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2290,6 +2290,38 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	return 0;
 }
 
+static int genpd_iterate_idle_states(struct device_node *dn,
+				     struct genpd_power_state *states)
+{
+	int ret;
+	struct of_phandle_iterator it;
+	struct device_node *np;
+	int i = 0;
+
+	ret = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
+	if (ret <= 0)
+		return ret;
+
+	/* Loop over the phandles until all the requested entry is found */
+	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {
+		np = it.node;
+		if (!of_match_node(idle_state_match, np))
+			continue;
+		if (states) {
+			ret = genpd_parse_state(&states[i], np);
+			if (ret) {
+				pr_err("Parsing idle state node %pOF failed with err %d\n",
+				       np, ret);
+				of_node_put(np);
+				return ret;
+			}
+		}
+		i++;
+	}
+
+	return i;
+}
+
 /**
  * of_genpd_parse_idle_states: Return array of idle states for the genpd.
  *
@@ -2299,49 +2331,31 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
  *
  * Returns the device states parsed from the OF node. The memory for the states
  * is allocated by this function and is the responsibility of the caller to
- * free the memory after use.
+ * free the memory after use. If no domain idle states is found it returns
+ * -EINVAL and in case of errors, a negative error code.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {
 	struct genpd_power_state *st;
-	struct device_node *np;
-	int i = 0;
-	int err, ret;
-	int count;
-	struct of_phandle_iterator it;
-	const struct of_device_id *match_id;
+	int ret;
 
-	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
-	if (count <= 0)
-		return -EINVAL;
+	ret = genpd_iterate_idle_states(dn, NULL);
+	if (ret <= 0)
+		return ret < 0 ? ret : -EINVAL;
 
-	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
+	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
-	/* Loop over the phandles until all the requested entry is found */
-	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
-		np = it.node;
-		match_id = of_match_node(idle_state_match, np);
-		if (!match_id)
-			continue;
-		ret = genpd_parse_state(&st[i++], np);
-		if (ret) {
-			pr_err
-			("Parsing idle state node %pOF failed with err %d\n",
-							np, ret);
-			of_node_put(np);
-			kfree(st);
-			return ret;
-		}
+	ret = genpd_iterate_idle_states(dn, st);
+	if (ret <= 0) {
+		kfree(st);
+		return ret < 0 ? ret : -EINVAL;
 	}
 
-	*n = i;
-	if (!i)
-		kfree(st);
-	else
-		*states = st;
+	*states = st;
+	*n = ret;
 
 	return 0;
 }
-- 
2.7.4
