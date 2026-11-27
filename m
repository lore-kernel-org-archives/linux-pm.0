Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771545;
	b=XqnaBiiVx1+q3IB9kNnOmjVmFj0EEOf++oMc299Ohm0/5mkdKZPsrThGwDfmP3NliS63
	 5/hKnnuX1ntlgyTsqyLiJgSRvHrgMvea7GdkC/BwPDiRC+XYeTh4sXeJcu+admQMuCAHQ
	 yRKsBRsVdmrOYtl6rwzD4InpOtucftFuFhmWrVJf8UBRkkBKL+ykID+oFqn+bpxQGV6i4
	 QkvSHA14T6wfoeU72wIbmcix7FQzMBlsWtCpzthq6leSvRcJsFruAfAs+hqeyeXivgG3y
	 aPFR9AyamZGKl96FAI08QguDEDPGFpQ0tVMbn1THjtK3Rmz/ucKZ8gg4dt/R/ypT9vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eb4ShHDEcPbwytF60hBjX+kNmkhn+q3+ARBxWD8KeAU=;
	b=phKUINGrzVRDiB21XyClLnZsl3kWFR2RSkaw9pQHnBM38VOWvEcUjFYl02Tkd2en2QpN
	 39RC+ztKyBy66Z78MIKmIgJh6I65U9CAL4pKCsN9SRMK2J9im1oaYypkJABq8kklurTXh
	 i4YnP7M6EWBvHfHzT9obGzfv/bHsHx1WAogC9pIRKhnbORp7b54rjgrTdQE/4ceT0dxVR
	 XYN8avn+4Gxyf2VV8iddE/Bf2c6ONkZ/3tU2HBarwKGIa0qSBiRglDY2Cr/SOPa6gsXem
	 RyVnh6CbzErSRiKhgoTpt5hf7YVL0hjuq3gKhkdikaPZGR/Je40XTlh3AOn6Yi2hGSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2but8Ei;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DxsuwBRF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54994606A334
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54994606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2but8Ei;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DxsuwBRF
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GRbk1779933
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eb4ShHDEcPbwytF60hBjX+kNmkhn+q3+ARBxWD8KeAU=; b=M2but8EitmsaKmKM
	+Y6azno8QMbXmA6Y4o8zl2+htv6TKv052mk4OQCuoLNQF3f+wtrVjVq2asliwX+f
	3paB/VgAvJI0WpTCgciK5DY+g8pet67rsdIjI+VrnzSwhvs/rHWI2RRNmmpomG1p
	WKa0yKWekFKKGTPxwXwJKiXI9EVqMibpYv7oTRvxLaQS91heijKg4F4WZh63AeMG
	RtPSEtxqzdnR6xkmER68PA2H1YSHzK+erJiwU+df2k7YsetculdeWcubcI6EL9Ak
	LmzO68FQJiGufI4U7v+PgyQpZvoZ5L4fHjUItk3cg58HvtiCqFxJmQVVN24baHjh
	fcIydQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhgvv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:25:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so1309081985a.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795771542; x=1796376342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eb4ShHDEcPbwytF60hBjX+kNmkhn+q3+ARBxWD8KeAU=;
        b=DxsuwBRFgj4c8F5SkG62XhnLRUgrPGLTEB5pYVxU5rl8+Y5gS1YqkVyiDUMAbXB5VD
         VciAHMhMTAxAxql/JuMtQS3cQlHLiaUF7CpEnvVuesxPMdyhPpppXL3yMz1XcO1s6BxY
         qPyXfvjSTijDoXVsl7UJTJsUeRug8DzF5zgGHxBsdheBCXbyVEjy/ZpxP2HjlKOewkit
         +ZlFaDEaVIAtWN+t3Uls89FIsrocrnZW122DxiV5DJg/Cru+8SrdOBoIDma3GAfT+02Y
         oZdcZ1icXB1ve7XuFW6PyWGYnN5jv7AtpJTnoHPfy0XQ5Wg/Rj7WZNGQ4kCxte3G1pDF
         MWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795771542; x=1796376342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eb4ShHDEcPbwytF60hBjX+kNmkhn+q3+ARBxWD8KeAU=;
        b=sEYUcAmesSLyH79odalmWzp8fC/7hVfcUO0zsk4VqGDKsbGhdV7VmmY4Czo55V2Tuo
         BH0WIV9yKckn9lizVdn5F0X2ZzXnm5tNohyChQ/ziq/oyZgT7H04ZRPvD7FZgs/JKFMd
         0uGAYRQ0kdz0x2/UNwjFxRKs4XFOTvKaHBvFvjz+lahi01CYk1tPB44BviSnAoCwCoMb
         vt9cB8nhaMlBGM3pT7NkxTCPlMsBPOGFnOgPgqe3yQIo8V/YfwboIwttSF1KQ/UoEZoM
         qQPCZPFnDmmg34NXr0scGFw++dmgrizISi2+ESv9rEAmUKn8bVNCabC60c9f540hl3FD
         A1KQ==
