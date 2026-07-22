Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177F293B75
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727503; cv=none; b=eLoRkjTDYFodkreGmb+3IZJmp3Q+g15DGhxgF2nLM0xQZj+LzSl4QOS3YOTc1bLkSjpTjRAyPpcwv1DKi/80hw9ekOGYmuOcrbSvE42EqCeJBskoq2RDz0edAwGmbnTywmZ7NNwTEyqsrTECXMP21EIvd+vJ7ykMj9WSMFZrTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727503; c=relaxed/simple;
	bh=Tn4zmq2o9A4/NAroW01ut1DtvvZJ3tnPOffipBKBe2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLb3rGPXXwq50XeWie6cxfMGL88w41Zn9NS7jd/WCBT2ecO0HsCewifGVLQabXZsIPia/4tUJWFdN0LWuyfrmkkUTaNZrpK1LB8x7Vz5KAPHIf/trcXTmBTh/noRYML2x5He1WkdRQ8PfKU61YLOaBB9yLmxcu54jo6rVZA7fUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqE6IwFh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hJk2/uWh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqE6IwFh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hJk2/uWh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWXON445410
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2l3UPMiH4BMjDVBQXY9WDYnPDDLaNtRsBeyRv5rmKZ4=; b=kqE6IwFhwLt8xaS8
	uFN2hqohGlBHEeDOLzkUJR0/fBwzxJy6qye3Yq715iXb+72l1ZT0fgHjRm/abXxa
	8GAYkV72G4Ow/eqPl9u/Qk1d5CCDkwiM9iJo8CebjECRPzr22eImqmstSRx9Og77
	rOEj9bAnK4zBaDHbFt7d+A3vApPxTB8iB7SX1pmSHzPWUETByQr9XGTeLh26hpPZ
	xlkMSeF9wCVLfehXZa3Fb5zeZpRvJLq6b8OkEkMLE0nfRunxCsP6pu5gPwF8IY1C
	RhthE1UW7kNQlm8IkovmLQM3bkrIEZb+Afb35/J5neUihZ+Q/XZNNgOEGDh5XnY9
	KvLQeA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgg2m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:38:20 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b73b3920so10289450a34.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784727500; x=1785332300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2l3UPMiH4BMjDVBQXY9WDYnPDDLaNtRsBeyRv5rmKZ4=;
        b=hJk2/uWhL/2mKhO52NaoqqpHKTuXDIdtjX8cfC0fmhGBGM5WMrtufXUvwCS4xAsuUK
         GnbaYxrTEiKudNUPCXMTzOuhHXjTeMyUIr+B0bBe8LMmofO+X8X6pT3ZoFehZDg3gj+Z
         WkC4cJnb6c6EQAw+DgWgjmc8RDyGFmDb9ShO8F9s/XAzuMTxyp5xMVFrct6f0a82WAEF
         ZlA8OmQHIOConbsNEKKQUPAHXyZR6d4wuTtmJL7sMWmNaNTrgScc1iT1pbiyv1fhUzN7
         poPStKqZWqo01trBBykdJNnO/2fDKTZ7RVPeYOpBqjR0qTvNzDk1DTY6Yl8oucrKGFTD
         88wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727500; x=1785332300;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2l3UPMiH4BMjDVBQXY9WDYnPDDLaNtRsBeyRv5rmKZ4=;
        b=Yeb0bCG4GoWi1nBjvTVLUpmFbpiieoCxttjytPqjQ2A0MWrPoCFBlyAe1rXmlcgbr1
         R0tTOM3OYFPlP004gKyOQQofYuWbtwTI2Bf5g6m4go+K4xrOlKp96xrXIY1x0lxNgbZ+
         QkhNBuWPsD54o8XFYK+tWZ+eO+4MYPrAg+tfY0fTbhtY76LjJ4r6v5WwB0K+8bHIGpa9
         EjSCkr8TRmea+ScySUygDCIxKmwAiAFqJTqJXnnbMM8lY8HvqoqGPCCvgAIiVr7wmsic
         Js0ACid+opOZ3UD2Z7CGCIPca0eFSkFMXsesLp01fyUG6bMdKdCWGMTSqJ8P54/ihjvN
         3AFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsrSionV4PS3FYHj52YKk1hHs3AsWLlujDAUBJg961dV8GmqXZCFSfHDPtplw+zxcPvY24VEnzmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIBpJBT81UHN5DGXo90O/7dBRJGFNNm81YM7R8jfm6Qkxh4XZ
	F45HN3it4cJsFzD7biWEIYTDhvqS/kgni/tgNzogD8WAUbbSezFxr0/DBQXj3AH+tNpTypEvoaB
	gOMjwXE4J63P6jn9jrVGA32LHo4eXlxyAMBbzqziievwl9KCLTzOWck2aF4+iIA==
X-Gm-Gg: AR+sD12RPdjfoWKWAwmzWkRgLuOIRASZHBzdC7uoRh5Smpk+hK+kBMSI2FWL7R0SOLR
	kXTppxOYya5tdhunyBuNtjyO4X9Td94pADtD2t6bGjG1hIopE3xv9YeMsJDjGj4q36/QU3gCH5E
	603tGZrrz4kaZVXU7k/8sja9+WtuWIsvRJygf9pnjWdjVErDY1O/1Dj3JKyzj5NEdkToGAcySwf
	Ymqa+bFypVOdkyvc7ctn+pDByVmu6DdDr0HEDqkRz6isYLhDSxI6o36ex1ole4MTGP8Ibl+BxW4
	r6Fc1byko3HnClUclYm6X1512OvMgHmZJjYfIflXuOBsuAEgzYVE4oRWpUQaQrYI92C8nLDiI94
	OzCyPEn292DJrhVowHpcytXczozru4fIp
