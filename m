Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589888;
	b=VpbHbv/m6RzsGXpPeeAH/OIM6kLU0AsUJhCqV47g7bCPcgOc0ocz5lRfeUruNS+761J3
	 a16lrfwAv45JmAe+0oQeGw2No1CpybbVvDAefE0qy9ZjpuW7cGXVIjhdX8IjiTM2SVEFH
	 +inCU+0sXVy6KeSWt9sUhAQVv7A7BsbseOoKEVmaWeLy/rqosrZRj1+0D1wt/WNNI5eCF
	 TIKI5TudS6vFKXxbjtStLhd3uY6nVMJDnc8FxAvyz6iR1+dxfRHv/eRufS5EY/4+wKld6
	 T9VOOOl2rAb7aoZR1YuZVKNXX8j4rP2ajg8eFf/Vwa7usQrMfK+j48df5A+56Y1/0sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589888;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VZsKRZWz0Z3rxIIDrH7Ii4MPaAl18xQJ9nCcRam0HMk=;
	b=ys3o9SzxTuaOJjt31kDBpyExtm9x7QNfxcYokdUYyOlr1mKJxiKqScV+gZE88ynPRbd5
	 QePMd9w1pcAzEdIHwzuJx9P5EG+ZZlMdpHI+pv7ul7hbmyGw8cwcAi+87BNyBcsXIvrmt
	 OrTRQ6IzsDzSWIVIAwDoi1JYj2bGUk8M6kXalKiTkpjDIlFxRiefO7LqmLMzZ998Tuwcg
	 m+98qnhz0wVO26Irgvivx1Y0cQL9eBGJ3j6vpDiXKdRb5yuKS7Ljc5k6pU78WgrxNax+i
	 AaMZ+8cC2884jGiy6YOwlZg5ZNAOgcvdAR92nw33aJ7y/UaZz6g1Qz2qwatafnenP6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="KwizZ2/i";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=km2vc9Aw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED88606A327
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 03:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED88606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KwizZ2/i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=km2vc9Aw
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20K1np2288057
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 03:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZsKRZWz0Z3rxIIDrH7Ii4MPaAl18xQJ9nCcRam0HMk=; b=KwizZ2/iLm/Mr1Y7
	DS7V4LgZLSQ0mhpqQV0kNMUsAyfwV+Dr1CsvqSx9Z7z2NF9qEyX/lEShMBdFpWpw
	8u3sNBdkvkBN6Y0qNBAFrcfLVsS3AccGIcKxo7p7zSbyJ26K3zybCnx+7mICBVtL
	YBxFCFNQ4d9i/9rq+6l9MlnqwHFRNRrnK760vJ/K+i07CswctI+HNYyorvUK0U0g
	IR0kEriYqjrcYo5jc1wV7HHfA0taxTAS6jAWdOTAxdDr1DImOYVYrOV8o1YZ+zUn
	gemueFL5DQotVUUtF3NL/5A98qUYRj+uM7QMqzpCRCjjjm3Epo1JX8wBPeyIbSQH
	FFnWNg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8ducxjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 03:24:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a06bc723b1so2893227b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 19:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793589886; x=1794194686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZsKRZWz0Z3rxIIDrH7Ii4MPaAl18xQJ9nCcRam0HMk=;
        b=km2vc9AwOXZ2TpQf3BLldKGtx/UiLRE88JcZ/Dt/KCqGcWeCCu/yH5RpLp5QOyfKTc
         mzlGJr0F6ffIb2GgkGlWgts7+3j/W/zPPi9AlHKCngtuNJW8PbZjwWT+3r9EzZwzxV12
         b6vz2lDCva77h1sgAdeBihs8nb5hGxpqfjQ5Ml/FbmvrC/M2/NzsTSk5YNyspcdCQfjr
         uTH4zFjVNg+J1crmpxi8rBfdEBoK9uLWT8SU2ZMPAuqa3L+l28yWl4zBpHniC09xYnp9
         UMDGGMhM/wg0cMPHGV8ZlJ0uYlWK4FMPCdM3gRB20TtTVJpyNomuVz8wWUOwTDOzAlok
         M9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793589886; x=1794194686;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZsKRZWz0Z3rxIIDrH7Ii4MPaAl18xQJ9nCcRam0HMk=;
        b=N9zXuB8fif/QoAiOs/Oijh7tFqAaF9E9Q5mgRa3OMVnh4l1Xk9iN/lEW4oPV24qebQ
         8/iVTUqoxmJaM7Wwj6vEgtBHLTmpkRzvoyM/n+9efPjO6Dt5jsJgn9VuUj9QfUqwnl2/
         0bmYcUNJ8WYP0bdJMw1lxnmIXUefCQU09fRhlhg8wbd2EQzDnAHGqVunlFLXYVXCqK8M
         N20RDxatJBtQHZKoHZ28HDoWdteRyq9HNWigqTbrmExX+wnWuV8ja9nz2umraaCogFgp
         BjKQVODuOnlIP58hQcE9047X9xFxDjQGfpAeflK4VOomnLgiQZK0oWk0xq1v2kW8Nvnq
         KPYQ==
