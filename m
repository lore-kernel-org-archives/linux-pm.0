Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269073A4530;
	Wed,  8 Apr 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686912; cv=none; b=UpqJIRFWIA4GBHOiOiwkAcU26JBP7cqiiVLd/Ph3eA+fKzqNY4KARblfIHCeF2iCxoPUyLkWCw4ii7r1hlke6XPKH2cUWOGy5Y5psAYU3c8qM1EfFf6pGR2CzFrsJ0oh3HBVZUPe1LsbB+r8tfSueUiVgy2ckfEoWFrnBawMdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686912; c=relaxed/simple;
	bh=SPLebewkKB+0YCQWs7sZtU8YJRNsnm/vRExKC/9yhvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xlvm5SiJzxf6OgBah/sh1jYVZrnPlTojpYOYVphDulqIPN/A2oijmDK9PP9UK2SU5OlwiW7e0mv3HTxWdZHx4/SNIhTnEW8qpHB1A0/iu3dgiGg5Fw9Nolh+p3zR/UwEJeQlbcSwQIB3qmtSy04juhnFkLkmhtITyBxeWJik+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npSl5xki; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npSl5xki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686911; x=1807222911;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SPLebewkKB+0YCQWs7sZtU8YJRNsnm/vRExKC/9yhvg=;
  b=npSl5xkiGo6Ke8vuIVd8TQXWmx5VV7kj19Fq9idzm2jwTUVx5iBMdojw
   uF+gFeYEE3M9a5NktjoV3e6ZSgPXwqVt6rh/216m1Ok8GVbmcl3sFU7K1
   yHmo10rFKnpO4gEAq9OtlocV3F1K851cMaQvNSFWxBNlEnOIkiTLQRvy1
   Br3rvxE+3xiw93lync2JLIuNSbEBcHT04PiYg9TqrwVW/Y+fJO5pEpHL3
   srN7Esh/bgk5pJyL2dNsxniRtqoRpaayl1otGs9H2IvWVXsOrxg6Ebeso
   zQn+yfF0wEyEY+sEPejs+wsyjJfy16E5EEMj8gl/gSsw20zeYpHTVyYNn
   Q==;
X-CSE-ConnectionGUID: AmG2TeDQSkGXR4C5HNdsag==
X-CSE-MsgGUID: vucqjukyTJadIgMXpmQcIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068083"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068083"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:51 -0700
X-CSE-ConnectionGUID: i+6e5IokSb+HGImhF/7yFg==
X-CSE-MsgGUID: IH7/k5AFQnaCVbp9Rl05DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837829"
Received: from aschende-mobl.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:49 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/7] platform/x86/intel/pmc: Use PCI DID for PMC SSRAM device discovery
Date: Wed,  8 Apr 2026 15:21:37 -0700
Message-ID: <20260408222144.3288928-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
References: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the PMC SSRAM discovery process to identify the device using its
PCI Device ID rather than relying on a fixed PCI bus location. The
enumeration of integrated devices on the PCI bus is no longer guaranteed
to be consistent across CPUs.

