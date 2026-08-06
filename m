Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A63859E9
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991373; cv=none; b=EdY5/aUpSOsHYwAwGlxHZXjvF5eQl5vRoRB7r7xgu7pIxHrNFRmZwovYuVTqUv/WfDfvldYbdtCpveWjAvcfA0dnxbYckfaxqmDPF4D5QCOP9GY2mGVvXSaYNy6lHR53jAiHubFvcHCrKqHcactI4I8OocTdC6NR1maqeIhS68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991373; c=relaxed/simple;
	bh=suOz/Hx7XUoXe4sS9JmcD+pnA/MA8fwNnKj/ilaZHZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZoRex1LS/bz1tRaR4ADCE2ao6uZptTTOQF6DE6orAk2Wy1x6XYPxKt3yigJME2Yx0tWXvXRwusE0mfmicNuzXLCnfyjPmCNUEimRy48YmebZ2RlXXxkDSPuQqvojgSGvrEfuOZjIdpVPk5nwiMk9a00TjWx/rpAUGL3dVLhH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXa8vCWm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2kkXGQc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXa8vCWm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2kkXGQc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NblYF226729
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 04:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2i4Uj4137KW
	y44soo5k/hNh4LVeKysh+1efT4S0lnOY=; b=cXa8vCWmhBMHedHJ9i5NLPuzQ/L
	pZBGNdjsolj8i1Ealyh+p00B2a8aBiW6kFAkxK8B6yXhiIj3ViA2798ngX+IIqmY
	DlIzociM5yNKunNCYqEfAp2sbZAl8tXXkDkorwLallXMQ2wMQFZogUIM7woG8lsS
	OLADrq0pdjCrEBLJe45XRJxHBudg6K4VjTXgpPy/G9dHeYoTm49bEOBMFuR83c/o
	nkYeHkXnszDNmVDioSWotbrYp4T+dMn6b12FByB2OBSVgbXNbevuvmyO0lt280Fr
	oBkXiGdWb8MwjtWhM7Us+ePKOXu5WBzWbetBQOOk+xJ2QS6nXswMhMCWNGA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2r64dbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:42:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso44623685ad.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 21:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785991369; x=1786596169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2i4Uj4137KWy44soo5k/hNh4LVeKysh+1efT4S0lnOY=;
        b=B2kkXGQceo4Q3qcR22rcC/XHNvYy7wNYdpNammO34FRMkpX8gn8z2oVXUCNb8Ho+Uk
         KwMsFydwD81Nhl73LNwInhGnDHWOan1LSAvo/ZGuUlaK1P1iKHnbBxdKVklguANEZhf9
         r7+RkmBHHF+4l9Yep7CXu0e8d+iHG7qQuN563gZi6xwIsXWKzr0kUO4p+q3rrYPc6iQ3
         uL1BnFXlM7mOeEtswaz+JIds+KWea5lVuj6gCgoVpX6Yi+uV+UWTYbL+0NgNsAmx/fvL
         PLc+kCge85KzkliWNB5UJeX6PATqDLZVJicIFYv3oiPXGGSHubaXtQUIhHVzxB1WVh/A
         YDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991369; x=1786596169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2i4Uj4137KWy44soo5k/hNh4LVeKysh+1efT4S0lnOY=;
        b=pCWwC4Sh5Mlrk1FRAhokW8opcGjkIbE8H9UkOeCARuqVQIJ9AEGfMtOhtroS+AMXm5
         uEkaW2WTylq63bYUDhPvqEVYNBsLRi5iiOljJOolLvgwTWBgKXmGcOkyC4nG3ZBjhpPP
         +TDTrlrWzYfnPb9FkPhMcEvsqgJP5d9dlG+5mxPYTK+UA553KcXqIm2JhHYbVvOv8Tn9
         0aRK8B/XQUhpM+fdv4qv0CbnV9HJzPH46kJp7OB1JsuVcjULV/x+3GxKE0ijloNNk0KW
         Lonk41fp7rqZq47SuDEAhavmhUg7O0+dVvyFgYH8ya6VnWXCkFaIXD4GT7OThJKKQb3y
         cRJw==
X-Forwarded-Encrypted: i=1; AHgh+RpsoxCuKzKFCtuPLirc1BXkpKlCMnAOKij1bTJHhxaGs7eiBdGgFRNo6+rpxcktq6AwFvc2A8lDJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ECpWod0yYST2EHQiaXfUvXBJImYHB084G/xv92qMbU2SBOYT
	HaDSC6M9cTObWNXLOJ4uhAjENowhcbaYEd1OkNFCmXUS1ZB3IkxKNVZdC681jizxx2mvWj9DZzK
	zbcgrJr63wm253zGJI/v3xL5D9j6rO7OmKp1geXShmK804oekE2GZZfA+7f+qGg==
