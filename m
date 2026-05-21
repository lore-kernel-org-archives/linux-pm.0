Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576A36CDF2
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353185; cv=none; b=IU+/Q0vwyIg2XyI0XeBVuNvxjcEAWaZAahbeTJR91TEWFWFSdrVMrMmesFYJ+q39+9sTn5VSQVJjxlLO/R2u1JkShVnhpSVKUi4MvrrkBvHY9QngyT6VLtUWBTiSgu+IBWh6XJSHoalHB0CXrzhS2bl4rz0XuNQ8MKDPv5UIn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353185; c=relaxed/simple;
	bh=qjlCjnHDgkFX4Bewdv0p/IUYKwUYhW4nEKsn3bhJzSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JizDPt/YM6PgzHk08krtdOLkoxr0fSoOfkLBO7wsht6P9M1YNf1N+Phrkz4N0MC0cJxZF7Er56G9VjXs5N1FcOij9G3EBmOdzGheB64RS2w6jdarEnOiAt2InlxQLYPeHSGAgGIKY3raFYf+XOH9L68O2pKD0ZUOwdPv7o8D578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qqqm80Cn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASWJpI9g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qqqm80Cn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASWJpI9g"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6nOis3680282
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3zRO05Qu7fKgLjkp/xMatp8T5yK89ojyhoiV7Fp5xE=; b=Qqqm80CnAHvQhbgs
	LEaZvG0T48ihTA8AwycDLJc6JXDsrF+qUhF7Bf8vYQMrLm6cf0YJJfonheHB7i3N
	osvwicbWuGTpgFkpWwX86Fg1uN5TPHiY5omW82PsXBg6e+QXh9EMDbk1mbSp0Zkm
	kYTZhHjRgTMq7n7xGXYFbswnQtshOSGINFfk0dWzOj7V+4J5iHPhKU8lmVJJd2aw
	bCxFA/linaCkSMt7BDXlMwITchi7UKwuUB5UyNg7pG2y+skCnY/tkaWIQvpTY37g
	i1i6YiQZE4mcLtFn0L2Er2lUSPdFessSqD0AT7gpC8c53ZrS2icPEq84bwtWh0RF
	ITr0YA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j42c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:46:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914aa01cc21so6133285a.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779353181; x=1779957981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3zRO05Qu7fKgLjkp/xMatp8T5yK89ojyhoiV7Fp5xE=;
        b=ASWJpI9gLjtEXWiFW61SVJo2vaFUoKk8nXkEJBXRnZaTStBTw3pgvQiefxZMBRp6Rm
         vdG+rm08Z6//Ssx3MV3gYC0NpNujjfM20H8JIFsTLPGu0ZCDlir9iASjuKv6HuKqusCR
         spalZRCDSb8Org4n/UatpxCw4cLXAif4SWpfCqbUR+J9kHs1ReNgthTCu2d588m5Wco+
         rV7PGW97qJuHUAKI0NnPDSZLMwhm41VDIgb4rwYdn3oLV9Pi9ZVBwpqGJcxgn4lXtePv
         hamAp0xz2zofr8qk2CJg3AmMcX1IE8bIEUsTZIyQBPUn2PWn3wPaI+aTqdi2IEWTEl/+
         Gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353181; x=1779957981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3zRO05Qu7fKgLjkp/xMatp8T5yK89ojyhoiV7Fp5xE=;
        b=fFjYmxVdrghcjdgGO7uq8iZ9bGTHqupFH/Tf0MV8d+Pdz9YAXVvp/Bb2LnWuzTeQ7X
         q0e1wwzUJdNToT5oEusq4rA26z51v4HMPNTQ350IataBNx9kjzd/CoJXKtVcc2DHVMTo
         2d5KDVX2ywKxMfYz7ghdQslenr7ACIBLuOfNKArQSe/K/n6QGc9eo2ArxV6p1zytDbPs
         4/9pCpLEJq8cLEIdtfk2Ikwe2uJTwBHm6F8+ggYvsRLjDKnrhMPTdb3URd4SQq/8qSaW
         vHA7e0jREv+O83ZMc+8NMIsKd+80ZqhFE3+oAf3mWl7UVCyEa505v8fsTv6ztPJO/IJT
         Dw1w==
X-Forwarded-Encrypted: i=1; AFNElJ8jsS1N0I68wP6Y+3Z7kCJNAiTBM720Gl8LQg3kjCXTpJSi8Cb7xhlwZyanWFBR0zEBzAE7zZl6eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/X5ZAGwjTQtRwfQ6hAbDQyolTX14vcpGcDs296/zPbyP1aSA
	kSS2r/j8nCWZiIXAfwFwAnWsP4vaAM4EcSWHoygV32im+g7wYmVN6Yf5yBpFFlghBoiaVLf1mRQ
	M00mI4jB6S3QoQQv6A441sknz0JRX/+9icEq0jQ5REPqV6nL6B5V2n+flvvFRzA==
