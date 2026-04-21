Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4F3BED02
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783942; cv=none; b=km5fh72GbjlzseqKJ7rFccfk6y1qlBbO2xo77N05u3DS7fnXLtgknYRqdxdNnKU3vFxNTqjHDOj7GuaXyF/lhJ3czTw5ynLApAG9Ep+CTNaPcRFMxnK9Ni8B8jQs2NWRbzQetOJ6neraDgbfN5m1pMCx/PUfvpeHRTgzPB4K/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783942; c=relaxed/simple;
	bh=BQStWNShpXYEQHETMevO6TYUnvhOafEYp/7hTNdu/1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FawzjjGWiMaltsOEQyWXzvNaOSuCCyDAkPr/+2zry7eFeqMV0d+suSrRNcsm2zRui79u1DUSap4WzOB1j4/ASbkESDlkcdk0g+EbOjPz1q1hDxy8nvVncDYsx7GjJMr+GquQOOhNkZEKTM73Q0OO0P9JKQu8w7f9+cnusxP85gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zg9tMN8G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZIMjl/0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zg9tMN8G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZIMjl/0s"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LDSJLX1538415
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 15:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7cJXZKQwUzW4kTymW48cOsdbLrsWiaiTZoJagvzo/I=; b=Zg9tMN8GVu61N1Q3
	9FN9688CVODEqF65/yFFDM/+LLlYKlpAYbIicIScLCQveyi0Yd3bsJKcCF98v+YY
	bTTeBlq/xIjz9UmeBzqYltk0irZmkQc/dSeanpZy3/08y+FXiGw5sfk0ft1kMAu4
	+CkWkg1pz2hi5e+G2YYO6HvIR7SPUn0DzeJpVEbq2TnukkQZFo83tN7FZkmviihS
	9aZlaaJ84tsF/3Hfvcyo0LvrRhd1fP8E/bQE66SSo/CGiwIZ4SlFt1igzo+Lsg30
	+fLqNvIaM49Zt8fRlViHofuuKHQoC3YFl3gzbYIWr8QAB96v+fGB0KuwaYa5J9gn
	PhJIZg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp4hahs4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 15:05:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479d4674399so1540478b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776783939; x=1777388739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7cJXZKQwUzW4kTymW48cOsdbLrsWiaiTZoJagvzo/I=;
        b=ZIMjl/0sQFzeN2OnRcYN5C72uirJCP65E17NTtczBj4hYFcq2QqQbhsSocvhp3j+/B
         tip/ZZb4YZOl8HhaD/VAL1DFfeY+XlWssYyQzlLyA9rU67jEVAIQRww3zY7Pxm8tSvf3
         ChU9rS3ty/8sw2+l8Tj8S15ZiSxHSnSiBOH82BXiZcaNmx9IfIGMdnT9Sa34V7LHZ5Sh
         eH1P0RSiVzWin6kd46fmEJPVmB7aQHMhW3TAB3Nm5k3sLzBad7W1jvyIBuZXqLJaX3qJ
         9y3ZRPk1ugkEX7bjQm16Rul72Pn4D1woVzPzT0lrEl24PaipcqCM5UYNDdq6lJnCizzr
         L07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776783939; x=1777388739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7cJXZKQwUzW4kTymW48cOsdbLrsWiaiTZoJagvzo/I=;
        b=P3D96Cld9GkpY/OCXOMkT7/8Gx2kP2AwWZ8KehjanbHtTKXmR1D/7n1DDdGllq6Abi
         j2Ob0s4u/1ttdFelRV6+5nCRO/Mm2ATJ1PdIHulq9u/HprZEi2Hiz7Vx5bEBmTdJxQHd
         ZRxDqzn6f+jfPYqqyV+fzpRKUx1SdxHxM9L3ynH4Ga0ILefT9ing6DPzEfzPk7hbvbsi
         EhUI/F5o8LolMaT6p8f+yBM9Xl2ye3sz1K5OCfU2XSSq4bT2IM4tM85alGuzJV9R8lqP
         r8cAap/6IYQItBahTWaSghL8dOPaKfsaIc6NHvGfBEXmJco7+8r94IS9Gu5fp7fQKAmC
         pHEg==
X-Forwarded-Encrypted: i=1; AFNElJ+osjpXQdVTQzZX9mdw1dRe4PzSER3v6gu2DGBcYfUsygmW4CLeLFb5llbB0W/mabwZhF8SAGt8Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/noLhswYssfwP0k/CucnMhzqVBcnj0+Vg3dyDCGTiixC3srs
	Z+S40y33Th/RwMvbgSbURJhjdyQzWgY2AIVXSfKFU1HNJMTTELM48XlEzTjCuTupAe4RkYpHrZ2
	Tp7fp6+1hgUSa3iCz4RHsn2iLDoN2Uv6IevackDtts0cSAVAwsuW3jp5k/SMwig==
