Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AD1A6807;
	Thu,  8 Oct 2026 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431101; cv=none; b=mWMWDjmyy0v1yTnGjSFksbHwxSTZ+3aJ6Y280mN9/v5dVdqbn7eNO/4kj1xsKlXENPGu4y3FH4LxH8RqmdQUdnWaXfnwJ013m1nxCscFMfcs3Ec4uCDm02lTrb9s74h6agT9qrLJpeYgnLDVhMzdeX+HqMXqx9lra4mviZvk5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431101; c=relaxed/simple;
	bh=QOlme/lDg+ziINNweuPf5n2q5GeNInNxMyDWk9LP27k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RO8O7CBqj6c0vN3E/ra4sAVpbdQFCOsCrs2NWZIImYLja7C3rl8QltW/oj2m1gkRAOnEH0p+fnoNprOV6tPK27sLe8mgzw8LaY5BsJ7pac/o7vwOfQiMexo3O2J+M8ZtAtMmY7kp1jLfCn4zbq/7ENWvYkhanYIfP93143bVKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7pK61BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7pK61BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35F71F000FF;
	Thu,  8 Oct 2026 03:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431099;
	bh=lRXs+TaDtI533D740/8obfC20NST4LyL9XsRaIWut7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N7pK61BQaqLykI4UFWGJgM7Y3Xu4J+1JBbxyU6AuMpm7JlrpLeP3+ttAbJTmI7Sqn
	 SFVeNAeZxzM9MYfUCmkpVK1PCFGoceoR3iByjWYPu12JtUJ6Fuu6IRTMzU6Lnay2cT
	 RGCHueGbZ34nexCaSfPVMmPGWTQGgP23NLRuudwoWfDDUWYuDeHWACcvV9kp2Zv5sE
	 x9P8MNVFVupE/HvuJG/lQWViY2pMllozvwfzTa8ohkoSya/i6mJt3hWnljpqYAZ5eo
	 TrBiVLWWYKcDt/ReYnWXLIfGCQf/gNcyazoXF8dq9n1bYA6LYV4e5YsUWi62NuRryR
	 t7Z6ZwO+YufHA==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 08 Oct 2026 03:44:30 +0000
