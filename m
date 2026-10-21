Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597950;
	b=CdqPU4CAWKSeg/OiMe0ubPd+if7T5cZ1lO1OIjA0lXdd6Q9/L5TeKxg45cXa0GlE68x1
	 ID1OTR3O8PR4Upcqe+flGQD5T0dbgpG3HteFQgs18mY6XEXv5hxIxy98WW+SGNKLZ5Wk3
	 3ODQhl334pzu3iVH2cY46R2AghbKUpMNZaJEmAoVHbr9G6ZGtI5KnJmC9SyAZRPDS9TAT
	 7k1gRMhoOcirp7PfcDZz/+WP0N9hSGhzR/nec3lntI1LLGPGY/ARgthh+xQBeYsJhtGgu
	 c0GBW54jTtO376Z1wuOkpvpJ1lz6bzvmVD/fxRes/oAf79pxmcahtuxqlJkszAfz51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597950;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ibYRO+1Znxm8b4rcaUEm8zC3whuBP06nv+aNbLyG60k=;
	b=cs3rZ2J6NQjCYQ18rQCxO6HrGnMmYHBoh1FP2J7sC59rRvI/MmFqZ8QP+5I39VyNimDc
	 980Ht3z4wpBAx5SR9lgmUiRBeX5pAg6bFGgKFmTFNey1mUUATsqb7NmQOEU1HICNL7rOn
	 d/b311Moty9n+VxSeB/7ayI0IIhI0Xd0XRUXLWwzcYxz2mUzDFvPSvbkz3lk/T0Kvs/8Q
	 7IZTtp9gDJe5IA6ksBGqZzb76AMicRNxgzeZVNiRZgbYqVT7DjvwHaRoviTQHQbMcMTBq
	 HdRAW21ErxDkuSgsQFE/Kj5dwUvRtQpbbg8fHuYkIguHozHf3fG1a9OXDUJhswkd6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1JkZaaM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NbdbjfEk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD2606A330
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CD2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1JkZaaM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NbdbjfEk
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFUAjl4158961
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ibYRO+1Znxm8b4rcaUEm8zC3whuBP06nv+aNbLyG60k=; b=X1JkZaaMrgTHS06M
	o7AuxubVAHNYAzDNoSeEZL7PJ8n7fdXBQFkiLgF7WtJ2/ov+PYwQneQBBkjh0NLC
	WfSNd8poJWwVZ56WkR2BJ45KPIORIWZS0/vfNsltIzvoPJNs/VfiNqPuH/zX6da4
	/48UV4Zar3SZ/QSaH6ySYnJdw50tmQf4tcpzsntlvEkD/tSp/RzyEi73Qyl8ZKbv
	Ic1Z7Ko783ll+iL6fmOlCCOtBIkmv4MvR0p3uY9ypvyBonzJxsZw7yuH2Sy3B1xy
	9oqq7kFjeAfSK0kndMy674r74DOW8SS5WZh2+3lgEEDFqDotzAsPcZTnldI6S7bH
	o7B8MA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q8p9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:52:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a04491c56so1308eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792597947; x=1793202747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibYRO+1Znxm8b4rcaUEm8zC3whuBP06nv+aNbLyG60k=;
        b=NbdbjfEkAUJfnEOgZvzihS3FCsTQ/Eq5luqXC2kqzy8XSIUgB569FdxvJQSc4ZsqlE
         q7YhhPtgkLq5Q0x3tWf1iFCO5/pb7hZJqv+UpyH1EeNJ7PrZ1O6+Ah/6PeEDtAjGromG
         iJrVKqTQo7z8UfQ7A14Sih7KFs0twkd6oyiP5RjsKGnpTPye77eKNEVm8/qBvrJSd3LG
         5bLMnICoDn3WRFtnga56XiWB0lfVJ3BSm0fw41YAQfHDUu61T5kpwFBBln3jFBAn6uDu
         8ichDtqGCgcYloL3/2QLB0DRzdLqm1mz4Xj/6feijC8WD/8TFK5eVtk2dcV5jH05Fyhp
         kg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597947; x=1793202747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibYRO+1Znxm8b4rcaUEm8zC3whuBP06nv+aNbLyG60k=;
        b=HtPmZ9Iz5MrfVxW/fYY5iu2oBFk7UK88tOvG03QlpZOWQ8D4Mjr5+V2CTJGBNxzoZK
         SrQYxlgkVOGd7hLLsEp/iAypukr9j//dJ854h8uwnH5h8H79Vj8GjgXuvNTvb16H9PyB
         7/mggnLgu6GtfHtRvlxoFGgtyLk+qWsDJO+xyMmuc81o9p6+13a5/HH9lCWzRUy9Qlxi
         kCmpuv2F7/WfNAWtBZcs5Qfey1bE+vo3GgFnTC3VRA0CFntpvQ0xjHHcf6lFybW+Fhcc
         CaQWHnZhDbYMSU1DlBQn6crJWtWyoVycqsglv+nGGRDxtrUzyM9PTJTife0tqltlSWi3
         I75g==
