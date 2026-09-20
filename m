Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4159486639;
	Sun, 20 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944548; cv=none; b=j1Klcn/+kxOvBzIdkPnN20jWOOhIqp0tT1Xe1xXjQC+xl4trF6raXNDv2h5nnODGXKQt0mII3QTFiNSQrTfqKZk0x6Uo0YZ2XBel2sv5UMYHyVraAAKHJgqmBpl+9eRRyC8nLeS+qwYavh3N1r1qSwSbPIbhVEqYP+qLxhBVM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944548; c=relaxed/simple;
	bh=9ESZC2kAiIQ34d9RGOlJO31tspF69xxIkSrfZ5ZpUoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irfeK5Uh7KrwMEN4pnXQOHXcbKy5YOQHeFuX4gf3ywMLs21QzqE9Uut6qSTJ4I+jqMUobu2/H2g7qVTZLUxilNzjAl3+gUyu7qIHnC5AAGwVxM6bhiiosaHNg44Ejb0Agur5S4Ov5L8KqZfc3rf3Av96NSe1mefUSo0/Lrnuf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTIehBHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTIehBHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054201F000FF;
	Sun, 20 Sep 2026 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944546;
	bh=kcHEEuxa8gkPmRZrK0Eoct63x6eoW301jlgZRtUKdPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OTIehBHvHDcjY7d3hGYLlQtOFpu2l3HavymxseF36BG742iId+XTGXfeyJxCxhW3w
	 r6u2ybzXJbO1W4xFMoO6m5NwvvtPYo27fb/E5PJq1vJtt4Pnym1VH/aC6AppGb3nnF
	 16pYJFD0Ee653Tkm5yBLvOLKqScyOvHF1CB9F6GzKK/xsNsS7jC3K87aCyaw6wt/8N
	 aRd4cNyVJAitD+5YUWRUIxmLFWwUB/rnXbRe4WBvciCl/Qtx1kprcXt+gmtMG1D0Vf
	 lrTpLMhJ1G7RAgCCZ8A4XqupKbY6kwHsFmNcF51Vj9/I36iULnUBqVs1O9fzXl4S9e
	 +NlOacl3pfnrw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:18 +0200
Subject: [PATCH v3 12/18] pmdomain: st: ux500: Control DB8500 EPODs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Move the DB8500 EPOD state handling into the Ux500 power-domain driver.

Keep the old regulator driver mutually exclusive with the pmdomain driver.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/mach-ux500/Kconfig               |   2 +-
 drivers/pmdomain/st/ste-ux500-pm-domain.c | 355 +++++++++++++++++++++---------
 drivers/regulator/Kconfig                 |   1 +
 3 files changed, 254 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c18def269137..56636c993f49 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,7 +26,7 @@ menuconfig ARCH_U8500
 	select PL310_ERRATA_753970 if CACHE_L2X0
 	select PM_GENERIC_DOMAINS if PM
 	select REGULATOR
-	select REGULATOR_DB8500_PRCMU
+	select UX500_PM_DOMAIN
 	select REGULATOR_FIXED_VOLTAGE
 	select SOC_BUS
 	select RESET_CONTROLLER
diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index d90a563cd6f3..b31a36a4acd1 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -6,174 +6,292 @@
  *
  * Implements PM domains using the generic PM domain for ux500.
  */
+#include <linux/cleanup.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mfd/db8500-prcmu.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
 #define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)
+#define UX500_EPOD_NONE		NUM_EPOD_ID
 
-static int pd_power_off(struct generic_pm_domain *domain)
+/**
+ * struct dbx500_powerdomain_info - dbx500 power domain information
+ * @genpd: generic power domain
+ * @epod_id: id for EPOD (power domain)
+ * @is_ramret: RAM retention switch for EPOD (power domain)
+ */
+struct dbx500_powerdomain_info {
+	struct generic_pm_domain genpd;
+	u16 epod_id;
+	bool is_ramret;
+};
+
+static DEFINE_MUTEX(ux500_pd_lock);
+static bool epod_on[NUM_EPOD_ID];
+static bool epod_ramret[NUM_EPOD_ID];
+
+static int enable_epod(u16 epod_id, bool ramret)
 {
-	/*
-	 * Handle the gating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
+	int ret;
+
+	if (ramret) {
+		if (!epod_on[epod_id]) {
+			ret = db8500_prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
+			if (ret < 0)
+				return ret;
+		}
+		epod_ramret[epod_id] = true;
+	} else {
+		ret = db8500_prcmu_set_epod(epod_id, EPOD_STATE_ON);
+		if (ret < 0)
+			return ret;
+		epod_on[epod_id] = true;
+	}
+
 	return 0;
 }
 
-static int pd_power_on(struct generic_pm_domain *domain)
+static int disable_epod(u16 epod_id, bool ramret)
 {
-	/*
-	 * Handle the ungating of the PM domain regulator here.
-	 *
-	 * Drivers/subsystems handling devices in the PM domain needs to perform
-	 * register context save/restore from their respective runtime PM
-	 * callbacks, to be able to enable PM domain gating/ungating.
-	 */
+	int ret;
+
+	if (ramret) {
+		if (!epod_on[epod_id]) {
+			ret = db8500_prcmu_set_epod(epod_id, EPOD_STATE_OFF);
+			if (ret < 0)
+				return ret;
+		}
+		epod_ramret[epod_id] = false;
+	} else {
+		if (epod_ramret[epod_id]) {
+			ret = db8500_prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = db8500_prcmu_set_epod(epod_id, EPOD_STATE_OFF);
+			if (ret < 0)
+				return ret;
+		}
+		epod_on[epod_id] = false;
+	}
+
 	return 0;
 }
 
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+	int ret = 0;
+
+	guard(mutex)(&ux500_pd_lock);
+	if (info->epod_id < NUM_EPOD_ID)
+		ret = disable_epod(info->epod_id, info->is_ramret);
+
+	return ret;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	struct dbx500_powerdomain_info *info =
+		container_of(domain, struct dbx500_powerdomain_info, genpd);
+	int ret = 0;
+
+	guard(mutex)(&ux500_pd_lock);
+	if (info->epod_id < NUM_EPOD_ID)
+		ret = enable_epod(info->epod_id, info->is_ramret);
+
+	return ret;
+}
+
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
+	.epod_id = UX500_EPOD_NONE,
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
@@ -186,11 +304,12 @@ static int ux500_pm_domains_probe(struct platform_device *pdev)
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
 
@@ -198,14 +317,44 @@ static int ux500_pm_domains_probe(struct platform_device *pdev)
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
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 89789ac7a786..851e1a8fc22f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -414,6 +414,7 @@ config REGULATOR_DBX500_PRCMU
 config REGULATOR_DB8500_PRCMU
 	bool "ST-Ericsson DB8500 Voltage Domain Regulators"
 	depends on MFD_DB8500_PRCMU
+	depends on !UX500_PM_DOMAIN
 	select REGULATOR_DBX500_PRCMU
 	help
 	  This driver supports the voltage domain regulators controlled by the

-- 
2.55.0

