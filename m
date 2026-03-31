Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDE451062;
	Tue, 31 Mar 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992008; cv=none; b=JNaHDf9EM/caydZjpNIonI4IcpbldHuj2v5A7MxCabybIL7KA6ZrUwXQMxPRcSdm/pdS4mL58y6bEldy4jOgrmbn90+CPYUHOe7gr7tjHkQUIF3iV2S90S3CIUraiyzuoxI32odM9Va9vUi+BSmO+jx26HYft4NnODGNigyb4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992008; c=relaxed/simple;
	bh=Wlgq/GJQ17O0CagfH5vfnmnkd5gBCgDkLxovD+l/sak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRDN80iPSYVvNMHlXROPVNAFs6P/QY9OymW9e/GO6wOEhqeLjYJWH0maSduH22LmnzI5V8exXpJCwYYQ/CKxw+v7//PUUQY/epQNJpaiemWCFp1wqiRlriOpkVPtMGFOluR06I0CAVfNO2cUgK8fr6npV/9FBwcledL2mXJh5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSplZ0lI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSplZ0lI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992007; x=1806528007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wlgq/GJQ17O0CagfH5vfnmnkd5gBCgDkLxovD+l/sak=;
  b=BSplZ0lI13zfx33fpaIfy85Aax3SBW61jA0warKccvcvlyG2CcCOgTDS
   mx4hxs46iJjwfXEixtyqcLqROz95nNuTM1VOZKqoN5eZUJ/WVUl9Q0WY4
   ssPpt3gJ45YpfNNyeeJDGJqf764AMKnRsGtk/lyb760523Va9ts2D7j+I
   SHS58rlv96z6LmmaXSqWId3nVYWtm9XW9eKXqRRUAK0ylWeXGP1DDD4R7
   CIqNjAU0SFyYRaPUK69U4gnwFJXNg/xIQ1q1AGNYcuocnRPnFws3TVrAI
   NaJPNUGw5hHinrSsZDHyTJSV3sB56R2zQJoaepGmPaThhhI+TW+dGOdC8
   g==;
X-CSE-ConnectionGUID: cs0Xu5lGT1+MIm2XoyRhvQ==
X-CSE-MsgGUID: c0GI7vqOSxKGmZWLcxlgGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79625012"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79625012"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:05 -0700
X-CSE-ConnectionGUID: 5Fceg9NTSaibRk9xBa2wKA==
X-CSE-MsgGUID: ihdaIMaJTfyLZRrAKSrW7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221627109"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:04 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] powercap: intel_rapl: Remove unused macro definitions
Date: Tue, 31 Mar 2026 14:19:45 -0700
Message-ID: <20260331211950.3329932-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 1e8146283009..f2637cc2cc6a 100644
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

