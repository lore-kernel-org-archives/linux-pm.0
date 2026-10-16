Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AA390CAA
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147277; cv=none; b=gMQP6H/ItMlQqY/IWtnGOJu5MGQSHs42HmbjSB6wQzKiSUk1mMBIK796RMTn9xGUHDN0vWbe4PECC9DIVtEaA2jyRDcKkzYTr/d8j4OnjpI1yxEPSaKzukJ4oLmhIuOd8EeeAHPQHTL08eRsbXFC3esBMOtLzAqgB9KePYEB8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147277; c=relaxed/simple;
	bh=en6GIR55VlWX7dSVSQCDMJ8nDuSuwT7XlUJmF14yJ10=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=AhZssHn2ApgngwOfw1ON3T70XpRbZ/pakgiWkiv4xH9vR/hl/+0FPMDSotYqB8SdfPTNbQXW9asUkRPXoaZ08mAv/sP03KJl4JFi+qR81GZkNURAmRYkkjLl6d0GzVxDw0cnNlkJn7dL9Lj381Y3lSGVxplrBrI+icv5szN2DgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AK1pHkk/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2FoU+Pu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AK1pHkk/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2FoU+Pu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAA98n1403279
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aomnUylDwXdx5lpqXnbm7P
	nJ90Xw+08tTXTkrKKRzQs=; b=AK1pHkk/coTY8iUYUNFW7EmF1lLWYFc6aIn3/v
	eusVnOBWYdOApK4MdsGV1xMRTGrPfykzUyEdW11KQBPnsun5LNqySaz96cBJJMGK
	2ouVIBXaO0gZUNc5Ewq29mAnd6Q23JF1T9aOm4LmZwgAivR4sVHpcvFzgROLzckb
	Ay2tOeKu6jarN5vFlC59jdbrxS5pSe6Fx7azLV5C0A70zG3gZvPjJko3BrdKE510
	k8Kpdv66R9pk/tX2nzExp2Hhs2lad1itrap6feEVN2OaVrYntX834Ds3+ErBi9UI
	3G6IjhCkGaRvb+B+Fo2+iLwiGCxBuHTxhW2I24J5RioG7u+g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb5seauhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:41:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so4493932a91.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792147274; x=1792752074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aomnUylDwXdx5lpqXnbm7PnJ90Xw+08tTXTkrKKRzQs=;
        b=i2FoU+PuIAsPr7p61s8CI4kfoxQv32f/ZBFjQ3g/zGCkzroDZ5bS2McUQ80vRXAihY
         1KxGP9GYYImnYX+65brpQanzHhVhCXoAl7GX8ix+osJdmPBsYXICQExV5SE6FDSOKLDj
         hrpsAJfjz9/4Ur+4FWkl3ZDp538IOlm4PNSGQtxwiqBnVunphMlJeAE+jZsYSdN0mRJO
         wwPtKZLLirxmUy9rUvIRIKLrO1V7loYNJoH2JvpBFVEcf5CGdoCbunppm84mQ7snAfOd
         EjQ2vGykpu8QUDRhn5dy9/eVywPpXtoAYF358TqR4aucbu5Y/StbqIuVFWUTgpVifMYL
         pbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147274; x=1792752074;
        h=content-transfer-encoding:content-type:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aomnUylDwXdx5lpqXnbm7PnJ90Xw+08tTXTkrKKRzQs=;
        b=LqONBfegjFlPqXaVh9wSQaRrYPpUx6cni/AfpK9fz1z1dMfJK7WEIUVaRUjRbJeaya
         pliEkq8eNx+Tzh1buitJ1QuONkmX18Ym1Y/EsbZYJZZaKkLJyTNU6IQKoQ0NlhgTy/zz
         X8WewzKMguN21GQ8z+6SETauYtPGgtM8YcIJ1M+7x3ZacFyv5bDuVvl1wG6uy+/mBuaC
         T3G9GzRnxz42V0hYaQ2jtwIyqGOgmGBz9tfw/6b1fFlZ3UMZ/TVQG3hyZN5x5j7gO8Ou
         IvvdfoSZdUhDe/bjU1MVwIKQcTLKiqdex3yfjAPCqH2OaX3RCVxC6GkvJb2i9Ry0oamg
         SJOA==
