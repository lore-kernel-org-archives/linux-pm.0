Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792554723;
	b=bwMFkESZ+0SGrKp1llL1zi8bvR35MPHKf/8Bjd1GoCx3LlBP4vi11tNiPw8K2wGkVXRw
	 lhHCc+2XCxY00LKMU+SiZHtG6tNeOHqGLqjAsX7CpzvLrba+Ha/qNoS4Oxn74vEFlMzOh
	 FHsQ6dlOoDDINd4tZ/MCdMIs9uBJn1oreiCPjZjLR45rdswUkDhv5ruV3C1GZNBee9i+t
	 oXKz3294KjaEjYUOBAdu48whxUhN6ImFPY4XplxHfLyYVyuif13Nl8kFoFUptdTINHkN2
	 5V0+qfKAOUTDtVDjE39pRiGz+rIjwuojxPQ4vlhN4IhU7RX6pYh2bJwLPCLAQBRVw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554723;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XWcRL5WfETpO93Mf1pV3/64mx56PNp+/0K9J6XH1qEw=;
	b=zoCJslj3FTmHDM4KjFmHym8YaN+UiUFPbU77dwpHGVu4ozIW2UHXSFOEZGusqe3ELwtU
	 4+IpDGYdWXlgfMe3VO+PxefBho58PrHKo5DP4nZK7viV9ESsYNwrJiEteChLRovvZf8xq
	 LFV8/AFYfcou2xWL4W4f/57q0z/mRwH5duG2MBnnNCpi0jamkyStRJPKIvd5Q8CzDMn8X
	 alYrIELw0+W6pYetIsFGZ4BJwygVZLX9Ix0TkIbo4Fz99dmtBNmi4z4ivOwXkM2bcnke3
	 +QwObJqp9eU1C0TYeOqZJii5XWUWLm7f8H4Z83OcMSr1ESwwd2aiou+HVLBSE3aqyaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MCAOM5lu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PPYhSOTt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8C606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MCAOM5lu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PPYhSOTt
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2F3sh3256696
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XWcRL5WfETpO93Mf1pV3/64mx56PNp+/0K9J6XH1qEw=; b=MCAOM5luxgDUBpYs
	QmRjaTXk3ZHpV7QcGFVweF5YfEldqf+5XJghGOdK7cHfxUT8ybmGocPnp3aR1t+1
	+wYmL7GqRhNaSNEpxuuKlPpvqrfdGY8a1VRQTFreyPZYAPyNmG6yKQo/KRpCpQbs
	Ly/2HQJKXAsQqxurO29dKExLABmV5U05hKai/G4YPL9jVLjnI5qBlee14bgpCT2H
	lDKk9bx3sl8u1Zjmm3HrUZ5W2yEn3QlTIeVy/MGXMXWa0cDz/wZ47CXA4UOSKgqX
	ZoS7imw64WLA+vf/X0nS320nMyH1c6BPL+Z5mVnADcSJHBDrfZ5Vou9kZbnIO9QW
	eDYkig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1vf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:52:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso305596a91.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792554720; x=1793159520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XWcRL5WfETpO93Mf1pV3/64mx56PNp+/0K9J6XH1qEw=;
        b=PPYhSOTtCgI0U2VmmXmbSDKkINbs15hGaMpNzIQZ1rDdryLubBFcjdl+/0Y9F3ogs9
         DS1qP5ROxp+bndU88S7+P4oDXjgFV6xoPOxgeUpQA7t3rL6Grourr/Phgr0BWkcTpYMM
         prHSJ0Kq2x9ZPGLA2Cg+ugYvqFx+e+1nmVIdSvYCAOl9ZZy1sfZOarAW4Fqd7dtIT3AG
         kTykEcqAGnL67w7fObdkSOExVfcQYcK+B4QUFukMCzswCUIHDIoGsB65bHKMZ56mvVp2
         CKG51am6zFUIerTPzT3HS9OBu5JhHbseeYF0nApAXtemNw/o2XbpaDHTILnWFnmSTk2y
         1gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792554720; x=1793159520;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWcRL5WfETpO93Mf1pV3/64mx56PNp+/0K9J6XH1qEw=;
        b=mOrqUr93UwzTZ2FjIWzOvepC2kTfH7+N53JMQj+Bxu5C9spG4E9gfVnV/fJMgvSBym
         qHQc2PaGvBFp1r4fGAldy+fK0p8Oz7sR4ZCisNdBpXafrXR+fioMsMVo2SgxNt31NOKn
         ShyFiYM8E+m75thfgCtHvLvZ+izRrLjQb9wj24wAGBFr6YVBU19cJqjYRZ3XbZRLhqzm
         8c59HcTE+OcqReaIPaL342spx32q3t2eh4rIbVx9kAuXSA3En0VXDHy8KAdu7JUwzKJ5
         BiREPQT/RAEhStlwn+Mw/tXSHv88QL8bNc4j5MlO6Ip2omUYf4DqD7jN3v8w0GoP+Zww
         Cdwg==