On earlier platforms, the IOE and PCH SSRAM devices were hidden from the
BIOS, and the SOC SSRAM device is associated to telemetry regions from all
available SSRAM devices. Starting with Nova Lake, the IOE and PCH SSRAM
devices register their telemetry regions independently, meaning each
telemetry region is now linked to its corresponding SSRAM device. A new
ssram_hidden attribute has been added to the pmc_dev_info structure to
reflect this distinction.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  4 ++--
 drivers/platform/x86/intel/pmc/core.c | 17 ++++++++++++-----
 drivers/platform/x86/intel/pmc/core.h |  6 ++++--
 drivers/platform/x86/intel/pmc/lnl.c  |  2 +-
 drivers/platform/x86/intel/pmc/mtl.c  |  2 +-
 drivers/platform/x86/intel/pmc/ptl.c  |  2 +-
 drivers/platform/x86/intel/pmc/wcl.c  |  2 +-
 7 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index eb23bc68340ab..95372a0807acf 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -720,7 +720,6 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
 
 static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_pmc_dev = {
-	.pci_func = 0,
 	.dmu_guids = ARL_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
@@ -729,11 +728,11 @@ struct pmc_dev_info arl_pmc_dev = {
 	.resume = arl_resume,
 	.init = arl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
 
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
-	.pci_func = 2,
 	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
@@ -742,4 +741,5 @@ struct pmc_dev_info arl_h_pmc_dev = {
 	.resume = arl_h_resume,
 	.init = arl_h_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 94ae098a155a6..e0ac329e6723a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1646,17 +1646,13 @@ int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, struct pmc *pmc,
 
 static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
-	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
 	struct telem_endpoint *ep;
 	unsigned int pmc_idx;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, pmc_dev_info->pci_func));
-	if (!pcidev)
-		return -ENODEV;
-
 	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
 		struct pmc *pmc;
+		u16 devid;
 
 		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
@@ -1665,6 +1661,16 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *
 		if (!pmc->map->lpm_req_guid)
 			return -ENXIO;
 
+		if (pmc_dev_info->ssram_hidden)
+			devid = pmcdev->pmcs[PMC_IDX_MAIN]->devid;
+		else
+			devid = pmc->devid;
+
+		struct pci_dev *pcidev __free(pci_dev_put) =
+			pci_get_device(PCI_VENDOR_ID_INTEL, devid, NULL);
+		if (!pcidev)
+			return -ENODEV;
+
 		ep = pmt_telem_find_and_register_endpoint(&pcidev->dev, pmc->map->lpm_req_guid, 0);
 		if (IS_ERR(ep)) {
 			dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep);
@@ -1715,6 +1721,7 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
 
 	pmc->map = map;
 	pmc->base_addr = pmc_ssram_telemetry.base_addr;
+	pmc->devid = pmc_ssram_telemetry.devid;
 	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
 
 	if (!pmc->regbase) {
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 829b1dee3f636..f385a0eccd2c2 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -425,6 +425,7 @@ struct pmc_info {
  * @ltr_ign:		Holds LTR ignore data while suspended
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @devid:		Device ID of the SSRAM device
  *
  * pmc contains info about one power management controller device.
  */
@@ -436,6 +437,7 @@ struct pmc {
 	u32 ltr_ign;
 	u8 num_lpm_modes;
 	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
+	u16 devid;
 };
 
 /**
@@ -495,7 +497,6 @@ enum pmc_index {
 
 /**
  * struct pmc_dev_info - Structure to keep PMC device info
- * @pci_func:		Function number of the primary PMC
  * @dmu_guids:		List of Die Management Unit GUID
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
@@ -512,9 +513,9 @@ enum pmc_index {
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
  * @sub_req:		Function to achieve low power mode substate requirements
+ * @ssram_hidden:	Some SSRAM devices are hidden on this platform
  */
 struct pmc_dev_info {
-	u8 pci_func;
 	u32 *dmu_guids;
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
@@ -528,6 +529,7 @@ struct pmc_dev_info {
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
+	bool ssram_hidden;
 };
 
 extern const struct pmc_bit_map msr_map[];
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 1cd81ee54dcf8..18f303af328e3 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -571,7 +571,6 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
@@ -579,4 +578,5 @@ struct pmc_dev_info lnl_pmc_dev = {
 	.resume = lnl_resume,
 	.init = lnl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 57508cbf9cd42..193ebbe584023 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -994,7 +994,6 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 
 static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info mtl_pmc_dev = {
-	.pci_func = 2,
 	.dmu_guids = MTL_PMT_DMU_GUIDS,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
@@ -1003,4 +1002,5 @@ struct pmc_dev_info mtl_pmc_dev = {
 	.resume = mtl_resume,
 	.init = mtl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 1f48e2bbc699f..6c68772e738c8 100644
--- a/drivers/platform/x86/intel/pmc/ptl.c
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -569,7 +569,6 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
@@ -577,4 +576,5 @@ struct pmc_dev_info ptl_pmc_dev = {
 	.resume = ptl_resume,
 	.init = ptl_core_init,
 	.sub_req = pmc_core_pmt_get_blk_sub_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
index a45707e6364f2..b55069945e9e7 100644
--- a/drivers/platform/x86/intel/pmc/wcl.c
+++ b/drivers/platform/x86/intel/pmc/wcl.c
@@ -493,7 +493,6 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info wcl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = wcl_pmc_info_list,
 	.map = &wcl_pcdn_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
@@ -501,4 +500,5 @@ struct pmc_dev_info wcl_pmc_dev = {
 	.resume = wcl_resume,
 	.init = wcl_core_init,
 	.sub_req = pmc_core_pmt_get_blk_sub_req,
+	.ssram_hidden = true,
 };
-- 
2.43.0

