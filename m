Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3603AEF2E
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862673; cv=none; b=dw93n+Oks13M7J14cw7E3O1tP2gaF4cUBAgJpkh5I8t3p4rrXP42GcqjLsHcDUcIY94cjiad7nlPIMyK4XUrhVSZPFRuKGznJgh7Hr/jgXD4gNq+2pMXbvz1HMJWDc/b5iy8mZzww5f2FcLy51BrkpSYt/KFbMznAXlHtnDcVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862673; c=relaxed/simple;
	bh=8FQXuUJcpQtjfEVJtChfXvc2WhQ4oxNz4YnKC3fcVzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJUU74YJPyfGTYd7oZyF7xVmsXFP6J5TomCyIX1RSZQVx/oHKg78IKqdQhWGBgZukEU7+VeDO1DTLXqjMznU+WpZQlPb7IvlvDfptzVz0rZCoFPwFlr4tXi2nLcQvZW4X7MpBZLiFkSjC43W8BaL0wiV+Ds8uKFpC/RnL6vX2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0A7UMcQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLFhXUWt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0A7UMcQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLFhXUWt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U4IUGO103746
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8FQXuUJcpQtjfEVJtChfXvc2WhQ4oxNz4YnKC3fcVzA=; b=W0A7UMcQUcZUv9aq
	AmNzC5rDL+GDEARwmB09E08qB+h0snZhmcJjHjPAo/7oRj2pTpgytzz40wDAZzyh
	0E/2UgGa8tS7CtYDrlJD65vootkyH8+x5dG4Du+OOA6/ZdyCdet3pn0dKCN/c9nN
	WBN+Q7mrjwjeFIAr9V1JmVQxTrP9cOHv6cZZZPns1uhWziOtoaI+iIl8lTZdhCon
	EL5sBdNWzSS7U5RHcuRTsBGMx+N1xPrm8vC6lzKE0/ZmkdGXUT5Tx9H/OKFOzzG6
	RLvH4UfLG92KbAD6jPLvtXo1Z1Z69I0wHiYlpIzZdBaaQX/JhTKjkk5c/0ARPUJK
	NXuNxg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67715emv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:24:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b86b756c4so11221431cf.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774862670; x=1775467470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FQXuUJcpQtjfEVJtChfXvc2WhQ4oxNz4YnKC3fcVzA=;
        b=fLFhXUWtqiHKWy+V+zgc0cxlOw1rdIstZF2YAxMNfg1eSCM0pwyuPlCj/myFuXpAhM
         6mwZnHoYJcbTtNvgh3ncpT4dEqI0xUEJWriGdhlT/TmanR/YljHfkyLqGkYiWrThQQFP
         xLCJc+OAu7hw3GLYw6vVLAfclTCIkY4MAhDMnhJYfVkZvnyLITjGniwUnPBLKWfCcsoF
         RyOz0JvG9FqB+pN/n6PCfDTnsz+gO/d0fOa/FOT4K4l91k1oo9HbXwOMVMb24Iz9YfY5
         jLwBco5/sLRRhGF64BlsAPPodVoDNlj13As7fFyHuARHjk82N/PLEiXnAscnF3Ds1Er/
         EXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862670; x=1775467470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FQXuUJcpQtjfEVJtChfXvc2WhQ4oxNz4YnKC3fcVzA=;
        b=tNmxaAnIxkvKo6UIQRLtQZ24DlJl7uFA1fGGvYunjpJggPZyRFTi2UbaUPyOEOBLvs
         MJK0KRiuh0RbOCrShkBNvk2RYTrGIEqL49dvvmfYZ3fG59veY6caae5ULD4mm3hChPUL
         rIzWx5j5jBYx8oNkWG7aEFwXdRf5/g6u6z97skkXFRTu/H/4FYPbTN5uLONrC3nH1KNQ
         o5ChYBD885Y3Z3pQoVHNnPwedoiBlJH7lRxpLpfqSxT1kzCxlbeQ3hsm++YV/NFVv6jE
         sZhOtQQdEWtk0g1au1+27Nb/iv7zkAO5UB375S3Y5MbUy8exoG9ZXg+piUvMoUzdffOy
         kELQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8w/nyuOk7cv6IqSleJQQk2p4UPY9rn+0e+Cnx4zxjc+nCmBLDDSCA2Rd9Ho1yAiKLcMeQ5xbT6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtH4uuANUWMjZX1NyUhEgBDVI/UC1nzhIEoaWQn3irRL2W5e4
	2w1elNJo5fsDsGSAjz4sKE8pTMPJzOTKSQXHuDDJNPDJsak+qqTswAryN1cbQBiWy57a+DMMq9T
	0hPJ454V3/STPYUYOdt3nYbyxKM8l9Ycp5isWVtIVYZuuzFoN82IAKSwQNOPCQg==
X-Gm-Gg: ATEYQzxq479NvJllFPt7ac0GynZqSQgF4dLqf+5EbcWkamULfipatebcKLvx2EqexRI
	rAcbatpeA50ykpOfDWMprh3Sk4bgofXyZSDIWeQ9UTHzFrva3D7FctTmSVWqbVaPngpUqADAkbT
	JzKPpCeZ2wRbodt3GHdGdqzql5lXLdDT1eRmEe0Bl8NDq1cKYJJQe5spLwW1jk/7yVSba7S+r7M
	bSaLvkfw1x/+ESIhTfICtoyxIhoO2Xvg4UrLkSIFRrsxIBvtfzPc90wzTS/IDtQpK5ZjN+RUZp0
	nTEuNQBCFUsIoFvCi2Jn8N7tOBKqmJvv+0xQp1HtgFr5jfD7Py/zlUzht9lvOltnDjGtbnUtJBw
	7Y5Tis04x1d4WDPifZStaMb1X5LWBJNf+BkO7m4HJOeVh8AmB91hngH+GI/eeKDGM5zrDJoNbd0
	/dM8k=
