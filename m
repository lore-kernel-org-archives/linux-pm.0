Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2C3E4C6E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833955; cv=none; b=KyDn1fgLX+/La6+fHMnyXERdWzpeSmaXt28AKlKbDzh3s3UsrkD6LUo7rYiEraUo7YopK1OQ72b/Md1FKeQVCWDJXqWSUkNEfg77kbHc/NFhNJpm/r7CipLR3UbXYWUO1lwacc9sjaXGT1m1wZtG6mdNtfHJWnL9B6wLQy5HYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833955; c=relaxed/simple;
	bh=2KlkGNOF7+OvLv0cTbiSK1wSmJp3z+rBZspm5oF/ITE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqUPSTIQGnmD7o28UXPLXOZhm22fN9lqIHHKQz9FC/1DoLjqdTz11ZynZXffHwosYSRplOH81Oux8qBr/ITLlH2rylohz/xvIdBv3x5Mlpu33IFzPtu1LmwWiVAA2Rgpqgyka2/TvJJn+HCln/97i7LX0JuP0ncOaZ0dkQplCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIdPpKcY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YuhzGJXL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIdPpKcY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YuhzGJXL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5Kb473199802
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ypc5cw+aeh2+Tg52m6j1/NuUMBslXu/qMIh12tt5Eiw=; b=DIdPpKcYHKUcSHCH
	HDORyNMxjlg9kkFh3FyJ42jpvMjAXeN57c2rE6lk6xD2GwgsgFK75UwbLARwJ7F2
	lPw6D88hRbpn0ChQNQXYr9aTTEC5+w1Lw30V8fw5vIXlbGeW3YnulCisIEO/b7Wn
	LxxhIbbQ6aKdgUFL83Ef7PTdTQXp6FzS9rlm4k4yykEIfPX/kbWqBVY20EqtNk7X
	b1xDOTTdKo4qRdHTmdGJL7A7MzyTTwfR1tM4YUbfwL0CfOrBCS+I7cTNZjx/JDIp
	wgL2IhfXAEzpH1oVMWVtgQu0iU9VPVZZvLdVJ2Ty4I0kr5ChzUYEzH4Zfyl0jRWA
	CQRm8w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qtchs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:32:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so5995664a91.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778833953; x=1779438753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ypc5cw+aeh2+Tg52m6j1/NuUMBslXu/qMIh12tt5Eiw=;
        b=YuhzGJXLia2qTwXWJjLvY+5lBS6fdLOh6aTzjWbIMNecx/U9YfiLDo9C9uwEPyjkjJ
         hUotUvbrNfb0Bjbva7QAKZKYUC5OKYwcbWLaHybStkJnfCgigvb4mj/fVA8qUkSS7IDz
         NqecvhYbYSNfJkzHd4yKS+JhnyUZWFTsZMwClv1zW2vweColEhyzu69EuCSk52L4/rUQ
         K/UFwzY3YhogKI4zRq5QIaERPsvDcRB+ITJmkAHHUoS8r/ZpOTgKqVDYiVzwuKckHNpu
         i5vCmGSou7/SyO/mCiH5syDu2wVAssKGfAYjocltU+ZPQ97GROLryfIG4p82Y9dMQNs5
         KcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833953; x=1779438753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ypc5cw+aeh2+Tg52m6j1/NuUMBslXu/qMIh12tt5Eiw=;
        b=j/Q1Q2T18ptjCPXWFDFpL+He+aUXwGJcc3cbUK6GFbWnrou3en/WiiNVGxoX177icQ
         JnY7922RNlH1tN9x5M6lVsisaUjk25ZnhsQ12+CiSEOHWnwEDzfaOV6I++BikMTcdHIn
         ndnnJNcoCKRqPiGNzTjUaFZ1Ux0b2KuDev1X2sRU6DJPRD0RwMk5Fk51EgJLPu5b33sI
         5yQixCoktTyNYG30X/89Sizj5XBsyWpecGhmad1h3R8bmkKecY7RtuaoqoCVUPirvXjs
         QcQf5130iogvQzIqjc01UAzWbz4eXa33UtfXMRqwfnUIncxav6+QdEckz4rz5ioCn8gt
         ocUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IVrN+3rbLh8LSPHmAiR91rKoVpjl1aplXSy+ZxnsGheLuYWxeMJBxkME4VMxWFle2bbCXftoUZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNi3S5/zY3r34tKVizszI0QAOB1Q/7VxmHFMBDswnI/o+bQvBW
	Esgapmg2nslPQTaWI6ttwzVE9m1mDEQGX7DVMMq7habyc6k0KZge9miumwMKcAPcE/3yTnDWtmu
	eQ5vfbJpuYp7L8P6KeoDdeYsSM98b1oU2lunSARvdQlAFIfdETYW9azv8YWDbKw==
