From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/3] soc/tegra: bpmp: Implement generic PM domains
Date: Tue, 14 Mar 2017 20:15:16 +0100
Message-ID: <20170314191516.13083-4-thierry.reding@gmail.com>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35453 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdCNTPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 15:15:35 -0400
In-Reply-To: <20170314191516.13083-1-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The BPMP firmware, found on Tegra186 and later, provides an ABI that can
be used to enable and disable power to several power partitions in Tegra
SoCs. The ABI allows for enumeration of the available power partitions,
so the driver can be reused on future generations, provided the BPMP ABI
remains stable.

Based on work by Stefan Kristiansson <stefank@nvidia.com> and Mikko
Perttunen <mperttunen@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c      |   4 +
 drivers/soc/tegra/Kconfig          |   5 +
 drivers/soc/tegra/Makefile         |   1 +
 drivers/soc/tegra/powergate-bpmp.c | 358 +++++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h           |  12 ++
 5 files changed, 380 insertions(+)
 create mode 100644 drivers/soc/tegra/powergate-bpmp.c

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 84e4c9a58a0c..f11c7025b4a1 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -810,6 +810,10 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto free_mrq;
 
+	err = tegra_bpmp_init_powergates(bpmp);
+	if (err < 0)
+		goto free_mrq;
+
 	platform_set_drvdata(pdev, bpmp);
 
 	return 0;
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 208d6edb3fdb..e052664439a1 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -106,3 +106,8 @@ config SOC_TEGRA_PMC
 
 config SOC_TEGRA_PMC_TEGRA186
 	bool
+
+config SOC_TEGRA_POWERGATE_BPMP
+	def_bool y
+	depends on PM_GENERIC_DOMAINS
+	depends on TEGRA_BPMP
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index b4425e4319ff..17f2e25e7954 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -3,3 +3,4 @@ obj-y += fuse/
 obj-y += common.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_PMC_TEGRA186) += pmc-tegra186.o
+obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/soc/tegra/powergate-bpmp.c
new file mode 100644
index 000000000000..d75144baa3ef
--- /dev/null
+++ b/drivers/soc/tegra/powergate-bpmp.c
@@ -0,0 +1,358 @@
+/*
+ * Copyright (c) 2016-2017, NVIDIA CORPORATION. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+
+struct tegra_powergate_info {
+	unsigned int id;
+	char *name;
+};
+
+struct tegra_powergate {
+	struct generic_pm_domain genpd;
+	struct tegra_bpmp *bpmp;
+	unsigned int id;
+};
+
+static inline struct tegra_powergate *
+to_tegra_powergate(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct tegra_powergate, genpd);
+}
+
+static int tegra_bpmp_powergate_set_state(struct tegra_bpmp *bpmp,
+					  unsigned int id, u32 state)
+{
+	struct mrq_pg_request request;
+	struct tegra_bpmp_message msg;
+
+	memset(&request, 0, sizeof(request));
+	request.cmd = CMD_PG_SET_STATE;
+	request.id = id;
+	request.set_state.state = state;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PG;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+
+	return tegra_bpmp_transfer(bpmp, &msg);
+}
+
+static int tegra_bpmp_powergate_get_state(struct tegra_bpmp *bpmp,
+					  unsigned int id)
+{
+	struct mrq_pg_response response;
+	struct mrq_pg_request request;
+	struct tegra_bpmp_message msg;
+	int err;
+
+	memset(&request, 0, sizeof(request));
+	request.cmd = CMD_PG_GET_STATE;
+	request.id = id;
+
+	memset(&response, 0, sizeof(response));
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PG;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+	msg.rx.data = &response;
+	msg.rx.size = sizeof(response);
+
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err < 0)
+		return PG_STATE_OFF;
+
+	return response.get_state.state;
+}
+
+static int tegra_bpmp_powergate_get_max_id(struct tegra_bpmp *bpmp)
+{
+	struct mrq_pg_response response;
+	struct mrq_pg_request request;
+	struct tegra_bpmp_message msg;
+	int err;
+
+	memset(&request, 0, sizeof(request));
+	request.cmd = CMD_PG_GET_MAX_ID;
+
+	memset(&response, 0, sizeof(response));
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PG;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+	msg.rx.data = &response;
+	msg.rx.size = sizeof(response);
+
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err < 0)
+		return err;
+
+	return response.get_max_id.max_id;
+}
+
+static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
+					   unsigned int id)
+{
+	struct mrq_pg_response response;
+	struct mrq_pg_request request;
+	struct tegra_bpmp_message msg;
+	int err;
+
+	memset(&request, 0, sizeof(request));
+	request.cmd = CMD_PG_GET_NAME;
+	request.id = id;
+
+	memset(&response, 0, sizeof(response));
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PG;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+	msg.rx.data = &response;
+	msg.rx.size = sizeof(response);
+
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err < 0)
+		return NULL;
+
+	return kstrdup(response.get_name.name, GFP_KERNEL);
+}
+
+static inline bool tegra_bpmp_powergate_is_powered(struct tegra_bpmp *bpmp,
+						   unsigned int id)
+{
+	return tegra_bpmp_powergate_get_state(bpmp, id) == PG_STATE_ON;
+}
+
+static int tegra_powergate_power_on(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *powergate = to_tegra_powergate(domain);
+	struct tegra_bpmp *bpmp = powergate->bpmp;
+
+	return tegra_bpmp_powergate_set_state(bpmp, powergate->id,
+					      PG_STATE_ON);
+}
+
+static int tegra_powergate_power_off(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *powergate = to_tegra_powergate(domain);
+	struct tegra_bpmp *bpmp = powergate->bpmp;
+
+	return tegra_bpmp_powergate_set_state(bpmp, powergate->id,
+					      PG_STATE_OFF);
+}
+
+static struct tegra_powergate *
+tegra_powergate_add(struct tegra_bpmp *bpmp,
+		    const struct tegra_powergate_info *info)
+{
+	struct tegra_powergate *powergate;
+	bool off;
+
+	off = !tegra_bpmp_powergate_is_powered(bpmp, info->id);
+
+	powergate = devm_kzalloc(bpmp->dev, sizeof(*powergate), GFP_KERNEL);
+	if (!powergate)
+		return ERR_PTR(-ENOMEM);
+
+	powergate->id = info->id;
+	powergate->bpmp = bpmp;
+
+	powergate->genpd.name = kstrdup(info->name, GFP_KERNEL);
+	powergate->genpd.power_on = tegra_powergate_power_on;
+	powergate->genpd.power_off = tegra_powergate_power_off;
+
+	pm_genpd_init(&powergate->genpd, NULL, off);
+
+	return powergate;
+}
+
+static void tegra_powergate_remove(struct tegra_powergate *powergate)
+{
+	struct generic_pm_domain *genpd = &powergate->genpd;
+	struct tegra_bpmp *bpmp = powergate->bpmp;
+	int err;
+
+	err = pm_genpd_remove(genpd);
+	if (err < 0)
+		dev_err(bpmp->dev, "failed to remove power domain %s: %d\n",
+			genpd->name, err);
+
+	kfree(genpd->name);
+}
+
+static int
+tegra_bpmp_probe_powergates(struct tegra_bpmp *bpmp,
+			    struct tegra_powergate_info **powergatesp)
+{
+	struct tegra_powergate_info *powergates;
+	unsigned int max_id, id, count = 0;
+	unsigned int num_holes = 0;
+	int err;
+
+	err = tegra_bpmp_powergate_get_max_id(bpmp);
+	if (err < 0)
+		return err;
+
+	max_id = err;
+
+	dev_dbg(bpmp->dev, "maximum powergate ID: %u\n", max_id);
+
+	powergates = kcalloc(max_id + 1, sizeof(*powergates), GFP_KERNEL);
+	if (!powergates)
+		return -ENOMEM;
+
+	for (id = 0; id <= max_id; id++) {
+		struct tegra_powergate_info *info = &powergates[count];
+
+		info->name = tegra_bpmp_powergate_get_name(bpmp, id);
+		if (!info->name || info->name[0] == '\0') {
+			num_holes++;
+			continue;
+		}
+
+		info->id = id;
+		count++;
+	}
+
+	dev_dbg(bpmp->dev, "holes: %u\n", num_holes);
+
+	*powergatesp = powergates;
+
+	return count;
+}
+
+static int tegra_bpmp_add_powergates(struct tegra_bpmp *bpmp,
+				     struct tegra_powergate_info *powergates,
+				     unsigned int count)
+{
+	struct genpd_onecell_data *genpd = &bpmp->genpd;
+	struct generic_pm_domain **domains;
+	struct tegra_powergate *powergate;
+	unsigned int i;
+	int err;
+
+	domains = kcalloc(count, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		powergate = tegra_powergate_add(bpmp, &powergates[i]);
+		if (IS_ERR(powergate)) {
+			err = PTR_ERR(powergate);
+			goto remove;
+		}
+
+		dev_dbg(bpmp->dev, "added power domain %s\n",
+			powergate->genpd.name);
+		domains[i] = &powergate->genpd;
+	}
+
+	genpd->num_domains = count;
+	genpd->domains = domains;
+
+	return 0;
+
+remove:
+	while (i--) {
+		powergate = to_tegra_powergate(domains[i]);
+		tegra_powergate_remove(powergate);
+	}
+
+	kfree(genpd->domains);
+	return err;
+}
+
+static void tegra_bpmp_remove_powergates(struct tegra_bpmp *bpmp)
+{
+	struct genpd_onecell_data *genpd = &bpmp->genpd;
+	unsigned int i = genpd->num_domains;
+	struct tegra_powergate *powergate;
+
+	while (i--) {
+		dev_dbg(bpmp->dev, "removing power domain %s\n",
+			genpd->domains[i]->name);
+		powergate = to_tegra_powergate(genpd->domains[i]);
+		tegra_powergate_remove(powergate);
+	}
+}
+
+static struct generic_pm_domain *
+tegra_powergate_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
+	struct genpd_onecell_data *genpd = data;
+	unsigned int i;
+
+	for (i = 0; i < genpd->num_domains; i++) {
+		struct tegra_powergate *powergate;
+
+		powergate = to_tegra_powergate(genpd->domains[i]);
+		if (powergate->id == spec->args[0]) {
+			domain = &powergate->genpd;
+			break;
+		}
+	}
+
+	return domain;
+}
+
+int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp)
+{
+	struct device_node *np = bpmp->dev->of_node;
+	struct tegra_powergate_info *powergates;
+	struct device *dev = bpmp->dev;
+	unsigned int count, i;
+	int err;
+
+	err = tegra_bpmp_probe_powergates(bpmp, &powergates);
+	if (err < 0)
+		return err;
+
+	count = err;
+
+	dev_dbg(dev, "%u power domains probed\n", count);
+
+	err = tegra_bpmp_add_powergates(bpmp, powergates, count);
+	if (err < 0)
+		goto free;
+
+	bpmp->genpd.xlate = tegra_powergate_xlate;
+
+	err = of_genpd_add_provider_onecell(np, &bpmp->genpd);
+	if (err < 0) {
+		dev_err(dev, "failed to add power domain provider: %d\n", err);
+		goto remove;
+	}
+
+free:
+	for (i = 0; i < count; i++)
+		kfree(powergates[i].name);
+
+	kfree(powergates);
+	return err;
+
+remove:
+	tegra_bpmp_remove_powergates(bpmp);
+	goto free;
+}
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 13dcd44e91bb..9ba65222bd3f 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -15,6 +15,7 @@
 #define __SOC_TEGRA_BPMP_H
 
 #include <linux/mailbox_client.h>
+#include <linux/pm_domain.h>
 #include <linux/reset-controller.h>
 #include <linux/semaphore.h>
 #include <linux/types.h>
@@ -91,6 +92,8 @@ struct tegra_bpmp {
 	unsigned int num_clocks;
 
 	struct reset_controller_dev rstc;
+
+	struct genpd_onecell_data genpd;
 };
 
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
@@ -138,4 +141,13 @@ static inline int tegra_bpmp_init_resets(struct tegra_bpmp *bpmp)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_SOC_TEGRA_POWERGATE_BPMP)
+int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp);
+#else
+static inline int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp)
+{
+	return 0;
+}
+#endif
+
 #endif /* __SOC_TEGRA_BPMP_H */
-- 
2.12.0
