Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388B4772B2;
	Wed,  2 Sep 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348620; cv=none; b=N/mFSgsxOPbftXNHZszQAB7nXZv6Dfd+kA8kscwa+MCYoIYyw4TA0Te6oy/y3rPPoIT36egI4o5ha2VLJ80JANnApSgjEURBCdTAEMFPRqhd7ENmOMG/Nk/kHtmmkRg9Dfh4xv3knx4O6jhq+F1LxSeDGwBC4clr62KqjWDr3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348620; c=relaxed/simple;
	bh=P/d6V8bx2n0tUQ85gOj+Z64f2Qvq4Li50KpmpHCGfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsWqjCbI5OXlS7wOvOjwPpSYFEKpUcuX5mzwRHgTGug5DMYnykCk7mW0dSki1wQS4HS7rjs1UlLrV+weak30h4uooisAwLszSXDDe6ayMrQBYWk+axvz10666zBG8uHwwpq68Ar3zu7CaLa5LuaVd3MMAtdF+geMfthbMDrXJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A01F00A3A;
	Wed,  2 Sep 2026 11:30:05 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>
Cc: devicetree@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 05/12] pmdomain: Make genpd_get_from_provider() public
Date: Wed,  2 Sep 2026 13:29:21 +0200
Message-ID: <1e1b20976fb2b0b78684be315cdf78960efcc403.1788338320.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the corresponding function in the clock subsystem
(of_clk_get_from_provider()), genpd_get_from_provider() is private, and
thus cannot be used by PM Domain drivers.

Make it public, so it be used by the R-Car X5H Module Controller driver.
Add an "of_"-prefix for consistency with public genpd function naming.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Add "of_" prefix,

v2:
  - No changes.
---
 drivers/pmdomain/core.c   | 22 +++++++++++-----------
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290677c..ac3a07066e7fc0e7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2890,7 +2890,7 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
- * genpd_get_from_provider() - Look-up PM domain
+ * of_genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
  * Looks for a PM domain provider under the node specified by @genpdspec and if
@@ -2900,8 +2900,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-static struct generic_pm_domain *genpd_get_from_provider(
-					const struct of_phandle_args *genpdspec)
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
 	struct of_genpd_provider *provider;
@@ -2923,6 +2922,7 @@ static struct generic_pm_domain *genpd_get_from_provider(
 
 	return genpd;
 }
+EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * of_genpd_add_child_ids() - Parse power-domains-child-ids property
@@ -2995,7 +2995,7 @@ int of_genpd_add_child_ids(struct device_node *np,
 			goto err_unwind;
 
 		/* Get the parent domain */
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd)) {
 			pr_err("Failed to get parent domain for %pOF: %ld\n",
@@ -3078,7 +3078,7 @@ int of_genpd_remove_child_ids(struct device_node *np,
 		if (ret)
 			continue;
 
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd))
 			continue;
@@ -3109,7 +3109,7 @@ int of_genpd_add_device(const struct of_phandle_args *genpdspec, struct device *
 
 	mutex_lock(&gpd_list_lock);
 
-	genpd = genpd_get_from_provider(genpdspec);
+	genpd = of_genpd_get_from_provider(genpdspec);
 	if (IS_ERR(genpd)) {
 		ret = PTR_ERR(genpd);
 		goto out;
@@ -3141,13 +3141,13 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 
 	mutex_lock(&gpd_list_lock);
 
-	parent = genpd_get_from_provider(parent_spec);
+	parent = of_genpd_get_from_provider(parent_spec);
 	if (IS_ERR(parent)) {
 		ret = PTR_ERR(parent);
 		goto out;
 	}
 
-	subdomain = genpd_get_from_provider(subdomain_spec);
+	subdomain = of_genpd_get_from_provider(subdomain_spec);
 	if (IS_ERR(subdomain)) {
 		ret = PTR_ERR(subdomain);
 		goto out;
@@ -3179,13 +3179,13 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 
 	mutex_lock(&gpd_list_lock);
 
-	parent = genpd_get_from_provider(parent_spec);
+	parent = of_genpd_get_from_provider(parent_spec);
 	if (IS_ERR(parent)) {
 		ret = PTR_ERR(parent);
 		goto out;
 	}
 
-	subdomain = genpd_get_from_provider(subdomain_spec);
+	subdomain = of_genpd_get_from_provider(subdomain_spec);
 	if (IS_ERR(subdomain)) {
 		ret = PTR_ERR(subdomain);
 		goto out;
@@ -3373,7 +3373,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		return ret;
 
 	mutex_lock(&gpd_list_lock);
-	pd = genpd_get_from_provider(&pd_args);
+	pd = of_genpd_get_from_provider(&pd_args);
 	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
 		mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f925614aebdbc914..0ef717428f2935e7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -458,6 +458,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec);
 int of_genpd_add_device(const struct of_phandle_args *args, struct device *dev);
 int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 			   const struct of_phandle_args *subdomain_spec);
@@ -492,6 +493,12 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 
 static inline void of_genpd_del_provider(struct device_node *np) {}
 
+static inline struct generic_pm_domain *of_genpd_get_from_provider(
+				const struct of_phandle_args *genpdspec)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline int of_genpd_add_device(const struct of_phandle_args *args,
 				      struct device *dev)
 {
-- 
2.43.0

