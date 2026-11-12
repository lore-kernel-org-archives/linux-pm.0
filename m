Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474730;
	b=W1p6Kmv/HaN1pznWIhHyN7oeVuBQ3uu5cFc7/WrIDyO6rhZPZTBHw54kSXJXvOjuzQkx
	 8HwwOjmIIVb45+KS6fCLX2sepwBcvYu1ShchYsHvphqqkyDVkpaphhISOTJusG2wWKtzi
	 qxqemaaadYaDC5iQIfvbTTUfRVmWZquLsRi5pMulOFjNUCc7Lv1UDVWWRsTvXMcqgcl3x
	 S5TtzWd5xpV/6W/d3DDc/UokdGnorH0bG8tPo1su+a+e2w7WrwJGDeYzPIifdIIwyMZVa
	 Oqkp/gobnKLjL0EjpKafe5vl1Ka60V24SxAKD3UHlUygr3XPezd4lDhuxYDW63FiVzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vGd4ARJYz5mi6yrOckAYjghiaMIrs6g7+qy725Lhpyk=;
	b=c8qBBn0WK0yQYgZqzQfJ2Zn42ZSDprDXhCGW6ZKXQqHaLaNlpsPFVJH3ndWxU9nfE7pd
	 YkE97qAKka1ri+cYBiOc4eXxLR/tLdnzYDOfE2c4zT49rIH7foxLCc+tIuvi2g+T4Lw58
	 Wpq9ihAVi6IIicnlSxnjWMhPWdehB3FKDFd832BzlUnRpde66u64jIf61bLr0ANFEdN7T
	 bOho1w4PaP0EFztTjdUanoSbT+HA+xRu1jtc+5KMZ2l/rMhP7WfoiVIIqE5+tdLNMhObb
	 dEJUb8eZjw5usUPeS9vwUmLkXYarHNJVLV3N4w9f38pE0qW9EZi6tiYyrY985ZNi1ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lxQW47zd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eeEftbmO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6D606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 09:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lxQW47zd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eeEftbmO
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC97HZf2514188
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 09:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vGd4ARJYz5mi6yrOckAYjghiaMIrs6g7+qy725Lhpyk=; b=lxQW47zdhk0z5+OK
	8IZmzr9xGD9eMroMoDQ2Sxl1oSs9cOFJh1ukpgqvhThGEPPDbJfmOnErNGyP8vKs
	9oYrdIp96TKWiFz+eoc87U8HrkQ6jZU9SPV5SL3ohDjK6RkhlYv3PXpale21kE4S
	JjS/XOm9ILchByGOJ4u9pF9DbTZuJcCxQwgjtJlA4qkPL7elP/c98RCfFOaMRk1k
	E4w2QSP8fp7UeqRkI99uwXyT0acls/u8dkGqaTs3gVAstY2GSVcE0eh4okUFxLCQ
	10UErvrriq1boI7pcfo9JjN03Trf16oO1s+jnkCQSr6w6cErER7l62If9JPcd1ts
	WzEtFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1tv1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 09:12:08 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89f84753b43so3278596b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 01:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794474728; x=1795079528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vGd4ARJYz5mi6yrOckAYjghiaMIrs6g7+qy725Lhpyk=;
        b=eeEftbmOMOHqgsGnUZDg6ko21h0TA4rqYdleY5dOmqZvlOZElx53ytfhh2iC1xQbzS
         6d7iLNnFPDSODHkp0D05cZ/92f7qyusq9LUxVH0tSFw8zQgxCiTlP6t0Yql7LbDxNU8k
         BrzzHbUmZ69TXU6zScMTHfMQI55l56sM7R7e/qtLv1giGBlNtRZp7Q++xn2zPOx+Yl1U
         VcBTluNCf7l5CE8a8IVMmnhHXQTn53HhHCZpujHCjbfvPgdUkTt+Z5EPMqYqbEIaGHuR
         5VyR0P5xJiUuwvPy8bSfijzg2ETZx5O4bAtCZxnxWNDNx78/2zJ2fFHaWAzkH6S1nCSx
         949g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474728; x=1795079528;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vGd4ARJYz5mi6yrOckAYjghiaMIrs6g7+qy725Lhpyk=;
        b=xGUim198C+uL1nzFoRbetItW2UN1+mLrI06FCH0soiVhf3GqFdbe0QZjmprkaGmgkI
         9/leKzNSRvm9+6QrGUZemfpO66jCGMpLJ6Mn5gFfN//pWqxJgC3c0R6zb1JA7bn7lOKM
         /h1peWeHySiLkdlpwpg5hnhXxzgD/0MxgCnb4xGzEJbOn1Uqpa9XaA+jbismJEOQU5aR
         P9PiUwOxIT80qqFY0yA4Nf2CqCYQ/AuZZz0hl9gdC/P6Rt+ib9hIY3AgJK9jm7h86MCC
         i7wRfrIq8oWWsw4NrdLeUkMbkzmq3KbL9xznlfedG7HQve71oBZuQp7XvoKRSUMkx6OK
         q0ww==
