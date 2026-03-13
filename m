Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA13DEAE3;
	Fri, 13 Mar 2026 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428021; cv=none; b=cNzD6cJPegZx4Vt/Scq3FRmCfkQeO/Yag+oQ5jJ3YIyIUssJnfmk/KX9qVayf2obY/ilRi3gXFdXVBJoQRJ0nIKJx81xBUM+pAnAQhZ0kikWuL7lwS+yvF5lFG65zV7UDtzLSUF9TYwiicNzG3Cg3X3zEJ6V6Lxc1a2H2F7mwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428021; c=relaxed/simple;
	bh=j1lmynITs9Fb/kArgJtTO8Nmrgt9jMhqxXelH35G5iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChycmbPl81CAJFfIx+uuNKqbkiw3K4MzAvt0NmAmvtBygGNXP4KvwhK8uB1mWabSQZY5/v2AmPqEm/l2MIgjumKoAyFutXXI1MhjQETvOYKfQ7cygGfbtvF59NrcSie3GHeu5uPB8h3X95lfVTeJNX1RMTi5FmNAtM27i/ZiFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HItxg90n; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HItxg90n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428020; x=1804964020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1lmynITs9Fb/kArgJtTO8Nmrgt9jMhqxXelH35G5iw=;
  b=HItxg90nS/nJ6yVFsbKqK7ypEDrYHRhSX8RcmlYinnhXojKQBiWpZRAl
   hqjngqs1ElWZRfnyKCxqmhYmXQV5qUTykdsY66GaTZKpKlAO62swjBHff
   FiutmiyVtPwiTsl/JNoIPmRQ0fHcHgihqzzM/z5QUOCCHksc7LT7ZELy3
   Jn/YeuG5U9vamAJjBO4G45N4ftrzSu/BEB+5xxVkdotAqJph9bROCKJXj
   aB2D36S6tK+8kAaqD8occIAHT3cRFChPuEGww3PEjbMtVZbM568bfm0r+
   7LcaiCRnYMdgtT/0i2yU2/U+1LsyHEuwd/gzllhRRK3lxwPJQSYWUSkH2
   Q==;
X-CSE-ConnectionGUID: YokVX1XrSOazd5PqsShvvg==
X-CSE-MsgGUID: XYULuKhpRRCY0XlIqKDSlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242265"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: iUUHc19cTOOYofkYoGWxow==
X-CSE-MsgGUID: Gen5jhubTD2R+ryRzEwvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709188"
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
Subject: [PATCH v1 6/6] powercap: intel_rapl: Move MSR primitives to MSR driver
Date: Fri, 13 Mar 2026 11:53:32 -0700
Message-ID: <20260313185333.2370733-7-sathyanarayanan.kuppuswamy@linux.intel.com>
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

MSR-specific RAPL primitives differ from those used by TPMI and MMIO
interfaces. Keeping them in the common driver requires
interface-specific handling logic and makes the common layer
unnecessarily complex.

Move the MSR primitive definitions and associated bitmasks into the
MSR interface driver. This change includes:

 1. Move MSR-specific bitmask definitions to RAPL MSR driver.
 2. Add MSR-local struct rapl_primitive_info instance and assign it to
    priv->rpi during MSR probe.
 3. Remove the primitive assignment logic from rapl_config() in the
    common driver.

No functional changes are intended.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 105 ---------------------------
 drivers/powercap/intel_rapl_msr.c    |  99 +++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 105 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index ffa3f95d8aa2..b2301b30e1ff 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -30,24 +30,8 @@
 #include <asm/intel-family.h>
 #include <asm/msr.h>
 