X-Received: by 2002:a05:6830:8387:b0:7e9:b4d0:53ac with SMTP id 46e09a7af769-7eda4d479b2mr11916563a34.29.1784727500103;
        Wed, 22 Jul 2026 06:38:20 -0700 (PDT)
X-Received: by 2002:a05:6830:8387:b0:7e9:b4d0:53ac with SMTP id 46e09a7af769-7eda4d479b2mr11916547a34.29.1784727499674;
        Wed, 22 Jul 2026 06:38:19 -0700 (PDT)
Received: from [192.168.1.11] ([106.222.235.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db292esm1359458a34.6.2026.07.22.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:38:19 -0700 (PDT)
Message-ID: <f3864ed8-34bb-42e2-a821-ac2d1a653076@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 19:08:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-1-99620e07f505@oss.qualcomm.com>
 <20260722-active-kangaroo-of-order-ebb28f@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260722-active-kangaroo-of-order-ebb28f@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a60c7cc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=/HV6WY1oXUpe+KOgORLkYw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=NFQhSzq1V_q7mLtt_zYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: uhHeOKdNm9PGDEnrDumyE6P5SK0SdQVc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMiBTYWx0ZWRfX5xt9OIGi5GDs
 eaS1xdOyHdH3vg4dRzSCMU4BLY5qQu5Pcc0/e0HayDwwHgfI7Mif/UF3BsTW2Dnf7x7aQR6Ax4v
 QoUaewptoMFzozSkH1lIEMiOYauov18=
X-Proofpoint-ORIG-GUID: uhHeOKdNm9PGDEnrDumyE6P5SK0SdQVc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMiBTYWx0ZWRfX7ObhfRXa878u
 2PDwPbujXu9ehY+apdSOwK5xbw4rswqSlPlZx3cP+V4yc6wYElqnp/T01Iv0SH3HHIN3WK8u3/w
 WL+gAfDG3tKbUO5A3qpH0Hj+aDtLDXNPDLBv3N/U1SOMm72xfnizZHX2FvVDDdIQ9lpF/v/axdX
 qHbxo2czFU60VRZE3KoBbXS/mu/sEXvf9qCEtbhDh4Quv0SxUj8wftPPqMROjId+0sBKXRSpFiY
 +w1nC8uk9gcluiOdb10SVJOieEubwUa05gHzE492UM/Y2pASK1H4SOQzs+69Cgsgn8/1bPSObGx
 +ot+iKWRDUuL7suXD88eC+1d/Myzce15gEdzP5RjnFnsUaYKO3keT3vz+mq28oefh+WJJ8Wf/rT
 KLEXS0j1zxASL6FH/sOExGjKnQOVpQRbqjPbt5qAaqdNmM4+QugMJpJyXKjcYLFlrzZTnRopS0q
 kdWV6RBjuptyBW6P6Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220132



On 7/22/2026 12:36 PM, Krzysztof Kozlowski wrote:
> On Tue, Jul 21, 2026 at 11:58:58AM +0530, Gaurav Kohli wrote:
>> Document the optional #cooling-cells property for Qualcomm PAS
>> remoteproc nodes so they can be used as thermal cooling devices via
>> the QMI Thermal Mitigation Device (TMD) interface.
>>
>> Qualcomm remote processors expose TMD endpoints that support thermal
>> throttling through firmware. The cooling-device specifier uses 3 cells:
>>
>>    <&phandle device_id min_state max_state>
>>
>> where device_id selects the TMD endpoint (for example PA, modem, or
>> CDSP software mitigation), with constants defined in:
>> include/dt-bindings/thermal/qcom,qmi-tmd.h
>>
>> Example usage in a thermal zone:
>>
>>    cooling-maps {
>>        map0 {
>>            trip = <&cpu_alert>;
>>            cooling-device = <&remoteproc_cdsp
>>                             QCOM_TMD_CDSP_SW
>>                             0 THERMAL_NO_LIMIT>;
>>        };
>>    };
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
>>   MAINTAINERS                                          |  1 +
>>   include/dt-bindings/thermal/qcom,qmi-tmd.h           | 20 ++++++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> index 11faf655f530..39e79a1c1079 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -77,6 +77,15 @@ properties:
>>         channels and devices related to the ADSP.
>>       unevaluatedProperties: false
>>   
>> +  '#cooling-cells':
>> +    description: |
>> +      Cooling device with three cells:
>> +        Cell 0: Cooling device id as defined in
>> +                include/dt-bindings/thermal/qcom,qmi-tmd.h
>> +        Cell 1: Minimum cooling state
>> +        Cell 2: Maximum cooling state
>> +    const: 3
>> +
>>     glink-edge:
>>       $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>       description:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dcffe9fc54f6..2d4d19201aec 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
>>   F:	include/dt-bindings/arm/qcom,ids.h
>>   F:	include/dt-bindings/firmware/qcom,scm.h
>>   F:	include/dt-bindings/soc/qcom*
>> +F:	include/dt-bindings/thermal/qcom,qmi-tmd.h
>>   F:	include/linux/firmware/qcom
>>   F:	include/linux/soc/qcom/
>>   F:	include/soc/qcom/
>> diff --git a/include/dt-bindings/thermal/qcom,qmi-tmd.h b/include/dt-bindings/thermal/qcom,qmi-tmd.h
> 
> Filename must match compatible. There are no qcom,qmi-tmd or qcom,.*tmd
> or qcom,.*qmi compatibles.
> 
> Which device is providing this ABI? PAS?

thanks for review.
Yes, this belongs under PAS. Should i rename the file to pas?

> 
> Best regards,
> Krzysztof
> 

