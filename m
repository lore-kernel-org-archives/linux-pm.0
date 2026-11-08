Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134185;
	b=g3fUX2RXpMgPOnM53AvSXso6nlzPfbWAjtYBaK/a+sfitHi4wNNmO7JJMwzTSSZRVRX5
	 2O3GlhVS/JzesOpYvjgqSHOc0qgfQiCWxSgCpyyB3rM15RAc8JafsMjM1VQ7ouMtPXLmA
	 jRf7kr6JN3JgIoJtFRXIzbqPhzxMvNuq2ZLC3pgJtf2NEJJZx3GQc7LIn11lTPH5IFTNc
	 PtFhfq7lqqpcGLJYOWaTQhw8MeCVGB795Q4yFCoxJtlApN4eonvXj0aOiPN1HLx9CYAOS
	 MAY+fUiReCgO1W40vpFmL5bsUF3IgkX0mRuWOwmnAohQbI2SGqhWHqjPUdHIahbn+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134185;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VBo8fjSNHmRxzWet6KHRueSq/iTXqSt9fGiagb0DQGs=;
	b=V6s5Oz2L64Inp/Sdwll+QBzfkgurS9qQ/6jmwEkAjboIyjzr8QoNJ9l3A5l6M8o/fCUD
	 OecRbEmjiIixLD7au0PC4nzu5MjEZuwP+6tmsMW1X/nS1EtfEbl0MH0Jh/dMG23Y1ATel
	 KVP7km7S4n83bWBySKgL1vjL+SBCzL6/ABJHqzZpLk5JsAsT0BnDYtgU5ObuCPCwjJkfS
	 6X+ZY/fy/RjSRfItnKOEmQz83fDPutBE3Fk/+DG8jgg5eS/4qesSlzm5vdhOsoGHmCu8e
	 mSm9oelx0gd2xtPTr16/0TOzo0aaB4VXVROx89wcU1SnBZU7LoShwGHZsWTZxaYGa8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmPE5n5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AC606A320;
	Sun,  8 Nov 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmPE5n5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D3C1F0089F;
	Sun,  8 Nov 2026 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794134185;
	bh=VBo8fjSNHmRxzWet6KHRueSq/iTXqSt9fGiagb0DQGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hmPE5n5LhvtyZEKccS1IGbEuBvpVvDr9liN6ChjmQSTkOM1E+ivpAGv1hCVZBRgt2
	 heI2Ccz4890ihw2VxS2TniEuaEbJKON5sLDvgyMXMts90z6dR05Hhk1UOnwOi6+RZ7
	 wkea1SpzGJKF5ef7MLzD0AMYXSjGFHPgHMDopMBCrm0okZMH3bmiFhoOWoYOP9jckq
	 jwNLm9JlTVxmqDh+Hd/dOnLhsfDyxpx0Jp+GbJdYxz3ie99JnfplkeQ2wWxL9r7zX1
	 KneyPIS//8tiyICN/gJE4upzrEj2snUTJmK5ZMDJCaMf1QMpGlqk2vH1y6JKyep5Z0
	 oVZwxIYv4WiEw==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 08 Nov 2026 10:36:02 +0000
