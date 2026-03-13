Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB132A3FD;
	Fri, 13 Mar 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428016; cv=none; b=rR1WpYDhpcf1v0lDJLolZKVRufgL+1t2W4Ee2eAiTioW+ZU4UfsBeEiqeW/FjR42HTG5QC4Vd15+DkVmJO4grQhwFUFPKOoz4FmRFNJ69TED6i1i6oKHEXP3LNgJPPhxqwZPFDuixJ2xe8909DiiH/ZgjaztrncWucB48fnFliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428016; c=relaxed/simple;
	bh=3OtMXqFbFSdWUgf1tdlAeDRBQKLP+muQc7Cy/0N6gds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcNpsvlVRwhWXX77nXPifwHFDoOMlnVcjKwItBird0S+i85PXGj0gIYHyNK4+Acx6GEfCq8ljSB7CptwY3vhZ4kEdTBO7iUS46zudMAuSjGPadxtzy4dlsvz2ULGUiOACFp65ouLsRN1yf5mj7g7bD95KKcNcyAYAaKiceseVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAls5bnn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAls5bnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428015; x=1804964015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OtMXqFbFSdWUgf1tdlAeDRBQKLP+muQc7Cy/0N6gds=;
  b=mAls5bnnA4mMEQSlyby44jhRQyPnyxb7r7ue3vpvr+l3MZqVwP4au28X
   t0TaQCSz20JVI5mJvJmuyavKOknUOagLoqc54WZs1C3Jrc7YBdnB53lTO
   HCJRloJqnG9t7JgIusyMy0xMjBhMt81QTPR8UZH1+14iZFt3LAFmY5+uu
   RCnMsCSJdaAHXNe0VPX8O5U8G9ijZ3M4EmW+Dw6n+lrHLss0LfxmBzor/
   KDs7QYYwFkC5kHQsD8lzbLC1h5IcDx7+9hPa8RmZtGIg7t2dAK2kB0ePA
   C0eGgAe6Mil8pkjPXldkdorNhY41rkB5hpXbQ1MbhmwCYOBi1/p4Yx8TJ
   w==;
X-CSE-ConnectionGUID: AFKhohu3S4qOyzVAOZMjSA==
X-CSE-MsgGUID: YLg6FMNpTVaHznHnwLB2Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242248"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242248"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: eVevYUkjSQuRstlbep1ORg==
X-CSE-MsgGUID: ujMBoOdFS4GF3dYQ9pZQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709175"
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
Subject: [PATCH v1 2/6] powercap: intel_rapl: Remove unused macro definitions
Date: Fri, 13 Mar 2026 11:53:28 -0700
Message-ID: <20260313185333.2370733-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Remove the following unused macro definitions from the RAPL common
driver:

 * DOMAIN_STATE_INACTIVE and DOMAIN_STATE_POWER_LIMIT_SET
 * IOSF_CPU_POWER_BUDGET_CTL_BYT and IOSF_CPU_POWER_BUDGET_CTL_TNG
 * MAX_PRIM_NAME

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8c838e2e457d..fdcac4a173a8 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -96,15 +96,7 @@
 /* per domain data, some are optional */
 #define NR_RAW_PRIMITIVES		(NR_RAPL_PRIMITIVES - 2)
 
-#define	DOMAIN_STATE_INACTIVE		BIT(0)
-#define	DOMAIN_STATE_POWER_LIMIT_SET	BIT(1)
-
-/* Sideband MBI registers */
-#define IOSF_CPU_POWER_BUDGET_CTL_BYT	0x02
-#define IOSF_CPU_POWER_BUDGET_CTL_TNG	0xDF
-
 #define PACKAGE_PLN_INT_SAVED		BIT(0)
-#define MAX_PRIM_NAME			32
 
 #define RAPL_EVENT_MASK			GENMASK(7, 0)
 
-- 
2.43.0