X-Forwarded-Encrypted: i=1; AKwUvByrlwRCnhnqTEYEmZLedd6fhWh36Sr5FvYlV4fz0PmwaNWAiz9WlHTiNDS2RqS5anfAkbQX7ZERkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvHpk47gzgiKEO19DMS5n4IXJXprlq5FJ5SkCFBiIOhas7Jnb2
	Ofomy9MpidKighGf0QDwgxR0EYZyIRkJfxWLq0wJEqOr5SRvZoQ4AoctAb45TQFuqJI3tHFsQAo
	T74dWyiWf4H6KYwOL9RQ2dobwqBW9JqH0NMJpVcq0pmr1lbR1f5z0Ui2HgLDscA==
X-Gm-Gg: AYBFou0hs2qUW6ikfFqjV/Sez5pejuTmWpVOdz9XJPvd7feW/uNb5mQKo4VA+EEpK3C
	QaSbYVlBU4D9dvmgH+eRsjp7AD6tfsQX4EPGdleJCugB5VkDL3weR3aoSgv4+1UYTl6LnEhkNam
	ShqOxN0aHvrEMI6wl+MIRIPm220j0kFNoNsMjK13Jt7qT8kRr863cpPspfWn4AB1jhfN7M1sM6E
	KCxk4YJz0UX+ZM5yzaml0HmXjXLDxJhUIuyFM3X+Zxb9bIbIlJrwdS50Wb0Q5yK8OD2mVb25wOQ
	UZ2Ik3YSI7MCDUR2ZkJXGeEzsv5DDInI46w68gHyhZ0xLd6Q3iHb0LEKAJyIezSUfnHBV6ey+CW
	NeXlOoV5wpS4ybdAjHH5/Kns8kvAxz1IRbioUauU71Hb0
X-Received: by 2002:a05:693c:2a13:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-3674d54bc37mr3321002eec.10.1792597947109;
        Wed, 21 Oct 2026 08:52:27 -0700 (PDT)
X-Received: by 2002:a05:693c:2a13:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-3674d54bc37mr3320967eec.10.1792597946485;
        Wed, 21 Oct 2026 08:52:26 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.81.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm9445801eec.25.2026.10.21.08.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:52:25 -0700 (PDT)
Message-ID: <d163db9d-5b0e-4bee-aef1-3fe8b7f1fc08@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:22:18 +0530
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
Subject: Re: [PATCH 3/4] dt-bindings: clock: ipq9650-apss-clk: Add IPQ9650
 apss clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-3-fd4c2b3cbdea@oss.qualcomm.com>
 <20261013-quantum-keen-mongrel-c3736c@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20261013-quantum-keen-mongrel-c3736c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX+g1c2dQp1lGo
 ZYIBtu3Bzil3YTs1csvhWAaDWgOHrPPDqpjs5rtjmORgfp9C1aMnFdgDcDWIcUfYoYsCU4Hs9SK
 FW7GxlD9VSJyLJI9EkuNXJC5ri/C1Ik=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad8dfbc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=rZLzW5DhxuwyX7/NBrPT8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=mdBYyscGZtZr9QMU3J0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: m-d6SRPjihKhnXTLZiYnHwXfQLjwZDns
