Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18173CC324;
	Fri, 18 Sep 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699246; cv=none; b=I3TAVbsPin72RjCtPE2bqwZhr15c67XeYe+v6ttxE5TSA0yekprRpGyX6mPut7zw+nyRcIY6PbsKcBwa3mDFQ3x2ab/NOlNAsnlUk/ZMNr/17AcJ4Sv5NOF97KG6K97NsEjkEG73GPFSCHhWWCrZq6DD2Z1jvstMwyQ/5Zuyq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699246; c=relaxed/simple;
	bh=iqHwifzZgzpugwjB9qhOAFhRt3RpxqvAF10RHTmE19A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7gSoeimGJ8hXyNc8yUQ+GvnzC3jOqedbo2oMi9WEZM8mHYctfcB/GS3hHzV9QYgLLBoElJg5w/Xbls3tbAJPM6n0sWAWH5RVetUlROwehCWWo3Gfch7IrzYdwWaUeYY4Q+k43PQ3EA9g/iCmVTrQdowOdfWLaCL358E3QSwo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMg9lkmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMg9lkmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B3A1F00898;
	Fri, 18 Sep 2026 02:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699238;
	bh=w/QQRys2Br/Sd+PVsft6KzNlyFv6gs8a6KTi1FtELqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OMg9lkmr/t9yKUXzHpNVrCQto73dYcj/gptlywCGtcGE0ey0muxoRHS6eNyWSOO1r
	 tRQBDFY1ZSJbyItLz39DULVct3QUAYygq3+AiT8Bfzs5Mtpov5qjBcB3tfRhUX6fAR
	 Hi+3K0kHcAoRkH0RsiwJILxSdqz+q7sGYdffC9mVY/oi9gCgfFhk5CM7Lh9TKJLrk3
	 /1NN7Dq6WdUolrrNEX+V/JJPdVuN/fedoSnKz6/szxSd4s4YgeKybzRsABgqdZUqXn
	 USzsy35fu6hcJCC6XDBTZcG6AiWeda4A6QqdId+ORhJ0QKfo6YbikQ/kMbanuC6U3D
	 +q/OwQ2nk+onw==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 18 Sep 2026 02:40:14 +0000
Subject: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
In-Reply-To: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14457; i=dlan@kernel.org;
 h=from:subject:message-id; bh=iqHwifzZgzpugwjB9qhOAFhRt3RpxqvAF10RHTmE19A=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqrKSV0AVz7W1PhDCE08dqlxWIbcMkJNKvyhD5N
 YhrCYxefIGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaqyklRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2fIxAAjm8mpjblq1z+/Hq0biNJd4vU++7XXq8LP5zYcJwY+CxUOz54DLa2A
 VBRjLjV8a9KGyVHK5sWudrCKhdi6oKAW9nktmdevgMS4oWK4Oi/yuY/ACLVj8m29uI06M1QXFH2
 1cKj8/tHMfel297OY1spXj82HCWotAFI9TJ/jvzLJ39DflKW7opP0df9U0kXZM3D1faTa13LTR9
 c/PcntXx5711/maV5QQHwiHbSwp4YB0SasiXpFRuO3tTxvZhdZmSk/Hg7aUxRRzwoJEWYHQ/fMT
 V2ancYM9aUT1LGd8gceiTCLPSnVcOn59QZhsvIR+v3esGd8DRCVs5tGCaFTAtzREMUJjdIWT4fu
 KiXHrol75MyhsD3ebVAKmpbX7Jt9ltUZTj4HA/5TRr7iwuTmJlnrYJ+zgNVrvrXTF5qtGJrCQFe
 ei8tpI72ZU+2cLHMaRR4NXONqvOna1g1BRL9oAIAJQb8Pg6KemUtNRImC1t37JR7gVXZeLYwwLP
 WqrfWDhR6y8M8hqmDBKjQ+0pK3AWKNJeRVpu58jpnW0gDVj4kPyqEQeUJsxsksqzAphFlJKSyZj
 RaUfDqNSeEitEN0kBwMs9oQ/V/jRFgDqeDFRIFxl5SLryRkomOpWWz0T0/a2sXxhVLe4Qpplk3x
 Xi2Jn9ICJSuylumpXAecPe2xTkwgog=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

  SpacemiT's PMU (Power Management Unit) consist of several power domains
which can be managed independently, depending on different application
scenario, each domain can be powered on/off for saving power.

  The driver is implemented based on Linux Generic PM Domain framework.
