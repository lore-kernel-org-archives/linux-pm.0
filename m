Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF353BE628;
	Tue,  5 May 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955632; cv=none; b=oMj5CJAP927gfC9Cxp9+hFMwRLaGJSXLiP1u8cRc46oXpm+LVUhpYvhzcvFxcCOyLjmzwZirX1ljDcKVqYpmX3D4Li0as4PfMJ0unx1cUsbKgQ/QvVv8nyrPIOVngPx6hAHIWSj0+Px2ikJssAMYZH7o3NC89pYVuNBjjhfOyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955632; c=relaxed/simple;
	bh=z0abVty87za3ukd+yPf4eDojqr20QcSMpjo9AZFQEAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHKEnCWaefZ4Zq5IQ6WpaaFVm5UhhpYSGoD91xmgavY9ysiIfVkTpCHaXWZl0kYB0x4YeEnM+zuQf+5lS7yX3fLYH0fl2BrB6Ba6bwpzZkyIOTze5rSWsNa/HT7MJnwi6M8UJoXM3Sweyf8LUARYCCfx2eK/yW9YwWRYrTi8KqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6avtQKs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6avtQKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955631; x=1809491631;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=z0abVty87za3ukd+yPf4eDojqr20QcSMpjo9AZFQEAs=;
  b=K6avtQKsAXInMkZ1b9ekiLNcyc/V0XVNRBfNa9xX49VxmA9igkgCH0hH
   AbAU4RpcKtaPXK+WJ+rP6ocQuGucLUHRo0c7rCIaNeunCVU3FSWs7ecoZ
   ozVbwqvtjxplbplluNonbwQc6r1Kr/v0F7kgFHtyZ2p4XA5AER1UA9lip
   qiSiUTTgW4y8pzZcreZbNyClnVKfXwrJeWee2SS0L+3zDves9kmKOUMG0
   5owzgouZfM0d94LhXiWCgjevQzHp4J/fvjhYFdZP79+eu9rFHiUXTQvw1
   8NmXPgu3okHVVbv75cLVDhLofjDqwLfxyA60Ubll1pt0k+vbDZ9YjceDu
   g==;
X-CSE-ConnectionGUID: HDiwjLAxQLG/5SroBUE3Kg==
X-CSE-MsgGUID: MA+NFlp/Rae1/0WIodEknQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841292"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:50 -0700
X-CSE-ConnectionGUID: iSY+Aia7RZaPx331R55Ugw==
X-CSE-MsgGUID: 3wIdfeVbQ2SYMPin5QmmZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565237"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:49 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 6/7] platform/x86/intel/pmc: Retrieve PMC info only for available PMCs
Date: Mon,  4 May 2026 21:33:37 -0700
Message-ID: <20260505043342.2573556-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
References: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Intel PMC Core driver to fetch PMC information only for
available PMCs. Previously, the driver attempted to retrieve PMC info
even when the corresponding PMC was not present.

This change aligns with recent updates to the Intel SSRAM Telemetry
driver. Starting with NVL, the SSRAM Telemetry driver is probed for
each individual SSRAM device. The prior implementation could not
differentiate between an unavailable PMC and one that had not yet
completed information retrieval. To resolve this, the PMC Core driver
now skips obtaining PMC info for unavailable PMCs.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  7 +++++++
 drivers/platform/x86/intel/pmc/core.c | 19 +++++++++++--------
 drivers/platform/x86/intel/pmc/core.h |  4 ++++
 drivers/platform/x86/intel/pmc/lnl.c  |  4 ++++
 drivers/platform/x86/intel/pmc/mtl.c  |  4 ++++
 drivers/platform/x86/intel/pmc/ptl.c  |  4 ++++
 drivers/platform/x86/intel/pmc/wcl.c  |  4 ++++
 7 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 4d91ee010f6d0..11609d593383b 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -672,6 +672,9 @@ static struct pmc_info arl_pmc_info_list[] = {
 	{}
 };
 
+static const u8 arl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_PCH};
+static const u8 arl_h_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE};
+
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
 #define ARL_H_NPU_PCI_DEV		0x7d1d