Subject: [PATCH v3 2/2] pmdomain: spacemit: Add power domain driver
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org>
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
In-Reply-To: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14583; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Vw+TWc+uk5jMy+oaSH7nF/5G1aKNMWVOMUxFePRRoog=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq8FCZVHndzrFMi0zB6QIQdghIh8uU5Uw4ZkUVo
 NQM7UdjxyiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavBQmRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1AlhAAlei6ep6Z+r/Peve+Y5HV2+YguSPk/MA3caC1SmjqKrpvKYyUJmOFz
 WzXelYydOg9XCeN+v7atLiN1rlfye1R098aI32231k8SsCUybDmN+ohMwLTsLmzv02LVCiRMaKt
 wfDlHMWWQIrB9j4lABLxbplgL1rKcc6km2ia9pTbyzyJRJoPQ7ZTW6xbOsw+R8X0dFKa871rude
 toiPxDVT09wKik+X5/EBPP0clfviHouxlljnO+h4b9r/xoS6xtN/t87V3J4g5RkAP/VvPAQFSg3
 NthgHelk5dUCmYzK8fDFy2P+DNw0FHMTkAL5n9q35kGoyZxOOrcOyJhChL1FCOhtt4eagNv5GRj
 gQj0n1d1p/2EyqaZeXRHPdBfc0GtM/RZKRRitBLG2BwJZtrv0C9ICtTpesREG5e6uIl68OTEJBb
 TpmuzWAHbkvp9hGLuFopS+Sng00jTOV9DCZi486sDr1/sEd9v11ub1Q4WV/jFiqugsr4EK9omKR
 Xe1z92B4MZFggPNItH452inLc60//SKg4e8VPRsTzsT5bCl/HhPUASzEIo2spIsvo5RP8LUhGPI
 Jvb9YgAenFQsrwYVnd9Wt8yoHl63+Gy7kr5VCDY+cWf3ggwq1DdprRM3TU9kmY6zu7r32cUeNTx
 Pi0EOX4z58Jiku38+saSjK/wePPzrY=
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

