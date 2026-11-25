Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602901;
	b=G6I1mxCvtvSVvXLGJDvctHgnZNIl65wMsxA50XtWe/wDBmY8VrrYnZZwF0voSXnVPhBa
	 dOhxNVnxNLzE+5wP7n1HcLvvvjW7Lfb23CKZW0al3aC58VO4FL+qXLDmkmKEHlddHFAZY
	 2pYn6fGI3kw2hfWXcVA3zexJ7qY2ovLjCqi6hfQB8NwpMYKcNfAih2BzZPEHdhGSCJQMu
	 AIxnd9maF6zTMbilcO4wKdpap/gx/bMkuBvkm//EZcjs1icEB6EaLGKeDY3NGXvePr6dP
	 fEENPGgNUO25a5QCPJqggb57UAWk4PNds2SBPzgggx0e+9/rfnKt/vBR7NN/MT/B6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602901;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
	b=vQRCfpWR/BiM7E0/KkGTOiZjS1AvCS+F4CuXDS/Bzhmi3daymPiiIOv4JtHQEMLfAOOf
	 JejJXqWgJsbci4aK/WzoZDgARBTugyDlXkrzJPDcgpdFfb6xJwznUGbcVQHCgx2OoW1ev
	 kGhb0rdFWM+iSu8HkN0HCwxKmslTQdeEWN8VZTrUawwAaH7nuU75JFcUSiBQ3FZEjSAK7
	 1WUv1wScbwLDFdDdiSins1K0zQZj89QYdPdHTjY80cpGKNsLi82oqqzoYgXNs+DOIZZWd
	 MWA2ZxjJlzAslpKemdyPxnbM2et3jvXSoaoXxZM3Nu/TpYFbphZeAb4GqlbCJW1N9wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WEJxPzW4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XwSuv1a4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30B606A336
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D30B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WEJxPzW4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XwSuv1a4
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nk9k1505201
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKR
	DLf85eBc=; b=WEJxPzW4QNtLm2FXJyMaQDhU8QRKMgn9q2nwODpdPKmp4xadd/Y
	IeG/KEximjTHnDIYrqcEFj9FVsy2uXcmrthC+DT1DZNnZKNjgSKdHmSJQhQlIn0h
	ABXOE20uMP7WO+C3fFsAx/p5m2nfmFCPp/GybprE0jhwgd4JHIS6EnS3TuOF2wxG
	fiB3ck6sB4vY4rOstVG4YDvGZzN6ah1uZInLBkjbHOVept0AtywwlprMG3w/QwF2
	K5gGGl7nb/LexzDvrKE8ewAvV5CQEF/9CU7ET8RQ1Wsa0+cQSMLFEYpQILxi4FhX
	9w1qMHEPnMXTKbzqCKuUpOCzTYvusOA+xFQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa29s3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:34:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cde6bb2c56dso3068549a12.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602898; x=1796207698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
        b=XwSuv1a4qxWKI5iYYS4KUUxHsPlDF6kjVP1fdV81t49aF5Ao4UeL7JUHKDhwbhtS+m
         dMwAQfjOvqklhbt57LucjmRLG3kWlI2/6+ylcjimNKNqohl3356t4qmp42UkXprzCJuS
         esUwL5OrFFYoeFEUoJlDXb1+cL2lLhRJ937H1tLrOYyXLiM/F+/7usq46zvW47tgzU6y
         GKAFvag16BwBptt1GGOGxHqw8xtrnwX1avas14c0hwUYVFe1DDWkx8nv42iFwpbGztSG
         81SQGZq0+3JUrzUw3ivKCOTuI/yL+EEb33+v86grbCrn8zBzlx6UzdyMqlnDY0wF142W
         8Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602898; x=1796207698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
        b=TQ0abJBqYsGqDwd+U1jEWzF3sDnV7sjvKEsxVLQtnptuekONu1kQzQLA6eafakuCCo
         tqoVqhzq/M6RKiTNQatsg5v1p9wfiMwezlKToeNSR7iYFX5LwR2pBiLltGaeYup8KB8P
         9wrpwSs2/lK6jz3Xxaif/9h4kB0MLUkMMLxmbl1omrXe7qGIpb6k/U5iD4cWr3kNH6cl
         IlsXdWSKdc6EkI6PTsJQ4Ud1xrhjpuoMTCzyFXZPeIUrLlnA7No0wVnkz8uCp4j6VQlX
         lRr1P5YVFylodcRKmLWF8voHsb8nRKjqnz73cNRT9KoIWyxaCPSKFRO6Z/5sc3DF9UpI
         HOFQ==