-/* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK		GENMASK(31, 0)
 
-#define POWER_LIMIT1_MASK		GENMASK(14, 0)
-#define POWER_LIMIT1_ENABLE		BIT(15)
-#define POWER_LIMIT1_CLAMP		BIT(16)
-
-#define POWER_LIMIT2_MASK		GENMASK_ULL(46, 32)
-#define POWER_LIMIT2_ENABLE		BIT_ULL(47)
-#define POWER_LIMIT2_CLAMP		BIT_ULL(48)
-#define POWER_HIGH_LOCK			BIT_ULL(63)
-#define POWER_LOW_LOCK			BIT(31)
-
-#define POWER_LIMIT4_MASK		GENMASK(12, 0)
-
-#define TIME_WINDOW1_MASK		GENMASK_ULL(23, 17)
-#define TIME_WINDOW2_MASK		GENMASK_ULL(55, 49)
-
 #define POWER_UNIT_OFFSET		0x00
 #define POWER_UNIT_MASK			GENMASK(3, 0)
 
@@ -57,28 +41,6 @@
 #define TIME_UNIT_OFFSET		0x10
 #define TIME_UNIT_MASK			GENMASK(19, 16)
 
-#define POWER_INFO_MAX_MASK		GENMASK_ULL(46, 32)
-#define POWER_INFO_MIN_MASK		GENMASK_ULL(30, 16)
-#define POWER_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(53, 48)
-#define POWER_INFO_THERMAL_SPEC_MASK	GENMASK(14, 0)
-
-#define PERF_STATUS_THROTTLE_TIME_MASK	GENMASK(31, 0)
-#define PP_POLICY_MASK			GENMASK(4, 0)
-
-/*
- * SPR has different layout for Psys Domain PowerLimit registers.
- * There are 17 bits of PL1 and PL2 instead of 15 bits.
- * The Enable bits and TimeWindow bits are also shifted as a result.
- */
-#define PSYS_POWER_LIMIT1_MASK		GENMASK_ULL(16, 0)
-#define PSYS_POWER_LIMIT1_ENABLE	BIT(17)
-
-#define PSYS_POWER_LIMIT2_MASK		GENMASK_ULL(48, 32)
-#define PSYS_POWER_LIMIT2_ENABLE	BIT_ULL(49)
-
-#define PSYS_TIME_WINDOW1_MASK		GENMASK_ULL(25, 19)
-#define PSYS_TIME_WINDOW2_MASK		GENMASK_ULL(57, 51)
-
 /* Non HW constants */
 #define RAPL_PRIMITIVE_DUMMY		BIT(2)
 
@@ -598,64 +560,6 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	return div64_u64(value, scale);
 }
 
