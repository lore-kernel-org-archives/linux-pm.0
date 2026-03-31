Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE143C071;
	Tue, 31 Mar 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992008; cv=none; b=DONIIKkevhp5AHKh702oAsEfWn3pM768zCdUhfnBYHWZKxHRnwphuy685KZ75EIx43SLgpxyhAkwf0SVoaY/q1pHR76cTFD8DCOzAuL0Nw42bvvUFPBPE97iTaazK2UOdck+bbMb6h2fnL2CE5l/eQYO/D5o/D9savXIv78YCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992008; c=relaxed/simple;
	bh=Ugm3CDyFyMIEHyIld0cqfyoRxG+LBdhCDk/4O3Km+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ7BEh2VLiIqwWw+JP+tSlo1JsSOkLaqJeYuHvBD3c4QS9NwwOv+5cUNvTQXE9W08cpt9RyAMOcGjOphe4Z5dsFgDF/KR0oGaEmkcF8eaJU96Hhto2Rpkba/ZAZYnojMYAXbfJvYLoLb1W/DkKBFWHib5SDL63XLspcpEWc+kEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRMDZeVM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRMDZeVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992006; x=1806528006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ugm3CDyFyMIEHyIld0cqfyoRxG+LBdhCDk/4O3Km+lI=;
  b=nRMDZeVMo58Y8k18vJ7svYkcF+V0CnAudhwQII139ZPiM13vdfqPACTP
   NECl2vgNMnJH//SCHwXmNhcxCrl85jneEtw/mk+ZpNx76YTDPRmTsJmoF
   RyzvhjzVM8uXmjx3rFkl8rqD7+pWoo15VQYfVCKDHnqDWLxT6eABn7Xio
   4HWMHQ8TvulC8pwmOyuv4ZEBQfsFk889/quD7W+J6Ief7/Ma+AETaiItN
   A4P8f2bjRTh5hm+vTfDYPzr1yebZNNGjWE3HIeqVJgZhyCssHw9nmFC1Z
   6wVX2RFDz3ikDOti7dfFiY6W22qD37HBtlI5shIiK0CW8h6c4XKxYuwE/
   g==;
X-CSE-ConnectionGUID: FtogEQFFSXawgVrZkFlOHw==
X-CSE-MsgGUID: ibw1uSK0ScubGl7INCi5kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79625010"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79625010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:05 -0700
X-CSE-ConnectionGUID: NeUmK7DdQ5SURizAmu6VCw==
X-CSE-MsgGUID: 5QecAxv1RUiTUqACCd0/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221627104"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:04 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] powercap: intel_rapl: Move MSR default settings into MSR interface driver
Date: Tue, 31 Mar 2026 14:19:44 -0700
Message-ID: <20260331211950.3329932-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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

MSR-specific RAPL defaults differ from those used by the TPMI interface.
The MMIO and MSR interfaces shared the same rapl_defaults pointer in the
common driver, but MMIO does not require the CPU-specific variations
needed by MSR. Keeping these in the common driver adds unnecessary
complexity and MSR-specific initialization.

Move MSR defaults and CPU matching into the MSR interface driver.

Moves
-----
  * Move rapl_check_unit_atom(), set_floor_freq_atom(), and
    rapl_compute_time_window_atom() into intel_rapl_msr.c.
  * Move MSR unit-field GENMASK definitions and local constants.
  * Move all MSR-related rapl_defaults tables and the CPU-ID matching
    logic (rapl_ids[]) into the MSR driver.
  * Move iosf_mbi dependencies (floor-frequency control and related MBI
    register definitions) as they are MSR-platform specific.

Modifications
-------------
  * Replace the common driver's platform-device manual alloc/add sequence
    with platform_device_register_data() in the MSR driver to pass
    matching rapl_defaults as platform_data.
  * Update MSR driver probe to assign pdev->dev.platform_data to
    priv->defaults.
  * Update Atom helper functions to use rp->lead_cpu directly for MSR
    reads/writes instead of the generic get_rid().
  * Update Atom floor frequency logic to access defaults via the
    package private data pointer.
  * Convert MSR device creation from fs_initcall() to module_init().
    This preserves existing enumeration behavior as the driver was
    already using module_init().
  * Since rapl_ids need to exist after boot, remove __initconst
    specifier.

No functional changes are expected.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 228 +-----------------------
 drivers/powercap/intel_rapl_msr.c    | 250 ++++++++++++++++++++++++++-
 2 files changed, 250 insertions(+), 228 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e099514e6c56..1e8146283009 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -28,7 +28,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/iosf_mbi.h>
 #include <asm/msr.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
@@ -212,8 +211,6 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
-static const struct rapl_defaults *defaults_msr;
-
 static const struct rapl_defaults *get_defaults(struct rapl_package *rp)
 {
 	return rp->priv->defaults;
@@ -759,7 +756,6 @@ static int rapl_config(struct rapl_package *rp)
 	/* MMIO I/F shares the same register layout as MSR registers */
 	case RAPL_IF_MMIO:
 	case RAPL_IF_MSR:
-		rp->priv->defaults = defaults_msr;
 		rp->priv->rpi = (void *)rpi_msr;
 		break;
 	case RAPL_IF_TPMI:
@@ -947,34 +943,6 @@ int rapl_default_check_unit(struct rapl_domain *rd)
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_check_unit, "INTEL_RAPL");
 