X-Gm-Message-State: AFq9FYLoU3C0woXDTa18CaGN8di6tfWVDoCgS+I2o4rNIeQCLkya/SXm
	OcdEccYndjE+Ha4MBNHOAW73ojGYZ10daUupa/jouMPOthJco/JHiKzTVSGf5xZXAYmyI1+gXEP
	HQpMyuV1ws8fn6e9y1HbYWBBqqcp/FpRkjsocTM/OHRYu/P/s8lT1BmfUwONywA==
X-Gm-Gg: AYBFou12+KMPlPoDYodJ9YVha6ntg0tzno3FjXltYR9gUW+eqDTBFQxfVXgE/yKRdHJ
	WztXjWfRA2Bt272b55tdkjPHBt9FxAd3Yw7hjdRAHMd9TxW+jx7osiQ9aLoGV+ELuVYMphKlgY3
	97WHEULpYmtk73nwySbxZ7xrpfY0SKuxXDPxsK7K+MNFEwkwMR47vKlFmcppSe7HmSuhehxajrM
	jb1kgQ/oHSuu038OULO3Z9wJdSkMLx63KqQr0z6SpmfgZMiK+S596x4HJzk3CqTyEWgcbzXNvd4
	1UKPf7bXSRbb3OSd7flLe/ZRNMXzGESz/O/LfzGwWJr6dBgGPZq68Bn8mhW5//ohXUZp+YR0qcm
	jYhU4SAks98ngmoMKEWAam6zER/c=
X-Received: by 2002:a17:90b:580d:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ad86d1c9eamr768441a91.12.1792554720241;
        Tue, 20 Oct 2026 20:52:00 -0700 (PDT)
X-Received: by 2002:a17:90b:580d:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ad86d1c9eamr768421a91.12.1792554719624;
        Tue, 20 Oct 2026 20:51:59 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80303302sm2163347a91.11.2026.10.20.20.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:51:58 -0700 (PDT)
Message-ID: <428a0bae-adad-4cbf-b551-fa0f0ab4e694@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:51:55 +0800
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
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Aiqun Yu (Maria)" <aiqun.yu@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, trilok.soni@oss.qualcomm.com
References: <2a5dd3fd-a03f-4ffb-827c-2937bf664c75@oss.qualcomm.com>
 <81963d52-0d49-4fb5-b9c8-e1199999aeb4@arm.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <81963d52-0d49-4fb5-b9c8-e1199999aeb4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfX/j4mxfqV8xX7
 9Tc53tDprLIbKj3TChOfFoqg539Mc4G6SLTW2sSM/TOkpdbL4OM6xw2G725W6V5WFNbDzQ4R/a0
 wb0+CuB2wOXJ0/CRLf0qeVKdaNfcXeA=
X-Proofpoint-ORIG-GUID: ZQ9iLNn3ti2O1wZpEBA9kTUmVqs7EiMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfX8T4cHdP2mdWY
 4EXC6NvS9M2vgjfMa6cssZv6+tRbgG4WNUAqR+PS4+n/Ww9/UQcWmp7A+lnMKk+mDMwDyMy8I/Q
 LpPG8dCX4JIJYEW3GBK03Q7C7fMeupysP8NjZgOWkrdCQCA4P8Dg0R0iWronPqaNyMwVww1YBWc
 lnJ+80WXJGNf5XG0hob8spIl5nj8ILNg+emMxOg4XIF8oo/vcuD/nTgdbOIu0Cz21/OMsKhgCBJ
 RPGdshbc48l1R+c6lb57cFkgn4ekqAWs5Fy1deZ3qRhGQgItbCt/QRRmx73jY+Q049tL/JseNuJ
 PJl0VrfyW4Ld2yPSLWS5++o3u6lkvdHYVJfXp9AWuh1MX4ZgQX6ULF8x+4cDL7MmK79YBGMgd8V
 WfXwdSgWOtUgGaRs93ZUcKQ2NPa3icNjJi4NBiKJeVVqdf9WkG0QbS8y8rzU2/hBtQoHbKx2n+E
 2y96cryi9RvIa+7nr4Q==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad836e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=GjOelb_QCqdLy_U7j1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=UYjydHh6ynBBc6_pBLvz:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: ZQ9iLNn3ti2O1wZpEBA9kTUmVqs7EiMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210014

