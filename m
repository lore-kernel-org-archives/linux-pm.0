Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1603DE42A;
	Fri, 13 Mar 2026 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428018; cv=none; b=h8EX70sC42OS0XjHtdUZHWpv0+euBgEVV1/uf0dYo6W/PZaw3fZQcWiObeTIvXE6xIPaZfY4RxYZJpL7xhQONr8kH31AlGZ07lLzerdgwwnZ7/6tjlVuw0yYoGygcUvqPbdZv8New/IhHNyEe41nmo/eyrf7i6RNDGxbvhtBIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428018; c=relaxed/simple;
	bh=tevxBjD08c+EmvS2R+hvXC1HUxRaLfEL9OOQYa4Rh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrvikElsqKfWGGqObAfnMN08kbRve1jX1yFl1wSiXX937ugxhmOAHrap5SF+OVaht3KiSsh0iu38eEy4nZ2Ujymbl0F0eUi3ziagshxZ/YrN7OHUlH9hPebnHKQxy2EB1IpGZ4ZcOhwQVLqQxSXLFouYVLb1EK6JihLNSvooHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciPT+85z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciPT+85z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428017; x=1804964017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tevxBjD08c+EmvS2R+hvXC1HUxRaLfEL9OOQYa4Rh6k=;
  b=ciPT+85zJB7SBclfoLHHfnfpKHZVty5+AdznumlQAeSo3hLcSa4vFaHU
   YxmDYuK3h8tQKrmm7bgRnHuO7qj8SAfVsNtfAd5AFeGXnv3BmjK3Ztk2G
   JAu/k6CExBDvbB1NEyVsu9A6YJJpqVRYEB1UaYSqS1V74S66qSsKggQH+
   owWGBqii5t1q6n6OYFSQ5VXXFcYOQ00w9v8TNaeVFRbTgreE2pmYjHts0
   NwAb6u5I8qRMLFGx1NQs9tCzFZBkTynHZo4m6qBi/An+vDtuPDHMqa4av
   xWSZW3PoZsJPmlKpToOafTBaCA0r8ePlWYLg1lmwOhOZJDvuei6G3JahV
   Q==;
X-CSE-ConnectionGUID: 4YKyE3j1QEeSLIsTUerQCA==
X-CSE-MsgGUID: hQj0Q2m/QwyNYzU8wrANgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242252"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: ZE/2CXdiT6iAmLerKI2W+Q==
X-CSE-MsgGUID: a9zULPIUTSWJ4V4D3u4drg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709178"
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
Subject: [PATCH v1 3/6] powercap: intel_rapl: Move primitive info to header for interface drivers
Date: Fri, 13 Mar 2026 11:53:29 -0700
Message-ID: <20260313185333.2370733-4-sathyanarayanan.kuppuswamy@linux.intel.com>
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

RAPL primitive information varies across different RAPL interfaces
(MSR, TPMI, MMIO). Keeping them in the common code adds no benefit, but
requires interface-specific handling logic and makes the common layer
unnecessarily complex.

Move the primitive info infrastructure to the shared header to allow
interface drivers to configure RAPL primitives. Specific changes:

 1. Move struct rapl_primitive_info, enum unit_type, and
    PRIMITIVE_INFO_INIT macro to intel_rapl.h.
 2. Change the @rpi field in struct rapl_if_priv from void * to
    struct rapl_primitive_info * to improve type safety and eliminate
    unnecessary casts.

No functional changes. This is a preparatory refactoring to allow
interface drivers to supply their own RAPL primitive settings.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 32 ++--------------------------
 include/linux/intel_rapl.h           | 32 ++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index fdcac4a173a8..d6c2819b1212 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -100,13 +100,6 @@
 
 #define RAPL_EVENT_MASK			GENMASK(7, 0)
 
-enum unit_type {
-	ARBITRARY_UNIT,		/* no translation */
-	POWER_UNIT,
-	ENERGY_UNIT,
-	TIME_UNIT,
-};
-
 static const char *pl_names[NR_POWER_LIMITS] = {
 	[POWER_LIMIT1] = "long_term",
 	[POWER_LIMIT2] = "short_term",
@@ -208,27 +201,6 @@ static const struct rapl_defaults *get_defaults(struct rapl_package *rp)
 	return rp->priv->defaults;
 }
 
-/* per domain data. used to describe individual knobs such that access function
- * can be consolidated into one instead of many inline functions.
- */
-struct rapl_primitive_info {
-	const char *name;
-	u64 mask;
-	int shift;
-	enum rapl_domain_reg_id id;
-	enum unit_type unit;
-	u32 flag;
-};
-
-#define PRIMITIVE_INFO_INIT(p, m, s, i, u, f) {	\
-		.name = #p,			\
-		.mask = m,			\
-		.shift = s,			\
-		.id = i,			\
-		.unit = u,			\
-		.flag = f			\
-	}
-
 static void rapl_init_domains(struct rapl_package *rp);
 static int rapl_read_data_raw(struct rapl_domain *rd,
 			      enum rapl_primitives prim,
@@ -748,10 +720,10 @@ static int rapl_config(struct rapl_package *rp)
 	/* MMIO I/F shares the same register layout as MSR registers */
 	case RAPL_IF_MMIO:
 	case RAPL_IF_MSR:
-		rp->priv->rpi = (void *)rpi_msr;
+		rp->priv->rpi = rpi_msr;
 		break;
 	case RAPL_IF_TPMI:
-		rp->priv->rpi = (void *)rpi_tpmi;
+		rp->priv->rpi = rpi_tpmi;
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 9e6bd654be1f..01f290de3586 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -137,6 +137,34 @@ struct rapl_defaults {
 	bool spr_psys_bits;
 };
 
+#define PRIMITIVE_INFO_INIT(p, m, s, i, u, f) {	\
+		.name = #p,			\
+		.mask = m,			\
+		.shift = s,			\
+		.id = i,			\
+		.unit = u,			\
+		.flag = f			\
+	}
+
+enum unit_type {
+	ARBITRARY_UNIT,		/* no translation */
+	POWER_UNIT,
+	ENERGY_UNIT,
+	TIME_UNIT,
+};
+
+/* per domain data. used to describe individual knobs such that access function
+ * can be consolidated into one instead of many inline functions.
+ */
+struct rapl_primitive_info {
+	const char *name;
+	u64 mask;
+	int shift;
+	enum rapl_domain_reg_id id;
+	enum unit_type unit;
+	u32 flag;
+};
+
 /**
  * struct rapl_if_priv: private data for different RAPL interfaces
  * @control_type:		Each RAPL interface must have its own powercap
@@ -152,7 +180,7 @@ struct rapl_defaults {
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
  * @defaults:			pointer to default settings
- * @rpi:			internal pointer to interface primitive info
+ * @rpi:			pointer to interface primitive info
  */
 struct rapl_if_priv {
 	enum rapl_if_type type;
@@ -164,7 +192,7 @@ struct rapl_if_priv {
 	int (*read_raw)(int id, struct reg_action *ra, bool pmu_ctx);
 	int (*write_raw)(int id, struct reg_action *ra);
 	const struct rapl_defaults *defaults;
-	void *rpi;
+	struct rapl_primitive_info *rpi;
 };
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.43.0

