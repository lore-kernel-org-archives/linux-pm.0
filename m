Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8D3A7591;
	Wed, 29 Jul 2026 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305913; cv=none; b=WJhYTu/eGCdvSBkgq1Qo7it+5PW7f3eKv2UNPqKaXMCh7jYcoSmVL1cwY6PZyg5zBxWvYBNDRH37MW/C/nyplhj8d1sBUD+ZChjNIitqyCS/CNyRlFogTU7aOeoHuxwarJXYxDNp8GOI/n5jCCFEG6B9FUOMQKTXQdCenCQFGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305913; c=relaxed/simple;
	bh=ddNo24E+GEItQW/o6WJ/skQG5ZpCCLDO4+Kj0K9eLdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2iEAZMaDRQ0H0gK8lcCD4/B3PIAInhNUQJtXF/nRbGIXICzIcvM5Wxc1RpydjNPZ5rOkBmr2N5O2dtC9g/qQ4voPS69MrdZ0ZOd6WAXQy9V4jR32/0xs900MDcu/f9DdaWSQEwl8yZPVEAbzUCXbUPe0W7oBBm6RFbKKwi/Wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4e6bf86e8b1511f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:29ca2cc5-3033-4db0-9422-90d9f89776f1,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:29ca2cc5-3033-4db0-9422-90d9f89776f1,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:3a6abda24f045964a8bd13b8808e2216,BulkI
	D:260729141827XYHT72GD,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e6bf86e8b1511f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1464706001; Wed, 29 Jul 2026 14:18:25 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com,
	lenb@kernel.org,
	pavel@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 4/6] cpuidle: cache aggregated governor latency QoS constraint
Date: Wed, 29 Jul 2026 14:18:20 +0800
Message-ID: <20260729061820.14841-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
References: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuidle_governor_latency_req() runs on every idle-state selection and
aggregates per-CPU resume latency with the global CPU latency and
wakeup latency QoS limits.  That path repeatedly walks get_cpu_device()
and pm_qos_read_value(), which shows up hot under menu_select().

Cache the aggregated constraint per CPU and refresh it only when the
corresponding per-CPU generation changes.  The generation is already
bumped by the global and per-CPU resume latency QoS notifiers added
earlier in this series.

On a menu governor profile, cpuidle_governor_latency_req() drops from
about 19.9% of menu_select time to about 4.2%, roughly a 6x reduction
in cost per call (~1.9 us down to ~0.3 us).

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpuidle/governor.c | 46 +++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index d286ccf19a69..f0be7c0cc612 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -29,14 +29,23 @@ struct cpuidle_governor *cpuidle_prev_governor;
  * Per-CPU generation bumped to invalidate that CPU's cached latency
  * constraint.  Global QoS changes invalidate every CPU; per-CPU resume
  * latency changes invalidate only the affected CPU.
+ *
+ * Start at 1 so it does not match a zero-filled latency_req_cache and
+ * falsely hit before the first real fill (which would return 0).
  */
-static DEFINE_PER_CPU(atomic_t, latency_req_gen);
+static DEFINE_PER_CPU(atomic_t, latency_req_gen) = ATOMIC_INIT(1);
+
+struct cpuidle_latency_req_cache {
+	unsigned int gen;
+	s64 latency_ns;
+};
 
 struct cpuidle_cpu_qos_nb {
 	struct notifier_block nb;
 	unsigned int cpu;
 };
 
+static DEFINE_PER_CPU(struct cpuidle_latency_req_cache, latency_req_cache);
 static DEFINE_PER_CPU(struct cpuidle_cpu_qos_nb, cpuidle_cpu_qos_nb);
 
 static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
@@ -207,10 +216,14 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 }
 
 /**
- * cpuidle_governor_latency_req - Compute a latency constraint for CPU
+ * cpuidle_aggregate_latency_req - Aggregate QoS latency constraints for @cpu
  * @cpu: Target CPU
+ *
+ * Combine the per-CPU resume latency with the global CPU latency and wakeup
+ * latency QoS limits.  Called on a cache miss from
+ * cpuidle_governor_latency_req().
  */
-s64 cpuidle_governor_latency_req(unsigned int cpu)
+static s64 cpuidle_aggregate_latency_req(unsigned int cpu)
 {
 	struct device *device = get_cpu_device(cpu);
 	int device_req = dev_pm_qos_raw_resume_latency(device);
@@ -225,3 +238,30 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 
 	return (s64)device_req * NSEC_PER_USEC;
 }
+
+/**
+ * cpuidle_governor_latency_req - Cached latency constraint for CPU
+ * @cpu: Target CPU (must be the local CPU; callers are idle governors)
+ *
+ * The per-CPU cache is only accessed by this CPU's idle ->select() path.
+ * Remote CPUs may bump latency_req_gen via QoS notifiers, but they do not
+ * touch the cache fields.
+ */
+s64 cpuidle_governor_latency_req(unsigned int cpu)
+{
+	struct cpuidle_latency_req_cache *cache;
+	unsigned int gen;
+	s64 latency_ns;
+
+	cache = per_cpu_ptr(&latency_req_cache, cpu);
+	gen = atomic_read(per_cpu_ptr(&latency_req_gen, cpu));
+
+	if (likely(cache->gen == gen))
+		return cache->latency_ns;
+
+	latency_ns = cpuidle_aggregate_latency_req(cpu);
+	cache->latency_ns = latency_ns;
+	cache->gen = gen;
+
+	return latency_ns;
+}
-- 
2.43.0

