Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031176;
	b=nRbeDDJPkfiMPbZjBU/RfoWRXfiFhuJ8LI06bSB594ODj3PWlORdRJ1KRuMKcIVj8k8o
	 c6i5ObnVvzoWY/ikoIwjytXAMjYIYgGUwFR96Ujlv3oHKbIJGqKt0jm3v1dBNJIciSKe8
	 P4Jj4Nb1X02ggmQG64BUCMpO1FMhTWTAO9hD/v2V3Nn6Pocn+tTETyIePoXstb6D44Z8Y
	 RTYLAzxPtAYSk99lIQGpfu06eqEPtIOaRALb++edmV8WdoYe9jF+pnez9spSBcisNJfax
	 ChOq5huw4+WdHWhYOKi8vcDyfZeMrujLaTDZhVSCH/wpNrR8p9yqPEkaPw0Ka6zwIdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031176;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MDwPgSaoR69t/F4sFSIpVUzjUnyLx69vHvJYpCEtCVU=;
	b=lxlXrJ2drqYR5WUx3lNYNJkXCNrPoqqEeou9Fuz+CIZqZy3zLnVNSSvbCbyx3tqPKiZf
	 v1M1CzzoD+i+binTI8yXUzY1eo5O91NIHhhMK6wDK8VWEHkA+KQjurr3pihqIIJBE/eiM
	 6hhAwDNoB1uaOxhffcQpfnWe7az2j7Qx6sX86ypeKJOUFa/yRbxBsfTkgKmJWcnbMtdjc
	 jkR3fU79uXWnuO38yJo3+wy0HWmsWNNNF4DEu4wolR+JyUzWwuTByDM8734Nd6A9hmGf+
	 rCLnL1HQwafljLcBowEsBOIuo+3iu7r9dbCjAYxg4+Ye1fSvcZzCvAgOr73yp8jVryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86A606A32A;
	Wed, 18 Nov 2026 19:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A21F000C5;
	Wed, 18 Nov 2026 19:46:11 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
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
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 10/15] pmdomain: Make genpd_get_from_provider() public
Date: Wed, 18 Nov 2026 20:44:58 +0100
Message-ID: <dcdd928d5b89cd0a67bd8c1d3a60cf657516850f.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the corresponding function in the clock subsystem[1],
genpd_get_from_provider() is private, and thus cannot be used by PM
Domain drivers.

Make it public, so the R-Car X5H Module Controller driver can call it.
Add an "of_"-prefix for consistency with public genpd function naming.

[1] of_clk_get_from_provider().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5:
  - Add Tested-by,

v4:
  - Improve patch description,

v3:
  - Add "of_" prefix,

v2:
  - No changes.
---
 drivers/pmdomain/core.c   | 22 +++++++++++-----------
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index c242807f62579e5b..2a44b45955dd6ba7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3008,7 +3008,7 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
- * genpd_get_from_provider() - Look-up PM domain
+ * of_genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
  * Looks for a PM domain provider under the node specified by @genpdspec and if
@@ -3018,8 +3018,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-static struct generic_pm_domain *genpd_get_from_provider(
-					const struct of_phandle_args *genpdspec)
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
 	struct of_genpd_provider *provider;
@@ -3041,6 +3040,7 @@ static struct generic_pm_domain *genpd_get_from_provider(
 
 	return genpd;
 }
+EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * of_genpd_add_child_ids() - Parse power-domains-child-ids property
@@ -3113,7 +3113,7 @@ int of_genpd_add_child_ids(struct device_node *np,
 			goto err_unwind;
 
 		/* Get the parent domain */
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd)) {
 			pr_err("Failed to get parent domain for %pOF: %ld\n",
@@ -3196,7 +3196,7 @@ int of_genpd_remove_child_ids(struct device_node *np,
 		if (ret)
 			continue;
 
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd))
 			continue;
@@ -3227,7 +3227,7 @@ int of_genpd_add_device(const struct of_phandle_args *genpdspec, struct device *
 
 	mutex_lock(&gpd_list_lock);
 
-	genpd = genpd_get_from_provider(genpdspec);
+	genpd = of_genpd_get_from_provider(genpdspec);
 	if (IS_ERR(genpd)) {
 		ret = PTR_ERR(genpd);
 		goto out;
@@ -3259,13 +3259,13 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 
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
@@ -3297,13 +3297,13 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 
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
@@ -3491,7 +3491,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		return ret;
 
 	mutex_lock(&gpd_list_lock);
-	pd = genpd_get_from_provider(&pd_args);
+	pd = of_genpd_get_from_provider(&pd_args);
 	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
 		mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610a9a6..d65ee8b3725c1bcb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -467,6 +467,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec);
 int of_genpd_add_device(const struct of_phandle_args *args, struct device *dev);
 int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 			   const struct of_phandle_args *subdomain_spec);
@@ -501,6 +502,12 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 
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