X-Received: by 2002:ac8:7c53:0:b0:509:47e2:9df3 with SMTP id d75a77b69052e-50ba3819907mr122971881cf.1.1774862670338;
        Mon, 30 Mar 2026 02:24:30 -0700 (PDT)
X-Received: by 2002:ac8:7c53:0:b0:509:47e2:9df3 with SMTP id d75a77b69052e-50ba3819907mr122971711cf.1.1774862669917;
        Mon, 30 Mar 2026 02:24:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae24151sm263968066b.8.2026.03.30.02.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 02:24:29 -0700 (PDT)
Message-ID: <5de59ab0-4249-4396-85c9-e8501bfcc35b@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 11:24:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: power: qcom-rpmpd: Split MSM8953 and
 SDM632
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold
 <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <20260327-sdm632-rpmpd-v1-1-6098dc997d66@mainlining.org>
 <ocrzwxmr256h3ef7ifwx3z6jgtzubiha3forfi7nao6gakb6wu@recertxxhlip>
 <39a320e472ddc6d44c950a995b577e77@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <39a320e472ddc6d44c950a995b577e77@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KNX-y-kmV_7jFQjmpvNhOBBG_Vw01oHx
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca414f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OuZLqq7tAAAA:8 a=svdJbqrqvjlJHIucFT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: KNX-y-kmV_7jFQjmpvNhOBBG_Vw01oHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3MyBTYWx0ZWRfX9o/9r6zhv6pT
 nBe04D3QOlfESBwUrxpcls1F4TFBhRoQr4qD1blIGRTfdeGSJMvPO2U9WmBS1P7VhokpsvHbBYh
 VT+1sS91tEVRDXTpSPj8Gt48cXuLa2avoTfGPa5VszNRsJgfyFWewVptuGH3aAWKtbdkghwaZdO
 DA0x2woxnBhME2Bdd0CX3wWzvSjjWbliD4woneP/nmkU2lpvqtuZSWlHBlcDV2v+GSOv+s28ohg
 syFo5eIRL1lC2Yo9yOhEJ/0RGeJNE6U/ZfRyrEVKo7oS0XIP9pnTPnFGPyr8j2JyUMIslwg2Vmw
 lMH2FMkzamw+EVcMz0jgaY5V6yzzNcz9mqxpSu8t0plD5xnY2RNQeywgmRNf+pAi8/5E6S8bE5j
 /y30gMG3z0+zN+ppoExjWLiloOidnOdIukGwAipsrTe/siWcVq6Sdlm+sS5nXoK560sB/ge4wO4
 6VVKr0FNYJ6zZ4QXZEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300073

On 3/28/26 9:22 AM, Barnabás Czémán wrote:
> On 2026-03-27 21:26, Dmitry Baryshkov wrote:
>> On Fri, Mar 27, 2026 at 09:11:43PM +0100, Barnabás Czémán wrote:
>>> Remove modem related bindings from MSM8953 rpmpd because MSM8953 MSS
>>> is using mss-supply as a regulator usually it is pm8953_s1.
>>> Split SDM632 bindings from MSM8953 because SDM632 is using mss-supply
>>> as a pm domain.
>>>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
>>>  include/dt-bindings/power/qcom-rpmpd.h               | 20 +++++++++++++-------
>>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> index 8174ceeab572..659936d6a46e 100644
>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>> @@ -48,6 +48,7 @@ properties:
>>>            - qcom,sc7280-rpmhpd
>>>            - qcom,sc8180x-rpmhpd
>>>            - qcom,sc8280xp-rpmhpd
>>> +          - qcom,sdm632-rpmpd
>>>            - qcom,sdm660-rpmpd
>>>            - qcom,sdm670-rpmhpd
>>>            - qcom,sdm845-rpmhpd
>>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>>> index 4371ac941f29..2d82434b993c 100644
>>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>>> @@ -84,13 +84,11 @@
>>>  #define QM215_VDDMX_AO        MSM8917_VDDMX_AO
>>>
>>>  /* MSM8953 Power Domain Indexes */
>>> -#define MSM8953_VDDMD        0
>>> -#define MSM8953_VDDMD_AO    1
>>> -#define MSM8953_VDDCX        2
>>> -#define MSM8953_VDDCX_AO    3
>>> -#define MSM8953_VDDCX_VFL    4
>>> -#define MSM8953_VDDMX        5
>>> -#define MSM8953_VDDMX_AO    6
>>> +#define MSM8953_VDDCX        RPMPD_VDDCX
>>> +#define MSM8953_VDDCX_AO    RPMPD_VDDCX_AO
>>> +#define MSM8953_VDDCX_VFL    RPMPD_VDDCX_VFL
>>> +#define MSM8953_VDDMX        RPMPD_VDDMX
>>> +#define MSM8953_VDDMX_AO    RPMPD_VDDMX_AO
>>
>> Well, no. This is an ABI break. It will make previous DT to stop from
>> working. You can drop unused indices, but you can not change the values
>> used by the existing domains.
> Do these indices never can be changed?

Yes, values in include/dt-bindings are supposed to never change

Here you're e.g. changing the "msm8953 domain 0" from translating into
VDDMD to translating into VDDCX (because RPMPD_VDDCX is defined as 0)

Some other older platforms were converted to use these macros, because
the indices happened to match

Konrad
