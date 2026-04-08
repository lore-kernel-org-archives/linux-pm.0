Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FB3A5E76;
	Wed,  8 Apr 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686914; cv=none; b=eJtfw1cGhuCDIHRNRV4hnRdX5AmplRkmijx1VV5gIzsT+mYZSYomf4DiFXcDvG6VgVn5qVY2es1hkTjU9oJ0oQuHd9hbeGyXyJsPdwQXnXid+bJ4vKv/QLhQGZab5wzaqe/Y8YWVg5YtPOy1vUEgvoEgB4aTq+SCrBfn7ROQuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686914; c=relaxed/simple;
	bh=zdsFh9CCF4yWumERgPuuCxcROsqxoVitxlzTyk7VDKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yte3K556T0NezA/L+Z534scmL268WghuObAKHwIP6Z3k/Ss7Z8ANKAIFiS6oXyk25YWVC1L+wNmXhFF3So+saua96zbAsF8OsCvKZIWTSixpkDZfp7S2WJl/peIH9qOhyBTqpy7Irqo7+rp/2S1dYQMu56oqivI9iBlI6RQOYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMburVaC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMburVaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686913; x=1807222913;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zdsFh9CCF4yWumERgPuuCxcROsqxoVitxlzTyk7VDKk=;
  b=QMburVaCXsSf4Ybv5P83zdvwrOzjDOQgjlAR4Y7gblZY8mVipAMbrEGt
   MdxZk8ssVphkpmlNaK1RvWEo5vBykL2CSI1SEKAw9q8bx6AwBjSdFuvpL
   Mq6om+oqo+GuNxhPTFDpdd3J0BC01HOcrsxhEo8HlLv0rgXx5l2pzfj7F
   AChZzkKftRPHndsL7sqvSXR5ppFiSvJlJMSitt+7JyiqqZqpDdMUrn8Zr
   JiXIHVCeWMYCWAPzzzfYD91JlcViB9Fy55apSYhmcKq3vPY//le1gAxbm
   MZBUAnd+yni/yL53eUOZkviluo0yKAwmC94X+NpOfB4bssSASY3CFJZeX
   g==;
X-CSE-ConnectionGUID: UM0kavHySLKcPPlt1eORtw==
X-CSE-MsgGUID: hXzHPvJZSN+GPRzshx7Ogw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068085"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068085"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:51 -0700
X-CSE-ConnectionGUID: NZ44cgGCQPyWWMq8VHZnoA==
X-CSE-MsgGUID: Du/53v2SSkufbzNlpyAd5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837830"
Received: from aschende-mobl.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:50 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 5/7] platform/x86/intel/pmc: Add support for variable DMU offsets
Date: Wed,  8 Apr 2026 15:21:38 -0700
Message-ID: <20260408222144.3288928-6-xi.pardee@linux.intel.com>
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

