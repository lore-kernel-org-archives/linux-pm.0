Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3431C3BF7
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539806; cv=none; b=Hf1pj2+LcocMe3pbP9HE2crChKTioeeyzpPdKUviFv0UqAYOYs06dE5fM9qNvNzj5tGGhm9ovPZMQ/94PgkWxp7mIvKYgv2ErBH6Ama0LosYBSjkhy0ip5+GaoOixnGOzZd9zYRMNM4FchsXAS5VJPXr6uDrM8lF6/7HrG88548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539806; c=relaxed/simple;
	bh=3+brzLFi86RviwLdsYj3RdJNJyzzfcUNyBJEorZsV4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTU1hTc4afyMQwSQUcsSJkGQ6hOr/uMPH93Vmhro2FwFJGoQscgaAefe8CXhwF4Oc3VoHVoaIoHTfeWcv3jgU5sad121od4bWqvha8CIgFpAEQPc0POD9p9GY0R+RrOLJwShjdP3MkA+P0VTwlgu7LcVWbFmxYyekwdQZPkr8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZpywMdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7HvclOp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZpywMdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7HvclOp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQY9j3402372
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 05:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHE9FIIN0wvEHZEXRmfXycS2gT8ro1pdCXElOWfJl48=; b=gZpywMdIzERHCht/
	zzUvjPP5p6M9oyYR2WXfpiBwVhZ/QyjiYE/V1EFOgRqgljRNCFKi0BlBubw5F6WF
	P/xHoq1QykWpKX16hEakl9RL7cdbLoiNB03Ft8mznsG4mHkhPtal+P47vO4TSXQr
	ZS/a7N+FRZ+ihuomOb6EFPOJIpY4rPM5X4gqqVULV30c0uTt2N955xT3msNIzNxy
	EpdGQqSs8R3BahTpcdnR+P84GRq4Ey3aWOtJZgZ1pCZN3EpcofRBNNU3cd+vc/4/
	UrLgdO2nE0l5FXabtep3FOLm6gKu3sGTGFTJPjyG8gmXcHJXfe445DTb8O6eOaj8
	XMHhYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhs605-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 05:30:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b3544bc7bso63177591cf.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539802; x=1776144602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XHE9FIIN0wvEHZEXRmfXycS2gT8ro1pdCXElOWfJl48=;
        b=P7HvclOppzR2SMJ09yTtOEcCWFbTvrc/b3sVz59SwNpYAb1eVBbWNcA/89ooCbXVcX
         qFinuLy4+s83YPBo2bx3hzEwhL2pUgJBTklcODA8LngLW3+1quAWJ8S2/0L5hwVS4gIn
         HeaoRTahTiPVwgTGw7OOjekAnKqVQHykrJJvePK8IscrEceVQDZN55ONAYK6bsmN0G3p
         eW4NhCM+dS9iYXqktE0qikIe8dLbI66QNrA0tStJLZxN6hIZnu8Y4WjhutJm3n1ygJTB
         QqOkne6eb5QQsCdcTb5cqjAMNZRf5s85fUUmLv/GJSMfDpdBkfiAm8dweJ3TAsnb5j0n
         5dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539802; x=1776144602;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHE9FIIN0wvEHZEXRmfXycS2gT8ro1pdCXElOWfJl48=;
        b=rr0QkAp1Q82tDnVgg+EOzXRrjzJ64AgOoBoHvWRsTTFpxxO8StzjofC8FZwgfI80zp
         Zcx3fNfhzQtb/OqaZYuyyJziXTcmmktV4u28dDgmPVYUAW6I9/j5qO2dXED6B4sWxOj9
         2Q+vNKYph4hmvZf9yrroPQI3WsYJS7l9Wj1wJ3fF/YcHcOJnHmEm0SaYLxRWhYeVy9eY
         awAVto3eqM12FmGOdakaVVhG+tJCWP976TfM+StL6XAlfLErqsW3TGvWiXpXaCbFe8kb
         6PEdFflf89IwqupmeI0C93+vxrniRG8er7QXwRLPjj4i+BYyRccxTRZ2dyYYXsqSkWvm
         oOuA==
