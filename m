Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D73BED43
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827721; cv=none; b=Qho529SHFJu1TSXQlbAfNWHXRkDqocl9EpwzN4AC4z56YCV1cugID8EF4hHZ+l8VLwytDvJYi+7nkt9+Amq9Bm0C7yMAb0GLoS+CcYvn+2ayUZG4fGe9HMeHRMTfkbDeMbnXr4cx413MH1OLk75qtpq06kS0vQMr7lEKlzzZQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827721; c=relaxed/simple;
	bh=ssBb4HfKiuiEt8/yNO0vd6SKrjua/jM+X6YSpl3EsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ6SQ3oyLL31nJcl8ucpU9hEkk3Gh7TAYTyP2VAQpJAQwjGx0WZHr7TiWKt/+AqWhNtVQDm+wBlcvuU8qdbuQ/6/snbGg5Vo4iRGbuHV01jZOV/pxe9mHV73lO6K/9yjouCkz132Z/dW3hpIPcdd3H/M9gQTddZVo4Yuv66ILrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QArdF7l0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QArdF7l0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09292C19425;
	Fri, 10 Apr 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827721;
	bh=ssBb4HfKiuiEt8/yNO0vd6SKrjua/jM+X6YSpl3EsOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=QArdF7l0VRCHx/K6JspzMx5gwnuweJtxLrzfAHx5Nh2Eu0c/77vHq+GyKTzUXgmUv
	 9/T8fMRTNGuv4zCYU1cJ51Q1Kmo2yOfbiXNP6QZ5K/pxdNX1uaLNPqcFNFVeWoylxs
	 4/C1tZjoWOeQ3xWkpKOCtqdwBNcjqW6I2c2ugK2OexQEx/FNI2meg5ZgGEln+phBFf
	 uWGRgvcwPhq6+D5Md/6b34S1cWV0JoFI5omOKCqUTtinoF6j/mmWFyVrFI/zt4SIvW
	 Kx9dC0Kaurq/NURfB8L9gMyJrWTG9o777w/Iaqj4TC6FuUs7u2GveEOwMLCX41q/8+
	 dLoruLACS4bkw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 3/9] tools/power turbostat: Eliminate unnecessary data structure allocation
Date: Fri, 10 Apr 2026 09:25:08 -0400
Message-ID: <99b38fa34342b227a863948460b7937a97dbce28.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
References: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Linux core_id's are a per-package namespace, not a per-node namespace.

Rename topo.cores_per_node to topo.cores_per_pkg to reflect this.

Eliminate topo.nodes_per_pkg from the sizing for core data structures,
since it has no role except to unnecessarily bloat the allocation.

Validated on multiple Intel platforms (ICX/SPR/SRF/EMR/GNR/CWF) with
various CPU online/offline configurations and SMT enabled/disabled
scenarios.

No functional changes.

[lenb: commit message]
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 791b9154f662..14021a6ed717 100644
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
 
@@ -9633,9 +9633,9 @@ void topology_probe(bool startup)
 	topo.max_core_id = max_core_id;	/* within a package */
 	topo.max_package_id = max_package_id;
 
-	topo.cores_per_node = max_core_id + 1;
+	topo.cores_per_pkg = max_core_id + 1;
 	if (debug > 1)
-		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n", max_core_id, topo.cores_per_node);
+		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n", max_core_id, topo.cores_per_pkg);
 	if (!summary_only)
 		BIC_PRESENT(BIC_Core);
 
@@ -9700,7 +9700,7 @@ void allocate_counters_1(struct counters *counters)
 void allocate_counters(struct counters *counters)
 {
 	int i;
-	int num_cores = topo.cores_per_node * topo.nodes_per_pkg * topo.num_packages;
+	int num_cores = topo.cores_per_pkg * topo.num_packages;
 
 	counters->threads = calloc(topo.max_cpu_num + 1, sizeof(struct thread_data));
 	if (counters->threads == NULL)
-- 
2.45.2

