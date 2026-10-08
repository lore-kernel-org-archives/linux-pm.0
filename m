Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62147ECD8;
	Thu,  8 Oct 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450773; cv=fail; b=uytNu1pE4Bo3cL3Yu4vFjmkVbZPJCZdFqSH4B8Dn5sNpnSvDYdwZhQQv5Wm54JdZCGNf3jRbppyZy+phU9MSy7ZKGoGPV2TK7Kvz46tWvH4+dvIXPWPAenjSxPpN5gdkhB0lGwUL5ga8ujHvlo+VquC/9MHAcGPbclQEzxYP3pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450773; c=relaxed/simple;
	bh=msGMaODfjcGLNGvobLiZ6XpUf0uDa4OY/7EoRg+Me6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkOCiNPTH5IKelni6YYlG8qC2MlT8MnVH2wn7VBVw7vaX4vuGmumELLJok1Vn6HIkU+7z/q4Jqc9WlavJZSU/k8+CDKSo0Jauru9RDG+lGtN9dcTEl8jOc4+Y0htQtLvPU02DuYUvISPyuR9DNrlpQEsXi8G++o6FoaEWV0ah58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSc6LT5EXZ45HRXgn8BYJ3O30OiPGEjfA0up8WOlsMXkUBgccGwIDd70vlP5phwcUnX1qS7qu/ePGJwDyjXs/dHo3GFFrU8rWe1XLP2qrqIZ2WbCArzs7MMOI0qp4AQRuD/+tHDOsrIsCiB4HOa3w0iDl3MFo37KU90VZJlfj3Uvq26PXffDzbxFVi6NFX/o4k9o5MQxXdquoEA0MzMRPtI0s0lC7KfAm/AskrWi8puTRWvfit+DHpM6TUqenhGQ6hOQ72SimajaLXi3gXu9FW4ljxLj7dYyuxfAQJYP0BeLsSl9C3wYkpeuAY86D5oBMXDdMhft2tuh+gUT3jkq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XstCLkN1UlVyeAWlo+H5fxw83emWmMhY0ERMFJKOJSc=;
 b=k5dfjG2MFLroeMNajgXbamuaVL7MFSM6/T8+zjfX8AsF67zOwNFAk5hpAyk/p6JvGU5IAmC12CxlI8AZUWocQSpC0A2jRphkz+OTTir2KbrU8QUil1X0gOFBE5/dpo676hC2RnZGGvjqSv8wR4HDpuWDyHPQ96XwHRdd3iJkedKLZaU5ISyk/GcIakraZqCF02T4+6p6KEA5N7jt7fs2uv52h+gRmU+JBsfWmiw28yjwnQs6h1lyMdboQD6NGm393sHxpjOa5PCmILSKxHodsNs1qoqGjrAF/e0i9rLVzqysqJCmLtWBzu/2a2608Cu0l1VE3vE8R5FGGEtDHWAmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:28 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:28 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ulfh@kernel.org,
	rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] cpufreq: Add RISC-V RPMI cpufreq driver
