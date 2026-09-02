Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD83A8758;
	Wed,  2 Sep 2026 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331977; cv=none; b=TBPXbqQZdUSJl+QTWmNSr8q+nf1IJ64jQLgAwhoUVX7OeTGJZnKwe/cQ+i1l20Uh2Up2ibqUO5B1EZJNta2GC8TlQTynh1/Qzp9D6J71c6oMGft9StsLHTRzGtccG77gyl7zOHcNabOodt2xcxE9bpLmMMpgTOOKCx6rhb7YXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331977; c=relaxed/simple;
	bh=bIacrkSfXQ+4gO3WEx9zrSJUgIWx0XvFnBXIHeIb8XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QREVC8AktXP+ty4KURpjov3yZgHm5Idj+KBsQXh84DsNZvCN0IfyXYK8zKqHRkIXUkEfeOGKDFiqZYbXqfiKF3zqrmggOy0NmvnSV//p2L5tivTvB+QLEsI7i2ZKO6PQ5wdRJ9+4uU4HmuSMfL6jk2HAYeqS1b++TM6nqeSjFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e37f55f4a69a11f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d1aa2c6a-b0f4-4894-a647-16fa581cb0e4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ded06c49fd58b92344748250acdd7992,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e37f55f4a69a11f19a56ed5b684f684d-20260902
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1056093679; Wed, 02 Sep 2026 14:52:39 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: trenn@suse.com
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	jwyatt@redhat.com,
	sageofredondo@gmail.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] cpupower: idle_monitor: add NULL check after calloc()
Date: Wed,  2 Sep 2026 14:52:24 +0800
Message-ID: <20260902065224.1392-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Twenty calloc() calls across five idle monitor files lack NULL return
checks, leading to potential NULL pointer dereferences on allocation
failure:

  - mperf_monitor.c mperf_register(): nine consecutive calloc() calls
    for per-CPU counters are used directly without any NULL check.
  - snb_idle.c snb_register(): is_valid and per-CSTATE previous/current
    counters are allocated without NULL checks.
  - nhm_idle.c intel_nhm_register(): same pattern as snb_idle.
  - hsw_ext_idle.c hsw_ext_register(): same pattern as snb_idle.
  - amd_fam14h_idle.c amd_fam14h_register(): per-state previous/current
    counters are allocated without NULL checks.

Add NULL checks after each allocation, returning NULL on failure,
consistent with existing error handling in the same functions (e.g.,
hardware capability checks already return NULL on failure).

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 ++
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c   | 4 ++++
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c  | 5 +++++
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c      | 4 ++++
 tools/power/cpupower/utils/idle_monitor/snb_idle.c       | 4 ++++
 5 files changed, 19 insertions(+)

diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 5edd35bd9ee9..6112161f7d5e 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -295,6 +295,8 @@ struct cpuidle_monitor *amd_fam14h_register(void)
 					      sizeof(unsigned long long));
 		current_count[num]  = calloc(cpu_count,
 					      sizeof(unsigned long long));
+		if (!previous_count[num] || !current_count[num])
+			return NULL;
 	}
 
 	/* We need PCI device: Slot 18, Func 6, compare with BKDG
diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index f5a2a326b1b7..28cbe91b106b 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -159,11 +159,15 @@ static struct cpuidle_monitor *hsw_ext_register(void)
 	}
 
 	is_valid = calloc(cpu_count, sizeof(int));
+	if (!is_valid)
+		return NULL;
 	for (num = 0; num < HSW_EXT_CSTATE_COUNT; num++) {
 		previous_count[num] = calloc(cpu_count,
 					sizeof(unsigned long long));
 		current_count[num]  = calloc(cpu_count,
 					sizeof(unsigned long long));
+		if (!previous_count[num] || !current_count[num])
+			return NULL;
 	}
 	intel_hsw_ext_monitor.name_len = strlen(intel_hsw_ext_monitor.name);
 	return &intel_hsw_ext_monitor;
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 5ae02c3d5b64..5039716b591d 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -350,6 +350,11 @@ struct cpuidle_monitor *mperf_register(void)
 	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
 	time_start = calloc(cpu_count, sizeof(struct timespec));
 	time_end = calloc(cpu_count, sizeof(struct timespec));
+	if (!is_valid || !mperf_previous_count || !aperf_previous_count ||
+	    !mperf_current_count || !aperf_current_count ||
+	    !tsc_at_measure_start || !tsc_at_measure_end ||
+	    !time_start || !time_end)
+		return NULL;
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
index 6b1733782ffa..ce745dac74cc 100644
--- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
@@ -178,11 +178,15 @@ struct cpuidle_monitor *intel_nhm_register(void)
 
 	/* Free this at program termination */
 	is_valid = calloc(cpu_count, sizeof(int));
+	if (!is_valid)
+		return NULL;
 	for (num = 0; num < NHM_CSTATE_COUNT; num++) {
 		previous_count[num] = calloc(cpu_count,
 					sizeof(unsigned long long));
 		current_count[num]  = calloc(cpu_count,
 					sizeof(unsigned long long));
+		if (!previous_count[num] || !current_count[num])
+			return NULL;
 	}
 
 	intel_nhm_monitor.name_len = strlen(intel_nhm_monitor.name);
diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
index 5969b88a85b4..76d9986b0ecc 100644
--- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
@@ -164,11 +164,15 @@ static struct cpuidle_monitor *snb_register(void)
 	}
 
 	is_valid = calloc(cpu_count, sizeof(int));
+	if (!is_valid)
+		return NULL;
 	for (num = 0; num < SNB_CSTATE_COUNT; num++) {
 		previous_count[num] = calloc(cpu_count,
 					sizeof(unsigned long long));
 		current_count[num]  = calloc(cpu_count,
 					sizeof(unsigned long long));
+		if (!previous_count[num] || !current_count[num])
+			return NULL;
 	}
 	intel_snb_monitor.name_len = strlen(intel_snb_monitor.name);
 	return &intel_snb_monitor;
-- 
2.43.0

