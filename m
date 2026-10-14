Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FA18BC3D;
	Wed, 14 Oct 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980537; cv=none; b=p7bCK8oUS3pESnnl6K/j2SC+W+ItMeCI8CrHugc0hIbkdg36PG1MI6vTqnUY0CVQSxiHnycoa+u1Fe5NeEdELYNHfgRDBtDOwpakr/bkUTADiEiMb7AcHHrsAiOTC3myoMqqP5nmPRmkI4ubrtLshhbs93IICTbt4tuToPZvqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980537; c=relaxed/simple;
	bh=CQcie8dwYVkPPdzbAYfcv66GgctYS4+aSgCBVGGf19E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lq9Gda598vEU3qIejZNqbO9gO69iV5LnDElYUmxfIOaXCSdjVQskl3NObz/LBGaqOJGQ6V6wv5LXUz77biXNIceBryLI9Wpc11VNac8p/5wrcsYjVHLzyX+CeqaYGf2fowvvi8zQbXe1M+ukP6gMDNt6ueglHtcJYEpb8e6/2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNMxkNsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNMxkNsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250B21F000FF;
	Wed, 14 Oct 2026 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980535;
	bh=ZUwBWXPt3ZRTAx2sMTJDuIYRRHxy9SD240WFMZ9p+2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bNMxkNsECU6l2DAqk0Jgv6alLDocQBhCq8QLBXZoJyBLcwmxR+eEeBR4SuhXk8srk
	 vIFFuO9w7DTbDvTh+zful4+YZrlUI2x5l8BOVlXxqwCzenS1Oq2cMCTwQDBBFHOzYq
	 1AO/2fIE8mER9uSp8Ka07Tzgek/1fKjUCT8RyzWojcEvKSsvOiaSjrQJSDiQ9PIhij
	 Ql5pdLLGchU6imdc0HVyVHgYm3iUi+drbMsnCfIsgOeDUoXR8PemNI2VuV8omj08WF
	 Hcm7UlddkjxT8bcYGJXLx3NlbOuw04nTmtZEOm00qGTR9hxxoGakG9M/fww3LPJ3q2
	 jee2uzVe7KLPA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:12 +0200
Subject: [PATCH RFC 12/16] clk: qcom: gdsc: Link required power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-12-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=8901;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=YPVRoRqGRf/TfZ6WCWJvddd/Cp26b+PDUFOAQKfQ3RU=;
 b=lWXN0hGMiCyf38QDb5xHVoqZek5uzjUzr3W8+aeukc8ndzAHk76AmR4541OVjkIqFhtCcEcRI
 9XZcal7ID3EDiuPw5Qmu2ep69RkxvMNtWzPnChzPRYkrJLOa9jrHGye
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A GDSC may require one or more controller power-domain endpoints to be
available while it is powered, not necessarily all the domains that are
consumed by the clock controller it's a part of.