X-Gm-Gg: Acq92OGB1R16NIXB2OOB/UitXsBXSepUkP4Gh3WaBdeRFe0adnDlJa9cCvx7z379yV/
	myUFi8CR5sGaIwe1S41ZGiWlhrF9kbh/xV3a690rj+QdQMQGUjsaOIsTnmSLJFXqyjyIS1YvL0w
	VxURzZ+3ATxe/0SoNkQ0hB+js5O1LGzqUHlZGXeHy3Hc7gIzUZdxMW6sajOfJ5lh2NR+jLLtMTr
	ZFY2bgcX5ZmsO0NVN3OxWdXRjik2YnRFraf7aKpPD1Gjyf/t4m2k3EDPDJ5CL1sS3kn/9N5JwKO
	eYmM2/h6bYwVcCyC0IwrO3z/sj4XPqbjZEz9TnXue85XnaoFlIeh/IIl0Sf99gdXhDkbeSRON/w
	D9pCsHVdgIDIMhr7VJ+hIIRXSz5GiZVilQ2HPI8jT5faqJB2k5YkDeQZSTPKQ
X-Received: by 2002:a17:90b:3d0a:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-369518b25cemr3166930a91.2.1778833952400;
        Fri, 15 May 2026 01:32:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3d0a:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-369518b25cemr3166888a91.2.1778833951854;
        Fri, 15 May 2026 01:32:31 -0700 (PDT)
Received: from [10.92.212.183] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695155b2c4sm2001418a91.3.2026.05.15.01.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 01:32:31 -0700 (PDT)
Message-ID: <5ad97e7b-f39e-44cd-b4be-86711a090d01@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:02:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
 <20260501-shikra-cpufreq-scaling-v1-1-c78b95f53b91@oss.qualcomm.com>
 <20260504-fuzzy-wapiti-of-ampleness-d8bc13@quoll>
 <8101e2c8-0593-4325-a701-84f776dd4b0a@oss.qualcomm.com>
 <eebae734-3b03-4848-a728-a29d8a210e57@kernel.org>
 <dfc3039b-c45c-44d3-85c0-0d131bb5e55a@oss.qualcomm.com>
 <27cc44d7-b3d1-4610-8257-4aad4115cd36@kernel.org>
 <e5552777-a449-4640-993f-5cf9bacbda56@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <e5552777-a449-4640-993f-5cf9bacbda56@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a06da21 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=nIfeAKEMkRZjI2vJ8KMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LDfg1AVjIZwba5AF2DT4ovETDLBJJTO3
X-Proofpoint-ORIG-GUID: LDfg1AVjIZwba5AF2DT4ovETDLBJJTO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA4NCBTYWx0ZWRfXwy1b3KrL+CyU
 iH0ia51xbGjZkKowAaA5nUaZNqtrjYkArW250kutEd4g3K+Gqp44sbb+Bv9YiCiSfk4ikNwIjPd
 G3D5L69ssKEf8Qx5SE9iKcEOaQ2mGnAuk6PGe4gMwipqnoRz8XXKLcTVFaVFEmKvsqkKCuOimb6
 8aXXz6wc+owAIgryo81lEHdd8HgaYevPHDNFQbblIuXYJBTM0VKTXGvBeTK2F1IF7wm0uBxSzgi
 dRSez1jOIIoToSfCD58gRffdgdx4drL4JnqbvtmShKGui6APhJ6Kk9wtkWeFurjFc6DmFVIKviL
 6zbjWEcMojVvmUKpJfalxAeBfOzgkstYIA8tYx+SGtCPLL+PrQpJAVqXhx2Cy3AGupSUOkUcduT
 dy2YQ5BWHY1CoIPxDYXn5HVnSMg3J8RsjWJw9Z1j4eyZgSTKkS0eOCVnGNKfJZeNhEBrUd4Nvca
 poSzPlYnPTCmuq8KlLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150084



