Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157281;
	b=kPA9DqZwhvwg+AQpvd52cQmr16nR4M1BZPpMDdfv8a0dxVgzAIw5uYZ6sC/erreEQBL0
	 njeBbN+YzVp7/pi6R+xpzp5HbRSUbMx/fXXH09r3UDQrBfUFzHsz+M+U09TrU80+HYqBq
	 sdg+J9Jq69B3lJ8owGnFafBU0tHXynRIfGHKhT8Fc+eKh02z7lyTpIrkIzRZKaQlpr1x7
	 8FKr7sFEzQYPfbRtYAcpeBe0eJxL0Cro4l2cOAQytZCAfBDWLW5y/0q6K5UDgB42Mhkwd
	 ihZrBgTjMinCGovWRtM213MCjFav3uYaYiARlkodBogIEQFXtbVQm2PAKDX5/s/izGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y5IdSOiR1ak5akmhkE6pI8RojC6EEhOJLCG9nz5PurU=;
	b=aFEKrj+9gMRcqHijsqZHC/VODCUpam5xeeBQz7QS1CGDhhf6TiZ7+Ga1k/Eb/FX6BEmY
	 RddWACFdNyPlk1cDUpAC9SIrWYHrtLkutO71udOB5I2lRlCS9i11KxyhqR8AgqkC+Qc+i
	 aHtZGatL/V46EUhpDacE6X33C2yzTI1V1PG3fX/ln90FXUuwryEbebbIDcCS58xWj0gnk
	 eXFa7TdD5QTy5VfdBzcxEboC2+TNOSjc1X2S8xj0mgbNNjSOAWl42DgLsR/APi0lk0eSM
	 wahyHYMx5DVWGa4egFFoojmD6GLZQ4dlQYQ762FLsEUqLxip/GX3MkUstRr/gb95Tqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkI4QR6u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="UoL7P99/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DF606A339
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494DF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkI4QR6u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UoL7P99/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3VEVt2143499
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5IdSOiR1ak5akmhkE6pI8RojC6EEhOJLCG9nz5PurU=; b=hkI4QR6ucta5eWG1
	nyjdT1vUjsi3zvTTbwhohx6zH3N8uS7jrj1zPoY9ZP+PiTbUTqkHLSZ4KEMtSal/
	R4fcnQ8nz4z3aaQirfBCv9WObKJw3847lOJVxS8bm5p6Bj5jrQluFvmyVDxNvahF
	wRP3KVEhK6a9+xbLOdhyrXIXeJVhCd6fGhz75pkHLhwMiPtGxabtmCC3mACSej+n
	EwtePSZAQXWkWTKCXRhdTvT2iNMnnA7EjaLdUn1hXqcsYmDj18kjvFAQnlV/nw+v
	2Gfjcm1vvOX1uPdcpGe7Kwf1ILb3uM5eroHPBXjmtkFSJ63R8NFHJsrOH85dPJHT
	RfBX7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au2a7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:47:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed05b3eaecso5637475ad.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795157278; x=1795762078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5IdSOiR1ak5akmhkE6pI8RojC6EEhOJLCG9nz5PurU=;
        b=UoL7P99/nP8ae97HuQdP+qRNbqfxhH+rHwpJxRIn07lLNpUim+kbrE9SCySebAuZue
         7gWiDCCrvbIYpwITMTn3K0XPBkbcjrACh+9iJsQztZMK+sVE/hDiXJpkY5p3KDUqJXrD
         eGLKjRkQbYa/ZWStHRYc6CW0mKgE/HuhXxLc7ZOLdgiHivc4RbiVlRjOKO3VyPzRp4gR
         7tjtK0354Ek6QaDsVqhUKTxcwZsBKaOc21DLfn/KeqAQN+6Pws+bTI8sMbrIrQuldDEk
         Y2KnmD2BgR9kUXemi5T7dHdHFxp/yRzdZ2Y39CDSVu020BWHFhYePzTLWX8IBhGxbfsh
         Z0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157278; x=1795762078;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5IdSOiR1ak5akmhkE6pI8RojC6EEhOJLCG9nz5PurU=;
        b=hD+GNKcW9tuKw1VRZJlxsbNnlcrKtIwUlTLgWbawRps1vSR3ldslY7sb5KTJeI3K23
         pi7HO7Q9HV9Y0JDfZYrp3cweS0XNpA/KjzxPjT4+IGZ93em5i3zespoXpEoYWzfS3Rzd
         k+mxPJcm2AtlOg0/FpCpr64EyyNSX+k9DQc5gEDNPUmFSU3TDFswkKpoJrl8VzITCJMw
         ruZ9bOE/OuWub6qe2sF5V3KhMKlYVshoGFtJ1XfBviWa4uKHOyc9gWT+jaYQ78DCon3D
         u2oBXX7Educ+TN92EUbguiVD4aB1VHtVo7hN90Tbf0+Pn5deeeIkidP5L17NzKQCww8g
         l6IA==
X-Forwarded-Encrypted: i=1; AL+hErHX3icVypwAS79A53QX0rlNRcALbbOO5gQh3GC3swYFg/SgNRQsJbxH4DQcg+N/bT53mqKeOy00Ng==@vger.kernel.org
X-Gm-Message-State: APuU4Z89FuhtkNMc9cSLf4+r8ubLebbIbM2ZlNj+thKrm0Aag9lRvSZ6
	tHU5fIJMEWDsIYo05sa2LWDcrxSPlEP591VbrlJ058t0I6ZC5F33RTxyaLqtHVf1EqgsHpnLEDf
	koIKCqz68IJbclzFI3TtaBl3STAAnjRGHjrZWAFNLQ3S7axLpdZsechlztSN2BQ==