X-Forwarded-Encrypted: i=1; AL+hErE75N/3Yp37qXxRr8S9d6i7dkokR7yhY5vnFDPLfH4H6RSi3CQhpZERoWT18s/ip6Nz0qNGikqKMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9hsAcQAsyVGJlCTuNACRlURvo09pNMXnwx7iYni6zlxUAWcg3
	/5fq0sxLEOV/UC1an6HmQvS+XS6wI0wPrCwgMNvnr+/xWwA+oPZZEcKo0KAvf3wl7W4c1y9o79w
	D21BprIu7BWXnqOYPW8XubWsjeQuI47aGXR2Qbrh+MyS9DWrrPHXdnfB97xLXrg==
X-Gm-Gg: AYBFou1vRhtIz15Lyzkgmo5nQ1Gesy7SRHzxlXd6uzeOI4feJTZ0/36BKHR6Frg0NIF
	QIwXYJ5u238yhE97Hajd72+3Gr3fk0FMIckv/2ePWHrRDpW5MpSKXi7Cp9wB3JOxmwt6C/vCRUq
	BNlspomOqQX2nmk0OsteKhVrXOfNNd64koHbFzTOvfeGjrmAhIL0vwMop56y+rduT9P5dKz1jGq
	uI2SuPHQ3iIrbJnrEyPAZk2LRzGIkRIJaREkO9OBE3sKEdHD/FaufSOOr4Oeul5IPTkMBfSjPp8
	m+sAUVjgkQf/xspKBJjR4zdRfwdrmQ4oAzlhY9p1NxKiCk+v9NqVYeaU2C54IpWMGNeMswYVieu
	Wsw59n7kVTeelPTyDJTl0UZV9I8D3v2CjEMpuHz4NpO0SY/w11BrvJcDpqtxDI3OMcrnZB83z0i
	ymcgsPArJ2ZsRON8wlBA==
X-Received: by 2002:a05:6a00:c1c7:20b0:8a0:1a6b:59fa with SMTP id d2e1a72fcca58-8bca925fef5mr2785356b3a.37.1794474728157;
        Thu, 12 Nov 2026 01:12:08 -0800 (PST)
X-Received: by 2002:a05:6a00:c1c7:20b0:8a0:1a6b:59fa with SMTP id d2e1a72fcca58-8bca925fef5mr2785331b3a.37.1794474727682;
        Thu, 12 Nov 2026 01:12:07 -0800 (PST)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b27e8sm3026131b3a.16.2026.11.12.01.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:12:07 -0800 (PST)
Message-ID: <e8dadc91-226d-4b05-8de1-4b22318fc7ea@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:42:00 +0530
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
Subject: Re: [PATCH 05/11] dt-bindings: clock: qcom: ipq5332-gcc: Describe
 clock inputs per compatible
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-5-d242e3d49648@oss.qualcomm.com>
 <62a5fabc-3a06-42fa-9c6b-6504650e712b@kernel.org>
 <7bcffc7c-5dda-4ead-a053-7eb4980e43a4@oss.qualcomm.com>
 <bec2bee4-dd38-4846-91d7-006fe38fc9da@kernel.org>
 <af43c724-89b9-456d-a5da-0d8ba46a9b8d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <af43c724-89b9-456d-a5da-0d8ba46a9b8d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af582e8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bsvW812kIstMtjDHHLsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: V4b-xryAEwN3tQWB6pdC7nnN-TOTbw42
X-Proofpoint-ORIG-GUID: V4b-xryAEwN3tQWB6pdC7nnN-TOTbw42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX7kbadb8VqBfj
 AUGZmX0PD/jvM/wWDImRIju6UkRe25Jj5toNGkC5c2OCRkuEgJpblpWkSMTEvmJ7H+Cs3kJ6F01
 XB9M8MEQlPFz+HBEwB/fU/Iia+pfTmFUH1+vuFrbR18KgtkazDpIgjo2ssb5mlyhDgB/UREd/NQ
 FZr1RpbVIYWEuXI7abUKxj/PmrMA9JljBXNcYqoU2Eosf1a6tx0pshMv/pva2rZMM6SyFg1xkWy
 n1kQmaSBS3TdvEhOMi9hctk53Uc50UeDovVSCAKO39S1ls3REAk6l71gN/BmEzPTy4fcMIXZFBa
 FuDpAQU3lxo4RSf3TgWG/gSz020nQIEv7UjYndljcxGr4fFcfHuaM2BhXvvq66jQvNnUzQ3OEQG
 uUZTdu1IoDVK1d4zaTVn1AdlldiKov6rhtJngU4eiPfBUkQEuzvjyPRDoaSnN0gk+ao63tSxSQw
 IJtzmcakHoC6JY9vTLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX+HZC+jxWuadF
 Hz3wpefmsslYarQDNixN9+2iNZTG/vhCjNppg0b8dzkPch+MwKt/W8oG9qG9x/D5wgY5VzmIWXB
 ZwXBBiSxu+tsLRzAgdQI/0U3UOFxfbU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120036