Date: Thu,  8 Oct 2026 17:10:29 +0800
Message-ID: <20261008091032.2832333-6-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
References: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1325:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d817ee7-da97-48d0-4a04-08df251c46a7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	aNR2AykmA1YDBZMepgXyPWs7L+oq1mavzSJ4g6Dm3tcgtb0wpc0opcI+4f0WEVVUwuwWlBafvAWwwf/dIZeqKSDA0Gy0Fl4Oj/J7DQs53ENjLNjjh9Im83PvkbvdVJ1qSlpqA4lhUoHDIo+BTFaQH2Mf/99Hzw5IUC/ZmRlKICJfBfmEFn6h+x7BWa0LakUm/tSice5gsDFzC50w9dZBnXhMO0ld63asg/facZleV3NkIaFa0/FE/UzbgqJZHFGK5N+XCwokbkRRWDbTctILZ9hVpjwoNMYsUIGhmU4FCqaluNgWU27/71eNfSJQahnt9fDG+RALmxL8yGItVOq5Bx9gRj29QhTxQ923PkSWrKv8gnouaF3gAG92L/yBB+fpQ/A90u3+stZXPdc7q4tPJKoR7aTug7XC/ZiaTJ4KfYyag/K3KYI5Amq71rcR1boDmsT/w7lk9rKaYB1jS/ylGMTjDpmVzlSahCgPvipBmMLKtSjeRhSpFlFCQMJNwJo5aS8+VurPCPjFRHjIRu/zOV7sz7fqRDMuHj93S1zxbbqpRiMo9OU+drRgWnc5/gC9bXvsecF0Lfyo7SJtmqC53A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZY5lvlOzk3pHIzMvqIefjTjtuwyoUxjcU7xbqkERpT7gd/8pm13wqQt2Ot6?=
 =?us-ascii?Q?RvL6BkHct7pyPP/9tnbPtvbIRNZoIlDlfCXVDJepGoxJ71t/cnOkKnsqD9L0?=
 =?us-ascii?Q?DdrXVDs8IZTmqT0C6NvrK6Ojz66wKakGlYCJvi+HUHbAZsVi0RO+fqkt7Zpg?=
 =?us-ascii?Q?szxN7SaHbblgLSTESYIG1d6g+iY4+3K9Znh4gsiUAZTc4Yb4gwM5qk8ZP12G?=
 =?us-ascii?Q?5Gpk4eBR4+UYHcrYPA7lQAbFOTu2G4D8YCDynEYNx8ciYELbDKChTRvSLnoe?=
 =?us-ascii?Q?734law+/WzhsT0VAUAkWryIsvT4GzVhgBX1mdhmI08/1Qo4U/VXQmRHJrCdO?=
 =?us-ascii?Q?q7d7BWlWOOEdneyZaJxUzDZvkqc8k3BEjwKYFvlnzfgW/PfEW1xbwqo2ti5+?=
 =?us-ascii?Q?zm94CYb3wkwH7Txg5kFXEX3zeduDmQXprO3n2RlXJ9NLb8xLcpa0Qg80DJsf?=
 =?us-ascii?Q?Nh+4WCoey09KRZfZ5XLNcDFUre17Pge6U3D2yxx8iXBv71Jmg0fSQU2uuAEA?=
 =?us-ascii?Q?E76rIYMoeokeTr5VGjTSd4un65eZKeM4AgC6CF3a2sid+CxhwUKq31XlPa6s?=
 =?us-ascii?Q?I+zS6pR3c6oLq7sIXUVsV+pFLkDBD4Q2Md32yCNnWEtvpWkyxY4t8LL0mam+?=
 =?us-ascii?Q?n+9gG8/bAfmKonb6lKQcbtMSehXN/kI2lMm5PzXf4C+Le6ADU/37s2GAx4B5?=
 =?us-ascii?Q?H5T62i4mjUY5qPWPjEwWzBfR8rdcWymvnO/y29v2F2W/jiE7g8FOnh4HhWqI?=
 =?us-ascii?Q?z3hw/QV16y1Xz0xsa7o7M+f1fpT4a3Yctt6P2rqjYSZ4+n1QYRt+L+6iTklE?=
 =?us-ascii?Q?Sz5TpU6tWjzcV6E0qxNFce3YcEzNRS/kze6G5gq0cy4jBX488fHoS4JtvZEX?=
 =?us-ascii?Q?OAx86MSmekf7AmVxjP4iwkFiEevfRk1o9H1W62ZxjDMw0HBiSJXTDflsbowk?=
 =?us-ascii?Q?IxUbpO6WgD+DiST93XjGmnXxEgDjK2rRSPgYMwyQxcI4sYJP7FMgIsUHSLfu?=
 =?us-ascii?Q?1nj8V5ZMpIS3n/sIpYlLIpkikwPLpeTB2Am9PieRTJ/5nVHFuXnLNAZdIN+J?=
 =?us-ascii?Q?hFBJ7D777RXyy4HBhOVq6mWxkRLYTb9nl1FyIZPjsBMA5UY1Nm1otwcj5Mv4?=
 =?us-ascii?Q?vTrdbBulGChskXvnBpaAmAV0qkQjkxbjZMv8+AfxXqIL+54N08DuppsKby4n?=
 =?us-ascii?Q?0rlJhg2DbotDZ600Zw/pKA7V6i+KG+kh4G/vnLI2LK4UVAoDmfPK0XwjNCUq?=
 =?us-ascii?Q?JM987wtzi1CVtcVZvsUDMh7/4tRWE3ATYxtwV94r631ITPFMVmBErzlukAUj?=
 =?us-ascii?Q?yJXMCJhZ/RY/CGRyRmEylBMqfBG1wXRYOKGHO9BtT3MYlrCgE8hovcdmWvLg?=
 =?us-ascii?Q?ONKnVW+jShlxsCePobIG9bsNJHEoTk9muYIH/kmmuCVf2EREWwrIGS3hEqUo?=
 =?us-ascii?Q?B8l5a1dyhdfEcVCHH3vqVUdvXwn6uf46R0UzdmfbJGM7Gk1tx8s0YHuufB2d?=
 =?us-ascii?Q?XdL4lPVAh6KV9u6J4nJzYdycCahZ8KKP8/xcnaFHsHBUGm181lYktFJvK13j?=
 =?us-ascii?Q?AgZxIq1XzXjN0fSgIIXW8iHGsNgmuSUjzA2ikGipaUWVQKvzEbxhkGlqeUvu?=
 =?us-ascii?Q?1697wNqGadJSrMo5sN+AqZurJi4vWpPlhmnTxchSHzayaj8k74xOb4rL+ONz?=
 =?us-ascii?Q?reEOpylcmapYeEN9lEgioUqMPwp/QwLvuY/apRwEsDqURHyz4hMikRDBqcMJ?=
 =?us-ascii?Q?Okj0WZnu6PUzSXo2iNMw/ORLp6T1kyo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d817ee7-da97-48d0-4a04-08df251c46a7
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:28.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+3NOM1g6/G1wXJI3EmpXzaL9fXF7AaTIzEx4maEs5Y2eN2742gJYLdiUvm0fWNFIcOwUGtnyQpswvcJ6/Gnw1I/wj0GYeLXD+G6wOHSb+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