On 14-05-2026 08:13 pm, Krzysztof Kozlowski wrote:
> On 14/05/2026 16:39, Krzysztof Kozlowski wrote:
>> On 08/05/2026 18:03, Imran Shaik wrote:
>>>
>>>
>>> On 05-05-2026 02:23 pm, Krzysztof Kozlowski wrote:
>>>> On 05/05/2026 10:50, Imran Shaik wrote:
>>>>>
>>>>>
>>>>> On 04-05-2026 03:53 pm, Krzysztof Kozlowski wrote:
>>>>>> On Fri, May 01, 2026 at 12:45:44PM +0530, Imran Shaik wrote:
>>>>>>> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
>>>>>>> but supports only up to 12 frequency lookup table (LUT) entries. Introduce
>>>>>>> qcom,cpufreq-epss-lite to represent this constrained EPSS variant.
>>>>>>
>>>>>> The entire point of having a generic compatible is that it MUST match
>>>>>> all devices. If it does not, then it is pointless to push that generic
>>>>>> compatible.
>>>>>>
>>>>>> I am speaking about qcom,cpufreq-epss.
>>>>>>
>>>>>> That's nothing new, I was arguing about it already, but now you have
>>>>>> confirmation of the mess introduced by generic compatibles. Solution is
>>>>>> not to add more generic compatibles, because what will be next?
>>>>>> qcom,cpufreq-epss-lighter?
>>>>>> qcom,cpufreq-epss-more-lite?
>>>>>> qcom,cpufreq-epss-high?
>>>>>>
>>>>>> Same was here:
>>>>>> https://lore.kernel.org/all/20240828203721.2751904-17-quic_nkela@quicinc.com/
>>>>>>
>>>>>> So that's second time I object and do object for every new instance. No
>>>>>> to generic compatibles, they are proven to be wrong at least for
>>>>>> Qualcomm.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> There is no functional change to the latest EPSS hardware
>>>>> (qcom,cpufreq-epss) in this case. The Shikra platform uses the CPU
>>>>> frequency scaling block, which is a predecessor of EPSS and is referred
>>>>> to as EPSS‑lite. The only difference between EPSS‑lite and EPSS is the
>>>>> maximum number of frequency look up table (LUT) entries.
>>>>>
>>>>> This constrained EPSS block is not specific to Shikra and can be reused
>>>>> by other SoCs that implement the same hardware. Hence, we have added a
>>>>> separate epss-lite compatible and reused the existing bindings, as all
>>>>> other aspects of the hardware behavior and interface remain identical.
>>>>
>>>> I don't understand how any of this is relevant to my comment. I know
>>>> what you did.
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> The intent behind proposing an epss-lite compatible was to describe a
>>> common hardware variant and avoid introducing SoC‑specific handling in
>>> the cpufreq driver.
>>
>> And I already objected. Look:
>>
>> "So that's second time I object and do object for every new instance. No
>> to generic compatibles"
>>
>> I provided arguments for that in the past.
>>
>> NAK
>>
>> Best regards,
> 
> I already provided the arguments here:
> 
> "The entire point of having a generic compatible is that it MUST match
> all devices. If it does not, then it is pointless to push that generic
> compatible."
> 
> so if you have generic compatible, IT MUST be used. You cannot keep
> adding more generic compatibles just because existing generic compatible
> is not generic enough!
> 

Hi Krzysztof,

Sure, I will drop the generic compatible approach and introduce a Shikra 
specific bindings file (shikra-cpufreq-qcom-hw.yaml), similar to the 
existing EPSS binding, using the compatible string qcom,shikra-cpufreq-epss.

Thanks,
Imran

> I gave you detailed reasoning and even example why this approach is
> getting ridiculous, but you just have to keep pushing your solution to
> maintainers and keep asking the same.
> 
> You were given the answer and the argument. Now you are just wasting
> maintainers time.
> 
> Best regards,
> Krzysztof

