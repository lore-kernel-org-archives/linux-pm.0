Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FF19E97B;
	Tue, 10 Mar 2026 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122673; cv=none; b=nAGMMCS4PKzhSCYj+Wrc+tOoQSrJfcWpgAdjboh4HGbYF9888X0HJM1oPDibNPLx3XmSp0Ip/bI+BdOR98e38N9OzyvTlUACrpuvrvMK2MzXm54w+ls4HtViotsIfeCv7nelMC9ftC9ytctFaYeZbEfMO6wb4MKeXc1RTXNgJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122673; c=relaxed/simple;
	bh=jqD+QcEfBenklTnE2I/r27JVde741C3sBEAO55rNOH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6eiLvLby+AZNwwB+k992i7KSc3NVyhk6EcNFJLpuLbctxa+qXFQVLp5OkeHtac5gB+iEPdVn/s8NHfwrLeXcKYC/U+LEQV49gHrmbkNyug3ISmJa3xUChzlOaAbuwi9hffVfAA5CQiAWNZp0roWRDlLZXZG2+uRapWTVlG0Lj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q56zx9z4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q56zx9z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773122672; x=1804658672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqD+QcEfBenklTnE2I/r27JVde741C3sBEAO55rNOH8=;
  b=Q56zx9z4lPSIiTFXPbsokXnhDSVQkDT9oCisGjm3kJ6F6NOc5zkz0UP9
   6JKh86ZHyYulS1zr9mrclGZdmrMRLZbpSgukt9DLQkY1DQ4wSDLEKSDw1
   jMJXAGBXBiTXvd5VNH03XxSXhB392nOYIGHUZt6rxadNEWPZzDwSAfC+C
   pOc6FE9moveqWVv8XScVjJ+4aoGWZYfPJr8FWrV4NpPGyoQRUQIoy9G/W
   pGd22Tak9D0Ve+IBReCPF6Q8I1OSW+ptcyGDOsWpbb0OpcwZEH0k065Va
   snnqsafzwi+uXG2Yl9T89zT4RdDb5DYBQ6WTnsv7i1/nICO0wi16bggK2
   Q==;
X-CSE-ConnectionGUID: 3GQANL2ETQKYiBA7KBxsYQ==
X-CSE-MsgGUID: L0gk7PnMRZaqrGBjAQp/1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73859066"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73859066"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:04:32 -0700
X-CSE-ConnectionGUID: nUSCxDACRrapotUUvgLzGg==
X-CSE-MsgGUID: t+c5y+U9Rd+A/oWMg61cvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224680600"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.35])
  by fmviesa005.fm.intel.com with ESMTP; 09 Mar 2026 23:04:30 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] tools/power turbostat: Optimize core count calculation and fix naming inconsistency
Date: Tue, 10 Mar 2026 14:02:01 +0800
Message-ID: <20260310060201.660773-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060201.660773-1-rui.zhang@intel.com>
References: <20260310060201.660773-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current core counting logic has both naming and efficiency issues.
The variable topo.cores_per_node is misleadingly named since it actually
represents the maximum number of cores per package, not per node. And
the core count calculation is suboptimal and wastes memory.

Rename topo.cores_per_node to topo.cores_per_pkg and improve the system
core count calculation algorithm to avoid memory over-allocation.

Validated on multiple Intel platforms (ICX/SPR/SRF/EMR/GNR/CWF) with
various CPU online/offline configurations and SMT enabled/disabled
scenarios. No functional changes found.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ae827485950d..ef3059ba07cd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2409,7 +2409,7 @@ struct topo_params {
 	int max_l3_id;
 	int max_node_num;
 	int nodes_per_pkg;
-	int cores_per_node;
+	int cores_per_pkg;
 	int threads_per_core;
 } topo;
 
@@ -9634,9 +9634,9 @@ void topology_probe(bool startup)
 	topo.max_core_id = max_core_id;	/* within a package */
 	topo.max_package_id = max_package_id;
 
-	topo.cores_per_node = max_core_id + 1;
+	topo.cores_per_pkg = max_core_id + 1;
 	if (debug > 1)
-		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n", max_core_id, topo.cores_per_node);
+		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n", max_core_id, topo.cores_per_pkg);
 	if (!summary_only)
 		BIC_PRESENT(BIC_Core);
 
@@ -9701,7 +9701,7 @@ void allocate_counters_1(struct counters *counters)
 void allocate_counters(struct counters *counters)
 {
 	int i;
-	int num_cores = topo.cores_per_node * topo.nodes_per_pkg * topo.num_packages;
+	int num_cores = topo.cores_per_pkg * topo.num_packages;
 
 	counters->threads = calloc(topo.max_cpu_num + 1, sizeof(struct thread_data));
 	if (counters->threads == NULL)
-- 
2.43.0

