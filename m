Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0073BE146;
	Tue,  5 May 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955632; cv=none; b=tu56zla/3X2lukImPLWgjedXpKIgcMB2ocMcgUJAWlB+dVnhhoesBtkO4fZdwB8xb9TiYPcaRAP2/zn3vNXOCkRktgavLF+DmGU7iQmv5xQkuaYOuNTatYX0auXwuMWFV4B6r47cuY8KN7KNLTjEmK1AM+77k5ouWei5H2E5gJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955632; c=relaxed/simple;
	bh=zdsFh9CCF4yWumERgPuuCxcROsqxoVitxlzTyk7VDKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjQkOJgUhIokRo8+5MRqQQ6hxsy02uc86qzn3j28Z3vLxXcDsIIhUjsGhKjtMISa2UAj4dqkpatTTY0BUbYY1divB4bVVnNtJ4SvsZ5JmneYlNGml17MNkJYC1b3yZ0qNHtWpSQDUl7GIz31epZ4RjAw9zeY5+B0EoUd3UAH36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8t2pT5y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8t2pT5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955631; x=1809491631;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zdsFh9CCF4yWumERgPuuCxcROsqxoVitxlzTyk7VDKk=;
  b=Z8t2pT5ywJXSBP0bDikrYzbTFd2U5E49+NCNlnByHyWbFcacij8wM8Kv
   XKxQtQKIq9M6E0kgQ3S8fLivsdzzM+hqUtKf5lpRxZDrxpN23Dp2Mxn1P
   801H1VTm1fpVplHbwCMuNN6hDZ7g6qMIOdHpM8WWRfUNWxBgJzAfLcPFu
   5AAqafWvQU31cr374j1zaAH3fHS2hpaWM6Iy26Ggtkstnre6mwUw5TO9k
   k5KjkOSrmH4fZd2NKbjZjIqb7+3jRtej+yCyVkZPJL4HYYI9V9KGbjs+C
   YqWW2sExxiL8qPJrhkRtSR86f8uCTZYsC4uY559Q6YH1Ne1ZqvldWx0Dt
   w==;
X-CSE-ConnectionGUID: L7TkOdseQ5eVDRwqT4jOlQ==
X-CSE-MsgGUID: Gn+FlKrwQTq/vS2W48rErw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841291"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841291"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:49 -0700
X-CSE-ConnectionGUID: jN8wo7VHQcGNZrj5b6PisA==
X-CSE-MsgGUID: w16L7LTvSxCSs7Fx49UhiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565232"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:48 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 5/7] platform/x86/intel/pmc: Add support for variable DMU offsets
Date: Mon,  4 May 2026 21:33:36 -0700
Message-ID: <20260505043342.2573556-6-xi.pardee@linux.intel.com>
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

Add support for handling different DMU Die C6 offsets across platforms.
The previous implementation assumed a uniform DMU Die C6 offset for all
platforms, which is no longer valid.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 ++
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 2 ++
 drivers/platform/x86/intel/pmc/mtl.c  | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 95372a0807acf..4d91ee010f6d0 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -729,6 +729,7 @@ struct pmc_dev_info arl_pmc_dev = {
 	.init = arl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
 
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
@@ -742,4 +743,5 @@ struct pmc_dev_info arl_h_pmc_dev = {
 	.init = arl_h_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e0ac329e6723a..5d2e2681b0eba 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1381,7 +1381,7 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
 		}
 
 		pmcdev->punit_ep = ep;
-		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+		pmcdev->die_c6_offset = pmc_dev_info->die_c6_offset;
 	}
 
 	if (pmc_dev_info->pc_guid) {
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index f385a0eccd2c2..ef69de160ffbc 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -514,6 +514,7 @@ enum pmc_index {
  * @init:		Function to perform platform specific init action
  * @sub_req:		Function to achieve low power mode substate requirements
  * @ssram_hidden:	Some SSRAM devices are hidden on this platform
+ * @die_c6_offset:	Telemetry offset to read Die C6 residency
  */
 struct pmc_dev_info {
 	u32 *dmu_guids;
@@ -530,6 +531,7 @@ struct pmc_dev_info {
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
 	bool ssram_hidden;
+	u32 die_c6_offset;
 };
 
 extern const struct pmc_bit_map msr_map[];
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 193ebbe584023..b724dd8c34dba 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -1003,4 +1003,5 @@ struct pmc_dev_info mtl_pmc_dev = {
 	.init = mtl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
-- 
2.43.0

