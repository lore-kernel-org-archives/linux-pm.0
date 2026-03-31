Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2934534A4;
	Tue, 31 Mar 2026 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992010; cv=none; b=QLRw8iVUdLIf1xbffgYM6AORjTFWIXliCw0z7J47rOfSFkQpPzsc6cFvUm35INv9zglt1OPhRFNR/Am+QgplOYYw9nKZDMObEu1kS0WLdv1nSEp4155PJOpRW2W2W8mlSiSzfLPNeVR47Ihj7bsux8KqEWJkoUP3wlggXRoUVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992010; c=relaxed/simple;
	bh=mmfrYi46OryDqQml/BItJOP2Nw58Rp0jNtG1gBSq4F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlGeGvNsYNC0XST0Z2dLQ7hsKoc4rw+/OmDDCjJkc23gKBm+knnkn7XeXn9hqz4Ah2zbAmi+QgPdZ8MS+bZqu6FWq8Q7sH6wRvpWGJHVAmSBwrHz8o7TU3g5urIyAQM23xJwq6tkvTE7hTUHe1w4RRHT3NmqE+C77uJL7vBBJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8jYFS3L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8jYFS3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992008; x=1806528008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmfrYi46OryDqQml/BItJOP2Nw58Rp0jNtG1gBSq4F4=;
  b=Q8jYFS3L00xTDxeW3pg+T63M+n8YEyHPCM1NfsCrIH5mvStWxnXyqKnJ
   Vctdy3ppYaEGf4fpMu45cUIDZGgUGd0LmkP2RG6FcNEA8MBQW7sgpCRgR
   Jo1hdaztcbHVr41by6wTIaXp7oke4qVPU9KG2hgrmcVf7ekahLykEugNP
   FvD7W4bq82wtHG1sluF9mxDznvHIZXl7kLzVBaXGUhBzKkJKRyVAP44K+
   MbmjMA3at7kmABQI8fKhp7tMGdfiNil3K/pA2ku7G7mwTx0KbSZPdNkpN
   +FWP9WiyyyCkQ2PbqpJRwafbVrfKdAtrSNelmPPAGL4x4riuKV40AHmDZ
   A==;
X-CSE-ConnectionGUID: X2PlkEz3Q8u/wU4HAQK6tQ==
X-CSE-MsgGUID: C6Ey2EIuS4KXHkIPYw11DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79625017"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79625017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:05 -0700
X-CSE-ConnectionGUID: ucXkdHAuSZi/Tf8rAojyNw==
X-CSE-MsgGUID: Oz82nk08T+GbvBK/J+7BTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221627118"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:05 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] powercap: intel_rapl: Move TPMI primitives to TPMI driver
Date: Tue, 31 Mar 2026 14:19:47 -0700
Message-ID: <20260331211950.3329932-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPMI-specific RAPL primitives differ from those used by MSR and MMIO
interfaces. Keeping them in the common RAPL driver requires
interface-specific handling logic and makes the common layer
unnecessarily complex.

Move the TPMI primitive definitions and associated bitmasks into the
TPMI interface driver. This change includes:

 1. Move TPMI-specific bitmask definitions from intel_rapl_common.c to
    intel_rapl_tpmi.c.
 2. Add TPMI-local struct rapl_primitive_info instance and assign it to
    priv->rpi during TPMI probe.
 3. Remove the RAPL TPMI related definitions from the common driver.

No functional changes are intended.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 51 --------------------------
 drivers/powercap/intel_rapl_tpmi.c   | 53 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index ffc9d0378257..06912cb805f7 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -79,15 +79,6 @@
 #define PSYS_TIME_WINDOW1_MASK		GENMASK_ULL(25, 19)
 #define PSYS_TIME_WINDOW2_MASK		GENMASK_ULL(57, 51)
 
-/* bitmasks for RAPL TPMI, used by primitive access functions */
-#define TPMI_POWER_LIMIT_MASK		GENMASK_ULL(17, 0)
-#define TPMI_POWER_LIMIT_ENABLE		BIT_ULL(62)
-#define TPMI_TIME_WINDOW_MASK		GENMASK_ULL(24, 18)
-#define TPMI_INFO_SPEC_MASK		GENMASK_ULL(17, 0)
-#define TPMI_INFO_MIN_MASK		GENMASK_ULL(35, 18)
-#define TPMI_INFO_MAX_MASK		GENMASK_ULL(53, 36)
-#define TPMI_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(60, 54)
-
 /* Non HW constants */
 #define RAPL_PRIMITIVE_DUMMY		BIT(2)
 
@@ -665,45 +656,6 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 						      51, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 };
 