Add a cpufreq driver for the RISC-V RPMI performance domains that CPUs
name through "performance-domains". The CPUs that name the same domain
share a policy, the levels the domain advertises become its frequency
table, and the level is set through the domain's fast channel when it
has one, so that the governor can switch frequency from the scheduler.
An energy model is registered from the power cost of each level.

The driver is a front-end over the RPMI performance service group core,
which creates the device it binds to when a CPU names the provider.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cpufreq/Kconfig                       |  16 +
 drivers/cpufreq/Makefile                      |   4 +
 drivers/cpufreq/riscv-rpmi-cpufreq.c          | 294 ++++++++++++++++++
 .../firmware/riscv/riscv-rpmi-performance.c   |  55 ++++
 4 files changed, 369 insertions(+)
 create mode 100644 drivers/cpufreq/riscv-rpmi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index db83f3365698..f012b8268b5e 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -364,6 +364,22 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
+config RISCV_RPMI_CPUFREQ
+	tristate "RISC-V RPMI Based CPUFreq driver"
+	depends on RISCV_RPMI_PERFORMANCE
+	default RISCV
+	select PM_OPP
+	help
+	  This adds the CPUfreq driver support for RISC-V platforms whose CPU
+	  performance is managed through the RPMI performance service group.
+	  CPUs reference their domain through the "performance-domains"
+	  property. The performance domains it drives are enumerated by the
+	  RPMI performance service group core, which is what owns the mailbox
+	  channel.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called riscv-rpmi-cpufreq.
+
 endif # CPU_FREQ
 
 endmenu
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 6c7a39b7f8d2..265a6bccef4b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -96,6 +96,10 @@ obj-$(CONFIG_CPU_FREQ_PMAC64)		+= pmac64-cpufreq.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ)	+= pasemi-cpufreq.o
 obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 
