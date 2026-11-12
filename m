Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470489;
	b=Gd1hiy2gQ/eGoSH0X4Q1YEwU58DTwFjy0zdAN8kFh9zBkhAsSIjodqrCnYwQhIeJhSug
	 YZfV29H2PKzrjtX9R5N9bRZY1TIQ2B5uvocgooNdlSEdsMU8aAnKdzZ8e9Uao8rRUDNj7
	 Na/F7JVxcs5V58qLqsCeJGd9w2iyxzUR98HDRIVPpNUuq0jg7y42LDUx4zG+2JJaySHnb
	 /edsDAF5bAtue68ICv7egBBXn9Q3b34uHAr10kFLV5nfId67b1imyYq5kPfq7ZwGT75Va
	 93y6v9Pm9KqNHzqeIgFndZNt5tzfn0c8oax/mXRW2t9D6Ajm8o36nFF4V9Aa/ueEZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470489;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qHgeoSf9WrMcSZDv9tgIKMaQF4nPDBzl46aeP6wToXs=;
	b=u7SIm09/11YuzTwfvArCy8wReuVw/i9UFxtuZLmVxGB9ERUkLJHeLCMMbqR4shKGV84G
	 Tj9GsKklxiQrb4EhCCjGMoVvYAyEWpFiirMpYKRD+IbvjFXf/yf5F1KyrpSXtypKlBoVc
	 G2fZm9G2Z3uKJUl3AqK9VG2MEAtEsh9HY6a/Yd8m5n2YYJuWTnAJPkbiUNkXTEXVTiphy
	 ewF/duGpQxM4V9a0Qc71YvR6hTBOUAsraqZWh1JAlkVdnODz0tVzpzoIPCHx+06cUHdix
	 MnNXuJd+6zOYUaSsZqUB6GyRgcRVLtnM1+cUxL77aLBMm32obDd/wd4vI7qNVOysJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFfe51m6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2B606A321;
	Thu, 12 Nov 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFfe51m6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75C21F00A05;
	Thu, 12 Nov 2026 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470488;
	bh=qHgeoSf9WrMcSZDv9tgIKMaQF4nPDBzl46aeP6wToXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BFfe51m6dCWOi+yxzf9PNDC6w9Kq30W8TNv7R98fCswCXMQ2Tc3X5u/mwlEce5aYB
	 NCGafC7UR/5fpiJrmXpwxNv5UwbLJquop1ERXRZB1SdXMLgVlLg0O/RVirIosd6cuf
	 pcFGvkRrvrtiQbmD8+t8XlfpN4jmrO22580ukn0jKll0B5BqSOZCjbfeUXuBMPQDzp
	 AukRKte+mHbgWVlBquwz7jr54UDIF8RKwAbjLPh0NFogfmrh5JBbxmSk0iNIsoq7BQ
	 uaXfOdrfXEWmyHBuds+/EN7sfNkTPPz61UlbAPX21S5WC4ZdX+mVgZAkeRxswNjiGe
	 4k2IgCqPsFYgQ==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 12 Nov 2026 08:00:57 +0000
Subject: [PATCH v4 2/2] pmdomain: spacemit: Add power domain driver
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
Message-Id: <20261112-04-k3-pm-support-v4-2-de3931aa5153@kernel.org>
References: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
In-Reply-To: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14488; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Omk7jHeQz5s4BEG7rQbr0lYThaX7AsiQQ2TOVrOYjnY=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9XJIHIqscR32ityk7ZlIlmG99AiAFspJM+6yv
 RBzYiJYh0OJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavVySBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1FEhAAjXNMryRJToN9mqPw7CUNBjgJu/UXUnXP/PFbeiZiQJvHIghkwG2We
 D0CRtMjb7ADSX1dH3+KWtUqx1YUGqYNhiX/Ycd6htDrG3bP82nmuDYKs/hLuGcsJStux2iiNERz
 V5RQ0781AZNRIGlyQ5JqgH70GAHQKQuH4DoOTRQHFY1HcuGufbQWhrhMsK/ahpefBIgLjGtnUYh
 Id+2VOZ2IC18slVKl+edlt01D4uoxlD7AwaRjxdSj/hp1WTt0G1BuqW9MvBnBlc6p2tbUMCGwGF
 aXHD/vNpUoOSbkfofSGo2dLDiahVZVzHMr5a/Enn88vES5mwvu8BKzUQaV4AwIQKLjOcd5Nf2uv
 7f5n4uA3KunzFzbf/iN349p1Z1cpmeRWtuSjKJ2K8sZdzNwUKP5AtI8Wf7SySh5VO6znoTjE8mS
 M/cGDGlOlzboQmm3iXdLI6S3LihFHp8pr8LSsIgmj3UZlvNfI2xqk9jSmRh2ZwLLp8vOfAgIpUM
 DbfFUh1eivak6j2oAjqgZmRtR4TewNrCj/sc1jjdaaN8HRq/G3xsHz9XdzYnmZHmakjbfxJ/jpN
 YjMepSaSAuwLJF3iGPxamQLpM9u2ggVkZrtMvLx6RntTojS0FXZKMYAkUxnOIVwiNEtWMoBEfr/
 zA0aiqBScjpSUcSkaqRnbiJKwbe7XY=
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
Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pmdomain/Kconfig                        |   1 +
 drivers/pmdomain/Makefile                       |   1 +
 drivers/pmdomain/spacemit/Kconfig               |  21 ++
 drivers/pmdomain/spacemit/Makefile              |   1 +
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 424 ++++++++++++++++++++++++
 5 files changed, 448 insertions(+)

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
index 000000000000..8e2808e92be3
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
+	  Say Y or M to enable device power management through PM domains.
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
index 000000000000..dd0613c1912a
--- /dev/null
+++ b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit Generic power domain support.
+ *
+ * Copyright (c) 2026 SpacemiT Technology Co. Ltd
+ */
+
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
+	if (ret)
+		dev_err(&domain->dev, "failed to power off domain %s: %d\n",
+			p->name, pd->pm_index);
+
+	return ret;
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
+	if (ret)
+		dev_err(&domain->dev, "failed to power on domain %s: %d\n",
+			p->name, pd->pm_index);
+
+	return ret;
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
+	return !(reg & bit);
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

