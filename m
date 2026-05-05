Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3713B7757;
	Tue,  5 May 2026 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955630; cv=none; b=MzfcA2HFaVfXDPKzpaf+h4q3eQ7Pjx+cUKU7gOvHfXL6iUYvGXNgRZuHELB2omLs4qrjz50L+obKUgLXSZRPsYx20T2nyVqfM1PJRF42BWI8paqlWv6hHCxJoERZsDHH7o1c0aCaMt8v08p+Qr71Iy2ZjhbApde8lD0cvrb9Mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955630; c=relaxed/simple;
	bh=mBrF0tYAXiNVB692DOsWpSeke6Xs0sIJXbZgDOAGnoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gng9QWvn7qVTRdmXtZyW2Pey1+H2IMz0Fzy6KDwISwUTSj/caixPTazf7xOrmclW+PSO3cPvJgEXAo/fNcTClk3R6CsNP4evPuF4S+s7+1lfbGnm3GKRpHZKkO6BymVXEClprg//5OYRgRG9noRt2hzj1i3QfsqlarWosSpPAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/97bAep; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/97bAep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955629; x=1809491629;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mBrF0tYAXiNVB692DOsWpSeke6Xs0sIJXbZgDOAGnoQ=;
  b=b/97bAepsAB2ASltb7cT5Pct6dnTQ9nALzP/zaZKBoJgby09BzfYvmrb
   RaZJflIQn0UB9YZlk2F7y3+SizUsqex0hROP4m7QuSYxksuvznbsJNnuJ
   ccn5zpK/yFoCEwYCmoAAJxZiSkcNd2ycSa+852j0cH/b8+LF0SauPXGUo
   MMs6RYkmEnfp0CmjWJcQPfQVCI3O6yLSpPfvk9/i3hH5s7FSNQ5qRYcbT
   WUD6R+vcJPq9pbpY4uSR7X3DHpiN/m0wHDuVUQgHf+VOHfr4TJx+8p0+D
   AAciQ1QDN0scRZtMvxZEAwsHk5Vj+HudY5Wp9HA42M2X0MlIgByuowRni
   Q==;
X-CSE-ConnectionGUID: QdaN0khPRdi/GkFT9Dj9zQ==
X-CSE-MsgGUID: DTG2U0EKRFiOhxra0eyowQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841288"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841288"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:47 -0700
X-CSE-ConnectionGUID: MvL5WyKuQPyY3c6IzA2QPA==
X-CSE-MsgGUID: VUUalZg4T0if8D/vVixaWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565221"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:46 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 2/7] platform/x86/intel/pmc: Enable PkgC LTR blocking counter
Date: Mon,  4 May 2026 21:33:33 -0700
Message-ID: <20260505043342.2573556-3-xi.pardee@linux.intel.com>
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

Enable the Package C-state LTR blocking counter in the PMT telemetry
region. This counter records how many times any Package C-state entry
is blocked for the specified reasons.

Add pmc_core_pkgc_counters_show() as a common helper to display
package C-state blocking counters from the telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 79 +++++++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.h | 15 ++++-
 2 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index c8a92d6235203..7681c444f4bdf 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1071,6 +1071,34 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
 
+static int pmc_core_pkgc_counters_show(struct seq_file *s,
+				       struct telem_endpoint *ep,
+				       u32 offset, const char **counters)
+{
+	unsigned int i;
+	u32 counter;
+	int ret;
+
+	for (i = 0; counters[i]; i++) {
+		ret = pmt_telem_read32(ep, offset + i, &counter, 1);
+		if (ret)
+			return ret;
+		seq_printf(s, "%-30s %-30u\n", counters[i], counter);
+	}
+
+	return 0;
+}
+
+static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+
+	return pmc_core_pkgc_counters_show(s, pmcdev->pc_ep,
+					   pmcdev->pkgc_ltr_blocker_offset,
+					   pmcdev->pkgc_ltr_blocker_counters);
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1322,7 +1350,7 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
 	return ERR_PTR(-ENODEV);
 }
 
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct telem_endpoint *ep;
 
@@ -1333,16 +1361,32 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
 		return;
 	}
 
-	ep = pmc_core_register_endpoint(pcidev, guids);
-	if (IS_ERR(ep)) {
-		dev_err(&pmcdev->pdev->dev,
-			"pmc_core: couldn't get DMU telem endpoint %ld",
-			PTR_ERR(ep));
-		return;
+	if (pmc_dev_info->dmu_guids) {
+		ep = pmc_core_register_endpoint(pcidev, pmc_dev_info->dmu_guids);
+		if (IS_ERR(ep)) {
+			dev_err(&pmcdev->pdev->dev,
+				"pmc_core: couldn't get DMU telem endpoint %ld",
+				PTR_ERR(ep));
+			return;
+		}
+
+		pmcdev->punit_ep = ep;
+		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
 	}
 
-	pmcdev->punit_ep = ep;
-	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+	if (pmc_dev_info->pc_guid) {
+		ep = pmt_telem_find_and_register_endpoint(&pcidev->dev, pmc_dev_info->pc_guid, 0);
+		if (IS_ERR(ep)) {
+			dev_err(&pmcdev->pdev->dev,
+				"pmc_core: couldn't get Package C-state telem endpoint %ld",
+				PTR_ERR(ep));
+			return;
+		}
+
+		pmcdev->pc_ep = ep;
+		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
+		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
+	}
 }
 
 void pmc_core_set_device_d3(unsigned int device)
@@ -1466,6 +1510,13 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_die_c6_us_fops);
 	}
+
+	if (pmcdev->pc_ep) {
+		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_pkgc_ltr_blocker_fops);
+	}
+
 }
 
 /*
@@ -1716,8 +1767,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
-	if (pmc_dev_info->dmu_guids)
-		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guids);
+	if (pmc_dev_info->dmu_guids || pmc_dev_info->pc_guid)
+		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info);
 
 	if (ssram) {
 		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
@@ -1738,6 +1789,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
+	if (pmcdev->pc_ep)
+		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
+
 	return ret;
 }
 
@@ -1834,6 +1888,9 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
+	if (pmcdev->pc_ep)
+		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
+
 	platform_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 118c8740ad3aa..a20aab73c1409 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -453,6 +453,9 @@ struct pmc {
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  *
+ * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
+ * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ *
  * pmc_dev contains info about power management controller device.
  */
 struct pmc_dev {
@@ -471,8 +474,12 @@ struct pmc_dev {
 	u8 num_of_pkgc;
 
 	u32 die_c6_offset;
+	struct telem_endpoint *pc_ep;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
+
+	const char **pkgc_ltr_blocker_counters;
+	u32 pkgc_ltr_blocker_offset;
 };
 
 enum pmc_index {
@@ -486,12 +493,15 @@ enum pmc_index {
  * struct pmc_dev_info - Structure to keep PMC device info
  * @pci_func:		Function number of the primary PMC
  * @dmu_guids:		List of Die Management Unit GUID
+ * @pc_guid:		GUID for telemetry region to read PKGC blocker info
+ * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
  * @map:		Pointer to a pmc_reg_map struct that contains platform
  *			specific attributes of the primary PMC
  * @sub_req_show:	File operations to show substate requirements
+ * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
@@ -500,9 +510,12 @@ enum pmc_index {
 struct pmc_dev_info {
 	u8 pci_func;
 	u32 *dmu_guids;
+	u32 pc_guid;
+	u32 pkgc_ltr_blocker_offset;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
+	const char **pkgc_ltr_blocker_counters;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
@@ -535,7 +548,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids);
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 void pmc_core_set_device_d3(unsigned int device);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-- 
2.43.0