X-Gm-Message-State: AFq9FYLOPZjKQaRVn6EL4TgnuYbYTyRGXfYyr/uB5kVUmZStHsL4Ksf/
	TKK6ux3jbCXsSbYAYQhgy9lREY3FIji9eUOa0UtzuEzxz5LQHQbvXlWeQJnoHPGId8IoHrpeHQB
	6X+jwN9lEU8ich+kGm7Y21GSef2NvdBoHqYt/QadkvXbPNcOlzUDAo8Xi13ZVsQ==
X-Gm-Gg: AYBFou26Noqam5biZUH923JPyAStUj5pFxxuD8mWdvIUrRg9Mb8irrTr6tdlKfxvOhj
	OTE/mHklEXjqp1GMfx0PgCZXGxi47e5aooiHt2jB5VGBBGJZRC8XkWbXQIyi0SjXUOKBLTqu+eq
	feSAgu/lnraG+Xqo59Brhtl5y2dsEpSVEHHoxNJHvQYhftDU9OWH6qNXa5wNfOOrIoRjNNj6Vil
	yWflIuvfcYGqXaiUTePsXcHBST8XErG27YypDXA1RIcMhhUf0ivFqqbhpuNxH7r2/DHuo0TegKK
	adC4ZySF+36BC/ze+H5mAYpruwJw+vg05t0JCn0R6DZXvv9XvIMZLHuY4P9BpEFlKCY7oChNR5A
	Hadc9dwgrl5IyIzBe+e7TVED8zoP07od2vqaWMV1IXFP6cLZ5AFddNVHRK4r9OiKKHSBbWbC4Mg
	I=
X-Received: by 2002:a05:6a00:1412:b0:89e:fc47:2c17 with SMTP id d2e1a72fcca58-8a9bb7a0b59mr7793190b3a.19.1793589885540;
        Sun, 01 Nov 2026 19:24:45 -0800 (PST)
X-Received: by 2002:a05:6a00:1412:b0:89e:fc47:2c17 with SMTP id d2e1a72fcca58-8a9bb7a0b59mr7793178b3a.19.1793589884938;
        Sun, 01 Nov 2026 19:24:44 -0800 (PST)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm1390092b3a.39.2026.11.01.19.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 19:24:44 -0800 (PST)
Message-ID: <334c8abe-79cf-4e86-8ec4-6038ba5d4f52@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 11:24:39 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cpuidle: runtime exit latency prediction and timer
 compensation
To: Pengjie Zhang <zhangpengjie2@huawei.com>,
        Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Aiqun Yu (Maria)" <aiqun.yu@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, trilok.soni@oss.qualcomm.com
References: <2a5dd3fd-a03f-4ffb-827c-2937bf664c75@oss.qualcomm.com>
 <81963d52-0d49-4fb5-b9c8-e1199999aeb4@arm.com>
 <428a0bae-adad-4cbf-b551-fa0f0ab4e694@oss.qualcomm.com>
 <0b481bb1-edcd-4ce4-8e6b-915c4e2e3e6d@huawei.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0b481bb1-edcd-4ce4-8e6b-915c4e2e3e6d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae8027e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=oDY1q4FYUH9vCYgQK8YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=UYjydHh6ynBBc6_pBLvz:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: lIXbIpkgfGLl3Oyg-nh1Dnzh9Ohsg4cu