-/* RAPL primitives for MSR and MMIO I/F */
-static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
-	/* name, mask, shift, msr index, unit divisor */
-	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
-						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
-						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
-						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	[FW_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[FW_HIGH_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL1_CLAMP]		= PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_CLAMP]		= PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
-						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
-						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER,
-						      POWER_INFO_THERMAL_SPEC_MASK, 0,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW,
-						      POWER_INFO_MAX_TIME_WIN_MASK, 48,
-						      RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME,
-						      PERF_STATUS_THROTTLE_TIME_MASK, 0,
-						      RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-	[PRIORITY_LEVEL]	= PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
-						      RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
-	[PSYS_POWER_LIMIT1]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
-						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[PSYS_POWER_LIMIT2]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK,
-						      32, RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[PSYS_PL1_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE,
-						      17, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
-						      0),
-	[PSYS_PL2_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE,
-						      49, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
-						      0),
-	[PSYS_TIME_WINDOW1]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK,
-						      19, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[PSYS_TIME_WINDOW2]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK,
-						      51, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-};
-
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 {
 	struct rapl_primitive_info *rpi = rp->priv->rpi;
@@ -668,15 +572,6 @@ static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 
 static int rapl_config(struct rapl_package *rp)
 {
-	switch (rp->priv->type) {
-	/* MMIO I/F shares the same register layout as MSR registers */
-	case RAPL_IF_MSR:
-		rp->priv->rpi = rpi_msr;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	/* defaults_msr can be NULL on unsupported platforms */
 	if (!rp->priv->defaults || !rp->priv->rpi)
 		return -ENODEV;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index b7c10ed75d69..cfb35973f0b5 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -44,6 +44,46 @@
 #define TIME_UNIT_OFFSET		0x10
 #define TIME_UNIT_MASK			GENMASK(19, 16)
 
+/* bitmasks for RAPL MSRs, used by primitive access functions */
+#define ENERGY_STATUS_MASK		GENMASK(31, 0)
+
+#define POWER_LIMIT1_MASK		GENMASK(14, 0)
+#define POWER_LIMIT1_ENABLE		BIT(15)
+#define POWER_LIMIT1_CLAMP		BIT(16)
+
+#define POWER_LIMIT2_MASK		GENMASK_ULL(46, 32)
+#define POWER_LIMIT2_ENABLE		BIT_ULL(47)
+#define POWER_LIMIT2_CLAMP		BIT_ULL(48)
+#define POWER_HIGH_LOCK			BIT_ULL(63)
+#define POWER_LOW_LOCK			BIT(31)
+
+#define POWER_LIMIT4_MASK		GENMASK(12, 0)
+
+#define TIME_WINDOW1_MASK		GENMASK_ULL(23, 17)
+#define TIME_WINDOW2_MASK		GENMASK_ULL(55, 49)
+
+#define POWER_INFO_MAX_MASK		GENMASK_ULL(46, 32)
+#define POWER_INFO_MIN_MASK		GENMASK_ULL(30, 16)
+#define POWER_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(53, 48)
+#define POWER_INFO_THERMAL_SPEC_MASK	GENMASK(14, 0)
+
+#define PERF_STATUS_THROTTLE_TIME_MASK	GENMASK(31, 0)
+#define PP_POLICY_MASK			GENMASK(4, 0)
+
+/*
+ * SPR has different layout for Psys Domain PowerLimit registers.
+ * There are 17 bits of PL1 and PL2 instead of 15 bits.
+ * The Enable bits and TimeWindow bits are also shifted as a result.
+ */
+#define PSYS_POWER_LIMIT1_MASK		GENMASK_ULL(16, 0)
+#define PSYS_POWER_LIMIT1_ENABLE	BIT(17)
+
+#define PSYS_POWER_LIMIT2_MASK		GENMASK_ULL(48, 32)
+#define PSYS_POWER_LIMIT2_ENABLE	BIT_ULL(49)
+
+#define PSYS_TIME_WINDOW1_MASK		GENMASK_ULL(25, 19)
+#define PSYS_TIME_WINDOW2_MASK		GENMASK_ULL(57, 51)
+
 /* Sideband MBI registers */
 #define IOSF_CPU_POWER_BUDGET_CTL_BYT	0x02
 #define IOSF_CPU_POWER_BUDGET_CTL_TNG	0xDF
@@ -268,6 +308,64 @@ static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 	return value ? value * rd->time_unit : rd->time_unit;
 }
 
+/* RAPL primitives for MSR I/F */
+static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
+	/* name, mask, shift, msr index, unit divisor */
+	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
+						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[FW_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[FW_HIGH_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_CLAMP]		= PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_CLAMP]		= PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER,
+						      POWER_INFO_THERMAL_SPEC_MASK, 0,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW,
+						      POWER_INFO_MAX_TIME_WIN_MASK, 48,
+						      RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME,
+						      PERF_STATUS_THROTTLE_TIME_MASK, 0,
+						      RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+	[PRIORITY_LEVEL]	= PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
+						      RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
+	[PSYS_POWER_LIMIT1]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[PSYS_POWER_LIMIT2]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK,
+						      32, RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[PSYS_PL1_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE,
+						      17, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
+						      0),
+	[PSYS_PL2_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE,
+						      49, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
+						      0),
+	[PSYS_TIME_WINDOW1]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK,
+						      19, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[PSYS_TIME_WINDOW2]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK,
+						      51, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+};
+
 static const struct rapl_defaults rapl_defaults_core = {
 	.floor_freq_reg_addr = 0,
 	.check_unit = rapl_default_check_unit,
@@ -418,6 +516,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	rapl_msr_priv->read_raw = rapl_msr_read_raw;
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 	rapl_msr_priv->defaults = (const struct rapl_defaults *)pdev->dev.platform_data;
+	rapl_msr_priv->rpi = rpi_msr;
 
 	if (id) {
 		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
-- 
2.43.0

