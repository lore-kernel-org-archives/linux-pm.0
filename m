Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF434EF03
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646395; cv=none; b=HajrTn4oV343pqMYx2dBa7CjzfU53MYUdlDOXEV1O4APzKBrK7uYPhiCZGxuWqpwtOvwOVLkkQA8NnVDQ/nii6Usu6lRQmMs1IyrZ8clyTWIjuMPGutariX0occ2ViraLxvbPDHJSq2QvUAZuVCa8ctWZOGiIF/but3zCo5IwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646395; c=relaxed/simple;
	bh=uHYgmmzfU5Zao5BII+0huGKvDzXccFTVTUM9nfmQBVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPZbjr4FcRKt9qxaoK0PeI2jgBPsxUokOBgHb4T/LUySDyEaaf87lMgDigKwDDerkGoEtmWXwPV9OERtNBENmCk2pEhsVhaF9iGxRavt/W+aMJCQeTU+8ci3vlegOGFvSOEOno/xZRMQAd1vWohsLkNn9ntsZfMxskuLejL7bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hg9KE2Dl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tf2beJTl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hg9KE2Dl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tf2beJTl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64b0e1066826
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vK7mvmous20WAUDAVlmQwFXMhJJ4sYSgW0kW2NqSHEc=; b=hg9KE2DlZnWM4V4B
	03uqfMW4hdvpJ5kP3+jyYi7xNS0M5mR8TE6rJzIVXM5CFu9D1Vp6BNi98HktG9MM
	8lidDftHtwrYWmaBLnQpWVqmQ0oAbX+kZgVdX0yA+diRHFwK6L6XpwV2art7Wzll
	URQMqQF+dsoeegLv8/0dJWPJ6R8sON0muGMIMyl+vkSFrAiDhe0lTUVUhQ8TLN14
	ufYH0JBZpje4+qH4/burppLC5lSMBbcQkEXfAXY8NpaGbyYrE9l5sxV0pLI3+/1+
	I39Hay+3bf1nbKEToJuaqrSgiC874ja1qSwXgD+sHNN+gAqKsEsH86kBcVTAc9zX
	9uYiLg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027cn40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 07:33:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aebfa0af7dso274412055ad.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773646392; x=1774251192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK7mvmous20WAUDAVlmQwFXMhJJ4sYSgW0kW2NqSHEc=;
        b=Tf2beJTlHdMtKJcd1WNkjZoYISIHSd4RNZ3yTIL0Xr6G/bLswKDtlamtag4MIgzxGG
         Tusn3jJFjPq6fELuHeq24khsG6ycI90xxgV191HvXR39hq4eStqpYelpdy/01EIS35qr
         fv0fUw2pHQJhPafvdLS/klgPv0T9Wi/3mHvK1l6F4eRMbuch+Y0wCiksIeudpjtuXIld
         EjNoK/Ssunke3XTK5VR4vGXsLBoT83mFEDy2IwL7xDl1swllWqOoikWMVQKxfvXBoABS
         oJCOEWmyVHd5wxInnaY3GmKWX8LjXTD2u1IKBRm7eBK2Cs600Ja2YbYTJnjnQkhUVadg
         RQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646392; x=1774251192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK7mvmous20WAUDAVlmQwFXMhJJ4sYSgW0kW2NqSHEc=;
        b=e+pArTdCRzO3Sx278JZ5zlAjA3Xu0NxPFzg285EEa17R33sczuIRNb2861vYauDKbh
         IBu93wAzQGcFSBCmD238K1lWL+IUUHoxKVP4l7oRXJm3kJj43HlbGxKPGFaY/lZbHuue
         PHBFwPB/o/GcTY+TaOh3q/1Okdo4q5oPxrADAmgNR7LBxCiwLKrVFvOXkDa01GoxT5fw
         giSR/4MMGdCHaGOIWwqslU2JIh3axu7zvOx9hD8NKBgRHjKEhzDHXtOeHOaEC9LIc3ix
         NmotFAlKwBAWODleHdLR6ZbBBNv+hBBXhSSg4DZxFvvlW+k75k4xzwfnCZCmvuV9icNL
         x8VA==
X-Forwarded-Encrypted: i=1; AJvYcCUFZhs8SSMAAn7Q6NT4hIwBKabn3lkEK9R9LyaVTJDbtvVkj9OV7rXPmPeoc4/HzNcB+Jg16z7fpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvASHOxdSNPlTGtdJ3bwrNN1cIQPDTJIv5Vivs1hHOCEcVfNzR
	eWmQtVIuWzXXa4MldjiqUxcIa7z2uEWo94xLe/tNo3ei1L4LYkUr1Pq8oyHhUdPB5R5eKT5pWbW
	318dWRE4YUXFkERBcPVOYUNAmVygpBC4Iwf0igCS62WRtOSuuvpTfT/7VCdoDTiqVEYyRtQ==
