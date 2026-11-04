Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806250;
	b=XxCuWg0bSBZqKW+OrD0iGnxGjFsCEvOo1aG7tt6OAQ5YEMLCBcb+/JMZUnlDpfEhyKar
	 nMOhImMvYNA+nXqrVhweliscBVOj5VoLLCsiL0CozoUsVrnmn1K+Lvvwgpl7rSHmDlJdp
	 lFkhqJSkTE44BfYbj+AXoN/Ho+wnRGtqF+M5++uzMRbak/Ljw5yQ5SeHgPmzbzH91mrRC
	 //dI1Qh7LVBbWqnDhjfOGL6N1QwosB6D/B17pdfZ8sPf1T7iVIs7w42//hxJ4Y3xpCgws
	 LtFhvmva+r1hiQf0wrBk/IGrXM+ipk4YCx79WmM+b7JJf2JcCavKLyEAko1ahejvgpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=60FkNKy5vq8EhtDh/XIweLBcGmETuyJEv/oTZohq2zw=;
	b=Z+wh0M64r45OajT3FN31IrCm67FfYAqZY3Uyx8kCoXUl7gMkfUoZDmFVrcapZpG30fpm
	 1cJ+qap2wBMxeHVGRyCez4FmJY+cSBs8K42Rckz3FQ2IVdWLZ/JqX6fXtLkWKz2xUbg9A
	 l5SBvoHAyjZe7qD76o6TQ2VkzGkgTsxwzPcHOiClfAOpdjS3PEqjTlTu/hkBvJcJYbGAK
	 VkpM1+yH3aChlBhTB16OtxAseQtPK51QS1OY6wuErySQqpxig/w3nv36SpIDoEbW3yMZp
	 V/hLYgIgJwG3dBVlgwgRKoS7Fx04ljJHbjTiF7AJx5XorFWMA53mLRd9XAVPVj6rN5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BDwAN+RN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sg5whUIs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B177606A334
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B177606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BDwAN+RN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sg5whUIs
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bo4JD1387759
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 15:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=60FkNKy5vq8EhtDh/XIweLBcGmETuyJEv/o
	TZohq2zw=; b=BDwAN+RNwvkaBeqrrCMjtvIiWJqRiIzSkfqIYSHNPV1fgQMmz7s
	qx101inGubWz5V5slVUIWJ4Y1oTR6xmDRgxukSqEK6ofKig6DVOxXc11V+jhcG2d
	VNRHVnuBE0d2QsVRwBtD7veKlNx0HOWq2KmNu4yfEEMVf8WTOdHXp2fhKW30OrKD
	HEPQmWpeiAhpax2LxJc+1RQ8unA+RysZDL/W8zQ4U2BpFtgfBP4DtiVd+a+n6FMy
	kvDLW59r8n36JM1lfOFQNQUF6Dquplt+4FDLtRDy7wziaJLg7Pta2zDYNXl8jSES
	vjU+spUTSW+PwjpEjltJT/N7mN19G0VBl5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgash2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 15:30:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed05b3eaecso7719965ad.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793806247; x=1794411047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=60FkNKy5vq8EhtDh/XIweLBcGmETuyJEv/oTZohq2zw=;
        b=Sg5whUIscBOtvJhtu+Vv1Ve1MfRTvuGF8olJG9t3t2tLKjZk8Ok5GbrR0ANG1z8YfS
         0xeDXWIfwuTpxt12UBhjMiqY0hiTsUad2Ydzh5y9Bk9Zfn6C2QiHKth0FlQRsgYIt+rK
         RBdt4p38/UZKGcvJzWmaHLaqt5hdEWMWSs3iwD7xvuSbB6bqupCTwqOrJuLNek7La+z1
         e4dJXdk8qzpKRQpcsb4zOrZCL/BLrgegiWb/fcTo68CGw+HX7ubcMjeV7BtG3EVNMF9N
         eXhRNpyze1NJn/6HIUpGPkE5CSJyt8152gpdm5oyUMpXx7ix863unqk1kVzy4LlLT4Xu
         /G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806247; x=1794411047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60FkNKy5vq8EhtDh/XIweLBcGmETuyJEv/oTZohq2zw=;
        b=0idCmkJGjJHom/r0kwH2nGEEL+zXx1N96/qD4lAyQWqa3z43PHPc5rMquzxX6P/f//
         PIqxE/9edh6ZkJ6qGA6nqsCecDERW+q0SryJmxc5cgMmgyOOF6uWk6y/NpE9+iHaoEFd
         FUAQfl9rTx3amfh76u5uT3G6W1dU+AbQX0Kcct+7Lpr7LfLVDS1b7U/ZovkxZazQXtTU
         +Y8Ob1PW5c+fkrgalt2gaFLDcTNVb7kILzjGyyan3bBebLizWv66MEDuc9/QnbDWCCAf
         hA8tKMMY57KtVqYrHwmQuJgfNgz26IIyPtT+b+hfuOvZPRh53YbklZR1miCJe3k+vU9P
         aJog==
