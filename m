Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604602;
	b=fXwPoySp2NCGPerTm69oq4x2bxp1eGrTsp4ncL9h9gZcYrkkpU8ly8DIAN8+9rJ0vwZp
	 RTPM5x3h6J3JaXndg1hBeUO8YdTlsPXIcUry28p5zpWO3JBEo/Cx5iZCN7Eq9ymiC9G19
	 VZo0eilRZt/QazWIPqyz90Ohb7FF2jkGGCzs6P7iCR24dif9JHsMdrvN/k/mizabrnKl6
	 6xg9zapZUL4xq6v8oYVh47iSl5CM27H9nvH09N4CupBPxRTBX4ZsmjSMbS+6qWa+EHWdf
	 h1Dxdqpj4lqkV4X6dYQMgIC169D0+4beEdYB6CLoMM8ySaYvgEc4V/CHdVAznhxSDQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604602;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N3jXlxFsdDnYKftBj+HA4lSK/F7n4JJDj3rZ2WfFfZA=;
	b=GkzdRdPnMiWQx1SjaHK+KNx5Qv0NGa5omjre6ctQLkRF+5KQ4+Sy92JtmgjMBAsSfEJh
	 J77aTRmIE0B54sLVJM+5C+cAqB7IltC2tlyD5tvkWWt2iREnLzgzY9l3Gv/KCr4Z0Yy8o
	 rsqX+AxK9YrCPZdC9GGxMFubaoAc340qPHXAA0zXBROD8JQ9cCJ0PtrFlv0xzKAoUSUzl
	 JKGFnbAUM5r4FxsLos4uvRieOZ2rOlyDgMuuc4blNFsIPriv3s1JdAZTzAvafhNU7RO4+
	 asQPPtO61IcD+thLrCnB1Lcx/8ZWGdmNrpMHenhY7arEDJzsgPjvQSUsHFPKahzVWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b9horh27;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="A3/r7GSh";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27246606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27246606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b9horh27;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3/r7GSh
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mSQu555596
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N3jXlxFsdDnYKftBj+HA4lSK/F7n4JJDj3rZ2WfFfZA=; b=b9horh27NV50ayY/
	B/SlS2tq8A9BXnKCZpmOaZn7KfLNquXoIFyN359bomonMfMHk0alIKaHfvcgKaa8
	Uly3kkop2GwUzV03rMQsMZ9hVPG6WLYJ5utD8DejvyncTLBdaaLmEv1CzD78vkVY
	xTK/0gIJPG6AtgCix1J2VWav6B+VYqaNlwlP/u1bR0YyylG5rshuZDbYfFaggybs
	DnOPttFymm0NIAgPYwgzaDLiw/V3Ewh/5y6L80TKrZFJqHiKjiuTvCK31Atbjs45
	u0ryOc5vntnsYxVbSHv0D3kRkJB1oIY96zOZNQrKdVu1Qt46FQqmcZY4hO9Tp+xs
	QM3KLA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrffp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:03:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5edfa1bf94cso121004e0c.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795604599; x=1796209399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3jXlxFsdDnYKftBj+HA4lSK/F7n4JJDj3rZ2WfFfZA=;
        b=A3/r7GSh3rTD2zOyyMS/24VI42GYW9hxkeX5z0VO5y3h8baV37YJoooYndJCa77Ekq
         E2M0Pl/pCOwxo8oGLLxBPWtnSVSSZSmsFiZmDCGIIl8rvFCcST6sO9054duMHMi9GbP3
         FByt4mF/SIKVWurmkjLx9lKRjqe0qjgNRwy0HBDRjQzY0z9yv9qzWkkpvfwB0Jhb4zZk
         5s4sslN3/3Z0gHLqgD+PBd8K4yFhmyCiSEpUFrXQ4qMdrNZpjXOitdwWVhaohCdAMBMK
         n4FRFPmsCQoH/54rP2JyBUvqb3iE2iBeobWydiycCx0MJtjo4sybywJGt2jbmAeIpreO
         jOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604599; x=1796209399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3jXlxFsdDnYKftBj+HA4lSK/F7n4JJDj3rZ2WfFfZA=;
        b=hADEaKTg5lqhUCv6wyJWSoMI0Ho3RxWH9yYwcR1Le3J7EP0hYK/F4ohlfoX2WZJvud
         gV9A7uBkNHR/+WLrgUKHRy/e+Xs0W42yKvOJztZpjfjA1gnssR8yAe2IJpDaI14YPxWX
         D8ZJg8juMizshXqfDKcSBMHAClklFl0xjhnCaWArb8CDdGnjxiH5BCvQBWBS42CPxATq
         0A4a3p8/fEZJgypN1YtnuInOXD8O53/372f/xEp+2XsocSt5Y4r9X8uyf2WvdOU28Z3I
         JzdnhreMNSfwa84wDvzD8WkPW6X2vIt1OUzeL+FGjCM6TT6REK8DdmkBap9mQEhDXap2
         6pTA==
X-Forwarded-Encrypted: i=1; AL+hErHsuZdWYiT+oghQDSn0D85Wd2ypUSRV4kIRb/KpSFde/cbByRa5GCDNKneBBv4Hc/4aeRiJw9ohbA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/4wYcl+lk5Ln9qZZY+DQNEarLH+e6wS3rh0KCaopV1nKcTrzXk
	Sx0bqTPWJMbSmgnYuvHnBCudjypQPYu3EFT0savLM1YRlLvHuCUef0ln68MvHyW02GvFwlnh/V7
	aciTZRSMh+D0IFD2Fu2HoCCNB5o4+QJiVSQmlZBQi0rx4d2IhkfIZop3NkCqK7w==