X-Forwarded-Encrypted: i=1; AKwUvBywgOAd7Rz12J2aR4csmRxh8eNTfkcY8P5azeb8aJG/4O19yW3SRr5GptGEZmR5CsOYmA2+2lQQ0A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKL3Att2HiZ4awwT7XEOZZXeAulHtXfGDoTEMBCzTWm5xkKiWS1
	ido/+6syUwdlBrzlfqulboWr3E87BG6O0tD+LV4dKXkmkYxfQo9Vijl655DyCjuSdCoQ+iWR07t
	wjAJsilKSDse7a/JBZNGQ6TG9M5eKiX+8f/Yyl8epsbdROyg/SJrmOdmbebJXDg==
X-Gm-Gg: AYBFou3lUCcTc35AFqSSMNqkViA5KOzWpoHZ5HGKiSaFX0ekYlp7AW3OTFF6pRPQWZT
	H5tK7ZGmKW/o3NUcuAB6GbkdgyTZI8r0TPXHCRVpNoy24uSVl4iYN2Rm1t+4Kvm3nuP4FVDHJR+
	0rgbtAmRSf8slqLJrBob3DiqxDz3TldtMeeGGnJpVBX2uC8FeB1C2uBZWkAYAea7QBNc0eHi4Pl
	vQMEzv4zG1zLxELtBgqFXIcPHOV7SFShEeSsDauS27eWXdQLXE2kJuSFNh+S08Ai37nSfu+UG2a
	smRR22VVZbkkBIp8AH6vB1m40s5W0713cOYQIxAR5gqX861YG/w8Xw0ENUbFEcqHYW+TrtOI5xY
	YQL3hE55N+VxD6Om3yQQmHitrKDY=
X-Received: by 2002:a17:903:38cc:b0:2e8:773a:e902 with SMTP id d9443c01a7336-2e8773aeaafmr169186765ad.58.1792147273572;
        Fri, 16 Oct 2026 03:41:13 -0700 (PDT)
X-Received: by 2002:a17:903:38cc:b0:2e8:773a:e902 with SMTP id d9443c01a7336-2e8773aeaafmr169186505ad.58.1792147273052;
        Fri, 16 Oct 2026 03:41:13 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804bfbsm7917915ad.28.2026.10.16.03.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:41:12 -0700 (PDT)
Message-ID: <2a5dd3fd-a03f-4ffb-827c-2937bf664c75@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:41:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Aiqun Yu (Maria)"
 <aiqun.yu@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, trilok.soni@oss.qualcomm.com
Subject: [RFC] cpuidle: runtime exit latency prediction and timer compensation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX6fLBiLVedB2L
 H/l0w5UW1RQK+l3v/ZQN1kMY9SYFIHUbVIFLmRKW9DrCT6IPJmqAyrROG+fy9Yr/wAV/LPOP0Xl
 fQ5+LwQL+lYvfNRjXoFXtDh/kFyE400=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfXzLHWUEp0sXEA
 6AOMQKvokwTJEaLHaukaj+3OfB6ZOWsTf107j1w4o/CdOxp1uD5IpZqcC0SRrCktbKmLTwpKCud
 G/27jE4AsNnEVsHfG2JcQo1Sl+FSQMabYZ7P6uwuau6QKsxVtLfhH2ldU85Eh+xBpWNB2E3fIAs
 lEM59+aOSE/2zlVg86eTabyXX1b5Gud/OyhwB6R7tPUHwip2Hrf5mIJo3OepxWEMUugU8ebe1Q8
 obcJt2nWZatxZeWt+4U+9SsMAHfiIk37W2FkJS2X2CK4oJb5n6a0y+JasKMxRLPJhlIk+wosoxp
 f1wMO+0Z4wYDf8p/lR1Gd/DMShLjB1nbK2GlBbTd9kbeYLRAQrdE6KnJ3m6cTlEmjJGjueDHCnd
 WLGx5DLv2an8ys2NmhpIrsJcSgzg5oCxOLIAbsuMRoXeb6XF6Zx/HIirWNlhlxFj4R8DDj9we6T
 E7jCMG5Sq91rEDgtBOw==
