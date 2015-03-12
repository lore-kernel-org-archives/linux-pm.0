From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 02/17] memory: tegra: add mc flush support
Date: Thu, 12 Mar 2015 20:15:03 +0800
Message-ID: <1426162518-7405-3-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The flush operation of memory clients is needed for various IP blocks in
the Tegra SoCs to perform a clean reset. Also add a mutex in struct tegra_mc
for mc flush operations.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>

---
v2: make indentition and name changes according to Alex's comments
    add mutex lock in struct tegra_mc for mc flush operations


 drivers/memory/tegra/mc.c       | 122 ++++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra114.c |   2 +-
 drivers/memory/tegra/tegra124.c |   2 +-
 drivers/memory/tegra/tegra30.c  |   2 +-
 include/soc/tegra/mc.h          |  46 ++++++++++++++-
 5 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index fe3c44e7e1d1..c78692919e21 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -62,6 +63,118 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static struct tegra_mc_swgroup *tegra_mc_get_swgroup(struct tegra_mc *mc,
+					unsigned int swgroup)
+{
+	struct tegra_mc_swgroup *sg;
+
+	list_for_each_entry(sg, &mc->swgroups, head) {
+		if (sg->id == swgroup)
+			return sg;
+	}
+
+	return NULL;
+}
+
+static struct tegra_mc_swgroup *tegra_mc_add_swgroup(struct tegra_mc *mc,
+					unsigned int swgroup)
+{
+	struct tegra_mc_swgroup *sg;
+
+	sg = devm_kzalloc(mc->dev, sizeof(*sg), GFP_KERNEL);
+	if (!sg)
+		return ERR_PTR(-ENOMEM);
+
+	sg->id = swgroup;
+	sg->mc = mc;
+	list_add_tail(&sg->head, &mc->swgroups);
+	INIT_LIST_HEAD(&sg->clients);
+
+	return sg;
+}
+
+struct tegra_mc_swgroup *tegra_mc_find_swgroup(struct device_node *node,
+					int index)
+{
+	struct of_phandle_args args;
+	struct platform_device *pdev;
+	struct tegra_mc *mc;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node, "nvidia,swgroup",
+				1, index, &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pdev = of_find_device_by_node(args.np);
+	if (!pdev)
+		return NULL;
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return NULL;
+
+	return tegra_mc_get_swgroup(mc, args.args[0]);
+}
+EXPORT_SYMBOL(tegra_mc_find_swgroup);
+
+static int __tegra_mc_flush_op(struct tegra_mc_swgroup *sg, tegra_mc_op op)
+{
+	struct tegra_mc *mc;
+	const struct tegra_mc_hotreset *client;
+	int i;
+
+	mc = sg->mc;
+	client = mc->soc->hotresets;
+
+	for (i = 0; i < mc->soc->num_hotresets; i++, client++) {
+		if (sg->id == client->swgroup)
+			return op(mc, client);
+	}
+
+	return -EINVAL;
+
+}
+
+#define tegra_mc_flush_op(sg, op)			\
+	((!sg || !sg->mc || !sg->mc->soc->ops ||	\
+		!sg->mc->soc->ops->op) ?		\
+		-EINVAL : __tegra_mc_flush_op(sg, sg->mc->soc->ops->op))
+
+int tegra_mc_flush(struct tegra_mc_swgroup *sg)
+{
+	return tegra_mc_flush_op(sg, flush);
+}
+EXPORT_SYMBOL(tegra_mc_flush);
+
+int tegra_mc_flush_done(struct tegra_mc_swgroup *sg)
+{
+	return tegra_mc_flush_op(sg, flush_done);
+}
+EXPORT_SYMBOL(tegra_mc_flush_done);
+
+static int tegra_mc_build_swgroup(struct tegra_mc *mc)
+{
+	int i;
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		struct tegra_mc_swgroup *sg;
+
+		sg = tegra_mc_get_swgroup(mc, mc->soc->clients[i].swgroup);
+
+		if (!sg) {
+			sg = tegra_mc_add_swgroup(mc,
+					mc->soc->clients[i].swgroup);
+			if (IS_ERR(sg))
+				return PTR_ERR(sg);
+		}
+
+		list_add_tail(&mc->soc->clients[i].head, &sg->clients);
+	}
+
+	return 0;
+}
+
 static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 {
 	unsigned long long tick;
@@ -229,6 +342,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	/* length of MC tick in nanoseconds */
 	mc->tick = 30;
 
+	INIT_LIST_HEAD(&mc->swgroups);
+	err = tegra_mc_build_swgroup(mc);
+	if (err) {
+		dev_err(&pdev->dev, "failed to build swgroup: %d\n", err);
+		return err;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mc->regs))
@@ -271,6 +391,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	mutex_init(&mc->lock);
+
 	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
 		MC_INT_ARBITRATION_EMEM | MC_INT_SECURITY_VIOLATION |
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 511e9a25c151..92ab5552fcee 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -15,7 +15,7 @@
 
 #include "mc.h"
 