X-Gm-Gg: AZFdTZfG4BJ+11uoegiGQB9MYX/9ZP2yMzlm5A6o5Scn1dEl7VjTCwGJA5nUTuwd/Fj
	BERESyONpQ1OPBXSc3MUMY3tYrOOYBylk/Ezx8FyU2Y8DQtxTTdFl94QUFPVeH2LiBtnRDWv/iu
	llye2Q5ymwGQf5EmlP1Sj0L53j9drT4w0YCHo+MptW7BBHXbVvp7LnVIroSNarSzOIy8ITVYHG5
	D2xxcEXOUUcLZ9wRPkdrHWTDtmovO7Z5tQkYN45V/6EICtGTnT94W4liGModXhNEiIy1t7aBGoR
	+laX/LeVaDd6yjSQSetFLgLCvRFFAtTvdS7bY2T0yny9m9/xWmb/EmlHM+ZlvEyfkh+FUsNFjz9
	jlVSAf0ix8PfqtHXz3r58OPPBFFx66tQBn7XxU7v1ZN6y/sQvw97JjagH
X-Received: by 2002:a05:6122:8495:b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ee8ad0e69dmr9793463e0c.0.1795604599320;
        Wed, 25 Nov 2026 03:03:19 -0800 (PST)
X-Received: by 2002:a05:6122:8495:b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ee8ad0e69dmr9793427e0c.0.1795604598783;
        Wed, 25 Nov 2026 03:03:18 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b022e84sm630307466b.84.2026.11.25.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:03:18 -0800 (PST)
Message-ID: <403d0d8d-85f0-405a-a26a-54040272aeba@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:03:15 +0100
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
Subject: Re: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
 <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
 <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
 <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
 <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfX8dayea2zXvgq
 9KH2fmBTDz5Tdq3OvrHVf8/ahZNzfoUNaJ5AJrP3D4lsoysD9XFJKEaZDzKVhFkZua9SQApb0na
 0GZ0DUr8br9+QmAzZv45mqlj832IsSuXgmB3pKSlPmN9HPaDhsJI/4lfyzrxcg7oZtzzzoT0pJ0
 S7YTmjckKChRfKdNHG9XZIjhEtu1IeQvLNOgLhlH5Zr14BZprn/iPaRJtUY5+BAk6WgS9STIrLX
 A/Z/7p5PNdrMXBoAOzExqUdESwKJlXcz9XXn49uKV/ziGm0Vo/W8zjQJjb3ENSQqvV4NjZZ9iCN
 1ZiRpim7pQHFEtufQvNOGD1fQKzbTcYWMB+RPIjWmZcreJ69iL4QKEfgMP9eL+n3UouV63cqbqU
 NWfRuyyKflm5/7g3UCQjTzyMlR//zuZ/kVN9w6yo3XTbRSR6mEWFspPukSN3kElkoC9riC+kYXv
 C9UOjyyg10oPRjTK9nQ==
X-Proofpoint-ORIG-GUID: bJ0qgU0LMsOM1nh_CUXhi85Enm48Mv-C
X-Proofpoint-GUID: bJ0qgU0LMsOM1nh_CUXhi85Enm48Mv-C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfX5nP9Qb9lPeho
 ExXxNd7JfwNxN5g5vVQ8JzqBh29jMT9C0GcvZ4NGLk1zlFPSsSY2DgtCwycINLZN+d2OHgleODX
 2IK2QzubFs5a2cx2h4YHZFMuCkvYIbQ=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06c077 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vYosS4eGo4e4NTISwfIA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250043

On 11/23/26 11:08 PM, Krzysztof Kozlowski wrote:
> On 23/11/2026 20:06, Konrad Dybcio wrote:
>> On 11/23/26 4:22 PM, Krzysztof Kozlowski wrote:
>>> On 23/11/2026 16:17, Konrad Dybcio wrote:
>>>> On 11/22/26 6:46 PM, Krzysztof Kozlowski wrote:
>>>>> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
>>>>> currently used only in the socinfo.c driver.  There should no and there
>>>>> is no in-tree DTS user of these, so none of these constants are really
>>>>> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
>>>>> that part matches the concept behind DT bindings.
>>>>>
>>>>> Driver have local copy of these defines, thus these can be dropped.
>>>>> This has no impact on in-tree ABI, but any outside users would be
>>>>> affected.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> I think we can move it altogether, to prevent a situation where one has
>>>
>>> We cannot move all, because some are actual ABI. I could try to leave
>>> these ones only, but that's a bit too much work, IMO, that's why I cut
>>> everything at ~450 value of ID.
>>
>> If you mean ABI as in "used in DTS", I don't think that's quite ABI
>> (again, looking at the glymur-ipcc.h case)
> 
> 
> True, not ABI in meaning something agreed between DTS and driver, but
> the values are used by bootloader, DTS and the driver, so I would just
> leave them as is. I rather care about not growing this for newer platforms.

Right, but they are compared against a hardware readout of a
well-defined value, not against made-up indices (i.e. these are
not bindings). I really don't like this ending up with 2 files
doing the same thing.

Konrad