X-Authority-Analysis: v=2.4 cv=P4yvFSAu c=1 sm=1 tr=0 ts=6ad1ff4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=sve4fK1iXEEtLkbIWiAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=UYjydHh6ynBBc6_pBLvz:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 4aEBImdTxU8q_IRo_aDQ7V2cSyKs_C3k
X-Proofpoint-GUID: 4aEBImdTxU8q_IRo_aDQ7V2cSyKs_C3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042

Hi all,

1. Abstract
-----------

This RFC proposes a way to measure and predict CPU idle exit latency at run
time in the kernel. It also discusses how to use the prediction to reduce the
delay between the expected hrtimer expiry time, called hrtimer rooster timer
solution.

This idea was presented at the 2026 Linux Plumbers Conference [1]:
[1]https://lpc.events/event/20/contributions/2595/
We would like to continue the discussion of this approach here in this RFC.

2. Background
------------

An hrtimer callback can run later than hrtimer next event, the expected expiry
time. This is a known behavior in the kernel. Hrtimer expiry only means that
the IRQ will be generated at the corresponding time. The callback still waits
for wakeup, resume, and the rest of the timer IRQ handling path. This can
delay its execution.

When an hrtimer expires while a CPU is idle, the timer IRQ starts waking the
CPU. The hardware resumes first. The firmware resumes next. The kernel can
start running after that. We call the period start from receiving the IRQ to
the entry of kernel execution as idle exit latency. Different CPU
architectures and platforms have this kind of idle exit latency.

The kernel currently uses a static idle exit latency from the device tree.
This value describes the worst case. It does not directly show the idle exit
latency under current conditions. A more accurate idle exit latency estimation
will cause less confusion and less power impact in real use cases. A similar
upstream discussion also points out that using a static worst-case value to
estimate typical latency can cause errors [2]:
[2]https://lore.kernel.org/all/44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com/

Other related upstream discussions cover genpd CPU latency QoS [3]:
[3]https://lore.kernel.org/all/20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com/
and IRQ timing infrastructure removal [4]:
[4]https://lore.kernel.org/all/20251210082242.360936-2-maz@kernel.org/

This RFC therefore discusses how to measure and predict idle exit latency in
the Kernel context, and how the prediction may be used for hrtimer handle
latency accommodation and other kernel Decisions needed to consider the idle
exit latency.

3. Runtime measurement and prediction
-------------------------------------

Different than other interrupts, timer interrupts will have the info of
expected time to be triggered. So, We assume the hrtimer expire time and it’s
handle latency can be used for specific idle exit latency runtime measurement.
We identify the cpu idle level, different cpu, cluster idle level is the key
difference of the idle exit latency variation. This section describes how the
kernel collects runtime samples and gets a typical exit latency under current
conditions. The collection step records valid samples. Prediction uses a
sample window to make a dynamic estimate for each condition.

3.1 CPU sample collection
-------------------------

When the CPU enters idle, record the CPU idle level it actually enters and the
current programmed hrtimer next event. The idle exit path records when the CPU
is awake and running again. This point is before any IRQ handler or hrtimer
handler.

In this RFC, observed exit latency is defined as the time when the CPU is exit
from idle in kernel idle driver minus the programmed hrtimer expire time:

    cpu idle exit time stamp - programmed hrtimer expired time

Keep separate records for each CPU ID and idle level.

There is much noise that will affect this period, for example other
unpredicted interrupt coming at the same time. We only take the measured and
expected time into consideration. A sample is valid only when all these
conditions are held:

  - The target CPU entered the target idle level.
  - The target hrtimer has expired.
  - The target CPU had only the target timer IRQ pending.

These conditions make sure that the recorded resume time belongs to the target
hrtimer, not to an early wakeup caused by another interrupt. Samples that fail
these conditions are marked invalid and excluded from exit latency statistics.

3.2 Cluster exit latency
------------------------

A single CPU chooses the CPU idle level, while multiple CPUs choose the
cluster idle level together. When the first CPU wakes, the resume process
includes the resume time for the whole cluster. We use the exit latency of the
first woken CPU as the cluster exit latency.

The cluster case uses the same measurement method as the CPU case. The last
CPU that makes the cluster enter sleep records the cluster ID and cluster idle
level for this entry. At exit, the first CPU in the cluster resumes after
wakeup represents the sample.