X-Gm-Gg: Acq92OFVuxIBEFNKySMRpuJyVk7L063gZ6amWr1/LUZqzdRYnPv4uSRgZuJiGQJewjz
	A+TXf+WQXUeEtuqPIcJA9mRLL4S4/pJdRXHoRdszeJEORoTnQXemoEmTX7UFi9aHJBrtd1AODdL
	0jqC/n7Xy3ojv2HS0+vjEVc4TMlcPmdE/2QVPdE817tzPbIkZ3mEkOep3JOWQqARBqJtJw75YFs
	aI67UbmjrVpDZtGeTta3oKyMgAtTbIz+CvuSss0vqHQicQOLO4YJpQoCPooCtGoi5bih06y0bUi
	Tlvzss4l9P0PY+BMs7PEWg8RRWVQYB2Qo6NY06R360K+9snCBxfq6mbvSaLK1c62L/W6w/ZxOGx
	bGPENeyMAPKJ3rMN+XM7uFtSj3adA4ii9uZMzNPw6KdM4D9aS+BuikplKc0XvRpRywHNFFIz3nK
	gZdOM=
X-Received: by 2002:a05:620a:46a9:b0:911:295d:59a1 with SMTP id af79cd13be357-914a2e4093cmr149157385a.8.1779353181496;
        Thu, 21 May 2026 01:46:21 -0700 (PDT)
X-Received: by 2002:a05:620a:46a9:b0:911:295d:59a1 with SMTP id af79cd13be357-914a2e4093cmr149154985a.8.1779353180997;
        Thu, 21 May 2026 01:46:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm16770566b.37.2026.05.21.01.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 01:46:19 -0700 (PDT)
Message-ID: <6c595a5f-b979-4e8b-ae77-d28d24700588@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <20260518-add_dc_in_support-v1-1-31fbaa329879@oss.qualcomm.com>
 <fd58d6d7-26cf-4b11-82ad-05b4863b6dd1@kernel.org>
 <20260519082526.odmn5dqi2jftwnln@hu-kotarake-hyd.qualcomm.com>
 <20260519-first-wine-bulldog-a6a4c7@quoll>
 <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
 <86f76a81-832d-4ba5-81d5-38b46b7dc0a7@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <86f76a81-832d-4ba5-81d5-38b46b7dc0a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0ec65e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=0kYgwNXdR7ZRvaqu29MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: JVndtx5wUt13ZFIf1LXZkzYUQCLBe3nx
X-Proofpoint-ORIG-GUID: JVndtx5wUt13ZFIf1LXZkzYUQCLBe3nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NSBTYWx0ZWRfXwSPmASMus/SJ
 Qil0tjmBplkI/5slnnSXTfQk6EolgDAdOrVjtoXOAbHN2YVuTucBQ76fCqKHiAEHt0tml33uN2F
 kc6s1oQXuiA4DsWoa9zpY+8zKzqheD/XjGbHKIa9+tZJ0GfaSJXNCbzvxpjBjUSINKZh9ToJfYa
 A83UBw7XCayB8XxCvNYxalVH885ksF+52Fg7RT+cjfgPR5AyeOUrSeKoEGOxF4nTpebwfawhVWj
 jNl/TWw+EdLCtQq6bXfj8JkgLaEUPXVXwrjnSiY/k3+fiK5YVugjdDI7pNyh8KQrurNd6dBbpNm
 nmz17TfjjV8xl2bzN2Zs+fAC88w1CKx+eVzjbZvavoeflmEPHDbYrLPFomoe84UoecCN/qM1p9n
 Hke4QtKi1KVJ64ctJL99Oq7OsHYPd97Br3ukEPY9NXf7fYhbUX5GlX98WrZ2s5UWdgoeelJmBJ3
 ooioPmSEqAytHy9jNEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210085

On 5/21/26 9:20 AM, Krzysztof Kozlowski wrote:
> On 21/05/2026 09:13, Kamal Wadhwa wrote:
>> On Tue, May 19, 2026 at 12:35:13PM +0200, Krzysztof Kozlowski wrote:
>>> On Tue, May 19, 2026 at 01:55:26PM +0530, Rakesh Kota wrote:
>>>>
>>>>> And isn't lack of monitored battery property enough to indicate that?
>>>>
>>>> Regarding monitored-battery — its absence alone isn't sufficient. The
>>>> BATT_ID line on debug boards is pulled to ~10kΩ, which is used during
>>>> development phase where some battery properties are still present. The
>>>> same ~10kΩ value is also used on some genuinely battery-less production
>>>> platforms where no battery properties exist, making auto-detection
>>>> unreliable. Hence the need for an explicit DT property to identify
>>>> hardware platforms where no battery populated. 
>>>
>>> I don't understand this logic. So you claim you have debug boards which
>>> do not have battery, but define monitored-battery? Then these are wrong
>>> and fix them first.
>>
>> Actually our firmware treats the debug board as a "fake battery" rather then
>> a "no-battery" case.
>>
>> This is done to avoid triggering shutdown or trigger power/thermal related
>> mitigations to kick in from the HLOS (android) that is configured mainly for
>> battery-backed devices.
>>
>> Note that we can know if its a debug board, just by looking at the battery
>> ID resistance or the battery profile name in the power supply properties
>> for `qcom-battmgr-bat` in sysfs.
>>
>> However, the problem started with the boards that are battery-less and
>> unfortunetely used the same debug board batt ID resistance value, so from
>> the firmware side the batteryless board is also seen same as a board with
>> debug-board connected.

Bumping up my other reply, are there other markers that could interpreted,
perhaps design_capacity = 0?

Or are those values reported based on hardcoded data which is chosen
through the batt_id values you mentioned?

>> Since firmware does not have a way to dynamically tell if it on a
>> debug-board powered device or a DCIN powered device, We are required to
>> add this new DT property.
> 
> Neither debug-board powered device nor battery-less will have
> monitored-battery, thus again, why lack of that property cannot tell you
> what you need?

A device with a battery will not have a monitored-battery either

Konrad