Hi Christian,

Thanks for your comments.

On 10/16/2026 9:32 PM, Christian Loehle wrote:
> On 10/16/26 11:41, Cong Zhang wrote:
>> Hi all,
>>
>> 1. Abstract
>> -----------
>>
>> This RFC proposes a way to measure and predict CPU idle exit latency at run
>> time in the kernel. It also discusses how to use the prediction to reduce the
>> delay between the expected hrtimer expiry time, called hrtimer rooster timer
>> solution.
>>
>> This idea was presented at the 2026 Linux Plumbers Conference [1]:
>> [1]https://lpc.events/event/20/contributions/2595/
>> We would like to continue the discussion of this approach here in this RFC.
>>
>> 2. Background
>> ------------
>>
>> An hrtimer callback can run later than hrtimer next event, the expected expiry
>> time. This is a known behavior in the kernel. Hrtimer expiry only means that
>> the IRQ will be generated at the corresponding time. The callback still waits
>> for wakeup, resume, and the rest of the timer IRQ handling path. This can
>> delay its execution.
>>
>> When an hrtimer expires while a CPU is idle, the timer IRQ starts waking the
>> CPU. The hardware resumes first. The firmware resumes next. The kernel can
>> start running after that. We call the period start from receiving the IRQ to
>> the entry of kernel execution as idle exit latency. Different CPU
>> architectures and platforms have this kind of idle exit latency.
>>
>> The kernel currently uses a static idle exit latency from the device tree.
>> This value describes the worst case. It does not directly show the idle exit
>> latency under current conditions. A more accurate idle exit latency estimation
>> will cause less confusion and less power impact in real use cases. A similar
>> upstream discussion also points out that using a static worst-case value to
>> estimate typical latency can cause errors [2]:
>> [2]https://lore.kernel.org/all/44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com/
>>
>> Other related upstream discussions cover genpd CPU latency QoS [3]:
>> [3]https://lore.kernel.org/all/20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com/
>> and IRQ timing infrastructure removal [4]:
>> [4]https://lore.kernel.org/all/20251210082242.360936-2-maz@kernel.org/
>>
>> This RFC therefore discusses how to measure and predict idle exit latency in
>> the Kernel context, and how the prediction may be used for hrtimer handle
>> latency accommodation and other kernel Decisions needed to consider the idle
>> exit latency.
>>
>> 3. Runtime measurement and prediction
>> -------------------------------------
>>
>> Different than other interrupts, timer interrupts will have the info of
>> expected time to be triggered. So, We assume the hrtimer expire time and it’s
>> handle latency can be used for specific idle exit latency runtime measurement.
>> We identify the cpu idle level, different cpu, cluster idle level is the key
>> difference of the idle exit latency variation. This section describes how the
>> kernel collects runtime samples and gets a typical exit latency under current
>> conditions. The collection step records valid samples. Prediction uses a
>> sample window to make a dynamic estimate for each condition.
>>
>> 3.1 CPU sample collection
>> -------------------------
>>
>> When the CPU enters idle, record the CPU idle level it actually enters and the
>> current programmed hrtimer next event. The idle exit path records when the CPU
>> is awake and running again. This point is before any IRQ handler or hrtimer
>> handler.
>>
>> In this RFC, observed exit latency is defined as the time when the CPU is exit
>> from idle in kernel idle driver minus the programmed hrtimer expire time:
>>
>>     cpu idle exit time stamp - programmed hrtimer expired time
>>
>> Keep separate records for each CPU ID and idle level.
>>
>> There is much noise that will affect this period, for example other
>> unpredicted interrupt coming at the same time. We only take the measured and
>> expected time into consideration. A sample is valid only when all these
>> conditions are held:
>>
>>   - The target CPU entered the target idle level.
>>   - The target hrtimer has expired.
>>   - The target CPU had only the target timer IRQ pending.
>>
>> These conditions make sure that the recorded resume time belongs to the target
>> hrtimer, not to an early wakeup caused by another interrupt. Samples that fail
>> these conditions are marked invalid and excluded from exit latency statistics.
>>
>> 3.2 Cluster exit latency
>> ------------------------
>>
>> A single CPU chooses the CPU idle level, while multiple CPUs choose the
>> cluster idle level together. When the first CPU wakes, the resume process
>> includes the resume time for the whole cluster. We use the exit latency of the
>> first woken CPU as the cluster exit latency.
>>
>> The cluster case uses the same measurement method as the CPU case. The last
>> CPU that makes the cluster enter sleep records the cluster ID and cluster idle
>> level for this entry. At exit, the first CPU in the cluster resumes after
>> wakeup represents the sample.
>>
>> The validity conditions for a cluster sample are similar to those for a CPU
>> sample:
>>
>>   - The cluster entered the recorded idle level.
>>   - The target hrtimer has expired.
>>   - The target CPU had only the target timer IRQ pending.
>>   - Other CPUs in the cluster had no pending IRQ except timer IRQ.
>>
>> Mark samples that fail these conditions as invalid. Exclude them from cluster
>> exit latency statistics and prediction.
>>
>> 3.3 Why measure in the kernel
>> -----------------------------
>>
>> A user-space program can use a periodic timer to measure the time from hrtimer
>> next event until the thread runs again. This time does not accurately
>> represent CPU exit latency for these reasons:
>>
>>   - The time when the thread runs again includes scheduler and user-space path
>>     overhead. It cannot show the exact time when the CPU resumed after wakeup.
>>   - User space usually does not know which CPU idle level the CPU entered, or
>>     which cluster idle level the whole cluster entered.
>>   - User space cannot reliably tell whether the target hrtimer, an IPI, a
>>     device
>>     IRQ, or another pending interrupt woke the CPU.
>>   - To send test results back to the kernel in real time, user space would
>>     need
>>     an extra user-to-kernel interface. The results cannot then be sent
>>     directly and continuously to a running cpuidle governor, or used directly
>>     for hardware timer programming and compensation.
>>
>> 3.4 Prediction from historical samples
>> ---------------------------------------
>>
>> For current experiment, we use a simple way to do the prediction to the valid
>> history samples. The predictor keeps a separate fixed-length window of recent
>> samples for every CPU and idle level. It keeps another window for every
>> cluster and cluster idle level. The current prediction is the average of the
>> samples in the window.
>>
>> 4. Possible use cases
>> --------------------
>> The “more accurate” idle exit latency can be used in different areas. It can
>> replace the current static idle exit latency used in current kernel
>> components. And One another possible use is hrtimer compensation. We will take
>> this as a specific example.
>>
>> 4.1 hrtimer compensation
>> ------------------------
>>
>> Idle Exit latency is one important part of the delay before an hrtimer
>> callback. When cpu is about to go to idle, we can predict the possible current
>> idle exit latency and do compensate. the prediction can set the hardware
>> wakeup time before hrtimer next event. This can compensate for the delay
>> caused by idle exit latency.
>>
>> We call this early wakeup interrupt Rooster IRQ. Its lead time covers the time
>> needed for hardware and firmware to resume. Rooster IRQ fires before the
>> original hrtimer expiry time, so the CPU can resume close to the expected
>> time. It does not change the software hrtimer expiry time or run the hrtimer
>> callback early.
>>
>> Rooster IRQ only adds a new hardware timer used for wakeup. This can use The
>> cpu local arch timer and a global/broadcast timer. The rooster timer is set
>> before hrtimer next expire time.
>>
>> In the CPU case, use the prediction for the CPU and idle level to set that
>> CPU's Local timer. The local timer wakes the CPU early.
>>
>> In the cluster case, a platform may have several global timer frames. A
>> separate frame can be assigned to each cluster that needs an early wakeup. The
>> last CPU that makes the cluster enter sleep sets a rooster cluser timer. It
>> uses the prediction for the cluster idle level to set the rooster wakeup time.
>> The rooster cluster timer directly wakes the first CPU in the target cluster
>> that needs to resume.
>>
>> If the platform has only one global timer, or if the local timer stops at the
>> target idle level, a global/broadcast timer can wake an intermediate CPU
>> first. That CPU then sends the wakeup interrupt to the target CPU through an
>> IPI. The rooster timer lead time must cover the exit latency of the
>> intermediate CPU's cluster and the target CPU or cluster.
>>
>> 5. Prototype status and results
>> ------------------------------
>>
>> The measurement and prediction mechanism has been validated with real hardware
>> on Qualcomm's platform.
>>
>> The LPC slides show sample results over a period. The sampled exit latency
>> stays fairly stable during that period. A prediction based on recent sample
>> averages also follows changes in the samples reasonably well.
>>
>> On device, we enabled compensation with one global timer and broadcast. We
>> measured the difference between the actual CPU resume time and the expected
>> hrtimer expiry time. t1 is the time when the CPU resumes kernel execution. t0
>> is the original hrtimer expiry time. In the table, "Before compensation" is
>> the reference with the same definition. "After compensation" is the result
>> with this compensation path enabled. The unit is us:
>>
>>     Metric: mean absolute value of t1 - t0, us
>>     State               | CPU C4 | Cluster CL4 | Cluster CL5
>>     -------------------+--------+-------------+------------
>>     Before compensation | 19.824 | 61.991      | 1929.767
>>     After compensation  |  0.073 |  0.191      |   10.738
>>
>> 6. Discussion
>> -------------
>>
>> The prototype code is still being cleaned up. We would like to discuss the
>> design and get community feedback before we finalize the code. The feedback
>> will guide the next implementation direction.
>>
> 
> So a few thoughts that are still in my head from the LPC talk:
> 
> 1. Existing hardware mitigations.
> For example Intel accomplishes this with a hardware feature called
> C-state pre-wake, how will these co-exist?
> 