The validity conditions for a cluster sample are similar to those for a CPU
sample:

  - The cluster entered the recorded idle level.
  - The target hrtimer has expired.
  - The target CPU had only the target timer IRQ pending.
  - Other CPUs in the cluster had no pending IRQ except timer IRQ.

Mark samples that fail these conditions as invalid. Exclude them from cluster
exit latency statistics and prediction.

3.3 Why measure in the kernel
-----------------------------

A user-space program can use a periodic timer to measure the time from hrtimer
next event until the thread runs again. This time does not accurately
represent CPU exit latency for these reasons:

  - The time when the thread runs again includes scheduler and user-space path
    overhead. It cannot show the exact time when the CPU resumed after wakeup.
  - User space usually does not know which CPU idle level the CPU entered, or
    which cluster idle level the whole cluster entered.
  - User space cannot reliably tell whether the target hrtimer, an IPI, a
    device
    IRQ, or another pending interrupt woke the CPU.
  - To send test results back to the kernel in real time, user space would
    need
    an extra user-to-kernel interface. The results cannot then be sent
    directly and continuously to a running cpuidle governor, or used directly
    for hardware timer programming and compensation.

3.4 Prediction from historical samples
---------------------------------------

For current experiment, we use a simple way to do the prediction to the valid
history samples. The predictor keeps a separate fixed-length window of recent
samples for every CPU and idle level. It keeps another window for every
cluster and cluster idle level. The current prediction is the average of the
samples in the window.

4. Possible use cases
--------------------
The “more accurate” idle exit latency can be used in different areas. It can
replace the current static idle exit latency used in current kernel
components. And One another possible use is hrtimer compensation. We will take
this as a specific example.

4.1 hrtimer compensation
------------------------

Idle Exit latency is one important part of the delay before an hrtimer
callback. When cpu is about to go to idle, we can predict the possible current
idle exit latency and do compensate. the prediction can set the hardware
wakeup time before hrtimer next event. This can compensate for the delay
caused by idle exit latency.

We call this early wakeup interrupt Rooster IRQ. Its lead time covers the time
needed for hardware and firmware to resume. Rooster IRQ fires before the
original hrtimer expiry time, so the CPU can resume close to the expected
time. It does not change the software hrtimer expiry time or run the hrtimer
callback early.

Rooster IRQ only adds a new hardware timer used for wakeup. This can use The
cpu local arch timer and a global/broadcast timer. The rooster timer is set
before hrtimer next expire time.

In the CPU case, use the prediction for the CPU and idle level to set that
CPU's Local timer. The local timer wakes the CPU early.

In the cluster case, a platform may have several global timer frames. A
separate frame can be assigned to each cluster that needs an early wakeup. The
last CPU that makes the cluster enter sleep sets a rooster cluser timer. It
uses the prediction for the cluster idle level to set the rooster wakeup time.
The rooster cluster timer directly wakes the first CPU in the target cluster
that needs to resume.

If the platform has only one global timer, or if the local timer stops at the
target idle level, a global/broadcast timer can wake an intermediate CPU
first. That CPU then sends the wakeup interrupt to the target CPU through an
IPI. The rooster timer lead time must cover the exit latency of the
intermediate CPU's cluster and the target CPU or cluster.

5. Prototype status and results
------------------------------

The measurement and prediction mechanism has been validated with real hardware
on Qualcomm's platform.

The LPC slides show sample results over a period. The sampled exit latency
stays fairly stable during that period. A prediction based on recent sample
averages also follows changes in the samples reasonably well.

On device, we enabled compensation with one global timer and broadcast. We
measured the difference between the actual CPU resume time and the expected
hrtimer expiry time. t1 is the time when the CPU resumes kernel execution. t0
is the original hrtimer expiry time. In the table, "Before compensation" is
the reference with the same definition. "After compensation" is the result
with this compensation path enabled. The unit is us:

    Metric: mean absolute value of t1 - t0, us
    State               | CPU C4 | Cluster CL4 | Cluster CL5
    -------------------+--------+-------------+------------
    Before compensation | 19.824 | 61.991      | 1929.767
    After compensation  |  0.073 |  0.191      |   10.738

6. Discussion
-------------

The prototype code is still being cleaned up. We would like to discuss the
design and get community feedback before we finalize the code. The feedback
will guide the next implementation direction.

Thanks,
Cong Zhang
