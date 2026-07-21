Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE54302F1;
	Tue, 21 Jul 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625971; cv=none; b=JI23FkTprbsOA1EdZ+N2IOfhQr+hwHyMtfqtMz2ChIMTl/t/k2RPHfj2J4avQ4TdhK/+huTgCr2SSdy+LMoW5E+dSGz688ZYr0Kg6t/MZOl7AbxvxCaVgil995nwCB0RJ296jCzhlicBG2qnSySsOWE9eZYwRVOQArpEus68dk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625971; c=relaxed/simple;
	bh=SYuYEQr3KC882LOXsv5y3jmDRURaR85r/Vd7elKeXU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7frwz3o2QY9J7WbV5qEuBSsUxVyi5OfHgikHTtFkk9evp4CSsH0c1rkZaCH01/J0ejfnOBRDFVWXNz0rjWO6y9IR59G/489XT2ZU4guMdXzcHNGnM691nXKZyN5ipr13mly7EbfofMZ+3X8mKnCAcZxDskYwXHTR/kRkwjx9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 31564f3484e611f1aa26b74ffac11d73-20260721
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:df15d5d9-d5e0-4add-bb14-b34e84641233,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:df15d5d9-d5e0-4add-bb14-b34e84641233,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:addffd65343360c0e8e7c4003aebabdf,BulkI
	D:260721172604V5C13W1K,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 31564f3484e611f1aa26b74ffac11d73-20260721
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(175.2.17.192)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 314397269; Tue, 21 Jul 2026 17:26:03 +0800
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
Subject: [PATCH 4/5] cpuidle: cache aggregated governor latency QoS constraint
Date: Tue, 21 Jul 2026 17:25:59 +0800
Message-ID: <20260721092559.18921-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
References: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
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
 drivers/cpuidle/governor.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index d286ccf19a69..67909470c14b 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -32,11 +32,17 @@ struct cpuidle_governor *cpuidle_prev_governor;
  */
 static DEFINE_PER_CPU(atomic_t, latency_req_gen);
 
+struct cpuidle_latency_req_cache {
+	unsigned int gen;
+	s64 latency_ns;
+};
+
 struct cpuidle_cpu_qos_nb {
 	struct notifier_block nb;
 	unsigned int cpu;
 };
 
+static DEFINE_PER_CPU(struct cpuidle_latency_req_cache, latency_req_cache);
 static DEFINE_PER_CPU(struct cpuidle_cpu_qos_nb, cpuidle_cpu_qos_nb);
 
 static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
@@ -212,10 +218,22 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
  */
 s64 cpuidle_governor_latency_req(unsigned int cpu)
 {
-	struct device *device = get_cpu_device(cpu);
-	int device_req = dev_pm_qos_raw_resume_latency(device);
-	int global_req = cpu_latency_qos_limit();
-	int global_wake_req = cpu_wakeup_latency_qos_limit();
+	struct cpuidle_latency_req_cache *cache;
+	unsigned int gen;
+	struct device *device;
+	int device_req, global_req, global_wake_req;
+	s64 latency_ns;
+
+	cache = per_cpu_ptr(&latency_req_cache, cpu);
+	gen = atomic_read(per_cpu_ptr(&latency_req_gen, cpu));
+
+	if (likely(READ_ONCE(cache->gen) == gen))
+		return READ_ONCE(cache->latency_ns);
+
+	device = get_cpu_device(cpu);
+	device_req = dev_pm_qos_raw_resume_latency(device);
+	global_req = cpu_latency_qos_limit();
+	global_wake_req = cpu_wakeup_latency_qos_limit();
 
 	if (global_req > global_wake_req)
 		global_req = global_wake_req;
@@ -223,5 +241,14 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 	if (device_req > global_req)
 		device_req = global_req;
 
-	return (s64)device_req * NSEC_PER_USEC;
+	latency_ns = (s64)device_req * NSEC_PER_USEC;
+
+	WRITE_ONCE(cache->latency_ns, latency_ns);
+	/*
+	 * Store gen last so a concurrent invalidate cannot leave a stale
+	 * latency_ns marked as current.
+	 */
+	WRITE_ONCE(cache->gen, gen);
+
+	return latency_ns;
 }
-- 
2.43.0

