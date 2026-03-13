Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0F3C3BED;
	Fri, 13 Mar 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428020; cv=none; b=EdOISzE8GuaMtxLljZlix+jxtWadSS655YYg81Xy1UfvKPOpjT3pGqrOIuMkj5/Jz3+ybG9AfLYm4zPXMDRT0850J5xDOe8P0KdqXr4B6YR83OmABoezrVe1mLGstubn/OgTIfe3JelzsMtHD1IeijH2c0PZXcZcDXcb7TZI74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428020; c=relaxed/simple;
	bh=H3Sgq1OvWbRgl5QkV0cCWTNXn79wzXPW8Hz1WP7/QWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFzkimrfQLzMcZc9F3i3HrlCA6/+oL+p0H1PZHoEhhnlcU4H57iui+dOKHZz/dr5YnDUGI7AIfrMdfWnPwR5d7qvlHPZROZ5Il35WqfQ/VJO829JuIiFyeRCz3ODfuOxwkm383kMap2vbPk7/1g+r7ElI5RxKtHJDGmM3DSz0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUvosGzv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUvosGzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428019; x=1804964019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3Sgq1OvWbRgl5QkV0cCWTNXn79wzXPW8Hz1WP7/QWQ=;
  b=UUvosGzvcYHbb+IBvwlxmkYXQYi6EHvqxJpNH3fy/BLLNHt/rA97x7VW
   4EAo8nUOA1vp3z5x6jU1p56vMOaJ13UjTi2rquFoenqYjvKXOuWMsPL0t
   +S09HfFKhqIaKh1z6LHZO+O82niSBXT0OkwZdO9abCtwCFiwnCG2QTe+M
   /zMayCjPLIuJbQpsd8dwId4GYvXbeuD7KogqbXHY4tlTas/Bck2UVIGvr
   FzRyQyGJricskrK6cXMaYy5m/wgwaAROfc1PhSZ2WpCHzHpRqxcnBqsDF
   b32lP9XbCURkqIIeMDmTpwuYbzf4nPDYI2Cz3+i5MjIrS4w0/nQudwAak
   w==;
X-CSE-ConnectionGUID: vjp4ma4VSLG/zxzbMDDXdQ==
X-CSE-MsgGUID: 8nCoHAc+QOu2O+sK33rfaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242261"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242261"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: GK7rubpIRtmrqjtTgeBy9w==
X-CSE-MsgGUID: iavHfFBkTk+4ky1Fn/UR4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709184"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] thermal: intel: int340x: processor: Move MMIO primitives to MMIO driver
Date: Fri, 13 Mar 2026 11:53:31 -0700
Message-ID: <20260313185333.2370733-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MMIO-specific primitives differ from those used by the TPMI interface.
The MSR and MMIO interfaces shared the same primitives in the common
driver, but MMIO does not require many MSR-specific entries (like PSYS).
Keeping these in the common driver does not add any value and requires
interface-specific handling logic that makes the common layer
unnecessarily complex.

Move the MMIO primitive definitions and associated bitmasks into the
MMIO interface driver. This change includes:

 1. Add MMIO-local struct rapl_primitive_info instance without
    MSR-specific entries and assign it to priv->rpi during MMIO
    initialization.
 2. Remove the RAPL MMIO case from rapl_config() in the common driver.