+##################################################################################
+# RISC-V platform drivers
+obj-$(CONFIG_RISCV_RPMI_CPUFREQ)	+= riscv-rpmi-cpufreq.o
+
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
diff --git a/drivers/cpufreq/riscv-rpmi-cpufreq.c b/drivers/cpufreq/riscv-rpmi-cpufreq.c
new file mode 100644
index 000000000000..1a5d0248f879
--- /dev/null
+++ b/drivers/cpufreq/riscv-rpmi-cpufreq.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V RPMI Based CPUFreq Driver
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Drives the performance domains that CPUs share. The RPMI protocol and the
+ * domain enumeration live in the performance service group core, which owns
+ * the mailbox channel and creates the device this driver binds to.
+ */
+
+#define pr_fmt(fmt) "riscv-rpmi-cpufreq: " fmt
+
+#include <linux/cpufreq.h>
+#include <linux/energy_model.h>
+#include <linux/firmware/riscv/riscv-rpmi-performance.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+struct rpmi_perf_cpufreq_data {
+	int nr_opp;
+	struct device *cpu_dev;
+	struct rpmi_perf_domain *domain;
+};
+
+static int rpmi_perf_set_target_index(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+	u32 level;
+	int ret;
+
+	/*
+	 * cpufreq indexes its own frequency table, which is not the same thing
+	 * as an RPMI level index. Go through the frequency so that the two
+	 * only have to agree on what they mean, not on how they are numbered.
+	 */
+	ret = rpmi_perf_domain_freq_to_level(data->domain,
+					     policy->freq_table[index].frequency,
+					     &level);
+	if (ret)
+		return ret;
+
+	if (rpmi_perf_domain_has_fast_channel(data->domain))
+		return rpmi_perf_domain_set_level_fast(data->domain, level);
+
+	return rpmi_perf_domain_set_level(data->domain, level);
+}
+
+static unsigned int rpmi_perf_fast_switch(struct cpufreq_policy *policy,
+					  unsigned int target_freq)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+	u32 level;
+
+	if (rpmi_perf_domain_freq_to_level(data->domain, target_freq, &level))
+		return 0;
+
+	if (rpmi_perf_domain_set_level_fast(data->domain, level))
+		return 0;
+
+	return target_freq;
+}
+
+static unsigned int rpmi_perf_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct rpmi_perf_cpufreq_data *data;
+	u32 cpufreq, level;
+
+	if (!policy)
+		return 0;
+
+	data = policy->driver_data;
+
+	if (rpmi_perf_domain_get_level(data->domain, &level))
+		return 0;
+
+	if (rpmi_perf_domain_level_to_freq(data->domain, level, &cpufreq))
+		return 0;
+
+	return cpufreq;
+}
+
+static int rpmi_perf_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table;
+	struct rpmi_perf_cpufreq_data *data;
+	struct rpmi_perf_domain *domain;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct rpmi_perf **mpxy_perf = dev_get_platdata(&pdev->dev);
+	struct of_phandle_args args;
+	int ret, nr_opp;
+	struct device *cpu_dev;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu,
+						 "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to get performance domain info: %d\n",
+			__func__, ret);
+		goto out_free_priv;
+	}
+
+	/* A domain ID only means something to the provider the CPU names. */
+	if (args.np != dev_of_node(pdev->dev.parent)) {
+		dev_err(cpu_dev, "performance domain of %pOF, not of %pOF\n",
+			args.np, dev_of_node(pdev->dev.parent));
+		of_node_put(args.np);
+		ret = -ENODEV;
+		goto out_free_priv;
+	}
+
+	domain = rpmi_perf_domain_by_id(*mpxy_perf, args.args[0]);
+	of_node_put(args.np);
+	if (!domain) {
+		dev_err(cpu_dev, "performance domain %u is not usable\n",
+			args.args[0]);
+		ret = -EINVAL;
+		goto out_free_priv;
+	}
+
+	ret = rpmi_perf_domain_opps_add(domain, cpu_dev);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to add opps to the device\n");
+		goto out_free_priv;
+	}
+
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
+		dev_err(cpu_dev, "performance domain has no operating points\n");
+		ret = -ENODEV;
+		goto out_free_opp;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_opp;
+	}
+
+	data->cpu_dev = cpu_dev;
+	data->nr_opp = nr_opp;
+	data->domain = domain;
+
+	/* Allow DVFS request for any domain from any CPU */
+	policy->dvfs_possible_from_any_cpu = true;
+	policy->driver_data = data;
+	policy->freq_table = freq_table;
+
+	policy->cpuinfo.transition_latency =
+		rpmi_perf_domain_trans_latency_us(domain) * 1000;
+	policy->fast_switch_possible = rpmi_perf_domain_has_fast_channel(domain);
+
+	return 0;
+
+out_free_opp:
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+
+out_free_priv:
+	kfree(data);
+
+	return ret;
+}
+
+static void rpmi_perf_exit(struct cpufreq_policy *policy)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+
+	dev_pm_opp_free_cpufreq_table(data->cpu_dev, &policy->freq_table);
+	dev_pm_opp_remove_all_dynamic(data->cpu_dev);
+	kfree(data);
+}
+
+static int __maybe_unused
+rpmi_perf_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
+			unsigned long *kHz)
+{
+	struct rpmi_perf_cpufreq_data *data;
+	struct rpmi_perf_level level;
+	struct cpufreq_policy *policy;
+	u32 idx, count;
+
+	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	if (!policy)
+		return -EINVAL;
+
+	data = policy->driver_data;
+	count = rpmi_perf_domain_level_count(data->domain);
+
+	/* The levels are in ascending order of frequency. */
+	for (idx = 0; idx < count; idx++) {
+		if (rpmi_perf_domain_level_info(data->domain, idx, &level))
+			return -EINVAL;
+
+		if (level.clock_freq < *kHz)
+			continue;
+
+		*uW = level.power_cost;
+		*kHz = level.clock_freq;
+		return 0;
+	}
+
+	/* No level at or above *kHz: there is no state to describe. */
+	return -EINVAL;
+}
+
+static void rpmi_perf_register_em(struct cpufreq_policy *policy)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(rpmi_perf_get_cpu_power);
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu), data->nr_opp,
+				    &em_cb, policy->cpus, true);
+}
+
+static struct cpufreq_driver  rpmi_perf_cpufreq_driver = {
+	.name = "rpmi-cpufreq",
+	.flags = CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = rpmi_perf_set_target_index,
+	.fast_switch = rpmi_perf_fast_switch,
+	.get = rpmi_perf_get_rate,
+	.init = rpmi_perf_init,
+	.exit = rpmi_perf_exit,
+	.register_em = rpmi_perf_register_em,
+};
+
+static int rpmi_cpufreq_probe(struct platform_device *pdev)
+{
+	struct rpmi_perf **mpxy_perf = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (!mpxy_perf || !*mpxy_perf)
+		return -EINVAL;
+
+	/*
+	 * There is one cpufreq driver for the whole system, so only one
+	 * provider can drive the CPUs. Refuse another one rather than point
+	 * the registered driver at its domains.
+	 */
+	if (rpmi_perf_cpufreq_driver.driver_data)
+		return dev_err_probe(dev, -EBUSY,
+				     "CPUs are already driven by another provider\n");
+
+	rpmi_perf_cpufreq_driver.driver_data = pdev;
+
+	ret = cpufreq_register_driver(&rpmi_perf_cpufreq_driver);
+	if (ret) {
+		rpmi_perf_cpufreq_driver.driver_data = NULL;
+		return dev_err_probe(dev, ret, "registering cpufreq failed\n");
+	}
+
+	dev_info(dev, "%d MPXY cpufreq domains registered\n",
+		 rpmi_perf_num_domains(*mpxy_perf));
+
+	return 0;
+}
+
+static void rpmi_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&rpmi_perf_cpufreq_driver);
+	rpmi_perf_cpufreq_driver.driver_data = NULL;
+}
+
+static struct platform_driver rpmi_cpufreq_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-cpufreq",
+	},
+	.probe = rpmi_cpufreq_probe,
+	.remove = rpmi_cpufreq_remove,
+};
+
+module_platform_driver(rpmi_cpufreq_platdrv);
+
+MODULE_ALIAS("platform:riscv-rpmi-cpufreq");
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_DESCRIPTION("RISC-V RPMI performance cpufreq driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/riscv/riscv-rpmi-performance.c b/drivers/firmware/riscv/riscv-rpmi-performance.c
index d44802f07ab0..f91f2d861dc0 100644
--- a/drivers/firmware/riscv/riscv-rpmi-performance.c
+++ b/drivers/firmware/riscv/riscv-rpmi-performance.c
@@ -19,6 +19,7 @@
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -995,6 +996,56 @@ static void rpmi_perf_mbox_chan_release(void *data)
 	mbox_free_channel((struct mbox_chan *)data);
 }
 