X-Forwarded-Encrypted: i=1; AJvYcCW+r3VXLtMiv2nuYCxrIB2+vbaDG/QocH2ZuCnRvzzklfHvPRRP9gW5so6TA/MGvfkyG9PgpU3w0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5s2WydzOhc+JI0ikRTfN0wI8aBzlAGOb+d4bd6h7XtNb44v5
	t8XCKRK3stEczf9XkeRT1O/vWhsIS4SqRISPBT2avbxob4cnTf8Pm4EJjErsA2q5l0VvhyQRulN
	ry5Pp68zbqm3CWTOYa5CFFWFKZQ2Q4b4et5LKJHWzIAd5n2IKjv5X5LJhEMD3Ng==
X-Gm-Gg: AeBDieuc7cCYdiy6s+TYTKmw2aWRXznD6KYds8ObEOW/Ho8cqmVRHJEsf7aq65oooSc
	/+nrgRSLOdBYskcbnYzmDWjQJwmuCGpTRcT1Vhw5acJj6cjm9/PETZEnR3U3+qaa0bG85CRA5vf
	EP5E0Oi6NBWUYI1oCWGbTNxtwDZGXB2V692lQ9Xz5/0kLhiyyf4lyv2mfo2Xkr4Y2gDugT/jIRE
	uQ9AhUFbwDXEYziC1fCTMdaqMd+fbx7Ycu1G/sGBkcX2CgS72XHd/aWC7HFNumBlTTX8ZYxbKPB
	TVzfq+/fbsaroOwYPomQhvoJy0r1QOwSrbu/aCL4FyqffIIWASg0a5JvJA7aW6uL04/llrhd00t
	CO8SGIlGewPYEdjecAgU4bnFe9hQbxeioZFofoNEoWfwyHoom
X-Received: by 2002:ac8:5f09:0:b0:50d:a602:1263 with SMTP id d75a77b69052e-50da6021b8emr10076171cf.63.1775539802126;
        Mon, 06 Apr 2026 22:30:02 -0700 (PDT)
X-Received: by 2002:ac8:5f09:0:b0:50d:a602:1263 with SMTP id d75a77b69052e-50da6021b8emr10075971cf.63.1775539801659;
        Mon, 06 Apr 2026 22:30:01 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm50675357f8f.8.2026.04.06.22.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 22:30:00 -0700 (PDT)
Message-ID: <d87e7890-588b-4195-99d9-c13c22bc408c@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 07:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: idle: Correct node name in the
 example
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org
References: <20260406145104.36472-2-krzysztof.kozlowski@oss.qualcomm.com>
 <177549428295.3420527.14302032860881762505.robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <177549428295.3420527.14302032860881762505.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX6TOWt+x0SVW4
 bR27Aw3fzlXa5ghxEXu3xGxI1JibMh7SLMjYEBLDoWqKyPjf4tGGhT50Ufq2x1s7Rnz42pljBeg
 cUTTIH5FMmVU4Jc7B8xERt/ofBQCu4spL0JEMd2SEzBTvqBwVgtMJJc/g1MphNJ10cvwHWT14C+
 PEgcfFCAsw3XQvnUlDoajZZkSYQRrKiLboSHSYRsiXxPX9c9wkarkjzLky3PP5NYqDuEW8oV1Zf
 +Hxm10M9VbqHKSsHyC2NPs5g08SZ79l+L2uQOGNeqIQcTiFQUC8mzBJHCme+qlr8nx1rjSBjRH6
 XoDVyLNLzE67JH2gn+8GFzgAWJVgUwH8UHIWb79sbU3fR52UqdLvjFArzBKokJB2crRqSWZaqE4
 33+UTNCXiVPvtJodLEfDg+Gjyo6nf55iBOwU0yHjLH/HxHWttLCVfjoBukxMaw+3RFaY9jnOeam
 m8UNLoewb0bQh5d16gw==
X-Proofpoint-GUID: IottzgCyKx1SgknuRjzLcp8ts6tjClWs
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4965a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: IottzgCyKx1SgknuRjzLcp8ts6tjClWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049

On 06/04/2026 18:51, Rob Herring (Arm) wrote:
> 
> On Mon, 06 Apr 2026 16:51:05 +0200, Krzysztof Kozlowski wrote:
>> Thermal bindings expect the node name with all the zones to be named
>> 'thermal-zones' (hyphen instead of underscore) and also DTS coding style
>> is not to use underscores for node names, so adjust the example code.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal-idle.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/thermal-idle.example.dtb: thermal-zones: 'cpu' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml
> 

So using correct name causes the example to be validated and points
issues there. I'll send v2.

Best regards,
Krzysztof
