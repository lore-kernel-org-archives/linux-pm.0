Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350EE4779B3
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843528; cv=none; b=XL2nFapJwgNa7wnvPcabYtgAXA70LN5qnpr+CymA8Z+6NdeIKQmdCnNhEwuhlT6nRVW/xt2fWBIJnTe73c6cwDmJRhR3jsD5o3z2kHQYTboIAgkO8GpJxFqycxzdOriTPbfWEzEItb8AqcV0MHlq6/EfZi1mVTOzzR0LaMApUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843528; c=relaxed/simple;
	bh=PGYLOf4H2QMPbrBU+NXGsXdOedNRm1YfTmB95cYcsNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsClDNIu7gv7oeeUUp0a63nrgT4sZaHvhF0oNFmC1ctbxnuB2TohiVu2BHZq8qQ5DIASg+PWrx54ZuvWxV9Lfjg/yPktduPg8gw1kS/k1IPW6+ptwXqiSojO1SVgRQTONMXWR23zYzRbwBWZbVPx7hwlJWan0JOiuQacg7uq0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgE/jV7t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bGwT2TVT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgE/jV7t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGwT2TVT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5htLj3197820
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6u7L0Q9dnsKKK3HvrGHppxM7smIumAyVg/mpzy/UTJw=; b=cgE/jV7t8xMKnFVH
	YZkEnvtWnrlbERrnipBi40loNRNCzgU42CBGR/YE3+jUfwcqfus1M++99vnj2BYW
	rocamrHtTAmMpzAmf6ufWQ5xAcKFcvszWmtTMzfG9Yyhd/nzuPC/WgfU4Iu1qkhh
	pkwfqZgfxahzxbVur8CTMjloITWevR/9r//hC+V9Q7HvGlY/kmEmpHgRx+Qx6y+Y
	F1LsWLVIXXfTSxj/TWVZnzKM062ChV5ROaixzujS+O9j1PBC+8QQ/BnJu1plmNU8
	2WAr9F2r8E5fP8bsRcxeNIJvqWqjqGs2tBmlOzZpOJJPg0vrubRFY/aSYzYfzbl3
	oWq6eA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qayq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:12:06 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-63126f42441so636435137.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778843525; x=1779448325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6u7L0Q9dnsKKK3HvrGHppxM7smIumAyVg/mpzy/UTJw=;
        b=bGwT2TVTqA7Hm7dB/9pQuPjZ5RQYTRnmSaKt5Zy8OIwe5kiR/E1sm3A+CEBRGnDIXn
         jneyjvA4o03/smc00dkppMQ/Ip1j9cfphiJdtumnFOI/MuOllSg767vqJR3Dq8E7IDUH
         LJQA+u8qhrDFPOq9TsCYxrq6xWEdmjeS8+73CHYTT4FpiddACyAqR042rFrUIrAheTRB
         LMRgYAPcyRlBTZLJHqLrKTEHHP8cTIFeH3+Tj/Duy4i6pXIe5gsagBpAP7vWRkkY0Zrk
         PhoqYz17dkwKBc7NYyvKWuSOTdFN1FmYlDQ6624t09Ps7yASVRN/yRJc49hVdQpZptgx
         Akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843525; x=1779448325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u7L0Q9dnsKKK3HvrGHppxM7smIumAyVg/mpzy/UTJw=;
        b=q4R65MetZQmq8ok6beJsfILtP1nNMiRLkuuyHqqGbEUKinapgi2QzDSTQTkZFRj0+6
         HN6xfsvSc68/QGTflmKLzeZsO5Wl8rBRzpxTVCboO9Ubp1vAa89lY/i8fvrWlIXqXPhO
         qJhzBZxn/uvpZaqhVvtG9b0wTnCEJ1GqqkQNX9+Nye/9WU7hA2sRx9yvH5XyQK0FjHZ9
         tFzLY9RQlN65i3RwXDRpCjnoMYRTXj/ReT/VYrtlARMXNaJZe1KVw2fy8mQqMssJbBOj
         2e4fPG9lyEHZn5I70pw6DNVdO0suyRI14wlic2RTrpVAgTtN9jxc/v20v+HrGRyGkZB2
         rS1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+rbr9awtRVtKbiI9tqBt2aQ6iAgAc0XFnOkivsFPU07UH1uwO8XCg9MPZEaucnkH+YVDeNaqLNsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TnWX44M2hy2MLDYvvV154Tqx04JVIhUocbfqXduWTi7fsqFR
	PZ2tuzQkdo2ZTjXIOqMka1Y8v8NjGgt0obrpu/1nQ1uDwQbpHPsoG1J7Z+18r1CdZk6mHddXvof
	xTr93hnyuxhye+5kCKN6IjewPLSeKhqO78c5ksliztLiRGIiYdSeJS5bO3zlUGV0R5nwYtQ==