X-Forwarded-Encrypted: i=1; AL+hErFcVBJPFC6+lncN7/j1hQPu0+q+0ZEe3FUAT4FdcKwUWhEouKZm8Aa48BC4KDPPBtLYeGs+JMiXZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Qf1s7NR28dYfVWVPNhJyhaApj/MGA4rzGsOBvnz8iFOGkj/4m
	XehEoyzjsz867TFTlJmWVHgvbKDYV1D+Vi6pisisnbhU3zwhsnHavTziE710mME0IOGMMjFMgc9
	gc2KKhdULAXI9143T6ocnRLjLSxTzv6CHm603fDkoOvA95+Ce7fEDV3gnIrte/w==
X-Gm-Gg: AZFdTZcgOPRpGc/XHa1pNtajv0dcUHPHqi1GNg46CGelsfUuFzbONoBird1VBouh1cj
	tJfVs0yQwx/mL4HTbuf0cjoim14a6VKJz1iYX15W50K1j/3XB9rV5UQTgWCuVvmXXKaJY40OH90
	zF1LSO6Qnn9H3tEX2Duqx1xVbuiw3eohMcSglZnG//Yy4yzLhqgOi2UQhFGYEx15Ruyh8195pk2
	lGEolsdDVgiTI648BcqfypeErCVsoChTaTf2eJGvre15ddC0wf+cVPL1jyMjNsRrowuErPg7sut
	iPbyTFiPULQPqlHbaHaGo877uGCsNyMM2npF81duwtuDpBy4BrG05Lm5AvHM7KqSidpC9er4M56
	igbsVmV5cpuB0SO8yQuv66eA6c58HTsdZxy4r+OBaD1xZIb9ZDsXZLCYGWLtcMgkCYaTdJRIIMm
	fBFWANyUYa5y/Fa2IlsOmHnTeVBWe4maUrhco=
X-Received: by 2002:a05:620a:1313:b0:949:7b51:2dc1 with SMTP id af79cd13be357-949ba80f404mr4061295685a.2.1795771542169;
        Fri, 27 Nov 2026 01:25:42 -0800 (PST)
X-Received: by 2002:a05:620a:1313:b0:949:7b51:2dc1 with SMTP id af79cd13be357-949ba80f404mr4061290885a.2.1795771541667;
        Fri, 27 Nov 2026 01:25:41 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:32e6:6e2f:3645:b017? ([2a05:6e02:1041:c10:32e6:6e2f:3645:b017])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm896902375e9.0.2026.11.27.01.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:25:40 -0800 (PST)
Message-ID: <8d6f9b42-a7cb-4403-9718-e7752324b048@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 10:25:39 +0100
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
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: thermal-zones: add
 hardware-binning trip properties
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
 <20261113-thermal_bin-v3-1-878df6eef8bc@oss.qualcomm.com>
 <20261118205056.GA839455-robh@kernel.org>
 <eb44a4e1-fa9e-466d-9e97-f87f365ce44f@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <eb44a4e1-fa9e-466d-9e97-f87f365ce44f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfXy7WokUZHWbc9
 CWlWrqGja5rWPOMpxQu9wB3x4Sa6AW1bPY6iWCfvp2mYFpQvyfi7ODsPgHKwIt9dbC5N1aYc31q
 iIJ+vdmPD3D9Ra/BdBbx3TOOz+qGBS8=