On 9/25/2026 12:09 PM, Kathiravan Thirumoorthy wrote:
>
> On 9/24/2026 4:28 PM, Krzysztof Kozlowski wrote:
>> On 24/09/2026 11:15, Kathiravan Thirumoorthy wrote:
>>> On 9/23/2026 2:17 PM, Krzysztof Kozlowski wrote:
>>>> On 21/09/2026 08:19, Kathiravan Thirumoorthy wrote:
>>>>> The IPQ5332 and IPQ5424 GCC blocks use different clock input 
>>>>> orderings.
>>>>> Document the clock inputs in compatible-specific schema 
>>>>> constraints instead
>>>>> of using a common clock description.
>>>>>
>>>>> Also add the 375 MHz PPE clock generated by the CMN PLL to the 
>>>>> IPQ5424
>>>>> clock input list.
>>>>>
>>>>> This keeps the binding aligned with the clock ordering used by the
>>>>> existing DTS and GCC driver implementations.
>>>>>
>>>>> Signed-off-by: Kathiravan Thirumoorthy 
>>>>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>>> ---
>>>>>    .../bindings/clock/qcom,ipq5332-gcc.yaml           | 26 
>>>>> +++++++++++++---------
>>>>>    1 file changed, 16 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml 
>>>>> b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>> index 1230183fc0a9..fb39dffca988 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>> @@ -25,14 +25,7 @@ properties:
>>>>>         clocks:
>>>>>        minItems: 5
>>>>> -    items:
>>>>> -      - description: Board XO clock source
>>>>> -      - description: Sleep clock source
>>>>> -      - description: PCIE 2lane PHY pipe clock source
>>>>> -      - description: PCIE 2lane x1 PHY pipe clock source (For 
>>>>> second lane)
>>>>> -      - description: USB PCIE wrapper pipe clock source
>>>>> -      - description: PCIE 2-lane PHY2 pipe clock source
>>>>> -      - description: PCIE 2-lane PHY3 pipe clock source
>>>> You are changing the order which is ABI break. Describe the actual
>>>> problem to justify such change. Are you saying this was broken since
>>>> beginning or what exactly is not working here? The driver was added by
>>>> Qualcomm in 2024, so how did it even work? It's not some 10 yo legacy
>>>> where we did some mistakes in binding while converting from TXT.
>>>>
>>>> Also, I do not get why the list cannot be shared.
>>> When the bindings was posted, list is combined for both IPQ5332 and
>>> IPQ5424. But the driver wasn't updated and it was following the below
>>> order, so was DTS, which is not compatible the DT binding description.
>>>
>>> enum {
>>>           DT_XO,
>>>           DT_SLEEP_CLK,
>>>           DT_PCIE30_PHY0_PIPE_CLK,
>>>           DT_PCIE30_PHY1_PIPE_CLK,
>>>           DT_PCIE30_PHY2_PIPE_CLK,
>>>           DT_PCIE30_PHY3_PIPE_CLK,
>>>           DT_USB_PCIE_WRAPPER_PIPE_CLK,
>>>           DT_CMN_PLL_NSS_375M_CLK,
>>> };
>>>
>>> So I'm splitting the description between IPQ5332 and IPQ5424 to 
>>> matching
>>> with the DTS and the driver description.
>> So we asked back in 2024 to have the common part of the list. I even did
>> the effort to dig it:
>>
>> https://lore.kernel.org/all/ruti7hmkxkayzmqfbme6rw6j2vbhlx4ul4ptcckwamcpd4cyfx@owufhxwpvlcj/ 
>>
>>
>> Authors implemented it partially, broken drivers. Now you basically
>> revert what we asked, which is BTW logical option. It's logical and
>> reasonable, but leaves bitter feeling.
>>
>> I have feeling there is no accountability and no responsibility of the
>> IPQ at all.
>>
>> No, that's not going to work. You cannot come 1.5 year later and revert
>> what reviewer asked you, even if issue was just by mistake in the first
>> place. And you should not even try to do that.
>
> I understand the concern, and I agree this should have been caught much
> earlier.
>
> I only discovered the mismatch while working on the IPQ5424 clock
> additions. My intent here is resolve the inconsistency that currently
> exists between the binding and implementation.
>
>>
>> NAK
>
> I'm happy to explore an alternative approach if updating the binding is
> not considered acceptable.

Krzysztof, I understand the frustration behind this, and we will make 
sure issues like this are caught earlier going forward.

Could you please advise us on the acceptable way forward for this series?

>
>>
>> Best regards,
>> Krzysztof