X-Gm-Gg: Acq92OF52tKHAEVybcTxIpOlP017JOHGbDIH/hLVre8NeHQSw1O/j+IW1N5wxdvv9Kd
	1mCaFdgU+QLTkZbv/Q8jwzgvphrqO/XQHNelZ5iuECgAn1X6A5/d1ai1OP/BWJYB2R1EFgMb/b9
	XlpXhmMayKhzRPyXaC8lWsC21eGd9+YeUGL3iIZxvH3YcKBKezBWt8xf+Pela5fb3N+zVU0XQG8
	NJgms/KLBn6bVsJyEsjFOw6rmIqIriTHwt3FUruRGPEGfWJVJgTuXl1mz9obvNPofSbvFVeY8wZ
	y0Hx5Y36OsJOeHcdWmQtbcxUTJJKRcZU81bA0yQl6MU5yy6A9ulyIiKCZtfsR+VhOQj9mJ7Tz/L
	h/8Cn3KaGSBQxKpgDrX8yB44DLJvKNnFIO8xPqoX+++GTFgOypyS2X7ZCXENmP27Yvu4R7ytnxe
	cfVjQ=
X-Received: by 2002:a05:6102:30ab:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-63a40dc920cmr389921137.8.1778843525580;
        Fri, 15 May 2026 04:12:05 -0700 (PDT)
X-Received: by 2002:a05:6102:30ab:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-63a40dc920cmr389918137.8.1778843525034;
        Fri, 15 May 2026 04:12:05 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eac613sm206295666b.56.2026.05.15.04.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 04:12:04 -0700 (PDT)
Message-ID: <62f6c5fd-c952-4bcf-9125-c5fe92fca1dc@oss.qualcomm.com>
Date: Fri, 15 May 2026 13:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Make important drivers default
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
 <20260428-interconnect-qcom-clean-arm64-v1-3-e6bc3f7832db@oss.qualcomm.com>
 <bb02291a-1579-4069-b6b1-757a0b5fb7e6@oss.qualcomm.com>
 <ca6c656c-07a1-466c-9c1f-a2efbf1498d0@oss.qualcomm.com>
 <02578386-a492-4342-95aa-9cfb00c8bacd@oss.qualcomm.com>
 <720715a0-eb4f-4083-a67f-aa380e130d6c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <720715a0-eb4f-4083-a67f-aa380e130d6c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BFCdbL1AN1z8o4YGw_j7Zn_Uguqb1uOX
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a06ff86 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=uUpgVYKiIJP92WW26QwA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExMyBTYWx0ZWRfX2vntaHE4tjdH
 6Am6GvRyEce91GXA3vEtDZx61xJchh05sDcRKBkCV5pTN+VcZNlHS/TwNVrlD+ETFBI5tsjgkxV
 eYMScvyd9ZOhv10CPAU1QsSs4Hg8e375pkSuzPwp8LhM20DoV5hG5y7MzlvSTOqWLahA3e86PIe
 f9VhfbTAZ/lmyp/PFTlTBMjYsaIOCrD0Ak2v6YyWJspZ9P4wkp7bfLaWYkBTtkrA+PgCtE0W2eV
 Q8vGl0v6EW9u5Z5mY7wOIXlmhmBW3aXtcrqbqMAi3NvJE48AQSFIoIs9wjb3nRAvHkpdz79rZgw
 xBf2HZ2BZxwaG4Wwq6ewFmDcgtZGH/4MsujW6ZuN0ijw/zA5kPxTdEviVQSG2hv59GDss057Wdv
 6SMGCfOUYMDd50mRwpZ1jVZZRyGVnzJVZn6aOz/lFWyOJhAnehlXXEgpy1QHk2OFddrO1CcL/91
 CZVlmIUDxUBr71vKm1w==
X-Proofpoint-ORIG-GUID: BFCdbL1AN1z8o4YGw_j7Zn_Uguqb1uOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150113

On 5/15/26 1:11 PM, Krzysztof Kozlowski wrote:
> On 15/05/2026 12:54, Konrad Dybcio wrote:
>> On 4/29/26 5:09 PM, Krzysztof Kozlowski wrote:
>>> On 29/04/2026 11:23, Konrad Dybcio wrote:
>>>> On 4/28/26 7:32 PM, Krzysztof Kozlowski wrote:
>>>>> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
>>>>> basic or fundamental SoC feature: bandwidth management between internal
>>>>> SoC blocks.  SoC can boot without these, but power management or
>>>>> performance will be affected.  These drivers do not represent any sort
>>>>> of buses visible to the board designers/configurators, thus they should
>>>>> be always enabled, regardless how SoC is used in the final board.
>>>>>
>>>>> Kernel configuration should not ask users choice of drivers when that
>>>>> choice is obvious and known to the developers that answer should be
>>>>> 'yes' or 'module'.
>>>>
>>>> I'd say let's make them all `default ARCH_QCOM` - all of these drivers
>>>> are required to boot (minus the OSM_L3 driver which is "only" highly
>>>> desired, so that your CPU's bus isn't heavily bottlenecked)
>>>
>>> So the few of them should not be a module? That's what you want to say?
>>
>> I'm saying that if you only want to shoot yourself in the foot and not
>> in the face, you can make them modules
>>
>> But the L3 driver is required to make the caches run at a reasonable
>> speed, so that they don't bottleneck the rest of the system's mem
>> bandwidth
> 
> okidoki, so I will mark all as default built-in as you said, including
> the OSM_L3, based on your explanation.

Thanks!

Konrad