Subject: [PATCH v2 2/2] pmdomain: spacemit: Add power domain driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-04-k3-pm-support-v2-2-6f778a53dd2d@kernel.org>
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
In-Reply-To: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14008; i=dlan@kernel.org;
 h=from:subject:message-id; bh=QOlme/lDg+ziINNweuPf5n2q5GeNInNxMyDWk9LP27k=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxxGtqkeOvnwpnuHPKBbOZp0qD7YdEzIn+f0MC
 +AaXHGOsE2JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCascRrRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+22+g//TaEI6ttCnYH/Yd4dY/jL0npTO6qGtqkcaCXz2blcTzS2GeByx7lBJ
 PobslJcqAm6YMwVAerjnu1L6ejt++D2imIP+MN79Y9xCpHjZ0qU/89tEjs9JuKknNeLMzW+Udpg
 eo2GidGAn1As8zswlzL285H3JIh+C4QBVPGaMsDakgjiOmLm46+HzF3Fmi57vODVaWfgMUgsFGB
 PJCSG75bWqr3upMvyHGx1ccANBNkwiAyCMziI7tM3fIMDd+v4ZvuLEqEWKE7hdBi7NoKvEuOHgT
 YqwyM0kMM0Qeemt90Jr32bXDtYlENPFD9wWd8GnrX1gJvhGz0s8FvJ11oVKjy7aQw9lcusafnI5
 5EVe46hm94k5UVId6g7tgoBfdVlV13fJBOtkIjyC2/GeT8UFiY1TUYqNoU2BbUnWNsfzw98bBSx
 xmKwQ3ioUaNwh0I0JLXUX4QDS/8e6mO5x9otx9g5ZVWRsSPiRtL9XIFIanF/dhA88O/ZFeH+eSt
 ELslQSILTBN2A8KFmeno0Uggf/VCCohKHW2XE87P3sV0DVO8VgZLl66A5kX1OGaNTO3KYCOL1X+
 k/OGchMAjf2bsHEm6MiXQU12JY6GFkSlbXzHXnvSX6gtWB/O6uxuzHTEbJHjstEIWML2V7eGngI
 QrHxBvWTqZtMwl3HPG6pngqamnd5Gk=
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
 drivers/pmdomain/Kconfig                        |   1 +
 drivers/pmdomain/Makefile                       |   1 +
 drivers/pmdomain/spacemit/Kconfig               |  21 ++
 drivers/pmdomain/spacemit/Makefile              |   1 +
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 413 ++++++++++++++++++++++++
 5 files changed, 437 insertions(+)

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
index 000000000000..0dce5eef8da8
--- /dev/null
+++ b/drivers/pmdomain/spacemit/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "SpacemiT PM Domains"
+
+config SPACEMIT_PM_DOMAINS
+	tristate "PM Domain driver for SpacemiT SoC"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on PM && OF
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	select AUXILIARY_BUS
+	help
+	  This driver enables power domain management for the SpacemiT
+	  SoC. On the SoC there are number of power domains available,
+	  which can be managed independently. For example VPU, GPU, LCD,
+	  and Audio reside in their own power domains which can be
+	  turned on/off.
+
+	  Say y to enable device power management through PM domains.
+
+endmenu
diff --git a/drivers/pmdomain/spacemit/Makefile b/drivers/pmdomain/spacemit/Makefile
new file mode 100644
index 000000000000..d0bd77a520c0
--- /dev/null
+++ b/drivers/pmdomain/spacemit/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SPACEMIT_PM_DOMAINS)	+= spacemit-pm-domains.o
diff --git a/drivers/pmdomain/spacemit/spacemit-pm-domains.c b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
new file mode 100644
index 000000000000..8fbe3b953464
--- /dev/null
+++ b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
@@ -0,0 +1,413 @@
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
+#include <linux/regmap.h>
+#include <linux/auxiliary_bus.h>
+#include <dt-bindings/power/spacemit,k1-power.h>
+#include <dt-bindings/power/spacemit,k3-power.h>
+#include <soc/spacemit/ccu.h>
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
+	unsigned int flags;
+	const char *name;
+};
+
+struct spacemit_pm_domain {
+	struct generic_pm_domain genpd;
+	struct spacemit_pmu *gpmu;
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
+struct spacemit_pm_aux_data {
+	int num_domains;
+	const struct spacemit_pm_domain_param *param;
+};
+
+static int spacemit_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *spd = container_of(domain, struct spacemit_pm_domain, genpd);
+	struct spacemit_pmu *gpmu = spd->gpmu;
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
+		dev_err(&domain->dev, "Fail to power-off domain: %s (%d)\n",
+			p->name, spd->pm_index);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int spacemit_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *spd = container_of(domain, struct spacemit_pm_domain, genpd);
+	struct spacemit_pmu *gpmu = spd->gpmu;
+	const struct spacemit_pm_domain_param *p = spd->param;
+	unsigned int val;
+	int ret = 0;
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
+	u32 reg = 0, bit;
+
+	regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);
+
+	bit = p->use_hw ? BIT(p->bit_hw_pwr_stat) : BIT(p->bit_pwr_stat);
+
+	return !!(reg & bit);
+}
+
+static int spacemit_pm_add_one_domain(struct spacemit_pmu *pmu, int id,
+				      const struct spacemit_pm_domain_param *param)
+{
+	struct spacemit_pm_domain *pd;
+	int ret;
+
+	pd = devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->pm_index        = id;
+	pd->param           = param;
+	pd->gpmu            = pmu;
+	pd->genpd.name      = param->name;
+	pd->genpd.flags     = param->flags;
+	pd->genpd.power_off = spacemit_pd_power_off;
+	pd->genpd.power_on  = spacemit_pd_power_on;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, !spacemit_pm_get_state(pmu, pd));
+	if (ret)
+		return ret;
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
+static int spacemit_pm_domain_probe(struct auxiliary_device *adev,
+				    const struct auxiliary_device_id *id)
+{
+	struct spacemit_ccu_adev *rdev = to_spacemit_ccu_adev(adev);
+	const struct spacemit_pm_aux_data *data;
+	struct device *dev = &adev->dev;
+	struct spacemit_pmu *pmu;
+	int err, i;
+
+	data = (const struct spacemit_pm_aux_data *)id->driver_data;
+
+	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	pmu->dev = dev;
+	pmu->regmap = rdev->regmap;
+	pmu->num_domains = data->num_domains;
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
+		.flags			= GENPD_FLAG_ALWAYS_ON,
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
+static const struct spacemit_pm_aux_data k1_of_data = {
+	.num_domains	= ARRAY_SIZE(k1_domain_params),
+	.param		= k1_domain_params,
+};
+
+static const struct spacemit_pm_aux_data k3_of_data = {
+	.num_domains	= ARRAY_SIZE(k3_domain_params),
+	.param		= k3_domain_params,
+};
+
+static const struct auxiliary_device_id spacemit_pm_domain_ids[] = {
+	{
+		.name = "spacemit_ccu.k1-apmu-pmdomain",
+		.driver_data = (kernel_ulong_t)&k1_of_data,
+	},
+	{
+		.name = "spacemit_ccu.k3-apmu-pmdomain",
+		.driver_data = (kernel_ulong_t)&k3_of_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, spacemit_pm_domain_ids);
+
+static struct auxiliary_driver spacemit_pm_domain_driver = {
+	.probe          = spacemit_pm_domain_probe,
+	.id_table       = spacemit_pm_domain_ids,
+};
+module_auxiliary_driver(spacemit_pm_domain_driver);
+
+MODULE_DESCRIPTION("SpacemiT Generic Power Domains driver");
+MODULE_LICENSE("GPL");

-- 
2.56.0