X-Gm-Gg: AeBDiesh38vZ70Z9n0LTUIzfBOQnh+aiT1N90dUGeSiVMdABM4GRrckLjZIxSANToWp
	/IoLjLHjhbqlDC3R4S/gzXw9LKDcfMUEn9l4amSSo7JtjjlfJ7H0NrpQ4b1Lc4KAwLp7dM/YQji
	RNvF6zcqxWyeTKhrWxPXh9QG0/d9z0yGAt4zznKUX/n/8IbuIyfJ1sKlATLi554TkhtHfab5GqA
	D62Trn6o7PL33R+Ba6CwqAdb9cLuYPwBFEgkl1mN4yUMibATaEldaJVfa9oQxyVVz9e4EUoLAFf
	bscmTYnaVzZfUmqnhsmcBHH0upQ5XCmlZJM2duN1xmhEE73thm8S/nJ5yhsIziR06ex1v5POhL9
	yILaVTq5TBxfBs/Sr7G6Yc7YPrg83D2HEM8238nw8DWJsl9WSNDqyfl8RQv9dGyRgCCdF/epB+u
	68IqcudrpmdRiVaAqqi78=
X-Received: by 2002:a05:6808:4f21:b0:472:cd4c:c39d with SMTP id 5614622812f47-4799c8e6498mr9838559b6e.13.1776783938910;
        Tue, 21 Apr 2026 08:05:38 -0700 (PDT)
X-Received: by 2002:a05:6808:4f21:b0:472:cd4c:c39d with SMTP id 5614622812f47-4799c8e6498mr9838480b6e.13.1776783938191;
        Tue, 21 Apr 2026 08:05:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm188512225e9.3.2026.04.21.08.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 08:05:37 -0700 (PDT)
Message-ID: <c431d61b-58c9-4d78-965d-be3c1aaf067b@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 17:05:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        amit.kucheria@oss.qualcomm.com
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOQm5v+Z c=1 sm=1 tr=0 ts=69e79243 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=AkVpxfCIfmJFk-uek8wA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: BuwX7j_DN3RzkBI8qvSpmQMHTD_MTFtz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MCBTYWx0ZWRfXwgocdWV7Nmp8
 hxP1+6OhTC7MVEFw+EN0z6Uu4yBPD2Ga57VrmqPH+aOgpyIXZ27EjrQy4nuH3H6130DWQZnqD6D
 pvaprHS3nlnMz/7VmP6YJ6bzULmydKB+NCpLFgwD+Bt2Y2sG4IbV+YWaGhvIKbBeUpVGQcYZ+Bf
 vhYnFgTG0oVRjO1rTbaop4DZ8lEM1hdF3oAOP25+U6Kceb6BHYY1bfJ/0VHW9PbGFd8/zpjoNzl
 Uvk7LyN4SfJOE2WBWcsLt89qTUqjHOQiy2Ggtv1Rof9tBxnGuCYmk3tTfJhc1uLOqzR6aGNc8KG
 ZlZNbar6H32UQ9UNNXNhbvTobR11I2YOxvTzg5b83qwzmegoZ5zZ1p+LwFD+7oBoR+R8gmFo8VC
 0Ar8T041EZdndIk6iJ/Tg0Fva32+NvYVTueTyXZsD0Kct5tQ2IDz9QNMstp3nkL0O33zoykZNnX
 i2dEeFmsDg+GacKW/sg==
X-Proofpoint-ORIG-GUID: BuwX7j_DN3RzkBI8qvSpmQMHTD_MTFtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210150


Hi Rafael,

On 3/26/26 15:35, Rafael J. Wysocki wrote:
> Hi All,
> 
> I'm looking for topic suggestions to be included in the power
> management and thermal control micro-conference submission for
> LPC2026.  The deadline for submitting LPC u-conf proposals is April
> 23, so if there are any topics you'd like to be covered, please let me
> know within the next 2 weeks.
Here are a list of topics to be discussed:

  * User Resource Manager: An userspace daemon designed to group the 
logic for thermal, performance and power, use case based. Who is using it?

  * Suspend / Resume: Some SoCs, automotive and IoT, have a complex 
architecture with multiple dedicated micro-controllers and an 
application processor running Linux. This one is in charge of 
coordinating the co-processors power cycle at suspend time. What are the 
constraints and the limitations of the actual suspend/resume?

  * Suspend / Resume: The PSCI specification for the SYSTEM_SUSPEND 
command says it is up to the firmware to implement its own suspend 
routine. Depending on the firmware, the SoC may lose the context or not. 
The kernel is not aware of that, so the devices context is always saved 
in the kernel suspend path

  * Thermal : the thermal framework is nicely designed but there are 
some places where the events handling is fuzzy: trip points update when 
the temperature dropped in the hysteresis area after the notification, 
thermal zones disabled at suspend time, ...

  * DTPM / Thermal : DT bindings and testing is challenging. We need to 
create fake devices for testing with compatible strings, overlays and 
then drop them because they are not welcome in the DT world. I propose 
to switch to fwnode, compatible with the existing DT bindings. More 
flexible and compatible with software nodes to create fake devices for 
self-testing

  * Thermal : A power cooling device connected to powercap (WIP). The 
Intelligent Power Allocator will then use the power values returned by 
DTPM / Powercap

  * The powercap framework describes, in a hierarchical way, the power 
consumption, or the energy consumed of the different devices. The 
userspace can set power constraints but the features are limited: no 
notification, no power zone priority, no temporary constraints, no peaks 
allowed, etc ... Let's give some use cases and explain the limitations.

  * May be some related to power supply and current limitation