-/* RAPL primitives for TPMI I/F */
-static struct rapl_primitive_info rpi_tpmi[NR_RAPL_PRIMITIVES] = {
-	/* name, mask, shift, msr index, unit divisor */
-	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, TPMI_POWER_LIMIT_MASK, 0,
-						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, TPMI_POWER_LIMIT_MASK, 0,
-						      RAPL_DOMAIN_REG_PL2, POWER_UNIT, 0),
-	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, TPMI_POWER_LIMIT_MASK, 0,
-						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	[PL1_LOCK]		= PRIMITIVE_INFO_INIT(PL1_LOCK, POWER_HIGH_LOCK, 63,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_LOCK]		= PRIMITIVE_INFO_INIT(PL2_LOCK, POWER_HIGH_LOCK, 63,
-						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
-	[PL4_LOCK]		= PRIMITIVE_INFO_INIT(PL4_LOCK, POWER_HIGH_LOCK, 63,
-						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
-	[PL4_ENABLE]		= PRIMITIVE_INFO_INIT(PL4_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TPMI_TIME_WINDOW_MASK, 18,
-						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TPMI_TIME_WINDOW_MASK, 18,
-						      RAPL_DOMAIN_REG_PL2, TIME_UNIT, 0),
-	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, TPMI_INFO_SPEC_MASK, 0,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, TPMI_INFO_MAX_MASK, 36,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, TPMI_INFO_MIN_MASK, 18,
-						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, TPMI_INFO_MAX_TIME_WIN_MASK,
-						      54, RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK,
-						      0, RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-};
-
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 {
 	struct rapl_primitive_info *rpi = rp->priv->rpi;
@@ -722,9 +674,6 @@ static int rapl_config(struct rapl_package *rp)
 	case RAPL_IF_MSR:
 		rp->priv->rpi = rpi_msr;
 		break;
-	case RAPL_IF_TPMI:
-		rp->priv->rpi = rpi_tpmi;
-		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index c06d687366fc..7f41491d9cd1 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -62,6 +62,58 @@ static DEFINE_MUTEX(tpmi_rapl_lock);
 
 static struct powercap_control_type *tpmi_control_type;
 
+/* bitmasks for RAPL TPMI, used by primitive access functions */
+#define TPMI_POWER_LIMIT_MASK			GENMASK_ULL(17, 0)
+#define TPMI_POWER_LIMIT_ENABLE			BIT_ULL(62)
+#define TPMI_POWER_HIGH_LOCK			BIT_ULL(63)
+#define TPMI_TIME_WINDOW_MASK			GENMASK_ULL(24, 18)
+#define TPMI_INFO_SPEC_MASK			GENMASK_ULL(17, 0)
+#define TPMI_INFO_MIN_MASK			GENMASK_ULL(35, 18)
+#define TPMI_INFO_MAX_MASK			GENMASK_ULL(53, 36)
+#define TPMI_INFO_MAX_TIME_WIN_MASK		GENMASK_ULL(60, 54)
+#define TPMI_ENERGY_STATUS_MASK			GENMASK(31, 0)
+#define TPMI_PERF_STATUS_THROTTLE_TIME_MASK	GENMASK(31, 0)
+
+/* RAPL primitives for TPMI I/F */
+static struct rapl_primitive_info rpi_tpmi[NR_RAPL_PRIMITIVES] = {
+	/* name, mask, shift, msr index, unit divisor */
+	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_PL2, POWER_UNIT, 0),
+	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, TPMI_ENERGY_STATUS_MASK, 0,
+						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[PL1_LOCK]		= PRIMITIVE_INFO_INIT(PL1_LOCK, TPMI_POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_LOCK]		= PRIMITIVE_INFO_INIT(PL2_LOCK, TPMI_POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_LOCK]		= PRIMITIVE_INFO_INIT(PL4_LOCK, TPMI_POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_ENABLE]		= PRIMITIVE_INFO_INIT(PL4_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TPMI_TIME_WINDOW_MASK, 18,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TPMI_TIME_WINDOW_MASK, 18,
+						      RAPL_DOMAIN_REG_PL2, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, TPMI_INFO_SPEC_MASK, 0,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, TPMI_INFO_MAX_MASK, 36,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, TPMI_INFO_MIN_MASK, 18,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, TPMI_INFO_MAX_TIME_WIN_MASK,
+						      54, RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME,
+						      TPMI_PERF_STATUS_THROTTLE_TIME_MASK,
+						      0, RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+};
+
 static int tpmi_rapl_read_raw(int id, struct reg_action *ra, bool atomic)
 {
 	if (!ra->reg.mmio)
@@ -344,6 +396,7 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 	trp->priv.write_raw = tpmi_rapl_write_raw;
 	trp->priv.control_type = tpmi_control_type;
 	trp->priv.defaults = &defaults_tpmi;
+	trp->priv.rpi = rpi_tpmi;
 
 	/* RAPL TPMI I/F is per physical package */
 	trp->rp = rapl_find_package_domain(info->package_id, &trp->priv, false);
-- 
2.43.0