-static int rapl_check_unit_atom(struct rapl_domain *rd)
-{
-	struct reg_action ra;
-	u32 value;
-
-	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
-	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, false)) {
-		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
-			ra.reg.val, rd->rp->name, rd->name);
-		return -ENODEV;
-	}
-
-	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * (1ULL << value);
-
-	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = (1ULL << value) * MILLIWATT_PER_WATT;
-
-	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = USEC_PER_SEC >> value;
-
-	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
-		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
-
-	return 0;
-}
-
 static void power_limit_irq_save_cpu(void *info)
 {
 	u32 l, h = 0;
@@ -1055,30 +1023,6 @@ void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode)
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_set_floor_freq, "INTEL_RAPL");
 
-static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
-{
-	static u32 power_ctrl_orig_val;
-	const struct rapl_defaults *defaults = get_defaults(rd->rp);
-	u32 mdata;
-
-	if (!defaults->floor_freq_reg_addr) {
-		pr_err("Invalid floor frequency config register\n");
-		return;
-	}
-
-	if (!power_ctrl_orig_val)
-		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
-			      defaults->floor_freq_reg_addr,
-			      &power_ctrl_orig_val);
-	mdata = power_ctrl_orig_val;
-	if (enable) {
-		mdata &= ~GENMASK(14, 8);
-		mdata |= BIT(8);
-	}
-	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
-		       defaults->floor_freq_reg_addr, mdata);
-}
-
 u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_raw)
 {
 	u64 f, y;		/* fraction and exp. used for time unit */
@@ -1112,149 +1056,6 @@ u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_compute_time_window, "INTEL_RAPL");
 
