Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D738F94B
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658303; cv=none; b=Cgil2/y2Fyn+MHcn6MSy5Z/7PjaKczV3aUS/gO/yq8IPZRqNmN6+P2wPln3XPHjea/etdCfPxYzP0uKCfnqpeH7lWWIumJPpzNJF8QhBxA5CIYDTwAZyMJxTTFmZFAMH1VDMsjP4Xps4VBvnAQeBfuFelz//mw9dBOAM2za1Bdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658303; c=relaxed/simple;
	bh=8M9P5kIaX0HmvR3Io43DMecC3rd24By7HN4pu6TtHsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXrjvIE87DUSZTw+jbTLqgM4e1N5fAfk8lYwmJR6mQdpdBGCmtXV6/vnr0JqH00dSz37e59HWRZ2VmmaPyYfcxQqnPi13UyYTItmoKg14TNZujk7hLSp2foJfTlnYDi/HfHC+7MFCDV7ZFsFZ5GlKoQHZ9oG34Q9+tgjQQ+cFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fWzQs0o+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UVMaxhDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fWzQs0o+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UVMaxhDs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64mV2323708
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 10:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WEspyIBfDFsB4jbARkWsz/VRMnCzHVtUmEgLGvdZwQU=; b=fWzQs0o+EnYXNmQB
	DoRjAC7vsxIgywWt4L4emTRRTzZIm3RUoqJt7gKfgipeNPspNWn3lsInvCljkFc8
	C/nkQHkjPb/uL/8r1OsB3iA0XB9jK1lNreF4Mo559B4trR5iNCxHJ2ncQAmjHcAq
	biVLgKjF7koetPI9LIKNHDPKGczBg9a3N9JI5pbb63vsRAD/CTTSoTGrrqgXV4A7
	sE0a1tFe1mjc9jOJlGN8wD48yCahDd0AMNcW9ozATRt9GrGYlO5/8uaP7VTnYXCY
	7+HaiQPh1crVIuPNP/a255Cl4Hqb03Bx1JXwqwdg5D7N6OZjYbyI6Fae/IVty9GL
	r41nDw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qndk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 10:51:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81be6f05so2782832185a.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773658301; x=1774263101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEspyIBfDFsB4jbARkWsz/VRMnCzHVtUmEgLGvdZwQU=;
        b=UVMaxhDsXLtI4/2pQ2TdBENLwGH5+w2djg/Y+fVR3R/xAPaf26FSEtYGnZd8kqnD26
         S303Osyikd1gPigkDaIHdd+LI0GddJb3i5G4LaaRXYOUeH8ru1Bl+9wZ0zIJuCI2YV4b
         pbL16w+286QkLu5YHsBrAG7b2QK7a9YUqA+wSmeNMQYkwqO/1vVRufByZtNhSFRxEjJF
         cwLSTzCSLQ5xiOGRu1A9nVdkiUdzl6qVxiMtomjqGy0Bw8gcMQRJ9eNQyunBwMXSlMCh
         ZKq45TbUJcOtNAJuz6TcjdWFuXaQAiQjNgQCmqy2y7uWwTWNIERo9gqx1QPjbnuviSaB
         D+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658301; x=1774263101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEspyIBfDFsB4jbARkWsz/VRMnCzHVtUmEgLGvdZwQU=;
        b=Ej+PwvHryKGkZk41cPO5rP7O4bk+nLPt1oqa+vBlqNjFB41QJoNcAW4a5ajrYuvTDn
         ltY9wADMm4r+BbIbsM2jvHYoaAWy1V43B/4yfMYIN05KKvegppWQ0m7ha0qUTCIJkPCH
         s6wg6QstXHli8NT8d4ZOwaK2gN7Xg/XeJ9u3LmX4xEhXfKHB3pxwXljPMXNoMfHEzrdl
         lNKPGIe4IRJyYa5wfdzG6wTY2fq/5MfERs8kYeMutfy36KBTf92LV3aX6jhNtlxDcN14
         kD6Vy9gQsiPWXOEMIdhGzCfs7RizxeTPJ9T0ADs8XdDM6/VUHWAJdR200EDOfA0WPqHy
         MkUA==
X-Gm-Message-State: AOJu0Ywk1dU934xlI/QB7wu2OUfw+4gabOevYPIJeXUwof/uXPOjRJKr
	z0u0N0GqMi47chABz3Rg5FmwZ/86SCnONVZBzs/4pLyd1d756/rkOvd7cCAp4ydZVRJC6hTU5pJ
	7tMr1O6ttHl0ntSY60psjEaGWiLICB4lURXg3p5OLaMOwTkjDh1T7IeEQnHcttg==