X-Gm-Gg: ATEYQzxl5PH/fxraoWFrfqIq1U3NvBzRuXHu9K6agnssQpbxzePEgJkJWsVXjEpsPAH
	73lsyYeJ9lLeh2TF5W4/X/RuXG0hC8dnHJdtwknxnOiDd4YgZ6sPHiHypy7t0lLU9fqZb4eOwNJ
	GhCivd6KVAb7t4uGGeO+nB7KRkL9tZanqOceLLHfFeutEdc4oum5u3CL4/2/gvjY+xXDDaSx1xe
	FL4bLNiGwI0GlAqsCvIbL0yBTASIYP+fQs9YJiNs+1r4JgIhs9YbQJmQZjEIGIk1pk44WMKb1in
	BoIPu4Q3TCNTjS7Cv3z818Og30tb45eleQpiM78I1CD1jqXD3wGXGAJaEsuVfHsuTRhS4rTbLh6
	IBTSdty0FsdoTvfLLTNNHveRI2ziLxreJ6EGJar4RA/retXvHyx4=
X-Received: by 2002:a17:903:19d0:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2aecab22c09mr140858895ad.30.1773646392246;
        Mon, 16 Mar 2026 00:33:12 -0700 (PDT)
X-Received: by 2002:a17:903:19d0:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2aecab22c09mr140858585ad.30.1773646391803;
        Mon, 16 Mar 2026 00:33:11 -0700 (PDT)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece627683sm94854595ad.32.2026.03.16.00.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 00:33:11 -0700 (PDT)
Message-ID: <c235ff5a-3a9f-4f97-b7b9-d6a95a68e393@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 13:03:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Enable TSENS and thermal
 zones
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aastha.pandey@oss.qualcomm.com,
        dipa.mantre@oss.qualcomm.com,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
 <20260313-sm8750_tsens-v1-2-250fcc3794a2@oss.qualcomm.com>
 <20260314-accurate-curassow-of-acumen-c05e67@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260314-accurate-curassow-of-acumen-c05e67@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MLzEJ-CvbI67g7UP4bPR_6HMGveG6nc5
X-Proofpoint-ORIG-GUID: MLzEJ-CvbI67g7UP4bPR_6HMGveG6nc5
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7b239 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2Jp1USYG6wLNhKp0wP4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1NiBTYWx0ZWRfX4ime70NVQTNs
 SeXPSAhjXFxDpDmv+bIue1VHwGj/bZqX8pFW34Lttv5UDs19c+L6y4QzCcdELzs5XnFZBcJmIpt
 M/Q0EsWTtGRLslUfjeAort4PuxS7E0HYW08fZpcW1P5r00RO2jnvH9IMsZKhHuVjE02KbSX023g
 u9ta1/UzrXEpwnCJTmm2RSSwvPT9BJkJtgCbZwZ7xDPXd8jlLM+0DAe3LBgFqagKeikbAQcGm5p
 mqhyWmGc5osvtXTxxYwDucf9PK4DHKLCeEwNKT8Q/cENoERDCcnAbRISB6F7JYyX660Gp7uK57X
 O6d3MiZR3LReNMAslwH+r0YBNvekJBVcNuqKt5GU8ffvNM8BPOmt7ZP36zM8bdllJwMslTm700j
 1pgVTKWjqAIIduIEgpiccr+TKtY0/YnKiYpXAPoQ9MXLpxCbsCcR8P50mf6isN2kWuIlwgHEV4A
 2Qg/DUIfAh0p03EN1XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160056



On 3/14/2026 4:01 PM, Krzysztof Kozlowski wrote:
> On Fri, Mar 13, 2026 at 04:04:18PM +0530, Gaurav Kohli wrote:
>> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>>
>> The sm8750 includes four TSENS instances, with a total of 47 thermal
>> sensors distributed across various locations on the SoC.
>>
>> The TSENS max/reset threshold is configured to 130°C in the hardware.
>> Enable all TSENS instances, and define the thermal zones with a hot trip
>> at 120°C and critical trip at 125°C.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 897 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 897 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index f56b1f889b85..db2a97cb228d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -20,6 +20,7 @@
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -5457,6 +5458,902 @@ compute-cb@14 {
>>   				};
>>   			};
>>   		};
>> +
>> +		tsens0: thermal-sensor@c228000 {
> 
> Please read carefully DTS coding style before posting patches. Actually,
> read also Linux kernel coding style as well.
> 

Thanks Krzysztof for review.

Can i use temperature-sensor instead of thermal-sensor as per 
generic-names-recommendation ?

> Best regards,
> Krzysztof
> 