No functional changes are intended.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c          |  1 -
 .../int340x_thermal/processor_thermal_rapl.c  | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 545b811fa930..ffa3f95d8aa2 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -670,7 +670,6 @@ static int rapl_config(struct rapl_package *rp)
 {
 	switch (rp->priv->type) {
 	/* MMIO I/F shares the same register layout as MSR registers */
-	case RAPL_IF_MMIO:
 	case RAPL_IF_MSR:
 		rp->priv->rpi = rpi_msr;
 		break;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 5dbeb0a43c8c..f8b9745c1b8a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -11,6 +11,77 @@
 
 static struct rapl_if_priv rapl_mmio_priv;
 
+/* bitmasks for RAPL MSRs, used by primitive access functions */
+#define MMIO_ENERGY_STATUS_MASK			GENMASK(31, 0)
+
+#define MMIO_POWER_LIMIT1_MASK			GENMASK(14, 0)
+#define MMIO_POWER_LIMIT1_ENABLE		BIT(15)
+#define MMIO_POWER_LIMIT1_CLAMP			BIT(16)
+
+#define MMIO_POWER_LIMIT2_MASK			GENMASK_ULL(46, 32)
+#define MMIO_POWER_LIMIT2_ENABLE		BIT_ULL(47)
+#define MMIO_POWER_LIMIT2_CLAMP			BIT_ULL(48)
+
+#define MMIO_POWER_LOW_LOCK			BIT(31)
+#define MMIO_POWER_HIGH_LOCK			BIT_ULL(63)
+
+#define MMIO_POWER_LIMIT4_MASK			GENMASK(12, 0)
+
+#define MMIO_TIME_WINDOW1_MASK			GENMASK_ULL(23, 17)
+#define MMIO_TIME_WINDOW2_MASK			GENMASK_ULL(55, 49)
+
+#define MMIO_POWER_INFO_MAX_MASK		GENMASK_ULL(46, 32)
+#define MMIO_POWER_INFO_MIN_MASK		GENMASK_ULL(30, 16)
+#define MMIO_POWER_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(53, 48)
+#define MMIO_POWER_INFO_THERMAL_SPEC_MASK	GENMASK(14, 0)
+
+#define MMIO_PERF_STATUS_THROTTLE_TIME_MASK	GENMASK(31, 0)
+#define MMIO_PP_POLICY_MASK			GENMASK(4, 0)
+
+/* RAPL primitives for MMIO I/F */
+static struct rapl_primitive_info rpi_mmio[NR_RAPL_PRIMITIVES] = {
+	/* name, mask, shift, msr index, unit divisor */
+	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, MMIO_POWER_LIMIT1_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, MMIO_POWER_LIMIT2_MASK, 32,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, MMIO_POWER_LIMIT4_MASK, 0,
+						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, MMIO_ENERGY_STATUS_MASK, 0,
+						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[FW_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, MMIO_POWER_LOW_LOCK, 31,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[FW_HIGH_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, MMIO_POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, MMIO_POWER_LIMIT1_ENABLE, 15,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_CLAMP]		= PRIMITIVE_INFO_INIT(PL1_CLAMP, MMIO_POWER_LIMIT1_CLAMP, 16,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, MMIO_POWER_LIMIT2_ENABLE, 47,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_CLAMP]		= PRIMITIVE_INFO_INIT(PL2_CLAMP, MMIO_POWER_LIMIT2_CLAMP, 48,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, MMIO_TIME_WINDOW1_MASK, 17,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, MMIO_TIME_WINDOW2_MASK, 49,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER,
+						      MMIO_POWER_INFO_THERMAL_SPEC_MASK, 0,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, MMIO_POWER_INFO_MAX_MASK, 32,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, MMIO_POWER_INFO_MIN_MASK, 16,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW,
+						      MMIO_POWER_INFO_MAX_TIME_WIN_MASK, 48,
+						      RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME,
+						      MMIO_PERF_STATUS_THROTTLE_TIME_MASK, 0,
+						      RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+	[PRIORITY_LEVEL]	= PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, MMIO_PP_POLICY_MASK, 0,
+						      RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
+};
+
 static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
 	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930, 0x59b0},
@@ -75,6 +146,7 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
 	rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
 	rapl_mmio_priv.defaults = &rapl_defaults_mmio;
+	rapl_mmio_priv.rpi = rpi_mmio;
 
 	rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
 	if (IS_ERR(rapl_mmio_priv.control_type)) {
-- 
2.43.0