Tested-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pmdomain/Kconfig                        |   1 +
 drivers/pmdomain/Makefile                       |   1 +
 drivers/pmdomain/spacemit/Kconfig               |  21 ++
 drivers/pmdomain/spacemit/Makefile              |   1 +
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 431 ++++++++++++++++++++++++
 5 files changed, 455 insertions(+)

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 5341dff669be..20aea5fe94b2 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -14,6 +14,7 @@ source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/riscv/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
+source "drivers/pmdomain/spacemit/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index d7aee13ae571..25238576f8a3 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -12,6 +12,7 @@ obj-y					+= renesas/
 obj-y					+= riscv/
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
index 000000000000..ae87ead9024e
--- /dev/null
+++ b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
@@ -0,0 +1,431 @@
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
+	unsigned int reg_pwr_ctrl;
+	u8 bit_hw_mode;
+	u8 bit_sleep2;
+	u8 bit_sleep1;
+	u8 bit_isolation;
+	u8 bit_auto_pwr_on;
+	u8 bit_hw_pwr_stat;
+	u8 bit_pwr_stat;
+	bool use_hw;
+	unsigned int flags;
+	const char *name;
+};
+
+struct spacemit_pm_domain {
+	struct generic_pm_domain genpd;
+	struct spacemit_pmu *pmu;
+	int pm_index;
+	const struct spacemit_pm_domain_param *param;
+};
+
+struct spacemit_pmu {
+	struct device *dev;
+	struct regmap *regmap;
+	struct genpd_onecell_data genpd_data;
+	struct generic_pm_domain *domains[];
+};
+
+struct spacemit_pm_aux_data {
+	int num_domains;
+	const struct spacemit_pm_domain_param *param;
+};
+
+#define to_spacemit_pd(gpd) container_of(gpd, struct spacemit_pm_domain, genpd)
+
+static int spacemit_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *pd = to_spacemit_pd(domain);
+	struct spacemit_pmu *pmu = pd->pmu;
+	const struct spacemit_pm_domain_param *p = pd->param;
+	unsigned int val;
+	int ret;
+
+	if (!pd->param->use_hw) {
+		regmap_clear_bits(pmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_isolation));
+		fsleep(15);
+
+		val = BIT(p->bit_sleep1) | BIT(p->bit_sleep2);
+		regmap_clear_bits(pmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(pmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	} else {
+		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
+		regmap_clear_bits(pmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(pmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       !(val & BIT(p->bit_hw_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (ret) {
+		dev_err(&domain->dev, "failed to power off domain %s: %d\n",
+			p->name, pd->pm_index);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int spacemit_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct spacemit_pm_domain *pd = to_spacemit_pd(domain);
+	struct spacemit_pmu *pmu = pd->pmu;
+	const struct spacemit_pm_domain_param *p = pd->param;
+	unsigned int val;
+	int ret = 0;
+
+	if (!p->use_hw) {
+		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_sleep1));
+		fsleep(20);
+
+		val = BIT(p->bit_sleep2) | BIT(p->bit_sleep1);
+		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(20);
+
+		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_isolation));
+		fsleep(15);
+
+		ret = regmap_read_poll_timeout(pmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       (val & BIT(p->bit_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	} else {
+		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
+		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, val);
+		fsleep(300);
+
+		ret = regmap_read_poll_timeout(pmu->regmap,
+					       APMU_POWER_STATUS_REG,
+					       val,
+					       (val & BIT(p->bit_hw_pwr_stat)),
+					       5,
+					       APMU_POWER_TIMEOUT_US);
+	}
+
+	if (ret < 0) {
+		dev_err(&domain->dev, "failed to power on domain %s: %d\n",
+			p->name, pd->pm_index);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static bool spacemit_pm_is_off_state(struct spacemit_pmu *pmu,
+				     struct spacemit_pm_domain *pd)
+{
+	const struct spacemit_pm_domain_param *p = pd->param;
+	u32 reg = 0, bit;
+
+	regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);
+
+	bit = p->use_hw ? BIT(p->bit_hw_pwr_stat) : BIT(p->bit_pwr_stat);
+
+	return (reg & bit) ? false : true;
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
+	pd->pmu             = pmu;
+	pd->genpd.name      = param->name;
+	pd->genpd.flags     = param->flags;
+	pd->genpd.power_off = spacemit_pd_power_off;
+	pd->genpd.power_on  = spacemit_pd_power_on;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, spacemit_pm_is_off_state(pmu, pd));
+	if (ret)
+		return ret;
+
+	pmu->domains[id] = &pd->genpd;
+
+	return 0;
+}
+
+static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
+{
+	struct spacemit_pm_domain *pd;
+	int i, ret;
+
+	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
+		if (!pmu->domains[i])
+			continue;
+
+		pd = to_spacemit_pd(pmu->domains[i]);
+		ret = pm_genpd_remove(pmu->domains[i]);
+		if (ret)
+			dev_err(pmu->dev, "failed to remove domain %s: %d - state may be inconsistent\n",
+				pd->param->name, ret);
+	}
+}
+
+static int spacemit_pm_domain_probe(struct auxiliary_device *adev,
+				    const struct auxiliary_device_id *id)
+{
+	struct spacemit_ccu_adev *spdev = to_spacemit_ccu_adev(adev);
+	const struct spacemit_pm_domain_param *p;
+	const struct spacemit_pm_aux_data *data;
+	struct device *dev = &adev->dev;
+	struct spacemit_pmu *pmu;
+	int err, i;
+
+	data = (const struct spacemit_pm_aux_data *)id->driver_data;
+
+	pmu = devm_kzalloc(dev,
+			   struct_size(pmu, domains, data->num_domains),
+			   GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	auxiliary_set_drvdata(adev, pmu);
+
+	pmu->dev = dev;
+	pmu->regmap = spdev->regmap;
+	pmu->genpd_data.num_domains = data->num_domains;
+	pmu->genpd_data.domains     = pmu->domains;
+
+	for (i = 0; i < data->num_domains; i++) {
+		p = &data->param[i];
+		err = spacemit_pm_add_one_domain(pmu, i, p);
+		if (err) {
+			dev_err(dev, "failed to add domain %s: %d\n", p->name, err);
+			goto err_out;
+		}
+	}
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
+static void spacemit_pm_domain_remove(struct auxiliary_device *adev)
+{
+	struct spacemit_pmu *pmu = auxiliary_get_drvdata(adev);
+	struct device *dev = &adev->dev;
+
+	of_genpd_del_provider(dev->of_node);
+	spacemit_pm_domain_cleanup(pmu);
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+		.use_hw			= true,
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
+	.remove         = spacemit_pm_domain_remove,
+	.id_table       = spacemit_pm_domain_ids,
+};
+module_auxiliary_driver(spacemit_pm_domain_driver);
+
+MODULE_DESCRIPTION("SpacemiT Generic Power Domains driver");
+MODULE_LICENSE("GPL");

-- 
2.56.0

