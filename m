Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422046C84D
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856280; cv=none; b=eUN8Rr+SmXrDw0EROwL1FPfxxsIdvam/i2blIQ91rFl1eLOFv/AgYjSgruLpVVbfS4TOlYtP1m/D9pPX4SRvyNZaCebUzXoT2EwglHkZuvwMh9nsYQ9Gt7CdfOzuZQMe21pWS+8FPw2pFDXthcrOdt3mwaf6KFh4MluYXaADeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856280; c=relaxed/simple;
	bh=K0Jqcu6iMw3kPQLw07nU3dgEc+RfrtZg3NeaZIDm+rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHDsBB0X5N40Bbvz5KOh0eb39PRmMEIU5SzKstkz0jHqpNkm9QyAlN4ExX2ayKkcEBtfFnV6etNuWpb653ySqoYI4221nOzxUXM3WBHJgNaFmIBuIyCTIOZ/uqEG/8a1z2B+p4ulRKQxusMsV7mhzdz0o8QXlxrypFjgo+bol5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D2TGJ0Vw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFUEz6Fh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D2TGJ0Vw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFUEz6Fh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886MB1j1521789
	for <linux-pm@vger.kernel.org>; Tue, 8 Sep 2026 08:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D7bGYpclRSIBS3LW8im3saKqNsoRXecyOy64DApXOHY=; b=D2TGJ0VwOMellRoo
	d5+n/8ZrXOGMnv1E1S7PelFzj3l6FYwzxv44nFXExX/kK6Sbz0KkL5WWsImBf0Ab
	LBU4WMjyO8vnaDwmu4gYNrwJuv4Qb9Tuv32+clNeIw+ai+++4amrrsTpEnspA2pm
	+rEfX6bVDWZ7KGPt4xLVwmF3+mF5HtqzGYHuXflZQM14En3vECgovCY0L1b+LNOX
	JT+2aLqAqGVh2lSJ5+fbyruN783riokQOSQcwsWOf3Z1CaGTdVuRaKzKWzPAOaaO
	EEGx8kKQNgqrbyiJ0etNJrU/mo9R5WRaLDoTZgYQAN2A/bCIsaTOFe45AJi7MrId
	iX3dHw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077jsna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 08:31:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so1147837a91.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788856275; x=1789461075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7bGYpclRSIBS3LW8im3saKqNsoRXecyOy64DApXOHY=;
        b=TFUEz6FhOeYlFdzQWgNs2LSO/ZIsPNuTln+L9ZiAIomOXQxqDHIdudWL0+r60TyEZQ
         rLcSoeWqYtEzALng7B4WcIsFulgAW88VJA4zjDcKJGpzgzJVvgFq0GI4lXKRmhXq2BQd
         6lH2oHK6pjqbPN2/y35s1Nx2wAl5r6Vo9Bi3XLUDpeuB2sy1wkK3T5XE/7BYR1tfE9ut
         qGm3lv158V3ykGftFK0wiSDbSykzl/3dsbegq9YzbQUJIGhCPz9Yf9lq/N+hROu2HlRX
         19Zqxd4btZGsLouh/5oCOhGogIgxw33RuzF+0LbSdCKaz6Pt3evpYl60nS6kNT4Kj0/w
         14sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788856275; x=1789461075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7bGYpclRSIBS3LW8im3saKqNsoRXecyOy64DApXOHY=;
        b=ewpWxOTvBfUzkUSr33ff/bJ+wpOnvqTcuQGy0TC56I09X4JhDgfVsyfxVTmsIt/BNr
         sGfKAnVy9hCZZ66DcpQtrDfiIj9Oqy4ypwa1K9yCiEZfVucBsyOIT9Y16+CKLG7Urh6i
         3lzqTd6z4cnCues2ITVfKnfUTJqNjzbamDiYogT/RT/aKp94oZYvhci9L2sR/QhNJX6O
         +/+UA8HD/uk0FtLBzzccyVlEwXezlRkIpX3v3fh+yzY2DDwv/XSggoYz+o62GZczeMVs
         kGLRaqd5JzhuIahWou5tGKxZwiEaop8efgrVRLRXD7jgNg+pqSjhqxzxq2/9jwVqO9eS
         mxTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXLnzIj6bi59s/d6JnDHx+aj2TS2cK6EyHq2O3ATWsVXuNMhfdA2BuwDiJCz1NBLnPw83DlU8oLA==@vger.kernel.org
X-Gm-Message-State: AFuF++kPAYamATL7I4UcW34TPeX5OmQuvmi3LUZ4Z+mwl0loeZXYvAjx
	ZemV4FoE6p1RJhEIim4dl3SVOLXGAa5bPxf9qficNaYZOuzl8bVNSBEfMObI3h9km/C/q6hwYRk
	oiMmobIFde9LiaY7ypn5gDSo2DUfb0DTl8JVuR6G3TsVYErhIUZ0BwOzBUiwDvA==
X-Gm-Gg: AYBFou3BYXPaLT3zO/n81vK+2Zt4FQiWIGoKoeNQy9j5M2GdOjMF3dsm1qWWzcefAx6
	cvcd/CA2Jvo7hnKxpFQM2Wqe3FpwK07a88z0nlk2s5/bJ4VCACBPP/P/qYRsoGqrcR9s/tqjcDp
	8ZHEKJ1GhzkR5OyzchKXzN7oDduUGJ4erPj/qVomoBC0vTdJByN+BY3H6TNKI9WXGRvcFF4+Qlq
	VvTvmeXwHXcRYUwolx4MNfr93DdQyQVSazmoWDCSjv0zHW6czTvTqoflb8XkQs0TzXerB8iYHF4
	qFRU9deNeyXO4ko1MPXQgbehG05wt3rcvaLhDam8G2IrIFWwWcqUrxyql3bpI9bYlTFFBhmsETR
	rVoXF2GvocEWmagWiPI9WD37SPStGSlracVfNxGBn5s+0T1POp+T5GhIz9TXozmEjclC/oNyQ4t
	fmr08OuCraE+GkcIc=