X-Gm-Message-State: APuU4Z+jI/d03VMmIFfj1V8xbAFXVI/cbPcr2/Y7JlEizk8/q8CQDENO
	cJL2k8GJaLkJzAXcxFigHfgevUxGusOchDKDLvoND4kBEvhRpQU4qOCukrxgTGtvhVbc4/53umZ
	PH1DSixmLBwdIlAb96nN29B2JYYr5rIXEnjx0BmdQVbEIhSDb8zrpJrWXvOTQoQ==
X-Gm-Gg: AYBFou3yKwsCUyTk1MuhPyG1XFMCX/dSHMsiBmEboqHS13uTWQNs+nxYHDzB5sk3JUf
	ujwYHmBFxsBKpc/Oa/Ctc3cTw1Ni0qfv3z75dTw28BarY6YdAQeMmjmjn3un1CfyKiPm5ee0kDJ
	kIoL7nGWSO0tfUacH6hbCbUt6t6LmDXlqy/H6cAq1UNxZg8CX/88rNRFxklMyuzOlmrz2KzjFBd
	vR8RmTJ4jzB8OMFyPe/buCEtPj7IUocSY622Um+xVo0+nZpjhZXpQyaVyFikUrxmKffUQoPJcJn
	3G1TtI2WDBUFDGrvZtKjVNzhDXjSgasB98Wgh4DVFW+bv71xLoPEi4Qa9UAeCgpp/0qjMhCcXdI
	a0WhtRGq3wvAMdZ/ib33PRbT5MopbEkLvGJObGOreREftNCYf/hBH0F8TfOreV2pcyBR97DnJqU
	UXn4Ov75b1v5czBYCayq3tMqM3+tNDSlw4mRoFOfU=
X-Received: by 2002:a17:902:dace:b0:2dd:2b8:7198 with SMTP id d9443c01a7336-2eb36414de8mr159111815ad.6.1793806246808;
        Wed, 04 Nov 2026 07:30:46 -0800 (PST)
X-Received: by 2002:a17:902:dace:b0:2dd:2b8:7198 with SMTP id d9443c01a7336-2eb36414de8mr159111455ad.6.1793806246305;
        Wed, 04 Nov 2026 07:30:46 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fdc5b9sm9994215ad.18.2026.11.04.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:30:45 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, vincent.donnefort@arm.com
Cc: linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
Date: Wed,  4 Nov 2026 23:30:42 +0800
Message-ID: <20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb4fa8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZLhjMWIiCFWLY5ZuiNwA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: huLJiigZN2WpceB0fKcm4vz66hQTy2X-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX8/94hAzBkKKu
 zWdASg847fW0blqd8VUWTep2/WYg/DPwowiUi0GGncFF5p8J+UE1rBG+QccPciylKKHSJYUljYq
 yuE1nSmAAtxVKq/rKJ7NQH2tQpafQ3LDDc/B+PrgtAd+DBlSn3bCSeJUqnhAqG0w3YSn+ueD3qv
 hyXdymz13sFlLj/ewFhj71VNkKVLOpajDofsKwEQ78fLiiI8kfban6PYCerO3XRrFz+eOb8MNM6
 8QXjheGtB3Y7HQ+EOiWvgZMmoY8WUOT9paA2Y44Z+FnuudDlnMPLKV1/G7o/2PPQ8jqdOGzs3y2
 89EgqvQrrnv1PgWILfiSqe60x3TKU+0n/Qvv1wfxaZQsxSuinUOOQ7CjfKQEVhLXdW1g6gPvDI+
 z7SoiB8KFlb2V9Ud+GB0kOfqZLfTDKeegsHE50LUgDsPcOtzoJ1pKnaqGb3ltWwSM0x8lrYdYJ5
 9pPF5f5b6yQX6EdxQRw==