X-Gm-Gg: AZFdTZcm6u5IRUXjVZmyBjd4y+6XO85rXEw31TFG88pNbOxiW7ga+E9eROUqPu66j5G
	mIDhLqO3wRvheb2aBuxR+EI7rr1N0vARhVz3IcIsVD/vrl99c/KnHxAXytfu50w4dXct5CPLnmw
	+OjJnW20BDsjiHxkAgbmgEHVFYQRngxymsK0r/S1xuJMpaOqXPn3xu+SwnwzhpuOAer49OoaG1N
	4kr7rrtbkuUa9DsQgcIg+kwP4tj0j+D7+0IdcjVOixsYlbGK5tVRZbwZE0eHuafbCGRz0I709dC
	u4EHNIrAtdGFMUZzuPt8bm83ht52nFQCzgHXBfK6hpp7uLj2Lpxspz/3BI4NwapoP94SxG5JKe0
	W19xKySBNvYjIuZmaScLRoevq0QLIgPXfYelWm1r5RkaqABFGijnD78UFmbHxVP3UfRHtG7Z2Dj
	Y+aR5H
X-Received: by 2002:a17:902:fc4b:b0:2e9:4b65:369f with SMTP id d9443c01a7336-2f03f1ba464mr20069615ad.34.1795157277837;
        Thu, 19 Nov 2026 22:47:57 -0800 (PST)
X-Received: by 2002:a17:902:fc4b:b0:2e9:4b65:369f with SMTP id d9443c01a7336-2f03f1ba464mr20069505ad.34.1795157277401;
        Thu, 19 Nov 2026 22:47:57 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm9781855ad.57.2026.11.19.22.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 22:47:57 -0800 (PST)
Message-ID: <eb44a4e1-fa9e-466d-9e97-f87f365ce44f@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 12:17:49 +0530
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
To: Rob Herring <robh@kernel.org>
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
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20261118205056.GA839455-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyNiBTYWx0ZWRfX9diGAyTFe0yJ
 3sfhwnI351U18+mmm89HqqBzyHtIvoSw3z/MhoFc5XXigesTUgiY1dV0MMuw2a8YOBMKkoo6OUL
 HjBEtB5adfKYQQae0Mp1D4D83W0+Kcn3JkanOJfpo4sfyo8YUsYyn6KuUAKeLeIlTg6H4rg+BA7
 WArjvSEn/rauCH+U7SaUFzrZi+Z2LGNEvcTKfv5iI+89OZLdyWmrzpB6QhsiVW83ROOcaMTMx9W
 bDuJhCgMfiwJpKoCLVlfEDchS9BytEH+708nw1PM0f/VpmfF7eZ5y6EFzDh9z9twjZIokpqKxdB
 So5vZH32CkcvXENsutrCkEg/72H9Z51DSa8t1rhOk/dR63Zz1D7Ijgz8nbzDzc4sY0LyjEHDbvX
 C2HMzoWH1pbgCOKYDAViABcKfGRT2pnV2Jg+bs5DxruZLH6N9RQwy4/8Js1IMX6r48YEJXv0qRM
 Voh/MifLwao/QB5QkDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyNiBTYWx0ZWRfX0F35PAoK9Mg1
 Pvj8JKiOZ1hRZziZM33sADui4C2gcMCzi6VGy5eUkzrF8bh9iG9IPuZSFG0so0TwOvVU94s5vza
 2jN6a0BBXgiVgXXazsaakQ8vhEvReNM=
X-Proofpoint-ORIG-GUID: TRiq9IdFwsXonYhu493o9DxLfrZV5e01
X-Proofpoint-GUID: TRiq9IdFwsXonYhu493o9DxLfrZV5e01
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6affed20 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=fXwKFA8GOUhRkyI-wlYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200026



On 11/19/2026 2:20 AM, Rob Herring wrote:
> On Fri, Nov 13, 2026 at 02:13:44PM +0530, Gaurav Kohli wrote:
>> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>
>> Differences in SoC packaging can be used to provide multiple SoC SKUs at
>> different thermal and performance characteristics. The underlying SoC
>> remains the same except for how much heat the packaging can dissipate,
>> thereby influencing the critical trip point at which an SoC SKU needs to
>> be throttled. This SKU-specific data is typically burned into fuses
>> during manufacturing and can be read back at runtime.
>>
>> Add two optional trip-point properties to describe this:
>>
>>    - 'temperature-bin': an array of per-bin trip temperatures, used
>>      instead of 'temperature' when the trip depends on the hardware
>>      revision encoded in fuses.
>>
>>    - 'thermal-hw-bin': one or more bitmask groups describing the hardware
>>      revisions for which a trip point is valid, modeled on the
>>      'opp-supported-hw' property of the OPP framework.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml | 60 +++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index 999ad40a20d5..cb9a8c96d053 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -152,6 +152,58 @@ patternProperties:
>>                   situation where the trip gets constantly triggered soon after
>>                   cooling action is removed.
>>   
>> +            temperature-bin:
> 
> Use the standard unit suffix.

Sorry, my previous reply was sent only to linux-arm-msm by mistake. 
Resending to the full list.

Thanks Rob for the review.

Would temperature-bin-millicelsius work for the unit-suffixed name?
I’ll also add minItems: 2 and maxItems: 32 in the next revision.

> 
>> +              $ref: /schemas/types.yaml#/definitions/int32-array
>> +              items:
>> +                minimum: -273000
>> +                maximum: 200000
> 
> minItems: 2
> maxItems: 32 ?