X-Gm-Gg: AR+sD13vrT6jSwL4b85dLkFtg8ptp3K3zyzm8yTsmdXnnbI5TivD0ORXATnyQjtjDjL
	WjJH5++5aiVtVH5674s2uUHhQP26IIfdKUn5zAuxOZKZtcpTF/2HaRN0s784ANfVr7/kbAw8VL6
	dV6F6kkYjMpDW5aQJsX/TolXYv3iwaKGDvb1RzFjTU+wxm10ba7g1QgBWeLiMV5bzjpR29NM5QT
	WTmNy7G1VGKw9HZqg5LB3s+tKlfOv4qQ29RFriZrtqqg97ra0K6bzUdKace8SnyPtA2QM7weSwp
	k7nE2dnCVz4HACI3/ljacDvLGa2CmZv3KXBsq6lwplzGqPjAHLNan/vZUwHRK1+0PGO54rigs9j
	/MZfw+cbwDNyfg/WcQqCJshRYCB+iBGFBdAZIDJHc/FPL+98ZhfKF1VUba+PU6xUatUG4n3mHyK
	JdwUBBJw6ezntOgLU=
X-Received: by 2002:a05:6a21:329d:b0:3c3:8ead:6df0 with SMTP id adf61e73a8af0-3cb85ea6f8fmr12556544637.28.1785991369540;
        Wed, 05 Aug 2026 21:42:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:329d:b0:3c3:8ead:6df0 with SMTP id adf61e73a8af0-3cb85ea6f8fmr12556503637.28.1785991369071;
        Wed, 05 Aug 2026 21:42:49 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm32643473eec.11.2026.08.05.21.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 21:42:48 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] sched/cpufreq: Update schedutil's DVFS request to reach the boost frequencies
Date: Thu,  6 Aug 2026 10:12:30 +0530
Message-Id: <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WrIb99fv c=1 sm=1 tr=0 ts=6a7410ca cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=uMDrv-Gue8sy1whakgkA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: NQUYS9lGbFemW86eTSthjeW-2oF6xPOi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX5vTAXS/cCqEa
 pCRJwKe7lfPbSGhjR7iGmuBtIC98Dyox7lCRSH/Q9QgZQjN0PmQ3CUJcuEZ9+YgOgZJ8gSQ1Jtc
 bOMQU/12+zotOUN7cytZxpIegxmlHgg=
X-Proofpoint-ORIG-GUID: NQUYS9lGbFemW86eTSthjeW-2oF6xPOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX5XyjqdhsDSKI
 ugR/UiEU8mPN9u51uuikbCyyuclrOT1kinrYR9cl+NIiyO1fSZjmszLlWsZ9ShCeVwmyQgArwrZ
 5w1oH/r312AWNb8sxCEV5bGTMipiAe3Sp6t5fREjY4vueH3D2PcXVbzTBwvSUy65SP8s73lXXy5
 fyLvTSuRV78fqibZ7CYUelXvT+6S+tzihyltZP0pjUWztitZJALDWA2ihQY4is01sWp1WoxwZ6x
 Z6/VLjeZxQkv2HBez0XAv0PkKbl20s6BfsoRXQa7JE4S7BmfESWTkaFwk7rH6bg99a5K/5gNH8u
 8MCcbCnoYK6t9t/SAit9IshTbTyh5/fh760+uY/20mVMzU0zW4SkaLqj3KpCzdalZIm1pLpv4/4
 jJOl7n5r1RhVLFgvpCq6dlAJRmSM2Vt5BfCD3xhVv/jCQEzxv7Bvq/cQM1LhestcnNEPBXEtrkF
 MakZPz7D+Qdjc1uQusg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060032

capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
arch_scale_freq_ref() method") as a fixed anchor that does not move at
runtime. However, schedutil uses that same fixed anchor as the reference
plugged into map_util_freq() which saturates exactly at capacity_freq_ref.

As a result, a system with cpufreq boost enabled effectively never runs at
boost frequencies under schedutil-governed load. Fix this by plugging in
policy-max into the map_util_freq equation, so that the DVFS requests
translates to the actual cpufreq driver ceiling.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a1782755efcc..dcefbeaa0702 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -195,10 +195,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq;
+	unsigned int freq, ref;
 
-	freq = get_capacity_ref_freq(policy);
-	freq = map_util_freq(util, freq, max);
+	ref = get_capacity_ref_freq(policy);
+
+	/*
+	 * That fixed anchor governs how utilization is interpreted, but
+	 * the DVFS request is free to target the current policy ceiling.
+	 * Using ref alone would saturate the util->freq map at ref so
+	 * use policy->max to reach boost frequencies.
+	 */
+	freq = map_util_freq(util, max(ref, READ_ONCE(policy->max)), max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
-- 
2.34.1