-static const struct tegra_mc_client tegra114_mc_clients[] = {
+static struct tegra_mc_client tegra114_mc_clients[] = {
 	{
 		.id = 0x00,
 		.name = "ptcr",
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 278d40b854c1..ec25546835fe 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -15,7 +15,7 @@
 
 #include "mc.h"
 
-static const struct tegra_mc_client tegra124_mc_clients[] = {
+static struct tegra_mc_client tegra124_mc_clients[] = {
 	{
 		.id = 0x00,
 		.name = "ptcr",
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 71fe9376fe53..3ed4bf409a72 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -15,7 +15,7 @@
 
 #include "mc.h"
 
-static const struct tegra_mc_client tegra30_mc_clients[] = {
+static struct tegra_mc_client tegra30_mc_clients[] = {
 	{
 		.id = 0x00,
 		.name = "ptcr",
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 63deb8d9f82a..1edcc0ffeae5 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -37,6 +37,32 @@ struct tegra_mc_client {
 
 	struct tegra_smmu_enable smmu;
 	struct tegra_mc_la la;
+
+	struct list_head head;
+};
+
+struct tegra_mc;
+
+/* hot reset */
+struct tegra_mc_hotreset {
+	unsigned int swgroup;
+	unsigned int ctrl;
+	unsigned int status;
+	unsigned int bit;
+};
+
+struct tegra_mc_swgroup {
+	unsigned int id;
+	struct tegra_mc *mc;
+	struct list_head head;
+	struct list_head clients;
+};
+
+struct tegra_mc_ops {
+	int (*flush)(struct tegra_mc *mc,
+			const struct tegra_mc_hotreset *hotreset);
+	int (*flush_done)(struct tegra_mc *mc,
+			const struct tegra_mc_hotreset *hotreset);
 };
 
 struct tegra_smmu_swgroup {
@@ -64,7 +90,6 @@ struct tegra_smmu_soc {
 	const struct tegra_smmu_ops *ops;
 };
 
-struct tegra_mc;
 struct tegra_smmu;
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
@@ -81,9 +106,14 @@ tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
 #endif
 
 struct tegra_mc_soc {
-	const struct tegra_mc_client *clients;
+	struct tegra_mc_client *clients;
 	unsigned int num_clients;
 
+	const struct tegra_mc_hotreset *hotresets;
+	unsigned int num_hotresets;
+
+	const struct tegra_mc_ops *ops;
+
 	const unsigned int *emem_regs;
 	unsigned int num_emem_regs;
 
@@ -102,6 +132,18 @@ struct tegra_mc {
 
 	const struct tegra_mc_soc *soc;
 	unsigned long tick;
+
+	struct list_head swgroups;
+
+	struct mutex lock;
 };
 
+typedef int (*tegra_mc_op)(struct tegra_mc *mc,
+				 const struct tegra_mc_hotreset *hotreset);
+
+struct tegra_mc_swgroup *tegra_mc_find_swgroup(struct device_node *node,
+					int index);
+int tegra_mc_flush(struct tegra_mc_swgroup *sg);
+int tegra_mc_flush_done(struct tegra_mc_swgroup *sg);
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.1.4