X-Received: by 2002:a17:90b:580e:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-39b25ee242bmr39317865a91.0.1788856274668;
        Tue, 08 Sep 2026 01:31:14 -0700 (PDT)
X-Received: by 2002:a17:90b:580e:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-39b25ee242bmr39317828a91.0.1788856274197;
        Tue, 08 Sep 2026 01:31:14 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm34458641eec.27.2026.09.08.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:31:13 -0700 (PDT)
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 14:00:28 +0530
Subject: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
In-Reply-To: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org, Ananthu C V <ananthu.cv@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788856266; l=3317;
 i=ananthu.cv@oss.qualcomm.com; s=20260903; h=from:subject:message-id;
 bh=K0Jqcu6iMw3kPQLw07nU3dgEc+RfrtZg3NeaZIDm+rs=;
 b=iPjJZVEcGt28pqL7LCCRww1bUy4MNe2vsZJkVHCywrOli4vGSOgaKJYiiGctaKkuYm7gHHIXr
 0fMqlN8duvKCN3/+krOMZidWCSYS9MOMkQdSRAIQw9ELK3pVdXloS2H
X-Developer-Key: i=ananthu.cv@oss.qualcomm.com; a=ed25519;
 pk=gutNfLSMVTRkB+MxVviMFq9I07C5qPe9xHY2J5XCMpo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4OCBTYWx0ZWRfX64d70qeIRdnq
 9nwQKQ2ZXizQkZ+Xe2Y0F7Ccfk6tPMFN4DVT1AEqoF4N9ES0AgEEwGpMoy1GBNahQUw/F2evbUR
 kHLmIpGHfMTI473JVWqapHvSdHtbnUvdafzIPG+MXkf6lH+2nCbrOU1Uu2IyU2eYCCm/lH56EAX
 OtLnnfzJu6AOtHrwFEXehw7Y0xMMvOuDVSripRGTzFP4OxRAQUzTmoIlR8dCBO1WaBS4X2GWScs
 Ln/dtX49QdxIjtK3nG5FLkqQPdKtQmAHDY3tsWWBEkOugtcyy5qgg265o1Dbz5xY8fzbWwBKsoX
 OKnMWsIXqRigeE77n4Hxad59u4M8FTBYYpk6gp1aA5SZcvQ4eVsdn5Ef8+lhh3ASX/07Yvh1sP+
 E0pCugwUR2YPFMEYqdvjmi+MLDLRj8qR212S6ovAzknKLC9EA6Y+Y0AakP66AvBMemuj4r3Y//b
 jSwBNrsnBFcOMYjpZ8g==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9fc7d3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=36zNjiBI7bMVG0EHEW0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6-n7IJjCDNWYICq2znDF0KhFGQbW69_f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4OCBTYWx0ZWRfXyDcozX7D2uCH
 u7HgufUh2efomZ4pJNxI2F3u8weyX41jHeYTy35MlYGcpPloK5iRhymFIrO/FTb3BW4A2s9ss8N
 2iRILEFt/WwIy9GqTdjuYwCdO/JnslQ=
X-Proofpoint-GUID: 6-n7IJjCDNWYICq2znDF0KhFGQbW69_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080088

capacity_freq_ref, the per-CPU frequency-invariance reference used by
schedutil, is seeded from policy->cpuinfo.max_freq at policy creation.
If boost frequencies are filtered out of the frequency table because
boost isn't yet enabled at boot, max_freq only reflects the non-boost
ceiling, so capacity_freq_ref never learns about boost frequencies for
the policy's lifetime. Enabling boost later raises policy->max, but
capacity_freq_ref stays stale, leaving schedutil unable to scale
utilization or target a frequency above the non-boost maximum.

Track the highest frequency in the table regardless of boost state
(max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_freq,
max_table_freq), so the invariance reference is boost-aware from boot
regardless of whether boost is currently enabled. Runtime enforcement,
still handled by policy->max, is unaffected.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
---
 drivers/base/arch_topology.c | 3 ++-
 drivers/cpufreq/freq_table.c | 6 ++++++
 include/linux/cpufreq.h      | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..da94f77441da 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
+		per_cpu(capacity_freq_ref, cpu) = max(policy->cpuinfo.max_freq,
+						      policy->cpuinfo.max_table_freq);
 		freq_inv_set_max_ratio(cpu,
 				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
 	}
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ea994647abc8..4984142dc08a 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -33,11 +33,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 	unsigned int min_freq = ~0;
 	unsigned int max_freq = 0;
+	unsigned int max_table_freq = 0;
 	unsigned int freq, i;
 
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
+		if (freq > max_table_freq)
+			max_table_freq = freq;
+
 		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
@@ -57,6 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	if (policy->cpuinfo.max_freq < max_freq)
 		policy->cpuinfo.max_freq = max_freq;
 
+	policy->cpuinfo.max_table_freq = max_table_freq;
+
 	if (min_freq == ~0)
 		return -EINVAL;
 	else
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35ce665edfd8..3f3b1380251a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -45,6 +45,7 @@ enum cpufreq_table_sorting {
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
+	unsigned int		max_table_freq; /* Highest valid frequency in the table */
 
 	/* in 10^(-9) s = nanoseconds */
 	unsigned int		transition_latency;

-- 
2.43.0