X-Proofpoint-ORIG-GUID: h_JEmg4eIQAEMM5BDFUvUYhQgxXccbjj
X-Proofpoint-GUID: h_JEmg4eIQAEMM5BDFUvUYhQgxXccbjj
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b094c97 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=7tqQl3XV2vr3itYC2nIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfXyoMP83l8phI7
 xssP3Ik+zsifZsmUbcG5ds09yRL9SV70J0dxVaDiBwtwi+eoE4YL532nZmZAv2aAPd1tHIAJGTg
 9xFam5TzNSnh29/OqsODnr0HCViCVW8Wx6To1JzBrxsL7XbSavdujVxD5de1XIzL20JtsHfzWzV
 pBz5UtxgdBldZpl7gGKXqnocLHxGPzzT7XGeekIfpI2Ab22X2sU8mMZ3xrwtVYv/cWTAmAtRSXh
 6fBSqRMir15MCVhkbxY+4XOoqGduXJp3+6w275NtJK00IMcWkyv0jBknxYnzT4RJSqr9suuXFS4
 KJQvDnkHvKIMPJAf2PiY2duEFfqeJQRxXlxLCMikw13rlJugjhOTvqLdnyRXdkK9bkSb0l8+9PL
 HdjejRJixkpUzr7aG11KlL9udvWYy0tWFLsoq7UUkj8ViT2C/bnibw0IVMkDCCOLvrimYM7MBTL
 vJWfLXLOmMBPNpaXb3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270037

On 11/20/26 07:47, Gaurav Kohli wrote:
> 
> 
> On 11/19/2026 2:20 AM, Rob Herring wrote:
>> On Fri, Nov 13, 2026 at 02:13:44PM +0530, Gaurav Kohli wrote:
>>> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>>
>>> Differences in SoC packaging can be used to provide multiple SoC SKUs at
>>> different thermal and performance characteristics. The underlying SoC
>>> remains the same except for how much heat the packaging can dissipate,
>>> thereby influencing the critical trip point at which an SoC SKU needs to
>>> be throttled. This SKU-specific data is typically burned into fuses
>>> during manufacturing and can be read back at runtime.
>>>
>>> Add two optional trip-point properties to describe this:
>>>
>>>    - 'temperature-bin': an array of per-bin trip temperatures, used
>>>      instead of 'temperature' when the trip depends on the hardware
>>>      revision encoded in fuses.
>>>
>>>    - 'thermal-hw-bin': one or more bitmask groups describing the 
>>> hardware
>>>      revisions for which a trip point is valid, modeled on the
>>>      'opp-supported-hw' property of the OPP framework.
>>>
>>> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>> ---
>>>   .../devicetree/bindings/thermal/thermal-zones.yaml | 60 +++++++++++ 
>>> ++++++++++-
>>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal- 
>>> zones.yaml b/Documentation/devicetree/bindings/thermal/thermal- 
>>> zones.yaml
>>> index 999ad40a20d5..cb9a8c96d053 100644
>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>> @@ -152,6 +152,58 @@ patternProperties:
>>>                   situation where the trip gets constantly triggered 
>>> soon after
>>>                   cooling action is removed.
>>> +            temperature-bin:
>>
>> Use the standard unit suffix.
> 
> Sorry, my previous reply was sent only to linux-arm-msm by mistake. 
> Resending to the full list.
> 
> Thanks Rob for the review.
> 
> Would temperature-bin-millicelsius work for the unit-suffixed name?

+1 that's the suffix used in the other documentations

> I’ll also add minItems: 2 and maxItems: 32 in the next revision.
> 
>>
>>> +              $ref: /schemas/types.yaml#/definitions/int32-array
>>> +              items:
>>> +                minimum: -273000
>>> +                maximum: 200000
>>
>> minItems: 2
>> maxItems: 32 ?
> 

