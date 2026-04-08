Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C203A451E;
	Wed,  8 Apr 2026 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686912; cv=none; b=lFQW8Q3XvKcmWVodhyrByujJUrmjoacfT+SscTYfEVTFr/pkPQAbocu1qJmCw4VnnLMvysXPW7G1JictLVBa+Jv1fcpdmCdieGfMI00Y446Gp/Wr4+vC4C8qUMgjBLcgpB8fJKloGxsTrRi+aznfFeYrEMLMOnzC+dzlwp97+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686912; c=relaxed/simple;
	bh=r+5kWdKlD1qb3CPwzROwOzZVAFhvsW7nzbj7++lggSI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkModOBcF+r6eqo9TvCxT5paHUzdDYbXW5cnwAyPEBZDB+HyhZDit3Q84QA+z0oH8p0DvJKzLVNRkT7M05D/y5EU7jZYSXrQpZekWMyLK0vA0rbs+HQTtD/3HKPCMXb8C7LxEdEgy8b3rIhNjGduvGYNRT6TllTPYZz70Ca1xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7jw8C8v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7jw8C8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686911; x=1807222911;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=r+5kWdKlD1qb3CPwzROwOzZVAFhvsW7nzbj7++lggSI=;
  b=Z7jw8C8vtTR4qxTD9RuF4mBwIQZca7HkwlkenIpAozzcaFLCe/26Tm6v
   rHsK0LbKLqNY6/sR58tF53FNgkMJmFvd++B9c4PG2VSnaOslUx5AMB1LI
   b+IOip0ZDgszQ8133CvfVTijofD3iXdI3ibmlSWF1vICF/71Yozon0brE
   rpTi0NuOf+smCTgjG2Sie9EQtYnnjxgX0BMn/iETDHEFAQjoZEgR1bH5Z
   gwN9DONlMkdtalTomm6sUlf3gvIuMpgokqUmYBYSqN+Ncb0uXpdexjg5F
   C5gY+eg2qKWjUxBep+pcGEB0lA340Qn/+bYzMgcj2+SQC5VnWnVVIeqFJ
   g==;
X-CSE-ConnectionGUID: V5WZaWB1Tm6L82q/fLSNWA==
X-CSE-MsgGUID: KQHeRL7DR2GSUIX9tjbkUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068077"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:49 -0700
X-CSE-ConnectionGUID: NBZZ1+v5SQCh8mx8aCELeg==
X-CSE-MsgGUID: smwp2o+oTieDgr+iCgCj/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837828"
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
Subject: [PATCH v2 3/7] platform/x86/intel/pmc: Enable Pkgc blocking residency counter
Date: Wed,  8 Apr 2026 15:21:36 -0700
Message-ID: <20260408222144.3288928-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
References: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the Package C-state blocking counter in the PMT telemetry
region. This counter reports the number of 10 µs intervals during
which a Package C-state 10.2/3 entry was blocked for the specified
reasons.

Create a common helper for pmc_core_pkgc_ltr_blocker_show() and
pmc_core_pkgc_blocker_residency_show() as these two functions
share similar logic.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 40 ++++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  8 ++++++
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5c519942ec58c..94ae098a155a6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1071,29 +1071,44 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
 
-static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
+static int pmc_core_pkgc_counters_show(struct seq_file *s,
+				       struct telem_endpoint *ep,
+				       u32 offset, const char **counters)
 {
-	struct pmc_dev *pmcdev = s->private;
-	const char **pkgc_ltr_blocker_counters;
 	unsigned int i;
 	u32 counter;
 	int ret;
 
-	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
-	for (i = 0; pkgc_ltr_blocker_counters[i]; i++) {
-		ret = pmt_telem_read32(pmcdev->pc_ep,
-				       pmcdev->pkgc_ltr_blocker_offset + i,
-				       &counter, 1);
-
+	for (i = 0; counters[i]; i++) {
+		ret = pmt_telem_read32(ep, offset + i, &counter, 1);
 		if (ret)
 			return ret;
-		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
+		seq_printf(s, "%-30s %-30u\n", counters[i], counter);
 	}
 
 	return 0;
 }
+
+static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+
+	return pmc_core_pkgc_counters_show(s, pmcdev->pc_ep,
+					   pmcdev->pkgc_ltr_blocker_offset,
+					   pmcdev->pkgc_ltr_blocker_counters);
+}
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
@@ -1381,6 +1396,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
 		pmcdev->pc_ep = ep;
 		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
 		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
+		pmcdev->pkgc_blocker_counters = pmc_dev_info->pkgc_blocker_counters;
+		pmcdev->pkgc_blocker_offset = pmc_dev_info->pkgc_blocker_offset;
 	}
 }
 
@@ -1510,6 +1527,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
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

