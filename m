Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC381385502;
	Wed,  8 Apr 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686912; cv=none; b=ohHI7q6HwC18/AUDU297/haLn7M0QoZx6sMUaRGgqafAwjdu9NnT6BmHoXj6mIqMw/hTU+FJ2FLtPdgWosPIKNiSOovhp2ARjMolhHbopmEwfzMJsByXlSyZT/x6WJPfVgKPm74ucdy7SmTM54JNu6hJg6BJhOfLYsha2ELEfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686912; c=relaxed/simple;
	bh=EHR8uC/EOCKGygtxJT4FTc44rZFfCWiTk+DZ32X05QQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUKE8Rop1U/UWXzDHs/jxX9/CDMeNZzjLlgAJ+qPDtfqxb+jvxjlWbENZg7LhMnVC9ztCp1vbfVXBPXqIRoUpWE+KOnJQy/pJGn4zrCs0gmU8GEuYytJOLSkrYM4AAo6aKvkCxkHdO6D3fgf2kg7SKefV+NIMSG6kV+0ezRokX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9iiwS0p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9iiwS0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686911; x=1807222911;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=EHR8uC/EOCKGygtxJT4FTc44rZFfCWiTk+DZ32X05QQ=;
  b=N9iiwS0p9ll2ECrkSX4H1bh62JezLtdaBoAcxW0ilfarV21HmwCILTnC
   pgGeW9PXqsKtzUZCkbo8zY/Mh8duVSr7ctAQQVrdUH05djhjC6swO79Nv
   3XcuHshfTAgItEj0ah/V/bL0Xul0F2NxT04WVFtfLGxsegH5h1wmCQx3m
   sLLshT5xvZyIeW/EkZwq5BBoiBXmL68ZBOevTMKk2Y929ht1ou4Bn3WOP
   bBoJqgPrbB8S+PLXQV3q6p/KamuATnP+i0yUps68zWTRbeuh3eVCQKb/J
   Fl/yY7M+gwx0QHM+1StdHN8J83GjAO67fFbv72TbIPAGFjiIeMum3ihG9
   A==;
X-CSE-ConnectionGUID: zsoVRqDZQsWS7pDB9ghSNg==
X-CSE-MsgGUID: D/GoUZMeQHGGMH4hTFuDEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068074"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068074"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:48 -0700
X-CSE-ConnectionGUID: PV73TY5RSj+dH4H9wcLvqQ==
X-CSE-MsgGUID: R5RPC4QeQwSaHb3ws35FcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837825"
Received: from aschende-mobl.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:48 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/7] platform/x86/intel/pmc: Enable PkgC LTR blocking counter
Date: Wed,  8 Apr 2026 15:21:35 -0700
Message-ID: <20260408222144.3288928-3-xi.pardee@linux.intel.com>
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

Enable the Package C-state LTR blocking counter in the PMT telemetry
region. This counter records how many times any Package C-state entry
is blocked for the specified reasons.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 74 +++++++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.h | 15 +++++-
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index c8a92d6235203..5c519942ec58c 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1071,6 +1071,29 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
 
+static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const char **pkgc_ltr_blocker_counters;
+	unsigned int i;
+	u32 counter;
+	int ret;
+
+	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
+	for (i = 0; pkgc_ltr_blocker_counters[i]; i++) {
+		ret = pmt_telem_read32(pmcdev->pc_ep,
+				       pmcdev->pkgc_ltr_blocker_offset + i,
+				       &counter, 1);
+
+		if (ret)
+			return ret;
+		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1322,7 +1345,7 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
 	return ERR_PTR(-ENODEV);
 }
 
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct telem_endpoint *ep;
 
@@ -1333,16 +1356,32 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
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
@@ -1466,6 +1505,13 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
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
@@ -1716,8 +1762,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
-	if (pmc_dev_info->dmu_guids)
-		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guids);
+	if (pmc_dev_info->dmu_guids || pmc_dev_info->pc_guid)
+		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info);
 
 	if (ssram) {
 		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
@@ -1738,6 +1784,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
+	if (pmcdev->pc_ep)
+		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
+
 	return ret;
 }
 
@@ -1834,6 +1883,9 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
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

