Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593983;
	b=0R4LejsOiYMV0xBoGb87nzMbiuTe4lYqZNL/OG3teEOSQa0Lj/3o9IuT1hujCMBX9sIM
	 I4mDL4eQyUYm53ZDNpb0i+RzcagI0WLEDtvVKk07J7XdH737sjQlL23qZh4pC1hapSZ6I
	 RkMEhytPBJvtXciJL3d+BVFEudpVcDeu0mt1bZcHw/lvHhyvP3CPbL1gqON89FR9z0AID
	 hjMs5J6nPTZ5dYUHli4lxrKVhVXRauaREQ9NWKkuA8CxCHJ25bIAHC/RCwXRhRQpO96Pd
	 7aGfCTqab4DPBiObRmGeB5IKO2yDE9xKtLfl52a3/Ap7lq4Rsg4sdscI2ShY7NHDo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593983;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
	b=TbVaZL14zrTX+TZGpIMwO1RsMDxLRVCh5SUTT00lexoX4TI7hjcxQjLCCj9qFZ9JrJXP
	 yA8n+aRA82vsdXYWBZZOuEOsEtYjAfGUXbwGeYr7cgPwgsVPpou5lsTacoWSA3imEH0We
	 y0+MzBpvaH+Fl/qJu3U8EcJt1BiuHEYyKtKT3EORpZgcE6CRH3tNOfZ9zPKCwgX9DslbB
	 ppJZqZJ1QDu2Wd6fop1rmgMoYoY9WPCLm/TL7vaX9mW0RBDXKtGiZNs7QL67GpdwCwrny
	 PE+n66dN8Er1/MoiOgaFp/ok55iD9cjUBKoW6Y+1bqjBkpvj5YSRxeOfZzplW8zVd3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOgmEFAK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M05iZ1P+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB9606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BAB9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOgmEFAK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M05iZ1P+
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68ikg3142902
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3
	P1yGnLgU=; b=dOgmEFAKM1/IgLulpGR1NimjAHrnA2tEsxS4CwsLaQ81ccjWW1E
	qD1+mriH+I4U7dJXU5rXYtFGnzkQcQM8xJyl/OKnHsXNJ2oBpJz79gCdqwRbz62W
	eFb1vsXzJZXuN6Udxn2stARmD6huOEj7rDIKV3jM9bjCnASHVPT33FEoE0L/ZOJp
	KA7iRQQt2WXbgEm+Kpn5CQEgZMQvEuklSUwUfhudCKaiNDLeHSFGL7UwTWnaCz01
	+6IkAvPmCpRIfpPuv1qlDD79qir1B273eBrvG3Q9X4xzDclasq3teZvl3rP9plbr
	CaGH1p5phj0HsTIwQLyT1KoWNpv/51btbSw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc29n6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:06:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a05b68f851so4846518b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795593980; x=1796198780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
        b=M05iZ1P+bHXGaKfP4T+YY8stZWk25N80uiN479lXi31x2/cmBkQFWsvBnqqF8Nu5Rs
         pHIMsXO7D5sL3P+xtOqt8649eikT/U+hEaC/SYDmBQ5W5ayHX75K7oM5LZcJy92+n9r/
         m0jl40LWjzoSDKdF5ysGAj7hwp3dMoNcFq0pzXH2NIps6QZF79+wW1xk03KPxMRSuSSw
         Z8RB0dive6Bvdqv3Y16yvT0EFv6sKLOn0DrySjkKAAvESFYnIBkeQRZu5Jxn2jqzLw7K
         521l2z++XeLIGdXnw/fEreuVKZFh9b/dkl8tXJjCHjAx89icwypMiyXZWviUkW16ucWV
         TaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593980; x=1796198780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
        b=21Udj338L9dMToqP98acWi05q8wCh2nVutM0NgOSOlfAcH5TzUsYfNvc20GYL1fD2z
         XPhAG+EYKYbKHCaYaQCCtB05K+sldlXGURC9IXj3tEKn1v1UnSOHEi+mTN/cLIvNKftp
         ZOo5642kxkVA/3QMb3uWO8tBFYoO5ul/xqsrcdMchLTETRp4JXu9l9NpzV9H9rNN7CAP
         VaR0iB3Q2seJ1Xyd4oa4XLZ0B3e3VLErYnV3Up4MTmJeUv3osAD2JVgtUfDCvx95VnYO
         0kUvlteAHB7cmkr+ycoXVV4JOcKK9/AsIVMunfc0Nyg+bTAZdVt3qGKayKm93teXlFq9
         F/Tg==
X-Gm-Message-State: APuU4Z+Wfy5JSYwSnnaJ5pRwsDmiV1OH8kpdWYKe4cuJ0lD/Ce0OJ2s5
	Gw2MXhqliBs6iZnje72NkBTNZthbBae9zMxrxwPsEqRtShbqT8ieqkcS3/EVzn8sxg8wkoChtT/
	MTEbKPI/YemLkzz81xae2VyQahrArxdpc9mIppiKlClqxQrsgGjsLzh7wOKLZvA==