X-Proofpoint-GUID: lIXbIpkgfGLl3Oyg-nh1Dnzh9Ohsg4cu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxMiBTYWx0ZWRfX+8jbptdPTyjg
 WiP+datXWMu1NsOozMwxp9GG6ZpkXA9ZeT6HNhQNHyiiSz6nE7eBWSp3UipylabRS9R5s1r+Lo2
 i0imvYSh0/TQKoJ8LYD/cwW+nAaCb6Sflwxp3sDyuirbNFro5rXk8XjpPdhTPKC0vfL3yWiawxV
 qhcKOTjgrwxTXQaOpbbPVvsjqPFw5+VWzKOreMygPbBJX43iZR/ypW/d405qBOm60+QmjXxFSmG
 sZyXV9eYfsZroUtKbxKJbO7g9ES8KUFGxfc2xWhsNNBXu+WaWWAeDUV0h2WW1PIvs+Jlg3a+QV2
 iZZk3b05ioj7jH8HG4oXKkApFvvfxXAf+iCKu7zKExLUXV7sYRQFAYltXayZdw310q3yuNS49rp
 AgJuccmLawNkI7uLfaA9ZhIYSAyiz6vTfs1icDDjpFZW0dy9zuqJokconPY79pqpuBBcHpDm24L
 4Bf7gZzU57qHPd/qKPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxMiBTYWx0ZWRfX8puiwCzt991e
 6GAz91BpVzLqWxZ87+fCfOvHoBQ3bmibFzF8IkzA5aORZ7WpEsTNJ8uDZSL0ENdHnhUb0uM/IZX
 P8uwYdbNqFEMbWotZsctXGp0+DLnoSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020012



