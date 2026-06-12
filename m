Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728F3AB5AC;
	Fri, 12 Jun 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257912; cv=none; b=QH3hRxFo4nzWiTrvDIYmO62ImH0bepH+NDLIYKRH/S7tKtcaTnG14Irrq1KYve9kQphUj9x5Gw5r2y5jAAEqbtOd0yKiIM0WFzaXFeUZXZLsmg/DAIa6iwbdnY/J+bHXPOwnkst0rnA1bzyVdQEzVL5Z/xaKHiX5Cuq+6r3uQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257912; c=relaxed/simple;
	bh=7fTCUHMih1u47whNSbXGHQdUnbbg9iDC23xen06vPas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJOYa00SrBYDoLhVXot/rHnIKgyg/UdDpn5eOMVWTQMc53i/eRM2RqIO1nJ/zhKHeklqwc/piW4NomHW2DdAFpI5qTMxvwhA3oaq5B9Ul4W2H4vQgHugsn4V17nH7/WZEhw6QDt7CsEE5MJ6y0V6yFA3lmZ1cSgey7JzjPciusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gDPiFq9q; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oDCtrU0w; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gDPiFq9q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oDCtrU0w"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gcFCk3YkVz9v1L;
	Fri, 12 Jun 2026 11:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781257906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf7zdrO8nx9luF+ZUjyGUDc8D9p7LPr06wHVS5hvGZc=;
	b=gDPiFq9qrGwl6b3sF5ZyP0ojy+jnlIyl9wT+kPk1tTV8kAeUhfl6KFheJ8gf6prcTLJGeV
	v0YiWHL7ive7HkmhrDSoL+sMiPRfWK8ISoCdhqk4WATyx6NKqtmVxu3XQPdIydAbAtbP5V
	GqKCZqyj5tWIljtUZ+xTh0RdH+j+lf2rU5MYbFZRjVvupY1FmRAreCBQwbDvH91CeT4e6T
	ohsssOKQy0WCa/zUMOT7eWs9nVfo6H/9mXP2k1LmxXJcAVKqPuystCAFzv+NwCVG7xsOQ4
	/6hs/RIQrXb5TL4WgOoLl6JTJhnBvaFoAu08ZmHyDBKrETPVLXcxANNtmve5HA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oDCtrU0w;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781257905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf7zdrO8nx9luF+ZUjyGUDc8D9p7LPr06wHVS5hvGZc=;
	b=oDCtrU0wBd8mpv/KzQ9vbr7YLeFGObtphORsgLE8DrGC22DciIBaFGyzBZ7CtprMy6GiIp
	EDcckGqZBRyWHtYQAJ54pVhb+nwGDZqH3jkTE+234PNxI0r45f7TiIQryf0T6EwThJCUnJ
	FnGUUqbH5N/ira+td5PBtTOGfiKwBrLjcVkfr+QSMBdT0Zwwu3OGd1fKMgQ+b181SjZqmA
	02PXQKdMYHdiuGvQU5Zcv5XHLH+TMEEkZb9U27U2LtkCBn8ymq9pddP76qh20l5uEglJut
	G/UYddwmg4AS6PKEXOxqoAafbCm15wyRkFy0CKM6unjXY1mqXffU+Q0OzLC/RQ==
Date: Fri, 12 Jun 2026 17:51:01 +0800
Subject: [PATCH v3 1/2] cpufreq: spacemit: Add K1 cpufreq driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
In-Reply-To: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, Shuwei Wu <shuwei.wu@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781257883; l=10241;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=7fTCUHMih1u47whNSbXGHQdUnbbg9iDC23xen06vPas=;
 b=mtlmsI5jctAx4FbvxWXQtLMRo7mBCr6r5JvPHNy3Zimp3086kWaXyxUVr5MFm+ggmOTZDFbYi
 P4MakYc7yZOCMMBIPDk4Ro1NzwbtGlsNfdJcjS2zfB2qXxf8iToozNo
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: 88c836974a72c62c2e2
X-MBO-RS-META: b1bbb5spo1badixip3e6nhrisumg5ie5
X-Rspamd-Queue-Id: 4gcFCk3YkVz9v1L

K1 has two CPU cluster clocks but one shared CPU voltage rail. Use one
cpufreq policy for all CPUs, let the OPP core handle the shared regulator
and the cluster0 clock, and update the cluster1 clock explicitly.

Block spacemit,k1 from cpufreq-dt probing when OPP v2 nodes are present,
as K1 needs the dedicated driver for safe transitions.

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
---
Changes in v3:
- Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology
- Add spacemit,k1 to the cpufreq-dt blocklist
---
 drivers/cpufreq/Kconfig               |   4 +
 drivers/cpufreq/Kconfig.riscv         |  15 ++
 drivers/cpufreq/Makefile              |   3 +
 drivers/cpufreq/cpufreq-dt-platdev.c  |   2 +
 drivers/cpufreq/spacemit-k1-cpufreq.c | 251 ++++++++++++++++++++++++++++++++++
 5 files changed, 275 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 78702a08364f..19bbd1bd2f36 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -259,6 +259,10 @@ endif
 
 source "drivers/cpufreq/Kconfig.arm"
 