X-Gm-Message-State: APuU4Z+lxepdzOvGztaRgBklBzrAFSXiRhQiGKxPBmb4bdrzbw2NXfXc
	PPqLwInOm7GuAIhlukR/65PQqOLwopyY2BlCahkBSRc5EG6+BtNeZgVyqqWGqq0l743Cyf4LgjW
	c14R1Ey0I7TnIMGz7+XewS/qkgYu+mhUeJtUwPzCTe4hLe6a+zqhLWt0/jbrzlA==
X-Gm-Gg: AZFdTZf2EAsQvASg1dqQMYXZjblE59Mwyisx1dunvgYEHj43ZbjhEX5T2IbCqVfTcPC
	botFf5vVuqRo/v+UJ1lSsVRzwS3yxftlI0dBU0kCmRQmNqwMzR6WWsHmUeqScZE5Q6pg2SbKtRz
	wuj5zRL370euSRjEfo6pIz11IRuKjh0rB96IpGoz/5aZDW1kbattlaRye99iA2spVq81P7uh8W0
	SH+uP+i9qdjUynPoE3oLU2x6iSGaNb8e7XZ6WXq6BqeUNngoh2eiTH3TK/a0QROAzElTB+6fLcB
	zHXo+TK+9EP4IUROekgS/fYh3+dpS4vUAoN6SYm0TWq8gUWSgi0gO6kfVl6XBOdMvs1m2JMyopm
	TWrMjW+w32WMPmkXpBUMSuqK1yn/BWWwi2c07QgF2cv+97tfrWDWKT7BsMvtJc6il8MXHvGVayO
	82etVvmtfMKTr3o4yFTRRkBzZ4VtXOQvPjTYZJSQk=
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr14212925a91.49.1795602898264;
        Wed, 25 Nov 2026 02:34:58 -0800 (PST)
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr14212897a91.49.1795602897652;
        Wed, 25 Nov 2026 02:34:57 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm28776942a91.3.2026.11.25.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:34:57 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, bigeasy@linutronix.de,
        clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, zhongqiu.han@oss.qualcomm.com,
        Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2] cpufreq: schedutil: Run irq_work in hardirq context on PREEMPT_RT
Date: Wed, 25 Nov 2026 18:34:51 +0800
Message-ID: <20261125103451.1385246-1-zhongqiu.han@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZswnGECPIME0lz2zgbfUt7z8BLU_rI9R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfXz9d0EnQjYYAf
 TXCy09fBa9F1XXbu25ihde4eqGyXjYoIW3gzLwcvYVgpOlR+ZJZf8EyCiF7mfWZbga/haPU2TMC
 brwRbYEIEyn9E4xszkViLvayxt42W94=
X-Proofpoint-GUID: ZswnGECPIME0lz2zgbfUt7z8BLU_rI9R
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06b9d3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=m2RqmQonHRMwM0EXqw8A:9 a=bFCP_H2QrGi7Okbo017w:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX0jCN+8i+P28S
 TgAk3qI7fAP7kvcSlpEyeXHRzQjPgdF230sRFgUgjzT9XjnHU6N8KOuGMUC3jdmgUWAaqGwBAy9
 bJnie7sUvSzEVkQPRvFBIFGKKSOyjYhiZojybtSfYNOt59VjF8gpolpeGsNyH1zyDIZnMidMbFL
 yNbZVttkejKFMx/0atDLO44ZlG145sCpL72KLftgQbgmucQP9IFN8G1E3f7tjEe5gNHSqTSgPYf
 FrGqEOFhNca4a93uljzudP/fZO1SR9uiiFpqJQBcXZvvBf0r+jEEaXUgSDWzNIfHPRdv7me/gsX
 OLBfQFekOZ43HOnS1AyzfKLRAFxngeLDd/L/mSEFuq1JrxCSGEhicDbiPxYgqhhndgfEhWM2spy
 P7Y0uYLPMpvqqSbRQvZkRv1CB600BOG+5L9yR20rE9KV3t0QJ4hPwBrj+D9xbjsYImhdRXzg0oQ
 PaPxtb2ghIG2d4Z8ogw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250041

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

Fixes: b4c6f86ec2f6 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
v1 -> v2:
- Add Fixes tag (Christian).
- Collect Reviewed-by from Christian.

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