@@ -721,6 +724,8 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
 static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_pmc_dev = {
 	.dmu_guids = ARL_PMT_DMU_GUIDS,
+	.num_pmcs = ARRAY_SIZE(arl_pmc_list),
+	.pmc_list = arl_pmc_list,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
@@ -735,6 +740,8 @@ struct pmc_dev_info arl_pmc_dev = {
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
 	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
+	.num_pmcs = ARRAY_SIZE(arl_h_pmc_list),
+	.pmc_list = arl_h_pmc_list,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5d2e2681b0eba..9c13a7554af96 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1734,16 +1734,17 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
 	return 0;
 }
 
-static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
+static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev, u8 num_pmcs, const u8 *pmc_list)
 {
+	unsigned int i;
 	int ret;
 
-	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
-	if (ret)
-		return ret;
-
-	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
-	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
+	for (i = 0; i < num_pmcs; ++i) {
+		/* Non-MAIN PMCs are allowed to fail */
+		ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
+		if (ret && (pmc_list[i] == PMC_IDX_MAIN))
+			return ret;
+	}
 
 	return 0;
 }
@@ -1765,7 +1766,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	ssram = pmc_dev_info->regmap_list != NULL;
 	if (ssram) {
 		pmcdev->regmap_list = pmc_dev_info->regmap_list;
-		ret = pmc_core_ssram_get_reg_base(pmcdev);
+		ret = pmc_core_ssram_get_reg_base(pmcdev,
+						  pmc_dev_info->num_pmcs,
+						  pmc_dev_info->pmc_list);
 		/*
 		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
 		 * has not finished probe and PMC info is not available yet. Try
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ef69de160ffbc..428b2e55864ab 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -501,6 +501,8 @@ enum pmc_index {
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
  * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
+ * @num_pmcs:		Number of entries in @pmc_list
+ * @pmc_list:		Index list of available PMC
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
@@ -521,6 +523,8 @@ struct pmc_dev_info {
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
 	u32 pkgc_blocker_offset;
+	u8 num_pmcs;
+	const u8 *pmc_list;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 18f303af328e3..5ff4922825d91 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -544,6 +544,8 @@ static struct pmc_info lnl_pmc_info_list[] = {
 	{}
 };
 
+static const u8 lnl_pmc_list[] = {PMC_IDX_MAIN};
+
 #define LNL_NPU_PCI_DEV		0x643e
 #define LNL_IPU_PCI_DEV		0x645d
 
@@ -571,6 +573,8 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
+	.num_pmcs = ARRAY_SIZE(lnl_pmc_list),
+	.pmc_list = lnl_pmc_list,
 	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index b724dd8c34dba..9abeabd3dbe27 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -965,6 +965,8 @@ static struct pmc_info mtl_pmc_info_list[] = {
 	{}
 };
 
+static const u8 mtl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE};
+
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -995,6 +997,8 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info mtl_pmc_dev = {
 	.dmu_guids = MTL_PMT_DMU_GUIDS,
+	.num_pmcs = ARRAY_SIZE(mtl_pmc_list),
+	.pmc_list = mtl_pmc_list,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 6c68772e738c8..90fcd7900d9f9 100644
--- a/drivers/platform/x86/intel/pmc/ptl.c
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -543,6 +543,8 @@ static struct pmc_info ptl_pmc_info_list[] = {
 	{}
 };
 
+static const u8 ptl_pmc_list[] = {PMC_IDX_MAIN};
+
 #define PTL_NPU_PCI_DEV                0xb03e
 #define PTL_IPU_PCI_DEV                0xb05d
 
@@ -569,6 +571,8 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
+	.num_pmcs = ARRAY_SIZE(ptl_pmc_list),
+	.pmc_list = ptl_pmc_list,
 	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
index b55069945e9e7..d34ac916907dc 100644
--- a/drivers/platform/x86/intel/pmc/wcl.c
+++ b/drivers/platform/x86/intel/pmc/wcl.c
@@ -469,6 +469,8 @@ static struct pmc_info wcl_pmc_info_list[] = {
 	{}
 };
 
+static const u8 wcl_pmc_list[] = {PMC_IDX_MAIN};
+
 #define WCL_NPU_PCI_DEV                0xfd3e
 
 /*
@@ -494,6 +496,8 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 
 struct pmc_dev_info wcl_pmc_dev = {
 	.regmap_list = wcl_pmc_info_list,
+	.num_pmcs = ARRAY_SIZE(wcl_pmc_list),
+	.pmc_list = wcl_pmc_list,
 	.map = &wcl_pcdn_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
 	.suspend = cnl_suspend,
-- 
2.43.0

