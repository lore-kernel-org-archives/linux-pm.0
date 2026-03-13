Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950233DF00A;
	Fri, 13 Mar 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428019; cv=none; b=QWt5zjlZTjS0h/IPo5nYwpVdj8WH7rLam77j+2lYAOuGZkRciQiWatlROuT/AayF7u7PVgyvAyBZC7/OYzPHc4WHG/3P4tlcXX9rBqqArKKsLF1j+s3QoGCZ6+T2aCvAd6ZlcrfT4MdEE58SOxW/OB1mk1hWoH1E1/ER21o2Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428019; c=relaxed/simple;
	bh=uLFhRLmnl+H6fX4Tj4A7q2oeiwiC8C76u4nHQ95EG2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abcbK4iDiKkMXDopY8Tlqq3U8rZyTD+DY5/N0C38ywVLfAPjAK6X6epAotM3gUAHJ0cWvvh9CLdOhVKACJwBTGttTY4JtfiDT7geXrylfg0iCcGuVdXCjlIkFom8nVN8dE4xDbqCqdTQwk+j4nbdPNn7xc9Bc1gSIb9ii+MjnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juRJ4qVk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juRJ4qVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428018; x=1804964018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLFhRLmnl+H6fX4Tj4A7q2oeiwiC8C76u4nHQ95EG2o=;
  b=juRJ4qVkKZZIN+leZ9Uzq7MV8oCh9uaNpCgivAA69fDMlfkaSQhIeNg9
   ScM61Hi2sDDeY6qiZUJwlRkNkHhrEFsBPQ4KDJusx+NsiSLhmKW5/YCaR
   hwqodFSJUBUp/kFaTb9Gwlej/EnddLgxci03nXhWmagQMb7YlgfXa5Ip8
   5q/elEowEv1hLc5bsH7FDaAov2T15nqaQLh0rMAYx463Cf+Dpd7shc3WS
   dFDRRdZ3WWNUL1aiEFqtQyVxPkw1vh8cE22GbbJxMU9L4lyH8iKfQOP/I
   7BpbV7x5L9vlC9cf+G7XikFdYdroUAYw3i6Gp1ByYWwOfxS12WCpMN48p
   Q==;
X-CSE-ConnectionGUID: TK24tqfrRA+EEt18pcPbzA==
X-CSE-MsgGUID: Ding33vBQaKmavOl3V0OBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242244"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: 76gfYKJgQNaNjsNSA5FIuQ==
X-CSE-MsgGUID: 5aA0rjRqSqGKZrJnZF+wMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709172"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] powercap: intel_rapl: Remove unused AVERAGE_POWER primitive
Date: Fri, 13 Mar 2026 11:53:27 -0700
Message-ID: <20260313185333.2370733-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AVERAGE_POWER primitive and RAPL_PRIMITIVE_DERIVED flag are not
used anywhere in the code. Remove them to simplify the primitive
handling logic.

No functional changes.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 13 -------------
 include/linux/intel_rapl.h           |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2b5c587b222b..8c838e2e457d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -89,7 +89,6 @@
 #define TPMI_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(60, 54)
 
 /* Non HW constants */
-#define RAPL_PRIMITIVE_DERIVED		BIT(1)	/* not from raw data */
 #define RAPL_PRIMITIVE_DUMMY		BIT(2)
 
 #define ENERGY_UNIT_SCALE		1000	/* scale from driver unit to powercap unit */
@@ -700,9 +699,6 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 						      19, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	[PSYS_TIME_WINDOW2]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK,
 						      51, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	/* non-hardware */
-	[AVERAGE_POWER]		= PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
-						      RAPL_PRIMITIVE_DERIVED),
 };
 
 /* RAPL primitives for TPMI I/F */
@@ -742,9 +738,6 @@ static struct rapl_primitive_info rpi_tpmi[NR_RAPL_PRIMITIVES] = {
 						      54, RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
 	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK,
 						      0, RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-	/* non-hardware */
-	[AVERAGE_POWER]		= PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
-						      RAPL_PRIMITIVE_DERIVED),
 };
 
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
@@ -837,12 +830,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	if (!ra.reg.val)
 		return -EINVAL;
 
-	/* non-hardware data are collected by the polling thread */
-	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
-		*data = rd->rdd.primitives[prim];
-		return 0;
-	}
-
 	ra.mask = rpi->mask;
 
 	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, pmu_ctx)) {
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 6d694099a3ad..9e6bd654be1f 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -77,7 +77,6 @@ enum rapl_primitives {
 	PSYS_TIME_WINDOW1,
 	PSYS_TIME_WINDOW2,
 	/* below are not raw primitive data */
-	AVERAGE_POWER,
 	NR_RAPL_PRIMITIVES,
 };
 
-- 
2.43.0