On 10/26/2026 4:17 PM, Pengjie Zhang wrote:
> Hi Cong,
> 
> Two comments:
> 
> On 10/21/2026 11:51 AM, Cong Zhang wrote:
>> Hi Christian,
>>
>> Thanks for your comments.
>>
>> On 10/16/2026 9:32 PM, Christian Loehle wrote:
>>> On 10/16/26 11:41, Cong Zhang wrote:
>>>> Hi all,
>>>>
>>>> 1. Abstract
>>>> -----------
>>>>
>>>> This RFC proposes a way to measure and predict CPU idle exit latency at run
>>>> time in the kernel. It also discusses how to use the prediction to reduce the
>>>> delay between the expected hrtimer expiry time, called hrtimer rooster timer
>>>> solution.
>>>>
>>>> This idea was presented at the 2026 Linux Plumbers Conference [1]:
>>>> [1]https://lpc.events/event/20/contributions/2595/
>>>> We would like to continue the discussion of this approach here in this RFC.
>>>>
>>>> 2. Background
>>>> ------------
>>>>
>>>> An hrtimer callback can run later than hrtimer next event, the expected expiry
>>>> time. This is a known behavior in the kernel. Hrtimer expiry only means that
>>>> the IRQ will be generated at the corresponding time. The callback still waits
>>>> for wakeup, resume, and the rest of the timer IRQ handling path. This can
>>>> delay its execution.
>>>>
>>>> When an hrtimer expires while a CPU is idle, the timer IRQ starts waking the
>>>> CPU. The hardware resumes first. The firmware resumes next. The kernel can
>>>> start running after that. We call the period start from receiving the IRQ to
>>>> the entry of kernel execution as idle exit latency. Different CPU
>>>> architectures and platforms have this kind of idle exit latency.
>>>>
>>>> The kernel currently uses a static idle exit latency from the device tree.
>>>> This value describes the worst case. It does not directly show the idle exit
>>>> latency under current conditions. A more accurate idle exit latency estimation
>>>> will cause less confusion and less power impact in real use cases. A similar
>>>> upstream discussion also points out that using a static worst-case value to
>>>> estimate typical latency can cause errors [2]:
>>>> [2]https://lore.kernel.org/all/44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com/
>>>>
>>>> Other related upstream discussions cover genpd CPU latency QoS [3]:
>>>> [3]https://lore.kernel.org/all/20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com/
>>>> and IRQ timing infrastructure removal [4]:
>>>> [4]https://lore.kernel.org/all/20251210082242.360936-2-maz@kernel.org/
>>>>
>>>> This RFC therefore discusses how to measure and predict idle exit latency in
>>>> the Kernel context, and how the prediction may be used for hrtimer handle
>>>> latency accommodation and other kernel Decisions needed to consider the idle
>>>> exit latency.
>>>>
>>>> 3. Runtime measurement and prediction
>>>> -------------------------------------
>>>>
>>>> Different than other interrupts, timer interrupts will have the info of
>>>> expected time to be triggered. So, We assume the hrtimer expire time and it’s
>>>> handle latency can be used for specific idle exit latency runtime measurement.
>>>> We identify the cpu idle level, different cpu, cluster idle level is the key
>>>> difference of the idle exit latency variation. This section describes how the
>>>> kernel collects runtime samples and gets a typical exit latency under current
>>>> conditions. The collection step records valid samples. Prediction uses a
>>>> sample window to make a dynamic estimate for each condition.
>>>>
>>>> 3.1 CPU sample collection
>>>> -------------------------
>>>>
>>>> When the CPU enters idle, record the CPU idle level it actually enters and the
>>>> current programmed hrtimer next event. The idle exit path records when the CPU
>>>> is awake and running again. This point is before any IRQ handler or hrtimer
>>>> handler.
>>>>
>>>> In this RFC, observed exit latency is defined as the time when the CPU is exit
>>>> from idle in kernel idle driver minus the programmed hrtimer expire time:
>>>>
>>>>      cpu idle exit time stamp - programmed hrtimer expired time
>>>>
>>>> Keep separate records for each CPU ID and idle level.
>>>>
>>>> There is much noise that will affect this period, for example other
>>>> unpredicted interrupt coming at the same time. We only take the measured and
>>>> expected time into consideration. A sample is valid only when all these
>>>> conditions are held:
>>>>
>>>>    - The target CPU entered the target idle level.
>>>>    - The target hrtimer has expired.
>>>>    - The target CPU had only the target timer IRQ pending.
>>>>
>>>> These conditions make sure that the recorded resume time belongs to the target
>>>> hrtimer, not to an early wakeup caused by another interrupt. Samples that fail
>>>> these conditions are marked invalid and excluded from exit latency statistics.
>>>>
>>>> 3.2 Cluster exit latency
>>>> ------------------------
>>>>
>>>> A single CPU chooses the CPU idle level, while multiple CPUs choose the
>>>> cluster idle level together. When the first CPU wakes, the resume process
>>>> includes the resume time for the whole cluster. We use the exit latency of the
>>>> first woken CPU as the cluster exit latency.
>>>>
>>>> The cluster case uses the same measurement method as the CPU case. The last
>>>> CPU that makes the cluster enter sleep records the cluster ID and cluster idle
>>>> level for this entry. At exit, the first CPU in the cluster resumes after
>>>> wakeup represents the sample.
>>>>
>>>> The validity conditions for a cluster sample are similar to those for a CPU
>>>> sample:
>>>>
>>>>    - The cluster entered the recorded idle level.
>>>>    - The target hrtimer has expired.
>>>>    - The target CPU had only the target timer IRQ pending.
>>>>    - Other CPUs in the cluster had no pending IRQ except timer IRQ.
>>>>
>>>> Mark samples that fail these conditions as invalid. Exclude them from cluster
>>>> exit latency statistics and prediction.
>>>>
>>>> 3.3 Why measure in the kernel
>>>> -----------------------------
>>>>
>>>> A user-space program can use a periodic timer to measure the time from hrtimer
>>>> next event until the thread runs again. This time does not accurately
>>>> represent CPU exit latency for these reasons:
>>>>
>>>>    - The time when the thread runs again includes scheduler and user-space path
>>>>      overhead. It cannot show the exact time when the CPU resumed after wakeup.
>>>>    - User space usually does not know which CPU idle level the CPU entered, or
>>>>      which cluster idle level the whole cluster entered.
>>>>    - User space cannot reliably tell whether the target hrtimer, an IPI, a
>>>>      device
>>>>      IRQ, or another pending interrupt woke the CPU.
>>>>    - To send test results back to the kernel in real time, user space would
>>>>      need
>>>>      an extra user-to-kernel interface. The results cannot then be sent
>>>>      directly and continuously to a running cpuidle governor, or used directly
>>>>      for hardware timer programming and compensation.
>>>>
>>>> 3.4 Prediction from historical samples
>>>> ---------------------------------------
>>>>
>>>> For current experiment, we use a simple way to do the prediction to the valid
>>>> history samples. The predictor keeps a separate fixed-length window of recent
>>>> samples for every CPU and idle level. It keeps another window for every
>>>> cluster and cluster idle level. The current prediction is the average of the
>>>> samples in the window.
>>>>
>>>> 4. Possible use cases
>>>> --------------------
>>>> The “more accurate” idle exit latency can be used in different areas. It can
>>>> replace the current static idle exit latency used in current kernel
>>>> components. And One another possible use is hrtimer compensation. We will take
>>>> this as a specific example.
>>>>
>>>> 4.1 hrtimer compensation
>>>> ------------------------
>>>>
>>>> Idle Exit latency is one important part of the delay before an hrtimer
>>>> callback. When cpu is about to go to idle, we can predict the possible current
>>>> idle exit latency and do compensate. the prediction can set the hardware
>>>> wakeup time before hrtimer next event. This can compensate for the delay
>>>> caused by idle exit latency.
>>>>
>>>> We call this early wakeup interrupt Rooster IRQ. Its lead time covers the time
>>>> needed for hardware and firmware to resume. Rooster IRQ fires before the
>>>> original hrtimer expiry time, so the CPU can resume close to the expected
>>>> time. It does not change the software hrtimer expiry time or run the hrtimer
>>>> callback early.
>>>>
>>>> Rooster IRQ only adds a new hardware timer used for wakeup. This can use The
>>>> cpu local arch timer and a global/broadcast timer. The rooster timer is set
>>>> before hrtimer next expire time.
>>>>
>>>> In the CPU case, use the prediction for the CPU and idle level to set that
>>>> CPU's Local timer. The local timer wakes the CPU early.
>>>>
>>>> In the cluster case, a platform may have several global timer frames. A
>>>> separate frame can be assigned to each cluster that needs an early wakeup. The
>>>> last CPU that makes the cluster enter sleep sets a rooster cluser timer. It
>>>> uses the prediction for the cluster idle level to set the rooster wakeup time.
>>>> The rooster cluster timer directly wakes the first CPU in the target cluster
>>>> that needs to resume.
>>>>
>>>> If the platform has only one global timer, or if the local timer stops at the
>>>> target idle level, a global/broadcast timer can wake an intermediate CPU
>>>> first. That CPU then sends the wakeup interrupt to the target CPU through an
>>>> IPI. The rooster timer lead time must cover the exit latency of the
>>>> intermediate CPU's cluster and the target CPU or cluster.
>>>>
>>>> 5. Prototype status and results
>>>> ------------------------------
>>>>
>>>> The measurement and prediction mechanism has been validated with real hardware
>>>> on Qualcomm's platform.
>>>>
>>>> The LPC slides show sample results over a period. The sampled exit latency
>>>> stays fairly stable during that period. A prediction based on recent sample
>>>> averages also follows changes in the samples reasonably well.
>>>>
>>>> On device, we enabled compensation with one global timer and broadcast. We
>>>> measured the difference between the actual CPU resume time and the expected
>>>> hrtimer expiry time. t1 is the time when the CPU resumes kernel execution. t0
>>>> is the original hrtimer expiry time. In the table, "Before compensation" is
>>>> the reference with the same definition. "After compensation" is the result
>>>> with this compensation path enabled. The unit is us:
>>>>
>>>>      Metric: mean absolute value of t1 - t0, us
>>>>      State               | CPU C4 | Cluster CL4 | Cluster CL5
>>>>      -------------------+--------+-------------+------------
>>>>      Before compensation | 19.824 | 61.991      | 1929.767
>>>>      After compensation  |  0.073 |  0.191      |   10.738
>>>>
>>>> 6. Discussion
>>>> -------------
>>>>
>>>> The prototype code is still being cleaned up. We would like to discuss the
>>>> design and get community feedback before we finalize the code. The feedback
>>>> will guide the next implementation direction.
>>>>
>>> So a few thoughts that are still in my head from the LPC talk:
>>>
>>> 1. Existing hardware mitigations.
>>> For example Intel accomplishes this with a hardware feature called
>>> C-state pre-wake, how will these co-exist?
>>>
>> C-state pre-wake and this RFC have similar goals. If their functions
>> fully overlap, we should see very low exit latency on the current
>> platform. In that case, we can fall back to sampling only, without
>> compensation.
>>
>>> 2. What about platforms without OS-coordinated cluster states?
>>> What about the platform influencing idle states more generally?
>>> (In particular with platform-coordinated cluster-off you should
>>> see two range of latencies, one which was true cluster-off and
>>> the other was unrealised cluster-off that is really just CPU off).
>>>
>> On Qualcomm platforms, we get accurate cluster-off information from the
>> cluster sleep driver. If firmware decides when the cluster enters sleep,
>> we need an interface to get this information.
>>
>>> 3. Does any workload actually care? What's the performance improvement?
>>> How does it affect power? Especially w.r.t existing latency constaints
>>>
>> Broadcast can be seen as a more aggressive form of compensation. It may
>> increase power consumption. But in theory, the global time frame
>> approach should not increase power consumption. We still need more data
>> for that.
>> We would also like to brainstorm specific use cases and benefits. Maybe
>> this can help performance and real-time workloads.
>>
>>> I have a bunch of methodological questions about the sampling, but
>>> presumably they would all be answered by the code.
>> We are cleaning up the code and will share it once it is ready. For now,
>> I can answer the questions below.
>>
>>> (Are we still sampling while the mitigation is applied? If so how is
>>> exit latency observed distinguished from prediction error? What if the
>>> first waking CPU is not the cluster-wake-initiating? What if the
>>> CPU wakes up too early because of the mitigation? (if this enters the
>>> idle loop again, this influences the governor massively of course).)
>>>
>> Sampling can stay enabled. We still know the real wake-up time of
>> rooster irq. The difference between when the CPU resumes execution and
>> that rooster irq time is still the exit latency.
>> We have seen this in our tests. It may be due to differences in the CPU
>> wake-up paths. One CPU may resume before the CPU that triggered the
>> cluster wake-up.In this case, the two CPUs resume at nearly the same
>> time. In the current design, we accept this sample if the other CPU has
>> no other pending IRQs.
>> When the prediction is correct, waking up too early is caused by
>> variations in exit latency. If the timer has not expired yet, the CPU
>> enters the idle loop again. This interval is usually very short, so the
>> CPU uses WFI to idle.
>>
>>> Also if "replace the current static idle exit latency" actually means
>>> for the QoS constaints too, then I think we shouldn't do this, it's
>>> deliberately a worst-case.
>> Yes, I think exit latency here does represent the worst case. However,
>> that worst-case value is often an estimate. If sampling keep enabled, we
>> could keep the highest observed value and use it for QoS. This might
>> give us a more accurate value.
>>
>>
> 
> 
> 1. Does the global/broadcast timer case also cover bc_hrtimer?
> With bc_hrtimer, the CPU hosting the timer is prevented from entering
> idle states that stop its local timer, which also keeps its cluster on.
> It only needs to exit shallow idle, so we shouldn't assume a full
> cluster-off exit latency for it. Does the lead-time calculation
> distinguish bc_hrtimer from a dedicated hardware broadcast timer (where
> the intermediate CPU itself may be in a deeper idle state)?
> 

By "global/broadcast timer case," that is the case where there is an
always-on global timer. Per my understanding, bc_hrtimer is similar to
normal hrtimer for during cpuidle. Because bc_hrtimer exists, the CPU
cannot enter a deep idle state. So the cluster cannot go to sleep, and
the compensation only applies to the CPU.

> 2. Regarding using the highest observed latency for QoS: a sampled
> maximum can still miss rare worst-case paths, especially when valid
> samples are restricted to timer-only wakeups. Also, timer compensation
> cannot help unpredictable device interrupts, which PM QoS needs to
> bound. Wouldn't it be safer to keep the static platform-provided
> worst-case latency for PM QoS, and only use the runtime estimate for
> timer compensation?
> 

Yes, you are right. The latency used for QoS should be the maximum time
that could happen. What we want is to make the max exit latency that
users write in the devicetree more trustworthy, by measuring the real
latency. So I have an idea. We could expose the maximum measured value
to users through sysfs. Then users can set the exit latency in the
devicetree based on the measured data and their hardware. At the same
time, PM QoS will still use the static exit latency.

> Thanks,
> Pengjie