X-Gm-Gg: ATEYQzy7TyQOXLcV3UEh23OX1rTERgCwNgOYfAgp5+N9LvPFrRd75JnvGJ1kgewHmL5
	v3O0F4KnwYbH6u3iKVt8Y7q7D/KtBRKMT85zuE0e/JqIKiv1JlQVzUzO8+gJ39FP5eqK5+fpgtz
	lidIgBSVZqN2YsAzhK1H+3FP5AkCObWYC7M2cyf6dDvaXVNb/SIVVDH/wyqeGwm2hyb1RIjrllD
	WnCNQ54jqGWOjiT23uXJ6EE4xYGjUrQKrodxDTMjKCeI1hE5sSYUrVM+slWFYP0Amcj1mVF7Mat
	XpUlmvRXMPxmwxlOpxVh5xuvpUuu+JydjBAQKRgJVkymBOVsIthWzBC+s0yyDWIVp3NdTSHYZXK
	7HWcXLVcLAO0TEnMvELPpmqtPCfcfrp2yyIb4zlN07hqMymo9RW3ill7yqz2EJHOxmeo748TAIx
	OJl+g+8pyq
X-Received: by 2002:a05:620a:7085:b0:8cd:78e3:879f with SMTP id af79cd13be357-8cdb5a9fce4mr1483321985a.35.1773658300630;
        Mon, 16 Mar 2026 03:51:40 -0700 (PDT)
X-Received: by 2002:a05:620a:7085:b0:8cd:78e3:879f with SMTP id af79cd13be357-8cdb5a9fce4mr1483320185a.35.1773658300170;
        Mon, 16 Mar 2026 03:51:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm441177245e9.15.2026.03.16.03.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:51:39 -0700 (PDT)
Message-ID: <00a7ea43-e527-47f3-bcd4-285b7ba37a2e@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
 <ba23f8c8-a842-4498-b52f-528baed62325@oss.qualcomm.com>
 <3d56b0db-7ece-48f7-ba59-fb1679aee804@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <3d56b0db-7ece-48f7-ba59-fb1679aee804@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CRrad5qTFnPTPqieDP8i0IqhHPDt-zoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MiBTYWx0ZWRfXx20OM9kxPGBm
 3hCbLNObs1SDyos86rteYlWQsT4YQU1KkNKZBlyq9tm7YkcT8AadO6+QfvxJQInKC1ZuR94Zhu2
 Dtc3aVV3+rz2AFd9TzoArSb6k2utM4gNovt05ylhyIk+QkbTTylaNBTB6H8HYaH3FvQ9epblYsJ
 4QjWMLqX+rlWs1aeCvAJboxsYcumTNAxziM9WoHbDQx8br72jyF7UHSotOqkvBmUVZS+8MYzxpO
 qnVeCOgyrMdROdlLcBQPnFFgVzMqnwewSzGKPnP7QnqVVGuIEPBmserBXnY2oMzu22FUJnh4y+h
 aA63qjMMSZMH48BHEx3xMcUYqAvNUhQkYZnRE6fCNcNDN+foZ0aR5ZN6a4A60h9TOfgbotXBlCg
 XBoYcgi6PgkAGXxgnKzFibVCyBc3nyHCdPrDYTzSMenHAJzUCWpepRN67OkDdIRAKl1leCnhykv
 583IcY4GKb/hDCaApwg==
X-Proofpoint-ORIG-GUID: CRrad5qTFnPTPqieDP8i0IqhHPDt-zoI
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7e0bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=J8AoiNgv1xfB8hOpzzcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160082

On 3/16/26 10:50, Christian Loehle wrote:

[ ... ]

>>> So we already do a per-CPU IPI need_resched() check in the idle
>>> path.
>> 
>> The need_resched() is not the same check. Here the interrupts are
>> off, the test check if there is a pending IPI before entering the
>> sleep routine which will in any case abort because of it. This
>> check saves the costs related to preparing entering the idle
>> state, the call to the firmware and the rollback. Those add an
>> overhead in terms of latency and energy for nothing. As stated in
>> the description, this ultimate check before going idle was
>> introduced also for the cluster idle state and showed a
>> significant improvement [1].
>> 
>> [1] https://lore.kernel.org/all/20251105095415.17269-1-
>> ulf.hansson@linaro.org/


> So I didn't mean this as "it's unnecessary", but it did make me
> question how big the "performance" impact of this really is, in
> particular for per-CPU idle states (i.e. at most sleep / powerdown
> for you?)

 From a per CPU perspective, it is hard to say. It really depends on the 
workload, the number of CPUs and the correctness of the governor prediction.

I would say the higher the number of CPUs, the higher the probability to 
receive an IPI, the lesser the accuracy of the governor [1] and the more 
visible the improvement of this change is.

Maulik did some benchmarking with glmark2 and showed an improvement.


> But if this is only about cluster states (The original
> patch wasn't really clear on that?) then one issue is that the non-
> pmdomain case (e.g. psci PC-mode) we don't actually know what a
> cluster is and therefore which CPUs to check for pending IPIs,
> right?

Ulf changes is for platforms, usually Snapdragon, where the kernel has a 
knowledge of the topology and uses the PSCI-OSI (IIRC). So the kernel is 
in charge of the last-man-standing for the group of CPUs belonging to 
the same cluster. It has all the needed information for this specific 
configuration.

In the case of the PSCI-PC, the firmware is in charge of the cluster 
idling and AFAICT it does a test for pending IRQ / IPI.

   -- Daniel


[1] IPI prediction is not possible because it fully depends on the 
scheduler, so on the behavior of the tasks.
