Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FE3905EE
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408428; cv=none; b=Svkescp5iEAc45gUT8KWgxTJWwGjvc1MOajNmVdmgTiSHQvWqirBxiOU/OcSwH4TiS3BF5ssSeeAhC4UdMhtB/nBlrCPtqiShqDNWwG3FFMkVHiQ+ybe69yW42+vyDwgKl4GAKZMt6/fmDtuJcDwbAkr06Npsui2dftf2syWpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408428; c=relaxed/simple;
	bh=g0W1PyzooAtJ3scJ3oC1HLYrSZOEKQZ6lGmXblvMhfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF5Ja9PxzUiApsdNsmgXQaGVGdavt11GaB4zOl2B08FLvUNqijbulkHy3OuDjEbRAPP1oT186iBA+TqXj5bnbRZ9AGmiAKM8lbbP+WbVsB/ekm477oUTKv4Bv9y2v/WhKdMKvhMSyh4HxgQNQueqSJ3T+D1Sxmomv0SMMcFNE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCo7FMfK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuxENL3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCo7FMfK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuxENL3V"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652A48oD1938551
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 13:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mb77+VbDY/WZt4TrGoR5MtuoBG8W9yZaYbwMG3StSPI=; b=oCo7FMfKvLe7P1eJ
	Rx9fCO46e8PCGH3r9O3boH+fhY6YKQnWiuB+8eboaHIdSMVt3ZSaoc814+VDTdID
	10D37B5+yJT9HdjaFGABToADZQaZdXMFJvvAUsAGpv8chaKTB9OcG1d21fnjkEY0
	rzEwz6oK5ug7AF18VVUhHbDCwkKUcbcgH0fBGskr0GVOW7BrJjf5kShYv0BhOyJl
	HCRv2hNQyTpkp3wP6/3kjmx4YqWlvUd3lj+Vw5fDp1wx2CC42kjnjTEmhnktceJE
	IFCLSGtiJVjiF3yMgDGCvmmF4/Fs6tDS/TUiGUXv6vzIOZrDEYVHsQgxTB3evCj1
	+M70VA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubj50n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:53:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so24429245ad.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780408425; x=1781013225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mb77+VbDY/WZt4TrGoR5MtuoBG8W9yZaYbwMG3StSPI=;
        b=DuxENL3VkmBMxf+tirx7eELKJLp6+8SUaWkQzmgmGSdXz4wMoP3f0Az7MEKYF70fFZ
         DIybOs0w/Pql6Gt0Ja3hV5Cl5ID2KVVVXeTptspua2MK0+mZxesAX6CmSZqFDFy4Y4x3
         DBbEo60QqWFGXxv+ScQ9JhkrZKDgJPhc4wS2dNHgI/bOjY6AHeXGlgPSBZ41xSHRiHRY
         u8CTCIIGSixZVe6ICHSymombTKtVNyNOEhkQHov48ZEU4o2txH6Hw2El2gZOoXKfV59v
         LqZ6nv24vvkK5GAu3R5JhN7FHxzGwiaQl7YdEBVVtVJqmEdBcwQyR6QUphQyMGCbRp/u
         vzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408425; x=1781013225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb77+VbDY/WZt4TrGoR5MtuoBG8W9yZaYbwMG3StSPI=;
        b=s+KKx5oW3lg+mz+sI5dHBzMeczyBRk9ywXQT4ZwNw7Ni1iTDXit1L+Lol6nAa2grHP
         B4+hQ32I8wZoUaTO0nlxv9b+H97zkEIff64OfmbvPRwip7s2o55hkDiWD+eH5fMJp/he
         UieQdutamu7lde9s+Qqxmg2Jt9ow7D33WyH1XzTxDhb8KZZVlF6TCFrVRT+v26QLGxA8
         a/gLxpnXO1C7Zlek4eMYZtNelor0pSVU9nLcDIaq5L2Ud9glmRKBLp5r4SexsAIYVo/B
         0hs4t4RjsWMdJgeFZr32m34+aJnHZxICEccM/JbA8lbAHDBlFZM2VS2YoVUQ3PXOLk9b
         3iZA==
X-Forwarded-Encrypted: i=1; AFNElJ8nnzQoSJc/3aeRayXpbXYfu/tuXncA1DYMOWLyOTrxYi8cmg2xNQo0lbrrF6aGcRnVStm9gPW5DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyafpvg+NV6sIYIs396UGJemEh5rpeXKeS8whCuocR8vaH0BA9N
	GIuCsjg/OORyGvaIgMYlnbVHnC032UVT5OC8tvQWXM2x2Wobv1TcbiMOuxKcCSR9Qx/oZX8o4k3
	onQ4h3EUlSKDer+OLu8ifpbKeFYZI9fxCwC4VfI6dhWKdtMhIzXasB0uS7MwAzA==