From a hardware perspective, either of two distinct power-on sequences
are supported, in software mode (SW mode), the driver is responsible for
controlling the states of bits such as sleep1, sleep2, isolation and
pwr_state, while in hardware mode (HW mode), the PMU hardware will complete
the sequence automatically without requiring software intervention.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pmdomain/Kconfig               |   1 +
 drivers/pmdomain/Makefile              |   1 +
 drivers/pmdomain/spacemit/Kconfig      |  15 ++
 drivers/pmdomain/spacemit/Makefile     |   1 +
 drivers/pmdomain/spacemit/pm_domains.c | 448 +++++++++++++++++++++++++++++++++
 5 files changed, 466 insertions(+)

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 23076ae90e66..0610acd030f6 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -13,6 +13,7 @@ source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
+source "drivers/pmdomain/spacemit/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index ebc802f13eb9..ba25b444e263 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -11,6 +11,7 @@ obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
+obj-y					+= spacemit/
 obj-y					+= st/
 obj-y					+= starfive/
 obj-y					+= sunxi/
diff --git a/drivers/pmdomain/spacemit/Kconfig b/drivers/pmdomain/spacemit/Kconfig
new file mode 100644
index 000000000000..4b927beedc7c
--- /dev/null
+++ b/drivers/pmdomain/spacemit/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "SpacemiT PM Domains"
+
+config SPACEMIT_PM_DOMAINS
+	bool "PM Domain driver for SpacemiT SoC"
+	depends on PM
+	depends on OF
+	depends on MFD_SYSCON
+	select PM_GENERIC_DOMAINS
+	help
+	  PM Domain driver for SpacemiT SoC. Say Y if you want to support
+	  SpacemiT SoCs.
+
+endmenu
diff --git a/drivers/pmdomain/spacemit/Makefile b/drivers/pmdomain/spacemit/Makefile
new file mode 100644
index 000000000000..5e8a740ba494
--- /dev/null
+++ b/drivers/pmdomain/spacemit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SPACEMIT_PM_DOMAINS)	+= pm_domains.o
diff --git a/drivers/pmdomain/spacemit/pm_domains.c b/drivers/pmdomain/spacemit/pm_domains.c
new file mode 100644
index 000000000000..d563e4e4e232
--- /dev/null
+++ b/drivers/pmdomain/spacemit/pm_domains.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit Generic power domain support.
+ *
+ * Copyright (c) 2026 SpacemiT Technology Co. Ltd
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <dt-bindings/power/spacemit,k1-power.h>
+#include <dt-bindings/power/spacemit,k3-power.h>
+
+#define APMU_POWER_STATUS_REG	0xf0
+#define APMU_POWER_TIMEOUT_US	10000
+
+struct spacemit_pm_domain_param {
+	int reg_pwr_ctrl;
+	int bit_hw_mode;
+	int bit_sleep2;
+	int bit_sleep1;
+	int bit_isolation;
+	int bit_auto_pwr_on;
+	int bit_hw_pwr_stat;
+	int bit_pwr_stat;
+	int use_hw;
+	const char *name;
+};
+
+struct spacemit_pm_domain {
+	struct generic_pm_domain genpd;
+	int pm_index;
+	const struct spacemit_pm_domain_param *param;
+};
+
+struct spacemit_pmu {
+	struct device *dev;
+	struct genpd_onecell_data genpd_data;
+	struct regmap *regmap;
+	struct spacemit_pm_domain **domains;
+	int num_domains;
+};
+
+struct spacemit_pm_of_data {
+	int num_domains;
+	const struct spacemit_pm_domain_param *param;
+};
+
+static struct spacemit_pmu *gpmu;
+
+static int spacemit_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *spd = container_of(domain, struct spacemit_pm_domain, genpd);
+	const struct spacemit_pm_domain_param *p = spd->param;
+	unsigned int val;
+	int ret;
+
+	if (!spd->param->use_hw) {
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_isolation));
+		fsleep(15);
+
+		val = BIT(p->bit_sleep1) | BIT(p->bit_sleep2);
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	} else {
+		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_hw_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (ret) {
+		dev_err(&domain->dev, "Fail to power-off domain: %d\n",
+				spd->pm_index);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int spacemit_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *spd = container_of(domain, struct spacemit_pm_domain, genpd);
+	const struct spacemit_pm_domain_param *p = spd->param;
+	unsigned int val;
+	int ret = 0;
+
+	regmap_read(gpmu->regmap, APMU_POWER_STATUS_REG, &val);
+
+	if (!p->use_hw && (val & BIT(p->bit_pwr_stat))) {
+		val = BIT(p->bit_isolation);
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		val = BIT(p->bit_sleep1) | BIT(p->bit_sleep2);
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (p->use_hw && (val & BIT(p->bit_hw_pwr_stat))) {
+		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
+		regmap_clear_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(30);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_hw_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (ret < 0) {
+		dev_err(&domain->dev, "power-off domain: %d, error\n", spd->pm_index);
+		return -EBUSY;
+	}
+
+	if (!p->use_hw) {
+		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_sleep1));
+		fsleep(20);
+
+		val = BIT(p->bit_sleep2) | BIT(p->bit_sleep1);
+		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(20);
+
+		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_isolation));
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       (val & BIT(p->bit_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	} else {
+		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
+		regmap_set_bits(gpmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(300);
+
+		ret = regmap_read_poll_timeout(gpmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       (val & BIT(p->bit_hw_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (ret < 0) {
+		dev_err(&domain->dev, "power-on domain: %d, error\n", spd->pm_index);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static bool spacemit_pm_get_state(struct spacemit_pmu *pmu,
+				  struct spacemit_pm_domain *pd)
+{
+	const struct spacemit_pm_domain_param *p = pd->param;
+	u32 reg, bit;
+
+	regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);
+
+	bit = p->use_hw ? BIT(pd->param->bit_hw_pwr_stat) :
+		BIT(pd->param->bit_pwr_stat);
+
+	return !!(reg & bit);
+}
+
+static int spacemit_pm_add_one_domain(struct spacemit_pmu *pmu, int id,
+				      const struct spacemit_pm_domain_param *param)
+{
+	struct spacemit_pm_domain *pd;
+
+	pd = devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->pm_index        = id;
+	pd->param           = param;
+	pd->genpd.name      = param->name;
+	pd->genpd.power_off = spacemit_pd_power_off;
+	pd->genpd.power_on  = spacemit_pd_power_on;
+
+	pm_genpd_init(&pd->genpd, NULL, !spacemit_pm_get_state(pmu, pd));
+
+	pmu->domains[id] = pd;
+
+	return 0;
+}
+
+static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
+{
+	int i;
+
+	for (i = 0; i < pmu->num_domains; i++) {
+		if (pmu->domains[i])
+			pm_genpd_remove(&pmu->domains[i]->genpd);
+	}
+}
+
+static int spacemit_pm_domain_probe(struct platform_device *pdev)
+{
+	const struct spacemit_pm_of_data *data;
+	struct device *dev = &pdev->dev;
+	struct spacemit_pmu *pmu;
+	int err, i;
+
+	data = device_get_match_data(dev);
+
+	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	pmu->dev = dev;
+	pmu->num_domains = data->num_domains;
+
+	pmu->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "spacemit,apmu");
+	if (IS_ERR(pmu->regmap))
+		return dev_err_probe(dev, PTR_ERR(pmu->regmap), "failed to get apmu regmap\n");
+
+	pmu->domains = devm_kcalloc(dev, data->num_domains,
+				    sizeof(*pmu->domains), GFP_KERNEL);
+	if (!pmu->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < data->num_domains; i++) {
+		err = spacemit_pm_add_one_domain(pmu, i, &data->param[i]);
+		if (err) {
+			dev_err(dev, "failed to add domain %d: %d\n", i, err);
+			goto err_out;
+		}
+	}
+
+	pmu->genpd_data.domains     = (struct generic_pm_domain **)pmu->domains;
+	pmu->genpd_data.num_domains = data->num_domains;
+
+	err = of_genpd_add_provider_onecell(dev->of_node, &pmu->genpd_data);
+	if (err) {
+		dev_err(dev, "failed to add provider: %d\n", err);
+		goto err_out;
+	}
+
+	gpmu = pmu;
+
+	return 0;
+
+err_out:
+	spacemit_pm_domain_cleanup(pmu);
+	return err;
+}
+
+static const struct spacemit_pm_domain_param k1_domain_params[] = {
+	[K1_PMDOMAIN_VPU] = {
+		.reg_pwr_ctrl		= 0xa8,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_pwr_stat		= 1,
+		.bit_hw_pwr_stat	= 9,
+		.name			= "vpu",
+	},
+	[K1_PMDOMAIN_GPU] = {
+		.reg_pwr_ctrl		= 0xd0,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_pwr_stat		= 0,
+		.name			= "gpu",
+	},
+	[K1_PMDOMAIN_LCD] = {
+		.reg_pwr_ctrl		= 0x380,
+		.bit_hw_mode		= 4,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_auto_pwr_on	= 0,
+		.bit_pwr_stat		= 4,
+		.bit_hw_pwr_stat	= 12,
+		.use_hw			= 1,
+		.name			= "lcd",
+	},
+	[K1_PMDOMAIN_ISP] = {
+		.reg_pwr_ctrl		= 0x37c,
+		.bit_hw_mode		= 4,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_auto_pwr_on	= 0,
+		.bit_pwr_stat		= 2,
+		.bit_hw_pwr_stat	= 10,
+		.name			= "isp",
+	},
+	[K1_PMDOMAIN_AUDIO] = {
+		.reg_pwr_ctrl		= 0x378,
+		.bit_hw_mode		= 4,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_auto_pwr_on	= 0,
+		.bit_pwr_stat		= 3,
+		.bit_hw_pwr_stat	= 11,
+		.use_hw			= 1,
+		.name			= "audio",
+	},
+	[K1_PMDOMAIN_GNSS] = {
+		.reg_pwr_ctrl		= 0x13c,
+		.bit_hw_mode		= 4,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_auto_pwr_on	= 0,
+		.bit_pwr_stat		= 6,
+		.bit_hw_pwr_stat	= 14,
+		.name			= "gnss",
+	},
+	[K1_PMDOMAIN_HDMI] = {
+		.reg_pwr_ctrl		= 0x3f4,
+		.bit_hw_mode		= 4,
+		.bit_sleep2		= 3,
+		.bit_sleep1		= 2,
+		.bit_isolation		= 1,
+		.bit_auto_pwr_on	= 0,
+		.bit_pwr_stat		= 7,
+		.bit_hw_pwr_stat	= 15,
+		.use_hw			= 1,
+		.name			= "hdmi",
+	},
+};
+
+static const struct spacemit_pm_domain_param k3_domain_params[] = {
+	[K3_PMDOMAIN_VPU] = {
+		.bit_auto_pwr_on	= 0,
+		.bit_isolation		= 1,
+		.bit_sleep1		= 2,
+		.bit_sleep2		= 3,
+		.bit_hw_mode		= 4,
+		.bit_pwr_stat		= 2,
+		.bit_hw_pwr_stat	= 9,
+		.use_hw			= 1,
+		.reg_pwr_ctrl		= 0xa8,
+		.name			= "vpu",
+	},
+	[K3_PMDOMAIN_GPU] = {
+		.bit_auto_pwr_on	= 0,
+		.bit_isolation		= 1,
+		.bit_sleep1		= 2,
+		.bit_sleep2		= 3,
+		.bit_hw_mode		= 4,
+		.bit_pwr_stat		= 0,
+		.bit_hw_pwr_stat	= 8,
+		.use_hw			= 1,
+		.reg_pwr_ctrl		= 0xd0,
+		.name			= "gpu",
+	},
+	[K3_PMDOMAIN_AUDIO] = {
+		.bit_auto_pwr_on	= 0,
+		.bit_isolation		= 1,
+		.bit_sleep1		= 2,
+		.bit_sleep2		= 3,
+		.bit_hw_mode		= 4,
+		.bit_pwr_stat		= 3,
+		.reg_pwr_ctrl		= 0x378,
+		.name			= "audio",
+	},
+	[K3_PMDOMAIN_LCD0] = {
+		.bit_auto_pwr_on	= 0,
+		.bit_isolation		= 1,
+		.bit_sleep1		= 2,
+		.bit_sleep2		= 3,
+		.bit_hw_mode		= 4,
+		.bit_pwr_stat		= 4,
+		.bit_hw_pwr_stat	= 12,
+		.use_hw			= 1,
+		.reg_pwr_ctrl		= 0x380,
+		.name			= "lcd0",
+	},
+	[K3_PMDOMAIN_LCD1] = {
+		.bit_auto_pwr_on	= 0,
+		.bit_isolation		= 1,
+		.bit_sleep1		= 2,
+		.bit_sleep2		= 3,
+		.bit_hw_mode		= 4,
+		.bit_pwr_stat		= 5,
+		.bit_hw_pwr_stat	= 15,
+		.use_hw			= 1,
+		.reg_pwr_ctrl		= 0x3f4,
+		.name			= "lcd1",
+	},
+};
+
+static const struct spacemit_pm_of_data k1_of_data = {
+	.num_domains	= ARRAY_SIZE(k1_domain_params),
+	.param		= k1_domain_params,
+};
+
+static const struct spacemit_pm_of_data k3_of_data = {
+	.num_domains	= ARRAY_SIZE(k3_domain_params),
+	.param		= k3_domain_params,
+};
+
+static const struct of_device_id spacemit_pm_domain_dt_match[] = {
+	{
+		.compatible = "spacemit,k1-power-controller",
+		.data = &k1_of_data,
+	},
+	{
+		.compatible = "spacemit,k3-power-controller",
+		.data = &k3_of_data,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver spacemit_pm_domain_driver = {
+	.probe = spacemit_pm_domain_probe,
+	.driver = {
+		.name           = "spacemit-pm-domain",
+		.of_match_table = spacemit_pm_domain_dt_match,
+	},
+};
+
+builtin_platform_driver(spacemit_pm_domain_driver);
+MODULE_DESCRIPTION("SpacemiT Generic Power Domains driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

