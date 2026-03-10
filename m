Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CFF4FA;
	Tue, 10 Mar 2026 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122672; cv=none; b=XVySf9fToHo533UgjRKd77BL8BhKeGM5vbUDWaziwh3WVmTOEaBi6lWCXI0xdfYf3PiQ6JA95Yj2GayQQlecr5vZR10eqizJs59fcJb6Kjf0ZcgMCadsXXza/57EylN/z8Izc3SOuJ2MqbvyLknkZuXhmcYdZOxF/GHWbWV4VdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122672; c=relaxed/simple;
	bh=8DBdmz4o3dmAgLKb/5gRMjvJ0E9ZryF0TCIhnOcy1wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+aeiiIDWYDVhFrwIodoUFi+TUay1Hhkw2ifRNcfZD1I4ad4T70FzEja8rNC+Rau6lmQr4sz3mJXyvrnjmEkjLfd863ePQQcENcaD+6CE0ICKy4KsuLysFcYiIn9MgMIrbs+D8wFvoII/4OTgJEcD9NLNOlt4ohtyVqtTDYlXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQtCN/m2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQtCN/m2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773122671; x=1804658671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DBdmz4o3dmAgLKb/5gRMjvJ0E9ZryF0TCIhnOcy1wI=;
  b=kQtCN/m2YlZTwih5oqMVh0kvO6UzUR8Wa7LHUXv+kpYaGjX8Txst1VGE
   QcI6inv/wiAQFp3dDTMS+/XPMwBvKG+c5wl2MyOs5xA+rl3XgmiZIGQs5
   l9dBwXpvn0wVDkWbPbBzGp86bpVxc6zKkDUayKhFUJIIxPphWyLhrgJbR
   e5Z4UMYLCk1LCWSgWIx5ipV0lfilqKFGXAXdWiBIYBLzvTqwZ2e6PUUtf
   oDMcs1DNQkpTsqLwXvVsrVYinXVVvsDXy3hAPWm6ITa5PbtI0ulBBdx42
   1sLoHQVh6xsDqRBG2+KV+5ZaHpUvWKnnx55meEJAmW7MXDGbCt2prHDwG
   w==;
X-CSE-ConnectionGUID: VmFtrBdURFal1YQrwTQn/A==
X-CSE-MsgGUID: Db1/+QZtRCm+I636Qm6+7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73859064"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73859064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:04:31 -0700
X-CSE-ConnectionGUID: T0KSgkBVRn2qcwNJ1JP1Lw==
X-CSE-MsgGUID: Tb8AC8l0SkeDqtGSl8pQDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224680596"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.35])
  by fmviesa005.fm.intel.com with ESMTP; 09 Mar 2026 23:04:29 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] tools/power turbostat: Fix out-of-bounds memory access in thread_data allocation
Date: Tue, 10 Mar 2026 14:02:00 +0800
Message-ID: <20260310060201.660773-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turbostat suffers from a critical memory allocation bug that can cause
segmentation faults or silent data corruption.

This is because turbostat uses
1. num_cores * threads_per_core to allocate memory for per thread data
   (threads_per_core is calculated based on online CPU thread siblings,
   resulting in a value of 1 when SMT is inactive)
2. cpu_id to reference the thread data for a given cpu
And then, when SMT is inactive, it is possible that,
	num_cores * threads_per_core < cpu_id of certain online cpus
and this causes out-of-bounds memory access when referencing the thread
data for these CPUs.

For example,  on a 4-core system,
1. the core's are numbered 0,1,2,3
2. the CPU's are numbered 0,1,2,3 and the HT siblings are 4, 5,6,7,
When only CPU0 and CPU7 are online, turbostat allocates thread_data
memory for 4 threads (4 cores * 1 thread_per_core) but references
thread_data[7] for CPU7.

Fix the problem by using topo.max_cpu_num + 1 to represent the total
thread count instead. The topo.max_cpu_num value is derived from the
width of /sys/devices/system/cpu/cpuX/topology/thread_siblings, which
represents all possible CPUs regardless of their online/offline status.
This ensures adequate memory allocation for all potential CPU accesses.

Validated on multiple Intel platforms (ICX/SPR/SRF/EMR/GNR/CWF) with
various CPU online/offline configurations and SMT enabled/disabled
scenarios. No regression or memory access violation observed.

Fixes: a2b4d0f8bf07 ("tools/power turbostat: Favor cpu# over core#")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a2671c28209..ae827485950d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9702,13 +9702,12 @@ void allocate_counters(struct counters *counters)
 {
 	int i;
 	int num_cores = topo.cores_per_node * topo.nodes_per_pkg * topo.num_packages;
-	int num_threads = topo.threads_per_core * num_cores;
 
-	counters->threads = calloc(num_threads, sizeof(struct thread_data));
+	counters->threads = calloc(topo.max_cpu_num + 1, sizeof(struct thread_data));
 	if (counters->threads == NULL)
 		goto error;
 
-	for (i = 0; i < num_threads; i++)
+	for (i = 0; i < topo.max_cpu_num + 1; i++)
 		(counters->threads)[i].cpu_id = -1;
 
 	counters->cores = calloc(num_cores, sizeof(struct core_data));
-- 
2.43.0

