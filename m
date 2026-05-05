Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C93B8D48;
	Tue,  5 May 2026 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955630; cv=none; b=iaECg10hZ738e5eaSDQR6J8bSss4eNSqvAMwZckHj+saNaDeUlhTw2FFnf01pbql/ygfjOMEH9i5lCfR3PzPOZibcfWzX0dM27/PP+yoYrKDK9zW48NM6i0FggsJBL8AYVbRtjJkJWZ59/p/FQH1iQTYGgUIi+nNM0+u+2wQbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955630; c=relaxed/simple;
	bh=/k1MUmF0MwnBDRN+1puSdwUT2Q4EMuWVs8AvXDkl1RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv07l0nOPBujUs1sVK0+p4MhqZ7dYRhmvOTDft7Iy6P6ONzT8TPT+1S+ssR2vyG498D+Nzml0Ucr8LVgklTXanIu6WvxmHirqwWidms2el+ltvaqXRBbK9T1L3vyEebAd5X2KdH/PCThrQZCIouOm+GjY+0FE0LQUratzXH4NRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It8VyN4N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It8VyN4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955629; x=1809491629;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/k1MUmF0MwnBDRN+1puSdwUT2Q4EMuWVs8AvXDkl1RY=;
  b=It8VyN4NoAYt+xNdbFjNefVKW+ImURzbcbfbSQD40gRNmbSJiDtVz4Rq
   UNWMOtyyV6J62pLZuSfEp4G7OyKGOKpF+YgMGNgEYLUm2VTyG45ze/Wag
   sasBjS9Cwp2x0TcwPyqUfBPInxeZH8PR4Ka/4rhpcbFHR7+bC7x7TEQEl
   dVsNRTI6j79rXdmRxirotDW8KDL+2Lk1a9pIk/QzFyFU/E1zz6rFacH+8
   UoXrOQ2MYiVUCYaIffyByXOYlrS1uUrawqPV8C4jkWJPy6X3HuocpgC/6
   H/HbOpfso7LEix4gFZ8/2sRBRqulZJeiPCG43ePjfheyplhzVu6zHJdwf
   Q==;
X-CSE-ConnectionGUID: 5wDTxXaKQ8+3VbvxhtyWuw==
X-CSE-MsgGUID: 4bFK+OfrQCCbxIrqeSODQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841289"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841289"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:48 -0700
X-CSE-ConnectionGUID: 7pfhti5TQtaB79tUPI/5mg==
X-CSE-MsgGUID: fUbRIFBGSdy2g53qqoaTlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565225"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:47 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/7] platform/x86/intel/pmc: Enable Pkgc blocking residency counter
Date: Mon,  4 May 2026 21:33:34 -0700
Message-ID: <20260505043342.2573556-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
References: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the Package C-state blocking counter in the PMT telemetry
region. This counter reports the number of 10 µs intervals during
which a Package C-state 10.2/3 entry was blocked for the specified
reasons.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 15 +++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7681c444f4bdf..94ae098a155a6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1099,6 +1099,16 @@ static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
 
+static int pmc_core_pkgc_blocker_residency_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+
+	return pmc_core_pkgc_counters_show(s, pmcdev->pc_ep,
+					   pmcdev->pkgc_blocker_offset,
+					   pmcdev->pkgc_blocker_counters);
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_blocker_residency);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1386,6 +1396,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
 		pmcdev->pc_ep = ep;
 		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
 		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
+		pmcdev->pkgc_blocker_counters = pmc_dev_info->pkgc_blocker_counters;
+		pmcdev->pkgc_blocker_offset = pmc_dev_info->pkgc_blocker_offset;
 	}
 }
 
@@ -1515,6 +1527,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
 		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_pkgc_ltr_blocker_fops);
+		debugfs_create_file("pkgc_blocker_residency_show", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_pkgc_blocker_residency_fops);
 	}
 
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a20aab73c1409..829b1dee3f636 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -455,6 +455,8 @@ struct pmc {
  *
  * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ * @pkgc_blocker_counters: Array of PKGC blocker counters
+ * @pkgc_blocker_offset: Offset to PKGC blocker in telemetry region
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -480,6 +482,8 @@ struct pmc_dev {
 
 	const char **pkgc_ltr_blocker_counters;
 	u32 pkgc_ltr_blocker_offset;
+	const char **pkgc_blocker_counters;
+	u32 pkgc_blocker_offset;
 };
 
 enum pmc_index {
@@ -495,6 +499,7 @@ enum pmc_index {
  * @dmu_guids:		List of Die Management Unit GUID
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
@@ -502,6 +507,7 @@ enum pmc_index {
  *			specific attributes of the primary PMC
  * @sub_req_show:	File operations to show substate requirements
  * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
+ * @pkgc_blocker_counters: Array of PKGC blocker counters
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
@@ -512,10 +518,12 @@ struct pmc_dev_info {
 	u32 *dmu_guids;
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
+	u32 pkgc_blocker_offset;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
 	const char **pkgc_ltr_blocker_counters;
+	const char **pkgc_blocker_counters;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-- 
2.43.0