+if RISCV
+source "drivers/cpufreq/Kconfig.riscv"
+endif
+
 if PPC32 || PPC64
 source "drivers/cpufreq/Kconfig.powerpc"
 endif
diff --git a/drivers/cpufreq/Kconfig.riscv b/drivers/cpufreq/Kconfig.riscv
new file mode 100644
index 000000000000..3d5b59fbcd4c
--- /dev/null
+++ b/drivers/cpufreq/Kconfig.riscv
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RISC-V CPU Frequency scaling drivers
+#
+
+config RISCV_SPACEMIT_K1_CPUFREQ
+	tristate "SpacemiT K1 CPUFreq driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on OF && COMMON_CLK
+	select PM_OPP
+	help
+	  Enable CPU frequency scaling for SpacemiT K1 SoC.
+	  K1 has two CPU cluster clocks and one shared CPU voltage rail.
+	  The driver keeps all CPUs in one policy and updates both cluster
+	  clocks with the shared OPP transition.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 385c9fcc65c6..9680f420e824 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -89,6 +89,9 @@ obj-$(CONFIG_ARM_TEGRA194_CPUFREQ)	+= tegra194-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
+##################################################################################
+# RISC-V SoC drivers
+obj-$(CONFIG_RISCV_SPACEMIT_K1_CPUFREQ)	+= spacemit-k1-cpufreq.o
 
 ##################################################################################
 # PowerPC platform drivers
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 25fd3b191b7e..69bbe739a627 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -185,6 +185,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8550", },
 	{ .compatible = "qcom,sm8650", },
 
+	{ .compatible = "spacemit,k1", },
+
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
 	{ .compatible = "st,stih418", },
