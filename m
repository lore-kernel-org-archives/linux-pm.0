Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796882;
	b=XEusUdHGGHVXK6p/GEFad4tLGgkna/MCzELaRkmnlsG1fdtRJKGlEG6961RQwYqptFWf
	 KlU4T/L3kNP+rQpQxiPTtRO/4QbVaaFA9pE1CnSrjV+13qX0lWtaVASh/wLgHV0MfEDaB
	 qj+xa1UIAxmpdUteXQ8pxuopUuZH1FiK43XHwI0F2ZQokt6oUx4GYqKn2D0fcnL8pGQzM
	 oiSBg1yaXJf8mYfdPrWUn3OHQJ0+wHykNVlPr9OzQ+uHAAP1wHweDFKPb15pB4jXR3iio
	 9JBqlvXwO9eTgYXFog0ws3lQrFhJYh7cgFNF/tjS0AmIhXaA8UnKuYdeGdygu/oPOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bolv81tEfuUDEEJ9pFfk+0De++1uyhX+bEnJc0yg6zg=;
	b=McQbWiJcppsDZKunsrA0U6MgGGagVlvQe/a0OneESHLwdtFg7T5ndWBXXvvv3CRRahwV
	 DhCbtQSEi91sfh/xJUT5GS+BKrH1SYq/W6Dh3WkApbm0lJUEXewLJgC00jAuWgJJPWuDC
	 vQDbkAY1CzkaLNq033v511snRQafS0ef3kxA/a2uHzG2EoUg2AnMXNF74hxOCWmbZK+GM
	 mWku2tX1uBwoDiCfekQgy0DiVWO3hnzyVcAlcgUYqRu8JmvjEVOfBTWt9Ucvli0Soi5WS
	 hUwJB2qzJ8ilDuIWa5oqGrrmzubD2mKKJKQBueRikIPCCw3EByt2fh5VdkcK0Odeitg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UjmwZn/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DD606A31E;
	Fri, 27 Nov 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjmwZn/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D91F00897;
	Fri, 27 Nov 2026 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796881;
	bh=bolv81tEfuUDEEJ9pFfk+0De++1uyhX+bEnJc0yg6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjmwZn/Igu9z3No4RvPiYizmb068mOk22PqfHBNElJKZ9YupABXKsrut3VCGWWZVZ
	 FiHTZCD1S+ajwUUYCqTmirUzh00s/EMaaebclXOwDi8Qfxe+yc0/duJHQgE1uGdSOw
	 q+q3IrxUIXdK/RKFU5e4QiF15wTaVb5l/9Sid9j8AfY55TPy7WsqYu8l1Jx8zRie6B
	 GmjjiUS5a7+AD/4rDSYN24aeSOUDZxz0UogFSXZxq9O6P1MKG9PgKSb+hLDmgkkzMZ
	 /UGZwe1LBWV6SfWqRBxXQ7bxsG8gOVN5Lwn+faQsEzu6SK3iQDe3AvrID/kXC2qd9l
	 BxAbXUawIdRsg==
From: Geert Uytterhoeven <geert@kernel.org>
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
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 09/14] pmdomain: Make genpd_get_from_provider() public
Date: Fri, 27 Nov 2026 17:26:54 +0100
Message-ID: <955497c820f1c2bd2ed7b2090540c2e98a287f63.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Unlike the corresponding function in the clock subsystem[1],
genpd_get_from_provider() is private, and thus cannot be used by PM
Domain drivers.

Make it public, so the R-Car X5H Module Controller driver can call it.
Add an "of_"-prefix for consistency with public genpd function naming.

[1] of_clk_get_from_provider().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v6:
  - No changes,

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
index 633a6e642b1ba50d..467d6e6e34dc21f8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3024,7 +3024,7 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
- * genpd_get_from_provider() - Look-up PM domain
+ * of_genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
  * Looks for a PM domain provider under the node specified by @genpdspec and if
@@ -3034,8 +3034,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-static struct generic_pm_domain *genpd_get_from_provider(
-					const struct of_phandle_args *genpdspec)
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
 	struct of_genpd_provider *provider;
@@ -3057,6 +3056,7 @@ static struct generic_pm_domain *genpd_get_from_provider(
 
 	return genpd;
 }
+EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * of_genpd_add_child_ids() - Parse power-domains-child-ids property
@@ -3129,7 +3129,7 @@ int of_genpd_add_child_ids(struct device_node *np,
 			goto err_unwind;
 
 		/* Get the parent domain */
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd)) {
 			pr_err("Failed to get parent domain for %pOF: %ld\n",
@@ -3212,7 +3212,7 @@ int of_genpd_remove_child_ids(struct device_node *np,
 		if (ret)
 			continue;
 
-		parent_genpd = genpd_get_from_provider(&parent_args);
+		parent_genpd = of_genpd_get_from_provider(&parent_args);
 		of_node_put(parent_args.np);
 		if (IS_ERR(parent_genpd))
 			continue;
@@ -3243,7 +3243,7 @@ int of_genpd_add_device(const struct of_phandle_args *genpdspec, struct device *
 
 	mutex_lock(&gpd_list_lock);
 
-	genpd = genpd_get_from_provider(genpdspec);
+	genpd = of_genpd_get_from_provider(genpdspec);
 	if (IS_ERR(genpd)) {
 		ret = PTR_ERR(genpd);
 		goto out;
@@ -3275,13 +3275,13 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 
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
@@ -3313,13 +3313,13 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 
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
@@ -3507,7 +3507,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		return ret;
 
 	mutex_lock(&gpd_list_lock);
-	pd = genpd_get_from_provider(&pd_args);
+	pd = of_genpd_get_from_provider(&pd_args);
 	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
 		mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a382b88a023221cf..0f2a9bf48c3e388d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -466,6 +466,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
+struct generic_pm_domain *of_genpd_get_from_provider(const struct of_phandle_args *genpdspec);
 int of_genpd_add_device(const struct of_phandle_args *args, struct device *dev);
 int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 			   const struct of_phandle_args *subdomain_spec);
@@ -500,6 +501,12 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 
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

