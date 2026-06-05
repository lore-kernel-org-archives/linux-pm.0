Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0533DEC2;
	Fri,  5 Jun 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680675; cv=none; b=VaYjoSxE/633iCXJzp1RR/zWea/iANfsPAA1hTbh3Nrrui7UUVs+CB17ySidVGXOJKEmsrOWnbQpZPu7VG1bAsTyWritl50QcNsCm5C/ol98CotjYGVkaOOqQZe8MfIzfG3sWUaGh1grFwEhHVKBVuQwl4ZS2ZV5e4zBc7kop9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680675; c=relaxed/simple;
	bh=KJZg+4nofOAYmOTYH/rq/MbTThlO3btzHuWDZMJp0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYi5ESsYXsVfh1QLJX/QT2Y7LwkubB8ChjvlV4rpcIEtv9eGxcPgWY1/uCpeejV3nB1X2c4Eh0lbdBqyuW/B6bsdujvzLekYjHYj9w7r0B/HUwskl2t+Y0BYNwG/P2GZJMg6Zj9uwGIDg6ifza9RF1LoyGvg5FGj7SWI5o3tQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm+qFcSt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm+qFcSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780680666; x=1812216666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KJZg+4nofOAYmOTYH/rq/MbTThlO3btzHuWDZMJp0NM=;
  b=Bm+qFcSt/Z02G7LY7WGZrGQv/Ws9n4Mrxih/1zjBsmpMxV5MoPpOLKeo
   fYZi/0/l1RrHnugKYjJBnNO422kEZOL+ZjwG+FJTHgSL3e0eFLhiA0Y14
   i7w29FrK3BfKyX1yMO9MSMlDGT6uSd2thrx0RprZUNBXHPE0dEJ1v4ct+
   JN3EdGOVM0JU/qMCCMvtlO5i8QQ8xmmqGCBa03fmyFKhQJmMqbMOEfUnV
   nGCUiBBLu/chOwcTX8GhwSA5wBWDi3FPGKv4dyrl7LlNTHklun+DHGEOp
   cg4RhQELbopheUOMLQsA84Tdn5HsC7Sx2EjTW9lcpjAy/5fzxv2nSA6lh
   A==;
X-CSE-ConnectionGUID: VbhEdnzrQva3S802l3BEiQ==
X-CSE-MsgGUID: 2mo10tuIQBuiF+gA6HIsnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92893776"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="92893776"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:31:05 -0700
X-CSE-ConnectionGUID: nNfQ2dFkT6uk7oixSCBpcA==
X-CSE-MsgGUID: F6jbnA7CQ721V+q0nG7qwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249233862"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa004.jf.intel.com with ESMTP; 05 Jun 2026 10:31:04 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: intel_tcc_cooling: Add Arrow Lake CPU models
Date: Fri,  5 Jun 2026 10:30:54 -0700
Message-ID: <20260605173054.2050476-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Arrow Lake CPU models in the support list.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c2ba0ba3178..52ea4f7fc9f9 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -65,6 +65,9 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
-- 
2.54.0