X-Proofpoint-GUID: huLJiigZN2WpceB0fKcm4vz66hQTy2X-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX+EpzIGNx/1mr
 qV6q41e1DXzlS09P5sTCnL2yYDza9NLMPUbNW85d9C1Ri28pdl5a53DiQXanh1q4LQ8RBNuo5IF
 lKiwEbO4O/97Bv9sV24f9vZP0ogHBrw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040061

Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
policy->cached_resolved_idx so that "a subsequent fast_switch operation
can avoid repeating the same lookup", and made cpufreq_set_policy()
invalidate the cache instead of filling it. That is, the cached index is
only meant to be used by the frequency switch immediately following the
resolution that has produced it.

However, two other places now access the cache without synchronizing
with its other users:

 * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq()
   in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
   resolved index back from the cache before calling ->target_index().
   sugov_work() calls it without sg_policy->update_lock, so the scheduler
   path (a tick on the policy CPU or a remote update) can overwrite the
   index via cpufreq_driver_resolve_freq() meanwhile. This matters when
   sugov_hold_freq() discards the lower frequency resolved there, leaving
   the CPU below the frequency schedutil has kept for it.

  CPU0 (sugov_work())                  CPU0 (tick interrupt)
  __cpufreq_driver_target(f_i)
    __resolve_freq()
      cached_resolved_idx = i
                                       sugov_update_single_freq()
                                         get_next_freq()
                                           cpufreq_driver_resolve_freq(f_k)
                                             cached_resolved_idx = k
    __target_index(cached_resolved_idx)
      ->target_index(policy, k)

 * Since commit 151717690694 ("cpufreq: Make policy min/max hard
   requirements"), cpufreq_set_policy() updates the cache as a side effect
   of __resolve_freq(), which can race with governors switching frequencies
   without policy->rwsem (schedutil, ondemand, conservative), and a similar
   race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
   inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
   apple-soc-cpufreq ->fast_switch() read the cached index directly too.

  CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
  __cpufreq_driver_target(f_i)
    __resolve_freq()
      cached_resolved_idx = i
                                       cpufreq_set_policy()
                                         __resolve_freq(min)
                                           cached_resolved_idx = j_min
    __target_index(cached_resolved_idx)
      ->target_index(policy, j_min)

In both cases, schedutil does not call the driver again until its
selection changes, so the CPU can get stuck at a frequency it has not
selected. All drivers implementing ->target_index() are affected.

The cache is only consumed by ->fast_switch() right after
cpufreq_driver_resolve_freq(), so only update it there and use a local
index in __cpufreq_driver_target().

Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..ffde75dab91d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
+/*
+ * Note that this does not update the cached frequency lookup in @policy,
+ * because it may be running in parallel with a frequency switch carried out by
+ * the governor that uses the cached index.  If @resolved_idx is not NULL, the
+ * index of the resolved frequency in the frequency table is stored in the
+ * location pointed to by it instead.
+ */
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *resolved_idx)
 {
 	unsigned int idx;
 
@@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
-	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = target_freq;
+	if (resolved_idx)
+		*resolved_idx = idx;
 	return policy->freq_table[idx].frequency;
 }
 
@@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 {
 	unsigned int min = READ_ONCE(policy->min);
 	unsigned int max = READ_ONCE(policy->max);
+	unsigned int freq, idx;
 
 	/*
 	 * If this function runs in parallel with cpufreq_set_policy(), it may
@@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	target_freq = clamp_val(target_freq, min, max);
+	freq = __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE,
+			      &idx);
+
+	/*
+	 * Cache the lookup result for the subsequent ->fast_switch() call, which
+	 * is the only user of it.
+	 */
+	if (policy->freq_table) {
+		policy->cached_resolved_idx = idx;
+		policy->cached_target_freq = target_freq;
+	}
+
+	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+				     policy->max, relation, &idx);
 
 	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
@@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
 	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_H);
+			      CPUFREQ_RELATION_H, NULL);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
 		policy->update_limits = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_L);
+			      CPUFREQ_RELATION_L, NULL);
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-- 
2.43.0

