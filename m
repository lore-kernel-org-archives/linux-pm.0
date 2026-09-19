Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC137083C;
	Sat, 19 Sep 2026 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795117; cv=none; b=YCX2EJ/Ns98S8bZbUyx51n9K13MxPhLaFa9I+O8owlA4Fex2wwhPhuV0gUfooeVsYXayn3BUZ509fvlswAgCDoz3woYa7W6bkfgHDM6ijTkPtSvfZRVngaD9w0V/UxyiP04ynPUoNztUsaL5SY+MVKqEM3p559Ss2NVaEEGG33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795117; c=relaxed/simple;
	bh=a8qdtL7EWICimlI1nt2nXMPjAaA3O6GDY2kFEuzOOqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dbhJ5u+k+NG3i/CBlIRF3sR6hvsYpPazGL3YowaE7E5TX/HnZybN7appg6afOq1G13VHhBK2GYKqUP36EdgD9jJVOfLBAaCqi++pLt7enmCePb6C13ehe3UZByw5j1vcJEm0G9gE6kg5Papr5J42S5LAdJR9d8FK+nXr0RWNiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+XISzl9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+XISzl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789795114; x=1821331114;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8qdtL7EWICimlI1nt2nXMPjAaA3O6GDY2kFEuzOOqA=;
  b=R+XISzl9JLNjj7yhjC4hbmIVhvjgBUJ9CAm/L5rfo695Tt8y7RCdrHea
   +XmJx9Oa0O9k2vZktZI31WlbkRmUiKR1RC6AuasS5YyDmVdP68sfjUKzc
   NKh+bbadosRxUEj/TLvALo2abgLITw2Y+F7NsiwA/R6Wo0TC0jJbxEAur
   fgczlO2aTvMqUEgbKGamGuK93/y1zC/az6/PdodlUd7itmoiI9MY9YK5d
   QkELkVzOUjBzC7D1hFSMBoh2SgWdEdx+eZw1VR+JKsdwVjo8wN4Bc0qdS
   2TzjPq1czBQonNuf2wXhIJZBHiFMHhkNqdv1igiO6sk79zCJiatC/vwcG
   Q==;
X-CSE-ConnectionGUID: kFQUX324SaiVT/+CK+bcUg==
X-CSE-MsgGUID: /QvL04KiSyOP2pssRZCvDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="100996810"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="100996810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 22:18:34 -0700
X-CSE-ConnectionGUID: zVqK4maSTgmqONh6odSF3A==
X-CSE-MsgGUID: R3XfW6M4RIiPStawKauQ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268422215"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.109.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 22:18:33 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmc: Fix stale NVL PCD-S S0ix_LPM telemetry constants
Date: Fri, 18 Sep 2026 22:18:28 -0700
Message-ID: <20260919051830.565240-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Nova Lake PCD-S S0ix_LPM telemetry layout changed. The PCD-S telemetry
GUID was changed to reflect the layout change, per the client GUID
revision rule.

nvl_pcds_d3_status_1_map[] was correctly updated, but two companion
constants were never updated to match:

 1. NVL_PCDS_NUM_S0IX_BLOCKER (core.h) is 71 instead of the actual
    number of blk == 1 entries across nvl_pcds_blk_maps.

 2. PCDS_LPM_REQ_GUID (nvl.c) is still 0x01091102. It was never
    bumped to 0x01091103 to reflect the S0ix_LPM telemetry metadata
    layout change.

Both constants describe the same S0ix_LPM/blocker telemetry region
for PCD-S, so fix them together in one change.

Fixes: 41354f4c8a79 ("platform/x86/intel/pmc: Add Nova Lake support to intel_pmc_core driver")
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 2 +-
 drivers/platform/x86/intel/pmc/nvl.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b4c7399f8369d..e55164e5807fd 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -323,7 +323,7 @@ enum ppfear_regs {
 #define NVL_LPM_LIVE_STATUS_OFFSET		0x1760
 #define NVL_LPM_NUM_MAPS			15
 #define NVL_PCDH_NUM_S0IX_BLOCKER		107
-#define NVL_PCDS_NUM_S0IX_BLOCKER		71
+#define NVL_PCDS_NUM_S0IX_BLOCKER		70
 #define NVL_PCHS_NUM_S0IX_BLOCKER		54
 #define NVL_PCDS_PMC_LTR_RESERVED		0x1bac
 #define NVL_PCDH_BLK_REQ_OFFSET			53
diff --git a/drivers/platform/x86/intel/pmc/nvl.c b/drivers/platform/x86/intel/pmc/nvl.c
index 8dabf2511dd9d..1ed02332dbfce 100644
--- a/drivers/platform/x86/intel/pmc/nvl.c
+++ b/drivers/platform/x86/intel/pmc/nvl.c
@@ -14,7 +14,7 @@
 /* PMC SSRAM PMT Telemetry GUIDS */
 #define PCDH_LPM_REQ_GUID 0x01093101
 #define PCHS_LPM_REQ_GUID 0x01092101
-#define PCDS_LPM_REQ_GUID 0x01091102
+#define PCDS_LPM_REQ_GUID 0x01091103
 
 /*
  * Die Mapping to Product.
-- 
2.43.0

