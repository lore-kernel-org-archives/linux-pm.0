Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832685;
	b=cBdgBDqQ3ef2xPK+9iLqAXJaf2pYi7A8Iv6JJP7TLWuWgd+CHohwFRcLBxNVopDxSNDI
	 z7SrJqeZRO2XWDFrsoAl2JMpZsWPiTDA3N/pFh6KwCGtJ+xP0vR6AvFR004o7z9pXlR8d
	 q8amxrRCAMI4nKsTaKfhajaoPOi1CeaUWw0hQ52k1/sCKZ5WhvlPHT9CpvfSc9XxJSu4G
	 rgw0uqHO54WnAVF6gnA5poPTZ3Ak2qALMyyL7K82R5DoNyb4YOLq8iof8oKPbGMHJ/rI5
	 /lSZlMl1vUq6yjiUu8wECX3JRDws9HtM5e/BfaMRVgcmuUl/e7gTqP1ElkzKIbsOgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=i+9ofENAzHEsTKb46GBTQBZKrmokj6ryzMIxvWntrdI=;
	b=Zp5/jEiudj27GUyurPNjkSr84mKzhB+ChEk7K6Z4loT7hdRUTvMhbTDdRvPJcOONQizo
	 hcdIopSISH/5Cv1ImjfYpNM6a9rvl5AQuzGNIe/1s5hntcmIkjlYsGUSJExPz/0uTI6IV
	 dKe5dbkLrzpoBrTX7P79y3yQfALKHyXUKKVIb0ZURhrSa9zFOWRl9qk67sq9erx1ULL4m
	 bASN7kHbVphcpkum7c2LE+OZcV9DWlfZpPvA3fdpHcU+0JMn4JnYg4dvnA1TGB7tFcVFg
	 Ng+n9KdQM+6A+FI5IW9nFOtF4cVZH5WlYprEUEQ8nH7ENM91uUFFOQSgRswQZ6E9A5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUgQAbCs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB0606A32C
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUgQAbCs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F41F000C1;
	Wed,  4 Nov 2026 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832684;
	bh=i+9ofENAzHEsTKb46GBTQBZKrmokj6ryzMIxvWntrdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iUgQAbCseXvUslL9aUjxNusRRb9qaHhAn62nHYLteQ90a7wc0q2TAfBdMtJ0LbBIi
	 1x1Xh88wGHafD4S2KUqyskf3te59HZlPFZoOwWgGPyFO9XXf6EsyUyRxb+7WrCW1be
	 oTT5Iv7GDXzOIqfIgItIS/M2XwuV6RLqL5U4iafW+QvgiIlUAgSJynd7LOlfU3umWd
	 sy8EMBL1v2AZRExGUsomwVEho+bOS1PYnN4ujcNW1EtH5qVsu7m+iO1ZvD88unHlk/
	 BO+dupzqk4EB3NAUWfUzi/43YnoCL4Nssv6rtkq0Xizl83l4t2etUjRiMdGDH4Oy05
	 nkrgFXx5BTD0A==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 04 Nov 2026 23:51:19 +0100
Subject: [PATCH 2/2] pmdomain: st: ux500: Control DB8500 EPODs
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
Message-Id: <20261104-b4-ux500-pd-genpd-v7-5-v1-2-4b4f256f340d@kernel.org>
References: <20261104-b4-ux500-pd-genpd-v7-5-v1-0-4b4f256f340d@kernel.org>
In-Reply-To: <20261104-b4-ux500-pd-genpd-v7-5-v1-0-4b4f256f340d@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Move the DB8500 EPOD state handling into the Ux500 power-domain driver.

Only domains backed by hardware EPODs issue PRCMU requests. Voltage
domains without an EPOD remain bookkeeping-only domains.

Do not carry over the unused RAM-retention regulator bookkeeping. The old
retention regulators have no consumers and retention is not modeled by this
series.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/mach-ux500/Kconfig               |   2 +-
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 294 +++++++++++++++++++-----------
 2 files changed, 192 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c18def269137..0818e1f63221 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,10 +26,10 @@ menuconfig ARCH_U8500
 	select PL310_ERRATA_753970 if CACHE_L2X0
 	select PM_GENERIC_DOMAINS if PM
 	select REGULATOR
-	select REGULATOR_DB8500_PRCMU
 	select REGULATOR_FIXED_VOLTAGE
 	select SOC_BUS
 	select RESET_CONTROLLER
+	select UX500_PM_DOMAIN
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index d90a563cd6f3..48ba0ee26be5 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -7,173 +7,230 @@
  * Implements PM domains using the generic PM domain for ux500.
  */
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mfd/db8500-prcmu.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
 #define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)