X-Gm-Gg: Acq92OGRBJZDQaLHLEnUv5YoFfHCPcl+il6rLTofLJr7OfJhnI/jYfCvGW+C/QS7nqr
	BYjvoCXUQMWAxHZa3ECXj0xrBGPzCc/vz+kKbhAmvpDN0YnSdhOBugFXa+7J/ihckySfROf+wtR
	xUaHy5UOmHTuWUbBVyL9hsYrsxbQC9tM3xkEG7SCQE9RahdQ6lreDZmymuiVg+lj3C3zAFk3vUP
	A0w14CFfXj6KXik5WFLOM5WiwtWi+IHQDEb+v3PmnCzkDEnTblKu26Yu9YvYOOTHJJeAUVj+UGB
	zHbhYSl0CWqNQctin4UbbjLD2P313lvG4P55A4YyE5d2qVp8TrU1YCapN9AgEnALOyyTfpwCivm
	jlKoBy2S51dDKS9OcQRCahVDrsEDijI0ZQTSjAdAqlkygKdYhhq9AT3ZgpwvOj8/ZtTw4wwn4iv
	xO9Rcj7Le8dRkiMceGwnpgv8j8NwAMRnfV
X-Received: by 2002:a17:903:4b4f:b0:2bf:2398:6009 with SMTP id d9443c01a7336-2c10ccbc173mr33528875ad.14.1780408425505;
        Tue, 02 Jun 2026 06:53:45 -0700 (PDT)
X-Received: by 2002:a17:903:4b4f:b0:2bf:2398:6009 with SMTP id d9443c01a7336-2c10ccbc173mr33528655ad.14.1780408424988;
        Tue, 02 Jun 2026 06:53:44 -0700 (PDT)
Received: from ?IPV6:2405:201:c416:5052:81a2:4375:a071:12a2? ([2405:201:c416:5052:81a2:4375:a071:12a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c0751asm143976745ad.55.2026.06.02.06.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:53:44 -0700 (PDT)
Message-ID: <4bf2e9eb-f015-48fa-bef2-ba1a58413e3f@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 19:23:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,shikra-epss-l3: Add
 EPSS L3 DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
 <20260524-shikra_epss_l3-v1-1-b1528a436134@oss.qualcomm.com>
 <20260530-victorious-resourceful-muskox-cdeadb@quoll>
 <afeab8fd-6951-46a3-8b92-9c3b7075949e@oss.qualcomm.com>
 <709428ff-e732-47b6-a6db-b26cd9149c98@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <709428ff-e732-47b6-a6db-b26cd9149c98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cWmXTLrTrcbuUHespJiG6U4GQbFh-9nf
X-Proofpoint-GUID: cWmXTLrTrcbuUHespJiG6U4GQbFh-9nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfXxZakrHhBszDU
 dOouARNEh6O8atn5Edrgs9L32xtl7ocKUd3IFzV6L3RyvIEzqD3qdzhmPQczjz8jj17xpEZmGpR
 ulOd4wwN8lNIBb1wKG31UCvyBQVWSJGOXatYrJCQ3GwEASPI4ZHTKVKf0ABE1gjEE/v+59Aa7Hh
 lRuY6Y3LbAdjhZjGqdFLqyM3zGxXPmTVeAqTRH0KScU3k2t0izlaA9sCEOlfynOG6IPp+F7Oqxk
 GBg8Sy8OsUUXNO9pHFi09sdTuWzjeBNsPeNnipkiIbBc/J0fMjgBz2f3ysxncAHNHl7VlAXBDMW
 BIChVPBY3uvC4UOI1qz/1U1y3CrcWdsTbR1cjGe3oPhpSM3ZdQwLhPAv/dFWo1wgi7uzL4Elrjb
 ABmwn9N+o6LgBo874LDr+6iZW0DF3QBYkrUB2ZmBvy3Eo9IEat/ERZd/pztHLXsLyA1t3RotZhc
 OUaf4vCKYPNN+6638Bw==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1ee06a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=FhBE5UMFHDhWvMFztzwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020133



On 6/2/2026 5:29 PM, Krzysztof Kozlowski wrote:
> On 02/06/2026 11:27, Raviteja Laggyshetty wrote:
>>
>>
>> On 5/30/2026 4:38 PM, Krzysztof Kozlowski wrote:
>>> On Sun, May 24, 2026 at 06:03:35PM +0000, Raviteja Laggyshetty wrote:
>>>> +  '#interconnect-cells':
>>>> +    const: 1
>>>> +
>>>
>>> I do not see any differences against OSM L3 binding. Why isn't this
>>> device there?
>>>
>>
>> The EPSS L3 on Shikra is similar to EPSS/OSM L3 on other Qualcomm SoCs,
>> but supports only twelve LUT entries. Due to this hardware difference,
>> the generic compatibles are not applicable, so a new SoC specific
>> binding is introduced.
>>
> 
> This I understood, but the binding would be exactly the same, no? Kind
> of repeating the question....
> 
Yes, Though the hardware is slightly different, it can be still described 
using the existing qcom,osm-l3.yaml binding and can be added as OneOf the 
compatible enum in the properties.

Just to differentiate the hardware difference with existing L3, separate 
SoC specific binding is added.


> Best regards,
> Krzysztof