C-state pre-wake and this RFC have similar goals. If their functions
fully overlap, we should see very low exit latency on the current
platform. In that case, we can fall back to sampling only, without
compensation.

> 2. What about platforms without OS-coordinated cluster states?
> What about the platform influencing idle states more generally?
> (In particular with platform-coordinated cluster-off you should
> see two range of latencies, one which was true cluster-off and
> the other was unrealised cluster-off that is really just CPU off).
> 

On Qualcomm platforms, we get accurate cluster-off information from the
cluster sleep driver. If firmware decides when the cluster enters sleep,
we need an interface to get this information.

> 3. Does any workload actually care? What's the performance improvement?
> How does it affect power? Especially w.r.t existing latency constaints
> 

Broadcast can be seen as a more aggressive form of compensation. It may
increase power consumption. But in theory, the global time frame
approach should not increase power consumption. We still need more data
for that.
We would also like to brainstorm specific use cases and benefits. Maybe
this can help performance and real-time workloads.

> I have a bunch of methodological questions about the sampling, but
> presumably they would all be answered by the code.

We are cleaning up the code and will share it once it is ready. For now,
I can answer the questions below.

> (Are we still sampling while the mitigation is applied? If so how is
> exit latency observed distinguished from prediction error? What if the
> first waking CPU is not the cluster-wake-initiating? What if the
> CPU wakes up too early because of the mitigation? (if this enters the
> idle loop again, this influences the governor massively of course).)
> 

Sampling can stay enabled. We still know the real wake-up time of
rooster irq. The difference between when the CPU resumes execution and
that rooster irq time is still the exit latency.
We have seen this in our tests. It may be due to differences in the CPU
wake-up paths. One CPU may resume before the CPU that triggered the
cluster wake-up.In this case, the two CPUs resume at nearly the same
time. In the current design, we accept this sample if the other CPU has
no other pending IRQs.
When the prediction is correct, waking up too early is caused by
variations in exit latency. If the timer has not expired yet, the CPU
enters the idle loop again. This interval is usually very short, so the
CPU uses WFI to idle.

> Also if "replace the current static idle exit latency" actually means
> for the QoS constaints too, then I think we shouldn't do this, it's
> deliberately a worst-case.

Yes, I think exit latency here does represent the worst case. However,
that worst-case value is often an estimate. If sampling keep enabled, we
could keep the highest observed value and use it for QoS. This might
give us a more accurate value.