+#define UX500_NO_EPOD		(-1)
+
+/**
+ * struct dbx500_powerdomain_info - dbx500 power domain information
+ * @genpd: generic power domain
+ * @epod_id: hardware EPOD ID, or UX500_NO_EPOD for a voltage domain
+ */
+struct dbx500_powerdomain_info {
+	struct generic_pm_domain genpd;
+	int epod_id;
+};
 
 static int pd_power_off(struct generic_pm_domain *domain)
 {
-	/*
-	 * Handle the gating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
-	return 0;
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+
+	if (info->epod_id == UX500_NO_EPOD)
+		return 0;
+
+	return db8500_prcmu_set_epod(info->epod_id, EPOD_STATE_OFF);
 }
 
 static int pd_power_on(struct generic_pm_domain *domain)
 {
-	/*
-	 * Handle the ungating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
-	return 0;
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+
+	if (info->epod_id == UX500_NO_EPOD)
+		return 0;
+
+	return db8500_prcmu_set_epod(info->epod_id, EPOD_STATE_ON);
 }
 
 /*
  * Apart from these voltage domains there is also VSAFE which is always
  * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
  */
-static struct generic_pm_domain ux500_pm_domain_vape = {
+static struct dbx500_powerdomain_info ux500_pm_domain_vape = {
 	/* Vape_pwr */
-	.name = "VAPE",  /* 0.95 .. 1.20 V */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "VAPE",  /* 0.95 .. 1.20 V */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_varm = {
-	.name = "VARM",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_varm = {
+	.genpd = {
+		.name = "VARM",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vmodem = {
-	.name = "VMODEM",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vmodem = {
+	.genpd = {
+		.name = "VMODEM",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vpll = {
-	.name = "VPLL", /* 1.8 V */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vpll = {
+	.genpd = {
+		.name = "VPLL", /* 1.8 V */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
 /*
  * CHECKME: as these are used directly by peripherals as regulators,
  * perhaps they should stay in the regulator subsystem?
  */
-static struct generic_pm_domain ux500_pm_domain_vsmps1 = {
-	.name = "VSMPS1", /* Also called VIO (1.2V) */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps1 = {
+	.genpd = {
+		.name = "VSMPS1", /* Also called VIO (1.2V) */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vsmps2 = {
-	.name = "VSMPS2", /* Also called VIO (1.8V) */
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps2 = {
+	.genpd = {
+		.name = "VSMPS2", /* Also called VIO (1.8V) */
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vsmps3 = {
-	.name = "VSMPS3",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vsmps3 = {
+	.genpd = {
+		.name = "VSMPS3",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
-static struct generic_pm_domain ux500_pm_domain_vrf1 = {
-	.name = "VRF1",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+static struct dbx500_powerdomain_info ux500_pm_domain_vrf1 = {
+	.genpd = {
+		.name = "VRF1",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = UX500_NO_EPOD,
 };
 
 /* The following are technically children of VAPE */
-static struct generic_pm_domain ux500_pm_domain_sva_mmdsp = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sva_mmdsp = {
 	/* Vape_SVA_MMDSP_pwr */
-	.name = "SVA_MMDSP",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SVA_MMDSP",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SVAMMDSP,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sva_pipe = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sva_pipe = {
 	/* Vape_SVA_pwr */
-	.name = "SVA_PIPE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SVA_PIPE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SVAPIPE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sia_mmdsp = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sia_mmdsp = {
 	/* Vape_SIA_MMDSP_pwr */
-	.name = "SIA_MMDSP",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SIA_MMDSP",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SIAMMDSP,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sia_pipe = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sia_pipe = {
 	/* Vape_SIA_pwr */
-	.name = "SIA_PIPE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SIA_PIPE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SIAPIPE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_sga = {
+static struct dbx500_powerdomain_info ux500_pm_domain_sga = {
 	/* Vape_SGA_pwr */
-	.name = "SGA",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "SGA",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_SGA,
 };
 
-static struct generic_pm_domain ux500_pm_domain_b2r2_mcde = {
+static struct dbx500_powerdomain_info ux500_pm_domain_b2r2_mcde = {
 	/* Vape_DSS_pwr DSS (display subsystem) */
-	.name = "B2R2_MCDE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "B2R2_MCDE",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_B2R2_MCDE,
 };
 
-static struct generic_pm_domain ux500_pm_domain_esram_12 = {
+static struct dbx500_powerdomain_info ux500_pm_domain_esram_12 = {
 	/* Vape_esram1_pwr, Vape_esram2_pwr */
-	.name = "ESRAM_12",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "ESRAM_12",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_ESRAM12,
 };
 
-static struct generic_pm_domain ux500_pm_domain_esram_34 = {
+static struct dbx500_powerdomain_info ux500_pm_domain_esram_34 = {
 	/* Vape_esram3_pwr, Vape_esram4_pwr */
-	.name = "ESRAM_34",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.genpd = {
+		.name = "ESRAM_34",
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+	},
+	.epod_id = EPOD_ID_ESRAM34,
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
-	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
-	[DOMAIN_VARM] = &ux500_pm_domain_varm,
-	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem,
-	[DOMAIN_VPLL] = &ux500_pm_domain_vpll,
-	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1,
-	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2,
-	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3,
-	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1,
-	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp,
-	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe,
-	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp,
-	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe,
-	[DOMAIN_SGA] = &ux500_pm_domain_sga,
-	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde,
-	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12,
-	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34,
+	[DOMAIN_VAPE] = &ux500_pm_domain_vape.genpd,
+	[DOMAIN_VARM] = &ux500_pm_domain_varm.genpd,
+	[DOMAIN_VMODEM] = &ux500_pm_domain_vmodem.genpd,
+	[DOMAIN_VPLL] = &ux500_pm_domain_vpll.genpd,
+	[DOMAIN_VSMPS1] = &ux500_pm_domain_vsmps1.genpd,
+	[DOMAIN_VSMPS2] = &ux500_pm_domain_vsmps2.genpd,
+	[DOMAIN_VSMPS3] = &ux500_pm_domain_vsmps3.genpd,
+	[DOMAIN_VRF1] = &ux500_pm_domain_vrf1.genpd,
+	[DOMAIN_SVA_MMDSP] = &ux500_pm_domain_sva_mmdsp.genpd,
+	[DOMAIN_SVA_PIPE] = &ux500_pm_domain_sva_pipe.genpd,
+	[DOMAIN_SIA_MMDSP] = &ux500_pm_domain_sia_mmdsp.genpd,
+	[DOMAIN_SIA_PIPE] = &ux500_pm_domain_sia_pipe.genpd,
+	[DOMAIN_SGA] = &ux500_pm_domain_sga.genpd,
+	[DOMAIN_B2R2_MCDE] = &ux500_pm_domain_b2r2_mcde.genpd,
+	[DOMAIN_ESRAM_12] = &ux500_pm_domain_esram_12.genpd,
+	[DOMAIN_ESRAM_34] = &ux500_pm_domain_esram_34.genpd,
 };
 
 static const struct of_device_id ux500_pm_domain_matches[] = {
@@ -186,11 +243,12 @@ static int ux500_pm_domains_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct genpd_onecell_data *genpd_data;
 	int i;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
 
-	genpd_data = kzalloc_obj(*genpd_data);
+	genpd_data = devm_kzalloc(&pdev->dev, sizeof(*genpd_data), GFP_KERNEL);
 	if (!genpd_data)
 		return -ENOMEM;
 
@@ -198,14 +256,44 @@ static int ux500_pm_domains_probe(struct platform_device *pdev)
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
 
 	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
-		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+		pm_genpd_init(ux500_pm_domains[i], NULL, true);
+
+	ret = of_genpd_add_provider_onecell(np, genpd_data);
+	if (ret)
+		goto remove_genpds;
+
+	ret = of_genpd_add_child_ids(np, genpd_data);
+	if (ret < 0)
+		goto del_provider;
+
+	platform_set_drvdata(pdev, genpd_data);
 
-	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
+
+del_provider:
+	of_genpd_del_provider(np);
+remove_genpds:
+	while (i--)
+		pm_genpd_remove(ux500_pm_domains[i]);
+
+	return ret;
+}
+
+static void ux500_pm_domains_remove(struct platform_device *pdev)
+{
+	struct genpd_onecell_data *genpd_data = platform_get_drvdata(pdev);
+	int i;
+
+	of_genpd_remove_child_ids(pdev->dev.of_node, genpd_data);
+	of_genpd_del_provider(pdev->dev.of_node);
+
+	for (i = genpd_data->num_domains - 1; i >= 0; i--)
+		pm_genpd_remove(genpd_data->domains[i]);
 }
 
 static struct platform_driver ux500_pm_domains_driver = {
 	.probe  = ux500_pm_domains_probe,
+	.remove = ux500_pm_domains_remove,
 	.driver = {
 		.name = "ux500_pm_domains",
 		.of_match_table = ux500_pm_domain_matches,

-- 
2.56.0

