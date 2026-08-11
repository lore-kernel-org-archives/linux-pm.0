Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B2416139
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436504; cv=none; b=bfc0/jhO3JJOoSf4h8ioapxm64wy03vG3Rm5e0CThg6CVTpYC/sUqGkswsf0xsy6zUkZxTzGQN4NjBjQBHw//nGQAJqBTON0mPjb8p7HKYUYxpBvlWkdwgKyTLb2Z6vpVcw4Mexc/uCcEktyDjmnSk6SpFNy9X+W0f0KNK108eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436504; c=relaxed/simple;
	bh=1P60yeqQ3jiIxpYyG9voDbKPXLyZCOei7vSuoqYbXR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2kx5MROv0SYzg+VHP31x+kpsy5/nie91/Olr8GZq/SvP59CiWWufvvrZ8gTsrYA4Rn1AZzG9Lq49a1YgIbX2dVLop5iM6JPqwoqZepP6C64VM859k4N3htyC/gDvvBLo3s+5k1WReZ5GeL0kaSArks1SBsU5kQdXNLWXwHG0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SliWy1FW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SliWy1FW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786436500; x=1817972500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1P60yeqQ3jiIxpYyG9voDbKPXLyZCOei7vSuoqYbXR0=;
  b=SliWy1FWZpxWSh6lCJ1OmFktHfNuHQqEUzBMT7o1XlJhOt/qRo0Gf1BV
   asgPymuwfgzC80mEIOcjd4qCgw9DEj/WL1CiWStyAO+Q2n/OTBwzfnsqj
   0+w++souq0jBGa1EUevkF4IzO7X65JT89YmXi65aAU7ntARjWQsocgu4Z
   CjleHG8TixnQ6ZPSnyek5NxwpDk5fs+L6KDI7loGwip0i8mQDImgghdJe
   O3Y50V75pDhSW4eeyxl8HNfCCGLwVy/q5c96Zz3aB4UMCUOIrZFKqYh37
   Vb4q1lgrdfbu1CtY0yNw109lBcB1tvX9w/KMeA3KddTIWS2SRPY+ljEKs
   w==;
X-CSE-ConnectionGUID: uyv47nFURDa7tDmi3kY+VA==
X-CSE-MsgGUID: g347jR6HQSeVKkkmkBN4yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97558191"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="97558191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:21:39 -0700
X-CSE-ConnectionGUID: K3+2uR+sTBa69X0oEy0onw==
X-CSE-MsgGUID: j4gHbkfdSVm4lsUrpcNp2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259008005"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2026 01:21:37 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	artem.bityutskiy@linux.intel.com,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] intel_idle: Fix C6S and C10 latency values for Pantherlake
Date: Tue, 11 Aug 2026 13:47:29 +0530
Message-Id: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the values using BIOS ACPI _CST characterization data read from
a Pantherlake device via
/sys/devices/system/cpu/cpu0/cpuidle/stateN/{latency,residency}:

  C6S: exit_latency 300->127, target_residency 300->381
  C10: exit_latency 370->1048, target_residency 2500->3144

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/idle/intel_idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 651408df9c24..0b5c94c7cd3a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1010,16 +1010,16 @@ static struct cpuidle_state ptl_cstates[] __initdata = {
 		.name = "C6S",
 		.desc = "MWAIT 0x21",
 		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 300,
-		.target_residency = 300,
+		.exit_latency = 127,
+		.target_residency = 381,
 		.enter = &intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 370,
-		.target_residency = 2500,
+		.exit_latency = 1048,
+		.target_residency = 3144,
 		.enter = &intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
-- 
2.34.1