X-Proofpoint-ORIG-GUID: m-d6SRPjihKhnXTLZiYnHwXfQLjwZDns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX/xioP0wa4Gkk
 XA/bmRY/lDs8uCl3YcMk5U2bM5IQmLbEYeWKNmbd9Zf10xkU+98nYAo/EON77wgG/Ox4v4DkmjH
 7XLc/iERQ9wySm2EJppJsZ4WzuZCJCPwVsesNPNESo4kZc4aLWzsUX9f5VvBjIzAAUAsmeEXe/J
 Pts3E1SSG5+ZQmIrzxVUr2mSUPQJZIQ59HlUEuZzS8/65JiqDad4OLAQ575KiKLRMWZy2nB0mHa
 CUh9SOMn2BJIU2jbgc6WEZrEQNJHZdPKPORt6h1Z/LlfVddPJLaHP29YvJYPTxmZD8A4btB+ABB
 35bNrbXGf8Y9KDpcAfsTgpZFTRneu02JSlsOI4+UZ3yTalKWFoMGR3KsONm7rLDabLPNKTynyE3
 U/NNHxIUeoM6m7nzkK3AAJdrOKirJ+DvLkaYKVLP9X/WZEHcENssrJvOKe1Bkgxt/Sq3gL9KKM3
 uBM+tBIyd5A2JNvFUvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063


On 10/13/2026 12:17 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 07, 2026 at 12:20:46PM +0530, Kathiravan Thirumoorthy wrote:
>> The APSS clock controller on IPQ9650 provides the CPU and L3 clocks and
>> has a register space separate from the GCC. The four Cortex-A55 cores,
>> the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL,
>> selected through a glitch-free mux whose parents are XO, GPLL0 and the
>> corresponding PLL. The L3 needs to be scaled along with the CPUs, so the
>> controller is also an interconnect provider.
>>
>> Add the binding, the clock indices for the Cortex-A78 (gold) cluster to
>> the shared APSS header, and the interconnect IDs for the CPU and L3
>> nodes.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   .../bindings/clock/qcom,ipq9650-apss-clk.yaml      | 58 ++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,apss-ipq.h          |  5 ++
>>   include/dt-bindings/interconnect/qcom,ipq9650.h    |  4 ++
>>   3 files changed, 67 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
>> new file mode 100644
>> index 000000000000..6b47183edd56
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9650-apss-clk.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq9650-apss-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm APSS IPQ9650 Clock Controller
>> +
>> +maintainers:
>> +  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> +
>> +description:
>> +  The APSS clock controller provides the CPU and L3 clocks on IPQ9650 and
>> +  has a register space separate from the GCC. The four Cortex-A55 cores,
>> +  the Cortex-A78 core and the L3 are each clocked by their own Zonda PLL.
>> +  Each clock is selected through a glitch-free mux (GFM) whose parents are
>> +  XO, GPLL0 and the corresponding PLL.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq9650-apss-clk
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Reference to the XO clock.
>> +      - description: Reference to the GPLL0 clock.
> Why do you need a new file? Looks exactly the same as existing
> ipq5424-apss-clk.

I kept it separate because the IPQ9650 block uses a GFM instead of an 
RCG, but that's internal to the controller and the compatible covers it. 
The binding interface is the same, so I'll add qcom,ipq9650-apss-clk to 
qcom,ipq5424-apss-clk.yaml in v2.

>
>
> Best regards,
> Krzysztof
>
