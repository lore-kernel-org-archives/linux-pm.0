Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118725B087
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330147; cv=none; b=jHcjquQtorDIGZQw+0WFOkx8pm+yc5WxVO+p4Zs4u9F2ByZCt68uXwJ1OJtFZ6Kycmk+K3fZQPAbTEwt4RuYVdp+C0wKm4rD5pv44pcNzhYjRKgcKurVPT/hh81nukkAVYqv3ikCyISzF1YS8oduMQFBBxzvbgKEZxqN/Q/zFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330147; c=relaxed/simple;
	bh=yoXwSvtLEDY7Y30JRpqeWxPNYwIKQ2YSbo8KvTplCso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOfLTngEKoWybvoJfY03sxSu7XIaahMm/FPQLZM660RF9fu0iXXl0AejQoJ8mBrBoG6DH640RmEZPqOrOD9M+wZlIGub3NqLOWWQZ6XQmHJqqdgSgZOxP1o2vpOaze9p1CG8bEyJenNCwX/vew0M6Vb++u8Y6Khyiz9UcPwtnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBYf/PsU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UI+2F1KR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBYf/PsU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UI+2F1KR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmB9g2645494
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3BsDa+bgM83S7/700MDK2LAZB8VC8f+XFusC3BhHyk=; b=aBYf/PsUeoBsmUm3
	QuAHkEKYWLA1441AxVar0asL8VLsCC0J7cazWEFF5aVXTK+LZ9tWb75Q5rQA0h7F
	oA+03NZeHNrGHmSmbanLNaE1y9ObDI5gttmPf1Box3bnpN0i99SLFuzB1fUO+QBu
	Xd8SG6FNwpmBX2Y3Z1BFy2l4HfA0MAQuepoF6Pu0CafY8f9t2EBaNQZkXe7beE8/
	xkafszO6JDAizYRBuMX9UTWhFhJADN8qA2H2mbv8CUIT3jGdsx2k403Y7FVwCIjf
	lY6MhXMeZdlrNLOj2nXeG8IXYH7OIzP0IvoqHKQpmKoVQ4gMb6yS6h/pDjzReTEz
	J6IR8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecbavw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:35:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1100533a91.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787330144; x=1787934944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3BsDa+bgM83S7/700MDK2LAZB8VC8f+XFusC3BhHyk=;
        b=UI+2F1KR86TREUNGiwzEDe96GepiNFsNLa7dG0sU4d1R5XZ6ZqCchTdIPEyNY/uDzn
         p4ThPMcSqbruzZqQfIje4VtPSWoS4RtCOaoks/U/B2atdUNvVHOl45iJVpxz7KcPHzMc
         KPi1qPSOD1Elh3mGLK7/u6EcppoCDwAxs+rRst8WxgrUY0rwr8U+sjM1nfZGjDMeiKjc
         RKqEmvhw00AMjsK7Zu8IfclUuJgFg8DTdm7TBVMDdmUgannjTrHEp28FY9WmqrY+nMjz
         Fkb6d7zi3iM4UhOShoz5heLVIOsY6i+k2cIEF22WQJb9l1lqQAfbcXCzHnUcQ5A95lqA
         XOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787330144; x=1787934944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3BsDa+bgM83S7/700MDK2LAZB8VC8f+XFusC3BhHyk=;
        b=qkdE80kB4ZfToDtre96Fn0PTqjeBVaMo79rcvKIcRuiKCKiMS/iTvY3N2Mnc1Awnp6
         ZWsbwn0O0QaNvEHofsIzGGsXz3APXkLxHA8KU1Z2QMKxtKZSz0gpzAVmJiYry2EN40Sv
         RYDuGJpD3IbKToPyvwCxUgCXukP7h1MFl6onZ1uRqhRRkLtlFJMTMrQjHQNimV+d9Cwk
         oNT1j6gUc2MF4VoGRjPTOpShCz1yt2l9S59RGhi33nitWc90DgNpbz0cSBg4cQXH3c6q
         XkSu6eMKjd4hN9pNFAEBaX3jI6HpzJMHe7Vt+I6WVAp87G1XzGQ+FBGOzsGlJyzVrzLk
         gfAA==
X-Forwarded-Encrypted: i=1; AHgh+RqVRz+oXn6oFsutBlZEUu4mW0zjZ2U42YbKYhbgJV0AWnq2JJC5FpCbDBBCRxb3oIJIuJr836aypA==@vger.kernel.org
X-Gm-Message-State: AFuF++mtu8/eRBNmQe7eFzficj/39oMCW7KJiuM6LmI05nJtwDyTScEK
	auk3bpuB7N2S9n5XPRJQcR0I7g3w8A+xljtKHmZ1nQMrcGylmqH9ITR0lfvCQLetDP3hXIjCrSA
	HvFxsdJvJ82VwAKCs20R3noIvs8mJ3SCNml/E6AHzXR8qEGq98yDkYgKSkrpZ6Q==