-static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
-					 bool to_raw)
-{
-	if (to_raw)
-		return div64_u64(value, rd->time_unit);
-
-	/*
-	 * Atom time unit encoding is straight forward val * time_unit,
-	 * where time_unit is default to 1 sec. Never 0.
-	 */
-	return (value) ? value * rd->time_unit : rd->time_unit;
-}
-
-static const struct rapl_defaults rapl_defaults_core = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-};
-
-static const struct rapl_defaults rapl_defaults_hsw_server = {
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-	.dram_domain_energy_unit = 15300,
-};
-
-static const struct rapl_defaults rapl_defaults_spr_server = {
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
-	.spr_psys_bits = true,
-};
-
-static const struct rapl_defaults rapl_defaults_byt = {
-	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = set_floor_freq_atom,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_tng = {
-	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = set_floor_freq_atom,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_ann = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = NULL,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_cht = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = NULL,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_amd = {
-	.check_unit = rapl_default_check_unit,
-};
-
-static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_IVYBRIDGE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_HASWELL,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_G,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_X,			&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_BROADWELL,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_SKYLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_X,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&rapl_defaults_cht),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&rapl_defaults_ann),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,		&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_VENDOR_FAM(AMD, 0x17,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x19,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x1A,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(HYGON, 0x18,		&rapl_defaults_amd),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-
 /* Read once for all raw primitive data for domains */
 static void rapl_update_domain_data(struct rapl_package *rp)
 {
@@ -2266,40 +2067,13 @@ static struct notifier_block rapl_pm_notifier = {
 	.notifier_call = rapl_pm_callback,
 };
 
-static struct platform_device *rapl_msr_platdev;
-
 static int __init rapl_init(void)
 {
-	const struct x86_cpu_id *id;
-	int ret;
-
-	id = x86_match_cpu(rapl_ids);
-	if (id) {
-		defaults_msr = (const struct rapl_defaults *)id->driver_data;
-
-		rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
-		if (!rapl_msr_platdev)
-			return -ENOMEM;
-
-		ret = platform_device_add(rapl_msr_platdev);
-		if (ret) {
-			platform_device_put(rapl_msr_platdev);
-			return ret;
-		}
-	}
-
-	ret = register_pm_notifier(&rapl_pm_notifier);
-	if (ret && rapl_msr_platdev) {
-		platform_device_del(rapl_msr_platdev);
-		platform_device_put(rapl_msr_platdev);
-	}
-
-	return ret;
+	return register_pm_notifier(&rapl_pm_notifier);
 }
 
 static void __exit rapl_exit(void)
 {
-	platform_device_unregister(rapl_msr_platdev);
 	unregister_pm_notifier(&rapl_pm_notifier);
 }
 
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9cd6a241df51..b7c10ed75d69 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -21,15 +21,33 @@
 #include <linux/intel_rapl.h>
 #include <linux/processor.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
+#include <linux/bits.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 #include <asm/msr.h>
 
 /* Local defines */
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
 #define MSR_VR_CURRENT_CONFIG		0x00000601
 
+#define ENERGY_UNIT_SCALE		1000	/* scale from driver unit to powercap unit */
+
+#define POWER_UNIT_OFFSET		0x00
+#define POWER_UNIT_MASK			GENMASK(3, 0)
+
+#define ENERGY_UNIT_OFFSET		0x08
+#define ENERGY_UNIT_MASK		GENMASK(12, 8)
+
+#define TIME_UNIT_OFFSET		0x10
+#define TIME_UNIT_MASK			GENMASK(19, 16)
+
+/* Sideband MBI registers */
+#define IOSF_CPU_POWER_BUDGET_CTL_BYT	0x02
+#define IOSF_CPU_POWER_BUDGET_CTL_TNG	0xDF
+
 /* private data for RAPL MSR Interface */
 static struct rapl_if_priv *rapl_msr_priv;
 
@@ -185,6 +203,201 @@ static const struct x86_cpu_id pmu_support_ids[] = {
 	{}
 };
 
+static int rapl_check_unit_atom(struct rapl_domain *rd)
+{
+	struct reg_action ra;
+	u32 value;
+
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
+	ra.mask = ~0;
+	if (rapl_msr_read_raw(rd->rp->lead_cpu, &ra, false)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg.val, rd->rp->name, rd->name);
+		return -ENODEV;
+	}
+
+	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
+	rd->energy_unit = ENERGY_UNIT_SCALE * (1ULL << value);
+
+	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
+	rd->power_unit = (1ULL << value) * MILLIWATT_PER_WATT;
+
+	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
+	rd->time_unit = USEC_PER_SEC >> value;
+
+	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
+
+	return 0;
+}
+
+static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
+{
+	static u32 power_ctrl_orig_val;
+	const struct rapl_defaults *defaults = rd->rp->priv->defaults;
+	u32 mdata;
+
+	if (!defaults->floor_freq_reg_addr) {
+		pr_err("Invalid floor frequency config register\n");
+		return;
+	}
+
+	if (!power_ctrl_orig_val)
+		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
+			      defaults->floor_freq_reg_addr,
+			      &power_ctrl_orig_val);
+	mdata = power_ctrl_orig_val;
+	if (enable) {
+		mdata &= ~GENMASK(14, 8);
+		mdata |= BIT(8);
+	}
+	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
+		       defaults->floor_freq_reg_addr, mdata);
+}
+
+static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
+					 bool to_raw)
+{
+	if (to_raw)
+		return div64_u64(value, rd->time_unit);
+
+	/*
+	 * Atom time unit encoding is straight forward val * time_unit,
+	 * where time_unit is default to 1 sec. Never 0.
+	 */
+	return value ? value * rd->time_unit : rd->time_unit;
+}
+
+static const struct rapl_defaults rapl_defaults_core = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+};
+
+static const struct rapl_defaults rapl_defaults_hsw_server = {
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.dram_domain_energy_unit = 15300,
+};
+
+static const struct rapl_defaults rapl_defaults_spr_server = {
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
+	.spr_psys_bits = true,
+};
+
+static const struct rapl_defaults rapl_defaults_byt = {
+	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = set_floor_freq_atom,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_tng = {
+	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = set_floor_freq_atom,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_ann = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = NULL,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_cht = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = NULL,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_amd = {
+	.check_unit = rapl_default_check_unit,
+};
+
+static const struct x86_cpu_id rapl_ids[]  = {
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,			&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(HYGON, 0x18,		&rapl_defaults_amd),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
+
 static int rapl_msr_probe(struct platform_device *pdev)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
@@ -204,6 +417,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	}
 	rapl_msr_priv->read_raw = rapl_msr_read_raw;
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
+	rapl_msr_priv->defaults = (const struct rapl_defaults *)pdev->dev.platform_data;
 
 	if (id) {
 		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
@@ -258,7 +472,41 @@ static struct platform_driver intel_rapl_msr_driver = {
 	},
 };
 
-module_platform_driver(intel_rapl_msr_driver);
+static struct platform_device *rapl_msr_platdev;
+
+static int intel_rapl_msr_init(void)
+{
+	const struct rapl_defaults *def;
+	const struct x86_cpu_id *id;
+	int ret;
+
+	ret = platform_driver_register(&intel_rapl_msr_driver);
+	if (ret)
+		return ret;
+
+	/* Create the MSR RAPL platform device for supported platforms */
+	id = x86_match_cpu(rapl_ids);
+	if (!id)
+		return 0;
+
+	def = (const struct rapl_defaults *)id->driver_data;
+
+	rapl_msr_platdev = platform_device_register_data(NULL, "intel_rapl_msr", 0, def,
+							 sizeof(*def));
+	if (IS_ERR(rapl_msr_platdev))
+		pr_debug("intel_rapl_msr device register failed, ret:%ld\n",
+			 PTR_ERR(rapl_msr_platdev));
+
+	return 0;
+}
+module_init(intel_rapl_msr_init);
+
+static void intel_rapl_msr_exit(void)
+{
+	platform_device_unregister(rapl_msr_platdev);
+	platform_driver_unregister(&intel_rapl_msr_driver);
+}
+module_exit(intel_rapl_msr_exit);
 
 MODULE_DESCRIPTION("Driver for Intel RAPL (Running Average Power Limit) control via MSR interface");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
-- 
2.43.0

