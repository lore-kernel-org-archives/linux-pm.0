Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002669;
	b=KI0oLp5UUhxx9MOQlz+lhObbPNlzLF36YLpNmgYjK+sVrgBfPrPiXMBU+6oX8sQPe6NC
	 Pqt4FhsMYKlLokHN2edMm/64oimV35b4K9zM87tnM+nYrGuxTw7sW8M3OGz8+lrsE5/9p
	 oEgOlSGbXkxqLy5/uhFdT2coswWohMkZi18U1ND+Uq72XM6b9Ft6Ml98n8ogpoM9dvskg
	 w3llSYS8lkPZoFpPsn3olChzLPJB5YM1Mhk5C86s7CWS1qsscjB3w54XlcVTYHD1RSmO5
	 7wo/yl5iDJtvNpjLcR+mo5dMBAbFJFI5cxKQyHqmrsiTM/YtqAAL/KnppWUeN+invVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002669;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=l2p6fNkATmo2ls7kVb2fBs7L9vIQ1LAsllBq/z0sxkU=;
	b=BvrGPkEne8NrIGc7Z9t2GsQkOP4ylEOlSjKicLpDyjiaIKcBFKCzW3A1sR+L5Ubf2vpY
	 UVbgsuFXkvco+EYALk1bYx7b5BoB5dCqs5mL5fT038LKcCXX07EEiXcqmpf2L6bJiygru
	 BP1jUh15l94JmGxXyi2frIJgMpZ08Pu9edF1vGculjjke86Z1Md6YeNgT6vXdWT2SFuTZ
	 KG1G2uMk5ouphFw1DKiP8Hne6RCATn2kW9SKIbq+LDNdmHBsSMoNa/0NFop/fvumzzgOM
	 mhiGzvhRoEkwb3+Ol2AttDHvWleslV25JJywEuALQHhLsWExYEPLFxgznMA0VjaEI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fbn2FEl5;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D0606A31A;
	Mon, 26 Oct 2026 08:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fbn2FEl5
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l2p6fNkATmo2ls7kVb2fBs7L9vIQ1LAsllBq/z0sxkU=;
	b=Fbn2FEl5c7nVpKedK9t4QHRc5MLrOeirMv500xy0+bh1jf6LY1V3ieV41xwX5gOSFyCqn4bdM
	ZaA+02Lyd9e7KRKpZAN02IxAjgwTmFVqHAXyhcn6OeV0f7xfDdhbw6l2/77ZkQd+bHvFvPFdfst
	rUzyudSEeIB5GDiDWVXFJkM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jCmh94RWTzLlYk;
	Mon, 26 Oct 2026 16:17:29 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id C2A7140586;
	Mon, 26 Oct 2026 16:17:34 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 16:17:34 +0800
Message-ID: <0b481bb1-edcd-4ce4-8e6b-915c4e2e3e6d@huawei.com>
Date: Mon, 26 Oct 2026 16:17:33 +0800
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
To: Cong Zhang <cong.zhang@oss.qualcomm.com>, Christian Loehle
	<christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Aiqun Yu
 (Maria)" <aiqun.yu@oss.qualcomm.com>, <kernel@oss.qualcomm.com>,
	<trilok.soni@oss.qualcomm.com>
References: <2a5dd3fd-a03f-4ffb-827c-2937bf664c75@oss.qualcomm.com>
 <81963d52-0d49-4fb5-b9c8-e1199999aeb4@arm.com>
 <428a0bae-adad-4cbf-b551-fa0f0ab4e694@oss.qualcomm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <428a0bae-adad-4cbf-b551-fa0f0ab4e694@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi Cong,

Two comments:

On 10/21/2026 11:51 AM, Cong Zhang wrote:
> Hi Christian,
>
> Thanks for your comments.
>
> On 10/16/2026 9:32 PM, Christian Loehle wrote:
>> On 10/16/26 11:41, Cong Zhang wrote:
>>> Hi all,
>>>
>>> 1. Abstract
>>> -----------
>>>
>>> This RFC proposes a way to measure and predict CPU idle exit latency at run
>>> time in the kernel. It also discusses how to use the prediction to reduce the
>>> delay between the expected hrtimer expiry time, called hrtimer rooster timer
>>> solution.
>>>
>>> This idea was presented at the 2026 Linux Plumbers Conference [1]:
>>> [1]https://lpc.events/event/20/contributions/2595/
>>> We would like to continue the discussion of this approach here in this RFC.
>>>
>>> 2. Background
>>> ------------
>>>
>>> An hrtimer callback can run later than hrtimer next event, the expected expiry
>>> time. This is a known behavior in the kernel. Hrtimer expiry only means that
>>> the IRQ will be generated at the corresponding time. The callback still waits
>>> for wakeup, resume, and the rest of the timer IRQ handling path. This can
>>> delay its execution.
>>>
>>> When an hrtimer expires while a CPU is idle, the timer IRQ starts waking the
>>> CPU. The hardware resumes first. The firmware resumes next. The kernel can
>>> start running after that. We call the period start from receiving the IRQ to
>>> the entry of kernel execution as idle exit latency. Different CPU
>>> architectures and platforms have this kind of idle exit latency.
>>>
>>> The kernel currently uses a static idle exit latency from the device tree.
>>> This value describes the worst case. It does not directly show the idle exit
>>> latency under current conditions. A more accurate idle exit latency estimation
>>> will cause less confusion and less power impact in real use cases. A similar
>>> upstream discussion also points out that using a static worst-case value to
>>> estimate typical latency can cause errors [2]:
>>> [2]https://lore.kernel.org/all/44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com/
>>>
>>> Other related upstream discussions cover genpd CPU latency QoS [3]:
>>> [3]https://lore.kernel.org/all/20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com/
>>> and IRQ timing infrastructure removal [4]:
>>> [4]https://lore.kernel.org/all/20251210082242.360936-2-maz@kernel.org/
>>>
>>> This RFC therefore discusses how to measure and predict idle exit latency in
>>> the Kernel context, and how the prediction may be used for hrtimer handle
>>> latency accommodation and other kernel Decisions needed to consider the idle
>>> exit latency.
>>>
>>> 3. Runtime measurement and prediction
>>> -------------------------------------
>>>
>>> Different than other interrupts, timer interrupts will have the info of
>>> expected time to be triggered. So, We assume the hrtimer expire time and it’s
>>> handle latency can be used for specific idle exit latency runtime measurement.
>>> We identify the cpu idle level, different cpu, cluster idle level is the key
>>> difference of the idle exit latency variation. This section describes how the
>>> kernel collects runtime samples and gets a typical exit latency under current
>>> conditions. The collection step records valid samples. Prediction uses a
>>> sample window to make a dynamic estimate for each condition.
>>>
>>> 3.1 CPU sample collection
>>> -------------------------
>>>
>>> When the CPU enters idle, record the CPU idle level it actually enters and the
>>> current programmed hrtimer next event. The idle exit path records when the CPU
>>> is awake and running again. This point is before any IRQ handler or hrtimer
>>> handler.
>>>
>>> In this RFC, observed exit latency is defined as the time when the CPU is exit
>>> from idle in kernel idle driver minus the programmed hrtimer expire time:
>>>
>>>      cpu idle exit time stamp - programmed hrtimer expired time
>>>
>>> Keep separate records for each CPU ID and idle level.
>>>
>>> There is much noise that will affect this period, for example other
>>> unpredicted interrupt coming at the same time. We only take the measured and
>>> expected time into consideration. A sample is valid only when all these
>>> conditions are held:
>>>
>>>    - The target CPU entered the target idle level.
>>>    - The target hrtimer has expired.
>>>    - The target CPU had only the target timer IRQ pending.
>>>
>>> These conditions make sure that the recorded resume time belongs to the target
>>> hrtimer, not to an early wakeup caused by another interrupt. Samples that fail
>>> these conditions are marked invalid and excluded from exit latency statistics.
>>>
>>> 3.2 Cluster exit latency
>>> ------------------------
>>>
>>> A single CPU chooses the CPU idle level, while multiple CPUs choose the
>>> cluster idle level together. When the first CPU wakes, the resume process
>>> includes the resume time for the whole cluster. We use the exit latency of the
>>> first woken CPU as the cluster exit latency.
>>>
>>> The cluster case uses the same measurement method as the CPU case. The last
>>> CPU that makes the cluster enter sleep records the cluster ID and cluster idle
>>> level for this entry. At exit, the first CPU in the cluster resumes after
>>> wakeup represents the sample.
>>>
>>> The validity conditions for a cluster sample are similar to those for a CPU
>>> sample:
>>>
>>>    - The cluster entered the recorded idle level.
>>>    - The target hrtimer has expired.
>>>    - The target CPU had only the target timer IRQ pending.
>>>    - Other CPUs in the cluster had no pending IRQ except timer IRQ.
>>>
>>> Mark samples that fail these conditions as invalid. Exclude them from cluster
>>> exit latency statistics and prediction.
>>>
>>> 3.3 Why measure in the kernel
>>> -----------------------------
>>>
>>> A user-space program can use a periodic timer to measure the time from hrtimer
>>> next event until the thread runs again. This time does not accurately
>>> represent CPU exit latency for these reasons:
>>>
>>>    - The time when the thread runs again includes scheduler and user-space path
>>>      overhead. It cannot show the exact time when the CPU resumed after wakeup.
>>>    - User space usually does not know which CPU idle level the CPU entered, or
>>>      which cluster idle level the whole cluster entered.
>>>    - User space cannot reliably tell whether the target hrtimer, an IPI, a
>>>      device
>>>      IRQ, or another pending interrupt woke the CPU.
>>>    - To send test results back to the kernel in real time, user space would
>>>      need
>>>      an extra user-to-kernel interface. The results cannot then be sent
>>>      directly and continuously to a running cpuidle governor, or used directly
>>>      for hardware timer programming and compensation.
>>>
>>> 3.4 Prediction from historical samples
>>> ---------------------------------------
>>>
>>> For current experiment, we use a simple way to do the prediction to the valid
>>> history samples. The predictor keeps a separate fixed-length window of recent
>>> samples for every CPU and idle level. It keeps another window for every
>>> cluster and cluster idle level. The current prediction is the average of the
>>> samples in the window.
>>>
>>> 4. Possible use cases
>>> --------------------
>>> The “more accurate” idle exit latency can be used in different areas. It can
>>> replace the current static idle exit latency used in current kernel
>>> components. And One another possible use is hrtimer compensation. We will take
>>> this as a specific example.
>>>
>>> 4.1 hrtimer compensation
>>> ------------------------
>>>
>>> Idle Exit latency is one important part of the delay before an hrtimer
>>> callback. When cpu is about to go to idle, we can predict the possible current
>>> idle exit latency and do compensate. the prediction can set the hardware
>>> wakeup time before hrtimer next event. This can compensate for the delay
>>> caused by idle exit latency.
>>>
>>> We call this early wakeup interrupt Rooster IRQ. Its lead time covers the time
>>> needed for hardware and firmware to resume. Rooster IRQ fires before the
>>> original hrtimer expiry time, so the CPU can resume close to the expected
>>> time. It does not change the software hrtimer expiry time or run the hrtimer
>>> callback early.
>>>
>>> Rooster IRQ only adds a new hardware timer used for wakeup. This can use The
>>> cpu local arch timer and a global/broadcast timer. The rooster timer is set
>>> before hrtimer next expire time.
>>>
>>> In the CPU case, use the prediction for the CPU and idle level to set that
>>> CPU's Local timer. The local timer wakes the CPU early.
>>>
>>> In the cluster case, a platform may have several global timer frames. A
>>> separate frame can be assigned to each cluster that needs an early wakeup. The
>>> last CPU that makes the cluster enter sleep sets a rooster cluser timer. It
>>> uses the prediction for the cluster idle level to set the rooster wakeup time.
>>> The rooster cluster timer directly wakes the first CPU in the target cluster
>>> that needs to resume.
>>>
>>> If the platform has only one global timer, or if the local timer stops at the
>>> target idle level, a global/broadcast timer can wake an intermediate CPU
>>> first. That CPU then sends the wakeup interrupt to the target CPU through an
>>> IPI. The rooster timer lead time must cover the exit latency of the
>>> intermediate CPU's cluster and the target CPU or cluster.
>>>
>>> 5. Prototype status and results
>>> ------------------------------
>>>
>>> The measurement and prediction mechanism has been validated with real hardware
>>> on Qualcomm's platform.
>>>
>>> The LPC slides show sample results over a period. The sampled exit latency
>>> stays fairly stable during that period. A prediction based on recent sample
>>> averages also follows changes in the samples reasonably well.
>>>
>>> On device, we enabled compensation with one global timer and broadcast. We
>>> measured the difference between the actual CPU resume time and the expected
>>> hrtimer expiry time. t1 is the time when the CPU resumes kernel execution. t0
>>> is the original hrtimer expiry time. In the table, "Before compensation" is
>>> the reference with the same definition. "After compensation" is the result
>>> with this compensation path enabled. The unit is us:
>>>
>>>      Metric: mean absolute value of t1 - t0, us
>>>      State               | CPU C4 | Cluster CL4 | Cluster CL5
>>>      -------------------+--------+-------------+------------
>>>      Before compensation | 19.824 | 61.991      | 1929.767
>>>      After compensation  |  0.073 |  0.191      |   10.738
>>>
>>> 6. Discussion
>>> -------------
>>>
>>> The prototype code is still being cleaned up. We would like to discuss the
>>> design and get community feedback before we finalize the code. The feedback
>>> will guide the next implementation direction.
>>>
>> So a few thoughts that are still in my head from the LPC talk:
>>
>> 1. Existing hardware mitigations.
>> For example Intel accomplishes this with a hardware feature called
>> C-state pre-wake, how will these co-exist?
>>
> C-state pre-wake and this RFC have similar goals. If their functions
> fully overlap, we should see very low exit latency on the current
> platform. In that case, we can fall back to sampling only, without
> compensation.
>
>> 2. What about platforms without OS-coordinated cluster states?
>> What about the platform influencing idle states more generally?
>> (In particular with platform-coordinated cluster-off you should
>> see two range of latencies, one which was true cluster-off and
>> the other was unrealised cluster-off that is really just CPU off).
>>
> On Qualcomm platforms, we get accurate cluster-off information from the
> cluster sleep driver. If firmware decides when the cluster enters sleep,
> we need an interface to get this information.
>
>> 3. Does any workload actually care? What's the performance improvement?
>> How does it affect power? Especially w.r.t existing latency constaints
>>
> Broadcast can be seen as a more aggressive form of compensation. It may
> increase power consumption. But in theory, the global time frame
> approach should not increase power consumption. We still need more data
> for that.
> We would also like to brainstorm specific use cases and benefits. Maybe
> this can help performance and real-time workloads.
>
>> I have a bunch of methodological questions about the sampling, but
>> presumably they would all be answered by the code.
> We are cleaning up the code and will share it once it is ready. For now,
> I can answer the questions below.
>
>> (Are we still sampling while the mitigation is applied? If so how is
>> exit latency observed distinguished from prediction error? What if the
>> first waking CPU is not the cluster-wake-initiating? What if the
>> CPU wakes up too early because of the mitigation? (if this enters the
>> idle loop again, this influences the governor massively of course).)
>>
> Sampling can stay enabled. We still know the real wake-up time of
> rooster irq. The difference between when the CPU resumes execution and
> that rooster irq time is still the exit latency.
> We have seen this in our tests. It may be due to differences in the CPU
> wake-up paths. One CPU may resume before the CPU that triggered the
> cluster wake-up.In this case, the two CPUs resume at nearly the same
> time. In the current design, we accept this sample if the other CPU has
> no other pending IRQs.
> When the prediction is correct, waking up too early is caused by
> variations in exit latency. If the timer has not expired yet, the CPU
> enters the idle loop again. This interval is usually very short, so the
> CPU uses WFI to idle.
>
>> Also if "replace the current static idle exit latency" actually means
>> for the QoS constaints too, then I think we shouldn't do this, it's
>> deliberately a worst-case.
> Yes, I think exit latency here does represent the worst case. However,
> that worst-case value is often an estimate. If sampling keep enabled, we
> could keep the highest observed value and use it for QoS. This might
> give us a more accurate value.
>
>


1. Does the global/broadcast timer case also cover bc_hrtimer?
With bc_hrtimer, the CPU hosting the timer is prevented from entering
idle states that stop its local timer, which also keeps its cluster on.
It only needs to exit shallow idle, so we shouldn't assume a full
cluster-off exit latency for it. Does the lead-time calculation
distinguish bc_hrtimer from a dedicated hardware broadcast timer (where
the intermediate CPU itself may be in a deeper idle state)?

2. Regarding using the highest observed latency for QoS: a sampled
maximum can still miss rare worst-case paths, especially when valid
samples are restricted to timer-only wakeups. Also, timer compensation
cannot help unpredictable device interrupts, which PM QoS needs to
bound. Wouldn't it be safer to keep the static platform-provided
worst-case latency for PM QoS, and only use the runtime estimate for
timer compensation?

Thanks,
Pengjie