diff --git a/drivers/cpufreq/spacemit-k1-cpufreq.c b/drivers/cpufreq/spacemit-k1-cpufreq.c
new file mode 100644
index 000000000000..631897eb8022
--- /dev/null
+++ b/drivers/cpufreq/spacemit-k1-cpufreq.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU frequency scaling driver for SpacemiT K1 SoC.
+ *
+ * Copyright (c) 2026 Shuwei Wu <shuwei.wu@mailbox.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct k1_cpufreq_priv {
+	struct device *cpu_dev;
+	struct clk *cluster0_clk;
+	struct clk *cluster1_clk;
+	struct cpufreq_frequency_table *freq_table;
+	cpumask_var_t cpus;
+	int opp_token;
+};
+
+static struct platform_device *k1_cpufreq_pdev;
+
+static int k1_cpufreq_set_target(struct cpufreq_policy *policy,
+				 unsigned int index)
+{
+	struct k1_cpufreq_priv *priv = policy->driver_data;
+	unsigned long old_freq = policy->cur * 1000UL;
+	unsigned long new_freq = policy->freq_table[index].frequency * 1000UL;
+	int ret;
+
+	if (!old_freq)
+		old_freq = clk_get_rate(priv->cluster0_clk);
+
+	if (new_freq > old_freq) {
+		ret = dev_pm_opp_set_rate(priv->cpu_dev, new_freq);
+		if (ret)
+			return ret;
+
+		ret = clk_set_rate(priv->cluster1_clk, new_freq);
+		if (ret)
+			dev_pm_opp_set_rate(priv->cpu_dev, old_freq);
+
+		return ret;
+	}
+
+	ret = clk_set_rate(priv->cluster1_clk, new_freq);
+	if (ret)
+		return ret;
+
+	ret = dev_pm_opp_set_rate(priv->cpu_dev, new_freq);
+	if (ret)
+		clk_set_rate(priv->cluster1_clk, old_freq);
+
+	return ret;
+}
+
+static int k1_cpufreq_init_policy(struct cpufreq_policy *policy)
+{
+	struct k1_cpufreq_priv *priv = cpufreq_get_driver_data();
+	unsigned int transition_latency;
+
+	cpumask_copy(policy->cpus, priv->cpus);
+	policy->clk = priv->cluster0_clk;
+	policy->freq_table = priv->freq_table;
+	policy->driver_data = priv;
+	policy->dvfs_possible_from_any_cpu = true;
+
+	transition_latency = dev_pm_opp_get_max_transition_latency(priv->cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
+	policy->cpuinfo.transition_latency = transition_latency;
+
+	return 0;
+}
+
+static struct cpufreq_driver k1_cpufreq_driver = {
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = k1_cpufreq_set_target,
+	.get = cpufreq_generic_get,
+	.init = k1_cpufreq_init_policy,
+	.register_em = cpufreq_register_em_with_opp,
+	.name = "k1-cpufreq",
+};
+
+static int k1_cpufreq_probe(struct platform_device *pdev)
+{
+	struct k1_cpufreq_priv *priv;
+	struct device *cpu4_dev;
+	static const char * const reg_names[] = { "cpu", NULL };
+	int cpu, ret;
+
+	priv = kzalloc_obj(*priv);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto free_data;
+	}
+
+	priv->cpu_dev = get_cpu_device(0);
+	cpu4_dev = get_cpu_device(4);
+	if (!priv->cpu_dev || !cpu4_dev) {
+		ret = -EPROBE_DEFER;
+		goto free_cpumask;
+	}
+
+	for_each_present_cpu(cpu)
+		cpumask_set_cpu(cpu, priv->cpus);
+
+	priv->cluster0_clk = clk_get(priv->cpu_dev, NULL);
+	if (IS_ERR(priv->cluster0_clk)) {
+		ret = PTR_ERR(priv->cluster0_clk);
+		dev_err_probe(priv->cpu_dev, ret, "failed to get cluster0 clock\n");
+		goto free_cpumask;
+	}
+
+	priv->cluster1_clk = clk_get(cpu4_dev, NULL);
+	if (IS_ERR(priv->cluster1_clk)) {
+		ret = PTR_ERR(priv->cluster1_clk);
+		dev_err_probe(cpu4_dev, ret, "failed to get cluster1 clock\n");
+		goto put_clk_c0;
+	}
+
+	priv->opp_token = dev_pm_opp_set_regulators(priv->cpu_dev, reg_names);
+	if (priv->opp_token < 0) {
+		ret = priv->opp_token;
+		dev_err_probe(priv->cpu_dev, ret, "failed to set regulators\n");
+		goto put_clk_c1;
+	}
+
+	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
+	if (ret) {
+		dev_err_probe(priv->cpu_dev, ret, "failed to add OPP table\n");
+		goto put_opp_regulators;
+	}
+
+	ret = dev_pm_opp_get_opp_count(priv->cpu_dev);
+	if (ret <= 0) {
+		dev_err(priv->cpu_dev, "OPP table can't be empty\n");
+		ret = -ENODEV;
+		goto remove_opp_table;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+	if (ret) {
+		dev_err(priv->cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto remove_opp_table;
+	}
+
+	k1_cpufreq_driver.driver_data = priv;
+	ret = cpufreq_register_driver(&k1_cpufreq_driver);
+	if (ret)
+		goto free_freq_table;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+free_freq_table:
+	k1_cpufreq_driver.driver_data = NULL;
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+remove_opp_table:
+	dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+put_opp_regulators:
+	dev_pm_opp_put_regulators(priv->opp_token);
+put_clk_c1:
+	clk_put(priv->cluster1_clk);
+put_clk_c0:
+	clk_put(priv->cluster0_clk);
+free_cpumask:
+	free_cpumask_var(priv->cpus);
+free_data:
+	kfree(priv);
+
+	return ret;
+}
+
+static void k1_cpufreq_remove(struct platform_device *pdev)
+{
+	struct k1_cpufreq_priv *priv = platform_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	cpufreq_unregister_driver(&k1_cpufreq_driver);
+	k1_cpufreq_driver.driver_data = NULL;
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+	dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+	dev_pm_opp_put_regulators(priv->opp_token);
+	clk_put(priv->cluster1_clk);
+	clk_put(priv->cluster0_clk);
+	free_cpumask_var(priv->cpus);
+	kfree(priv);
+}
+
+static struct platform_driver k1_cpufreq_platdrv = {
+	.probe = k1_cpufreq_probe,
+	.remove = k1_cpufreq_remove,
+	.driver = {
+		.name = "spacemit-k1-cpufreq",
+	},
+};
+
+static const struct of_device_id k1_cpufreq_match_list[] __initconst = {
+	{ .compatible = "spacemit,k1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, k1_cpufreq_match_list);
+
+/*
+ * K1 has no dedicated cpufreq controller device. Register a logical platform
+ * device so clock/regulator dependencies can defer probe.
+ */
+static int __init k1_cpufreq_init(void)
+{
+	int ret;
+
+	if (!of_machine_device_match(k1_cpufreq_match_list))
+		return -ENODEV;
+
+	ret = platform_driver_register(&k1_cpufreq_platdrv);
+	if (ret)
+		return ret;
+
+	k1_cpufreq_pdev = platform_device_register_simple("spacemit-k1-cpufreq", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(k1_cpufreq_pdev);
+	if (ret)
+		platform_driver_unregister(&k1_cpufreq_platdrv);
+
+	return ret;
+}
+module_init(k1_cpufreq_init);
+
+static void __exit k1_cpufreq_exit(void)
+{
+	platform_device_unregister(k1_cpufreq_pdev);
+	platform_driver_unregister(&k1_cpufreq_platdrv);
+}
+module_exit(k1_cpufreq_exit);
+
+MODULE_DESCRIPTION("SpacemiT K1 CPUFreq driver");
+MODULE_AUTHOR("Shuwei Wu <shuwei.wu@mailbox.org>");
+MODULE_LICENSE("GPL");

-- 
2.53.0