Model those enable-only requirements as GenPD subdomain links, without
propagating the GDSC performance state to the rail.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/common.c |   4 +-
 drivers/clk/qcom/gdsc.c   | 141 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/clk/qcom/gdsc.h   |   6 ++
 3 files changed, 141 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 01c00c2568b2..48da90eac096 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -332,7 +332,7 @@ int qcom_cc_really_probe(struct device *dev,
 	struct clk_regmap **rclks = desc->clks;
 	size_t num_clk_hws = desc->num_clk_hws;
 	struct clk_hw **clk_hws = desc->clk_hws;
-	struct dev_pm_domain_list *pd_list;
+	struct dev_pm_domain_list *pd_list = NULL;
 	const struct dev_pm_domain_attach_data pd_data = {
 		.pd_indices = desc->pd_indices,
 		.num_pd_indices = desc->num_pd_indices,
@@ -397,6 +397,8 @@ int qcom_cc_really_probe(struct device *dev,
 		scd->dev = dev;
 		scd->scs = desc->gdscs;
 		scd->num = desc->num_gdscs;
+		scd->pd_list = pd_list;
+		scd->no_external_parent = !!desc->num_dvfs_rail_voters;
 		ret = gdsc_register(scd, &reset->rcdev, regmap);
 		if (ret)
 			goto put_rpm;
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 2d0803e1eb3b..73054c600c29 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -12,10 +12,12 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include "clk-dvfs.h"
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
@@ -162,6 +164,8 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
 	}
 
 	ret = gdsc_update_collapse_bit(sc, status == GDSC_OFF);
+	if (ret)
+		return ret;
 
 	/* If disabling votable gdscs, don't poll on status */
 	if ((sc->flags & VOTABLE) && status == GDSC_OFF && !wait) {
@@ -343,6 +347,7 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 static int gdsc_disable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
+	bool wait_for_off = domain->synced_poweroff;
 	int ret;
 
 	if (sc->pwrsts == PWRSTS_ON)
@@ -379,7 +384,10 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->pwrsts == PWRSTS_RET_ON)
 		return 0;
 
-	ret = gdsc_toggle_logic(sc, GDSC_OFF, domain->synced_poweroff);
+	if (sc->num_required_pds && !(sc->flags & VOTABLE))
+		wait_for_off = true;
+
+	ret = gdsc_toggle_logic(sc, GDSC_OFF, wait_for_off);
 	if (ret)
 		return ret;
 
@@ -535,6 +543,93 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static void gdsc_put_rail_voters(struct gdsc_desc *desc, struct gdsc *sc, size_t num)
+{
+	size_t i;
+
+	for (i = num; i-- > 0;) {
+		struct device *voter;
+
+		voter = qcom_clk_dvfs_get_rail_voter(desc->dev, sc->required_pds[i]);
+		if (!IS_ERR(voter))
+			pm_runtime_put_sync(voter);
+	}
+}
+
+static int gdsc_get_rail_voters(struct gdsc_desc *desc, struct gdsc *sc)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < sc->num_required_pds; i++) {
+		struct device *voter;
+
+		voter = qcom_clk_dvfs_get_rail_voter(desc->dev, sc->required_pds[i]);
+		if (IS_ERR(voter)) {
+			ret = PTR_ERR(voter);
+			goto unwind;
+		}
+
+		ret = pm_runtime_resume_and_get(voter);
+		if (ret)
+			goto unwind;
+	}
+
+	return 0;
+
+unwind:
+	gdsc_put_rail_voters(desc, sc, i);
+
+	return ret;
+}
+
+static void gdsc_remove_required_subdomains(struct gdsc_desc *desc, struct gdsc *sc, size_t num)
+{
+	size_t i;
+
+	for (i = num; i-- > 0;) {
+		struct device *voter;
+
+		voter = qcom_clk_dvfs_get_rail_voter(desc->dev, sc->required_pds[i]);
+		if (IS_ERR(voter) || !voter->pm_domain)
+			continue;
+
+		pm_genpd_remove_subdomain(pd_to_genpd(voter->pm_domain), &sc->pd);
+	}
+}
+
+static int gdsc_add_required_subdomains(struct gdsc_desc *desc, struct gdsc *sc)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < sc->num_required_pds; i++) {
+		struct device *voter;
+
+		voter = qcom_clk_dvfs_get_rail_voter(desc->dev, sc->required_pds[i]);
+		if (IS_ERR(voter)) {
+			ret = PTR_ERR(voter);
+			goto unwind;
+		}
+		if (!voter->pm_domain) {
+			ret = -ENODEV;
+			goto unwind;
+		}
+
+		ret = pm_genpd_add_subdomain_with_flags(pd_to_genpd(voter->pm_domain), &sc->pd,
+							GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION);
+		if (ret)
+			goto unwind;
+	}
+
+	return 0;
+
+unwind:
+	gdsc_remove_required_subdomains(desc, sc, i);
+
+	return ret;
+}
+
 static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
 				   struct generic_pm_domain *subdomain)
 {
@@ -598,11 +693,14 @@ static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
+	unsigned int parent_flags = desc->no_external_parent ?
+		GENPD_SUBDOMAIN_NO_PERF_STATE_PROPAGATION : 0;
 	int i, ret;
 	struct genpd_onecell_data *data;
 	struct device *dev = desc->dev;
 	struct gdsc **scs = desc->scs;
 	size_t num = desc->num;
+	size_t initialized = 0, linked = 0;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -647,13 +745,24 @@ int gdsc_register(struct gdsc_desc *desc,
 			continue;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
-		ret = gdsc_init(scs[i]);
+		ret = gdsc_get_rail_voters(desc, scs[i]);
 		if (ret)
-			return ret;
-		data->domains[i] = &scs[i]->pd;
+			goto err_remove_domains;
+
+		ret = gdsc_init(scs[i]);
+		if (!ret) {
+			data->domains[i] = &scs[i]->pd;
+			initialized = i + 1;
+			ret = gdsc_add_required_subdomains(desc, scs[i]);
+		}
+		/* A GDSC that is on keeps its rails through the links. */
+		gdsc_put_rail_voters(desc, scs[i], scs[i]->num_required_pds);
+		if (ret)
+			goto err_remove_domains;
+		linked = i + 1;
 	}
 
-	/* Add subdomains */
+	/* Add explicit collapse parents and legacy inferred parents. */
 	for (i = 0; i < num; i++) {
 		ret = 0;
 
@@ -661,7 +770,8 @@ int gdsc_register(struct gdsc_desc *desc,
 			continue;
 
 		if (scs[i]->parent)
-			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain_with_flags(scs[i]->parent,
+								&scs[i]->pd, parent_flags);
 		else if (!desc->no_external_parent &&
 			 !IS_ERR_OR_NULL(dev->pm_domain))
 			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
@@ -669,13 +779,25 @@ int gdsc_register(struct gdsc_desc *desc,
 			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
 
 		if (ret)
-			goto err_pm_subdomain_remove;
+			goto err_remove_parents;
 	}
 
-	return of_genpd_add_provider_onecell(dev->of_node, data);
+	ret = of_genpd_add_provider_onecell(dev->of_node, data);
+	if (!ret)
+		return 0;
 
-err_pm_subdomain_remove:
+err_remove_parents:
 	gdsc_pm_subdomain_remove(desc, i);
+err_remove_domains:
+	while (linked--) {
+		if (scs[linked])
+			gdsc_remove_required_subdomains(desc, scs[linked],
+							scs[linked]->num_required_pds);
+	}
+	while (initialized--) {
+		if (scs[initialized])
+			pm_genpd_remove(&scs[initialized]->pd);
+	}
 
 	return ret;
 }
@@ -693,6 +815,7 @@ void gdsc_unregister(struct gdsc_desc *desc)
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
 			continue;
+		gdsc_remove_required_subdomains(desc, scs[i], scs[i]->num_required_pds);
 		pm_genpd_remove(&scs[i]->pd);
 	}
 }
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 8275e266cfcc..b11438551225 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -10,6 +10,7 @@
 #include <linux/pm_domain.h>
 
 struct icc_path;
+struct device;
 struct regmap;
 struct regulator;
 struct reset_controller_dev;
@@ -31,6 +32,9 @@ struct reset_controller_dev;
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
+ * @required_pds: ordered controller power-domain indices required
+ *                while this GDSC is logically on
+ * @num_required_pds: number of entries in @required_pds
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -79,6 +83,8 @@ struct gdsc {
 	bool				needs_icc;
 	unsigned int			icc_path_index;
 	struct icc_path			*icc_path;
+	const unsigned int		*required_pds;
+	size_t				num_required_pds;
 };
 
 struct gdsc_desc {

-- 
2.56.0