X-Gm-Gg: AR+sD13X2vJTURKQckDdU3tNIXeSkMNoUycMPnQMIbOrHzolDz+fdq6NerMMopnr7nk
	Gz9Spi89ExryTDm4gxbHlKsTqNtOYQx49kpr63HkzFHoyHnGkaqj3oVX1mGb+Nwr0lVHZeHMtA3
	Ne1BSeVtlmHaN8Q02zDCoN5+KYv7JvJdjElvN+RvHS9fBiqNnkfg/hCg4BaUr8fb7pYRdFuzWJ9
	ituwMELKBxyIUHX/3dfSD9plDC4OFLGsYqrwIMhNdpRGVl0oE7OBgksaE+CH5wla1j12uJ+ZpZ5
	FUpYxJNMO06Otn/doZCsmxiJH1lylCn2iYV1WWHHskjIBQMAmL2lb3DqYR2NB6i12F3QVQM8qM4
	cJHohuQ7nQsg2UKOmEpv68wKE/HbIpq4j
X-Received: by 2002:a17:90b:5303:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-395c354cbffmr14302505a91.3.1787330144110;
        Fri, 21 Aug 2026 09:35:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5303:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-395c354cbffmr14302327a91.3.1787330143403;
        Fri, 21 Aug 2026 09:35:43 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.20.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c194d2sm3737725a91.15.2026.08.21.09.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 09:35:43 -0700 (PDT)
Message-ID: <55d15218-d812-4b4f-a3a8-ebe02ee26f2b@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 22:05:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-10-5e0ede4a0c72@oss.qualcomm.com>
 <20260813-glorious-secret-mantis-dcc083@quoll>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260813-glorious-secret-mantis-dcc083@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfX+shEmnTEK/XC
 Ft92Lgj6tjxEjHWVXv+rit3j92ww8fEVkpfbBoihoIUUIn1ELiB15lBl01FYT3u+wyNn4Hu1TBM
 K6UF9pZoCiY0fKJIzVMe+BTMMwlNwlzsYbq6Bx1j1i4qqDlNvFvNReGasi+ZKRcGRewzJg3QF8g
 pTxjuCf0gXcYcOxjjjirCcG/2CBayuCSjCAIMYF6k9h/sfnmvmF2Uld/51Ol3QCgZptf7rWdGbp
 lOrXyuf6W+YI1jgAK0h10isvM9OdNAOpDCVOJMtbcHg6WjMapVtU0RFbYqyQt3W3FQ13YqWRMwq
 Znts7CUxE9LVrms6KnuMm9jdyr0NNfsRrFtDgKdvkU0M9jX3XNdOpuXi3n1TGAeCmDnl3PDnQ2x
 GGzDiEF9DMEhyA3uLl7OVXePXpyoLkN0ba5u1DOesqvMsz8WREzaj107wPCUhQRtJ0JhjZc3Ke6
 otKn8dLurC8s8r5lYTw==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a887e61 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=+KmVXPE0btiop/5qwQKk0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=tqvfEU5OP8eIFZPyU8cA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: DHKlwFATTqxv8FCjVAxXrSlRFnNsRfdo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfX4AEEOnilAAFF
 ufbmnuFtIXk6houg/0nhEdUHmW9n24Rosyn6sICfFDGX5o3iyscrsm0qKFTov72qY6RXJe3OLNa
 HUe2E3zSF2nFUcavjlAbMT4rqwRifhM=
X-Proofpoint-ORIG-GUID: DHKlwFATTqxv8FCjVAxXrSlRFnNsRfdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210130


On 8/13/2026 3:10 PM, Krzysztof Kozlowski wrote:
> On Sun, Aug 09, 2026 at 12:57:09PM +0530, Hardeep Sharma wrote:
>> Add the device tree binding and clock/reset IDs for the global clock
>> controller (GCC) on the Qualcomm Kuno SoC so its device trees can
>> describe the GCC block and reference the clocks and resets it provides.
> Almost each of your bindings commit has different style. I would assume
> this you would write once and copy-paste.

Thanks for review.

Corrected in v3 : 
https://lore.kernel.org/all/20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   | 56 +++++++++++++
>>   include/dt-bindings/clock/qcom,kuno-gcc.h          | 95 ++++++++++++++++++++++
>>   2 files changed, 151 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
>> new file mode 100644
>> index 000000000000..ff01ff31c2e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,kuno-gcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller on Kuno
>> +
>> +maintainers:
>> +  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module provides the clocks and resets on Kuno.
>> +
>> +  See also: include/dt-bindings/clock/qcom,kuno-gcc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,kuno-gcc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Board active-only XO source
>> +      - description: Sleep clock source
>> +      - description: PCIe pipe clock source
>> +
>> +  power-domains:
>> +    items:
>> +      - description: CX domain
>> +
>> +required:
>> +  - compatible
>> +  - clocks
> Not a power domain provider? Then it should not be allowed or explain
> oddities in the commit msg.

Thanks for review.

Apologies.
The GCC does host GDSCs, so it genuinely is a power-domain provider.
Rather than disallowing #power-domain-cells, in v3 I've made it
"required" in qcom,kuno-gcc.yaml and declared #power-domain-cells = <1>
on the SoC gcc node, following qcom,sdx75-gcc.

v3: 
https://lore.kernel.org/all/20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

>
>> +
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
>> +
>> +unevaluatedProperties: false
> Best regards,
> Krzysztof
>