+/*
+ * cpufreq has no device tree node of its own: a CPU names its domain through
+ * "performance-domains" on the CPU node. Create the device it binds to, but
+ * only when some CPU actually points back here.
+ */
+static bool rpmi_perf_cpus_present(struct device *dev)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int ret;
+
+	for_each_of_cpu_node(cpu_np) {
+		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
+						 "#performance-domain-cells", 0,
+						 &args);
+		if (ret)
+			continue;
+
+		if (args.np == dev_of_node(dev)) {
+			of_node_put(args.np);
+			of_node_put(cpu_np);
+			return true;
+		}
+		of_node_put(args.np);
+	}
+
+	return false;
+}
+
+static void rpmi_perf_frontend_unregister(void *data)
+{
+	platform_device_unregister((struct platform_device *)data);
+}
+
+static int rpmi_perf_cpufreq_register(struct device *dev, struct rpmi_perf *perf)
+{
+	struct platform_device *pdev;
+
+	if (!IS_ENABLED(CONFIG_RISCV_RPMI_CPUFREQ) || !rpmi_perf_cpus_present(dev))
+		return 0;
+
+	pdev = platform_device_register_data(dev, "riscv-rpmi-cpufreq",
+					     PLATFORM_DEVID_AUTO, &perf,
+					     sizeof(perf));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return devm_add_action_or_reset(dev, rpmi_perf_frontend_unregister, pdev);
+}
+
 static int rpmi_perf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1078,6 +1129,10 @@ static int rpmi_perf_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, mpxy_perf);
 
+	ret = rpmi_perf_cpufreq_register(dev, mpxy_perf);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register cpufreq device\n");
+
 	dev_info(dev, "%d MPXY performance domains registered\n", num_domains);
 
 	return 0;
-- 
2.43.0