X-Gm-Gg: AZFdTZeT/ic1pojn6Wgk80Ius/kHlS7P3UmrGAxQdBzzdRcKOz5mISYnY76q+6nUe9N
	Wqjih8+RyKAvc3oIe0d/XSClBFJ6/WM5g6gz+om7v7o/twhM9uRJT8zNGSg3Rxmzhk4zxqUGvsm
	ZCHVftYiQvqesDM9BVseJ26dsMmNUrkzdYlPdQjuPfv0YCyE69GKCdsogajZ/NcsHbjtJwMH3hr
	gLcsX2w69Jq98NRQzKbUZonqyEmJjyNnCFNW5x3Mhh3VJsnhH04q3v8GAzqw1yl5gwx9r8+/nR4
	9vLb+stW3e47Z7Y6aM1KOAsfIV5N/ChW7X+xkwNWrmQDTMjRzjI70TyZNkXzmWbcDK2xcmvBKE0
	6iG4BqbJlU4sTnM3FWbFssarUtWNxVgxPzGiKycmL4si+zf1VtDU0C56TiX5ZjGO8YWBA5g/Nd0
	6DpLcHgoqvTbjcWwY/Sr0aJGa2/TZU+edmcZdXAUs=
X-Received: by 2002:a05:6a00:21d6:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8c87bcb7b35mr10647267b3a.8.1795593980048;
        Wed, 25 Nov 2026 00:06:20 -0800 (PST)
X-Received: by 2002:a05:6a00:21d6:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8c87bcb7b35mr10647255b3a.8.1795593979558;
        Wed, 25 Nov 2026 00:06:19 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b25bfasm8558604b3a.46.2026.11.25.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:06:19 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, bigeasy@linutronix.de,
        clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on PREEMPT_RT
Date: Wed, 25 Nov 2026 16:06:13 +0800
Message-ID: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b0696fd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=m2RqmQonHRMwM0EXqw8A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: leshffVwLW8b_uoYyYg_whWfgbu9SZMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzMiBTYWx0ZWRfX56ioBI/jlwS2
 ivjx0uajRvRK1j5i+iQLyTpBOysWbe7H5cRb9tPWTQa8ebSufL54T0cpy7x5znadhR9UepBKrFz
 uJ8YFTambKcSwoxm83Pnpm89/5ou3QA7dKfm3ObpuojKgsQgNsGUdHji5XYU/aO0gRKgc4Oh4Lb
 nH06nrmpBuDdsIfzj5DGVQu8PW8CTI50QYjvgTRGTzVy7m4FFRIDDycIEYw5PIszEQJaHIZzsBk
 yodIMsOhNIKN/Bv/73ukihTH5UYaYVsoG9mWuLLb4tVnM7IR4nd35eMnWqIFIMMCL9sWge/gU9a
 Ta6zxhbpzOc4kGMpSkZs4LqLHGr7SZ2d3yH80yY0DHgOIA3+C3wP0ulgA57qvPOb3ikjEgMtOiV
 LSKBA4e4x1wIyFBSmONKWfUwrN7o7Del+MXeXEhU+NzTpC2R5DNLtaZmd5unoH1smDLvU25sal5
 Fh/8Ntp1jna22eR7TQA==
X-Proofpoint-ORIG-GUID: leshffVwLW8b_uoYyYg_whWfgbu9SZMo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzMiBTYWx0ZWRfX5RGhFkkdI98G
 8bw6lFTTjeu9sJtiU0xs9eYAkTxPhY94BIvK5cfVmavTLRCDDrARoqZghgPvYIUlaKs3e4g/2TA
 1Vp9cSLc8C5ixNH2jAkfAlPQd7HiE9Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250032

On PREEMPT_RT, an irq_work not marked IRQ_WORK_HARD_IRQ runs in the
per-CPU irq_work/N thread at SCHED_FIFO priority 1. The schedutil slow
path queues its irq_work on the local CPU, so the wakeup of the
SCHED_DEADLINE sugov thread is delayed until no other RT or DL task is
runnable on that CPU.

Meanwhile work_in_progress stays set, so no new frequency update is
queued for any CPU of the policy: one busy RT task can freeze the
frequency of its whole policy.

sugov_irq_work() only calls kthread_queue_work(), which only takes raw
spinlocks and is safe in hard interrupt context on PREEMPT_RT, so mark
the irq_work IRQ_WORK_HARD_IRQ, as commit f8d958880933 ("srcu: Use
IRQ_WORK_INIT_HARD for srcu's irq_work") did for srcu.

Tested on a Qualcomm SM8850 board running PREEMPT_RT, with SCMI cpufreq
forced into the slow path. With a SCHED_FIFO 10 stress-ng worker on CPU1
(30% load, 50 ms slices, 15 runs of 5 s each), sugov_irq_work() now runs
within 15 us of irq_work_queue() instead of waiting for the RT burst to
end (up to 212 ms), and the policy frequency is no longer frozen. The
irq_work latency below is measured from irq_work_queue() to the entry of
sugov_irq_work(). The cost is that the kthread wakeup now runs in the
irq_work IPI handler, as it does on !PREEMPT_RT. In a separate cpufreq
stress test with cyclictest (SCHED_FIFO 90) on all CPUs, this raises the
average IRQ work IPI time from ~0.5 us to ~1.3 us, with no change in the
number of IPIs, and the cyclictest per-CPU worst case by ~2 us.

  PREEMPT_RT                           before              after
  ---------------------------------    -------------       ----------
  irq_work latency on CPU1, max        130 - 212 ms        <= 14.5 us
  policy0 frozen, total per 5 s run    0.57 - 1.25 s       none
  cyclictest max, CPU1-5               13 - 16 us          14 - 18 us

On !PREEMPT_RT, cyclictest and IRQ work IPI duration are unchanged. No
lockdep or DEBUG_ATOMIC_SLEEP splat on either PREEMPT_RT or !PREEMPT_RT.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14405a614991..b2e9ac7e3517 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 	else
 		kthread_bind_mask(thread, policy->related_cpus);
 
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
 	wake_up_process(thread);
-- 
2.43.0

