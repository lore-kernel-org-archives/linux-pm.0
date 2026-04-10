Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9923C1414
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827724; cv=none; b=TuTbVBxd+22njC7K2R0c+jyWwy4yacvXCBxms+osD+p6+abvZaVbCKcMMtXFShW/YWjBDnMSJfJuSIih2bnZePPFSE/gfMJqn9CuHS7L0E4QRJYQkn5xu/LLEt+oJ7So75htKF6T3rwa946yoc/LAHCwGZSGqjbPYQ5bbBj8xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827724; c=relaxed/simple;
	bh=VLBttnUlDmnzSGh1bBOpEhIOFQJuIyJBdmvxaUlTFK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN3CBuQ48TLWcIDj5pjUrAP+iJ73Un7FtWJ1Z0pDA5wmAV2tj1Df4cbORBxQuCzg/CHupxBEWIUfV4LbJPMiLI3hf/eFY/7guL/w9kzipXB6LUOfnBaLZjqYU7YMR24X4iS6QuGo3zgOr1MApcL02/NRSgcal9vDNALrBdwFf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig3WZgFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig3WZgFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A81C19425;
	Fri, 10 Apr 2026 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827724;
	bh=VLBttnUlDmnzSGh1bBOpEhIOFQJuIyJBdmvxaUlTFK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Ig3WZgFT9UJO6Mj4sj8ZfEB6NuNL5dxyFfNPUb4C5uXqE1Qzh3TmMT78OL3rk6FO9
	 oJbXkljVUq9DVe5f4fsJsRJE2izVgPeJdBtHRihR6YYdlKId5mu3cE/sVPrJCjmhze
	 FNNWcjkneqqrWh4P+/NIJC1DXAYbG1leh4U2hNgxV48bdkwwCQSy0J6/uQcqD+/gtz
	 jHxaAex5qknryVovAziFFrdU/Wdz8c/sI5aSH6zAXjSD/jyFdR5jUYWKBGGf6fDke8
	 jOHqE2xMHp1ZZw+Qz9AZhVWZ6erJvm7UiuR8YVcUtZyOXBCtjpnsmt1yz8nulQswj7
	 oV1v5jnSFTprg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 7/9] tools/power turbostat: Fix --show/--hide for individual cpuidle counters
Date: Fri, 10 Apr 2026 09:25:12 -0400
Message-ID: <b6398bc2ef3a78f1be37ba01ae0a5eedaee47803.1775827309.git.len.brown@intel.com>
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

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Problem: individual swidle counter names (C1, C1+, C1-, etc.) cannot be
selected via --show/--hide due to two bugs in probe_cpuidle_counts():
1. The function returns immediately when BIC_cpuidle is not enabled,
   without checking deferred_add_index.
2. The deferred name check runs against name_buf before the trailing
   newline is stripped, so is_deferred_add("C1\n") never matches "C1".

Fix:
1. Relax the early return to pass through when deferred names are
   queued.
2. Strip the trailing newline from name_buf before performing deferred
   name checks.
3. Check each suffixed variant (C1+, C1, C1-) individually so that
   e.g. "--show C1+" enables only the requested metric.

In addition, introduce a helper function to avoid repeating the
condition (readability cleanup).

Fixes: ec4acd3166d8 ("tools/power turbostat: disable "cpuidle" invocation counters, by default")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 35 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4d954533c71d..3487548841e1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11285,6 +11285,14 @@ void probe_cpuidle_residency(void)
 	}
 }
 
+static bool cpuidle_counter_wanted(char *name)
+{
+	if (is_deferred_skip(name))
+		return false;
+
+	return DO_BIC(BIC_cpuidle) || is_deferred_add(name);
+}
+
 void probe_cpuidle_counts(void)
 {
 	char path[64];
@@ -11294,7 +11302,7 @@ void probe_cpuidle_counts(void)
 	int min_state = 1024, max_state = 0;
 	char *sp;
 
-	if (!DO_BIC(BIC_cpuidle))
+	if (!DO_BIC(BIC_cpuidle) && !deferred_add_index)
 		return;
 
 	for (state = 10; state >= 0; --state) {
@@ -11309,12 +11317,6 @@ void probe_cpuidle_counts(void)
 
 		remove_underbar(name_buf);
 
-		if (!DO_BIC(BIC_cpuidle) && !is_deferred_add(name_buf))
-			continue;
-
-		if (is_deferred_skip(name_buf))
-			continue;
-
 		/* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
 		sp = strchr(name_buf, '-');
 		if (!sp)
@@ -11329,16 +11331,19 @@ void probe_cpuidle_counts(void)
 			 * Add 'C1+' for C1, and so on. The 'below' sysfs file always contains 0 for
 			 * the last state, so do not add it.
 			 */
-
 			*sp = '+';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/below", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/below", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 
 		*sp = '\0';
-		sprintf(path, "cpuidle/state%d/usage", state);
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		if (cpuidle_counter_wanted(name_buf)) {
+			sprintf(path, "cpuidle/state%d/usage", state);
+			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		}
 
 		/*
 		 * The 'above' sysfs file always contains 0 for the shallowest state (smallest
@@ -11347,8 +11352,10 @@ void probe_cpuidle_counts(void)
 		if (state != min_state) {
 			*sp = '-';
 			*(sp + 1) = '\0';
-			sprintf(path, "cpuidle/state%d/above", state);
-			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			if (cpuidle_counter_wanted(name_buf)) {
+				sprintf(path, "cpuidle/state%d/above", state);
+				add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+			}
 		}
 	}
 }
-- 
2.45.2

