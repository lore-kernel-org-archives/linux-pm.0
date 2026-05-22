Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43431715B
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442246; cv=none; b=GKMCzp6XM9OXvrofl4HXvJGYN4tWnD1za1gnqQQH/Eo9HfDdBbvD/SYu1ztjHIk90Z4DA2OyQgX4C8JY5QypICZY6SiH0ixo49RqzaxJcBPfnv996Bb+Xh2AkvdmphunFgmNF4pyjyLhku+U+WwiXRbQF/lmFgfL6iSAyh5hHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442246; c=relaxed/simple;
	bh=UMQAUsNjrWcfUgwwUpJCdT7jtfG0UQMZ4o+VMv4vPP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAKf5BQjimYca1ZrJFSpO4Y2VjT/a82eC/Qy84MFuQk5IuE1w8NmjtRNCXOYv7skeXqZrSKqOiHUf7xK1kI5tdDAaFjCUL4xnzJLkecHZChsA03gahnJMjWK9dywfW90rM2RCZwehNo2UdOO8Aa2g1dzqO6EarfKCnE9EROTk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nVYZtXiQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGryQmYV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nVYZtXiQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGryQmYV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8r4gg399205
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAIFtLKu+vGu7qZ4vvvbMM2OnE0zcwInjzx49aFw+LY=; b=nVYZtXiQ7bPKs9JU
	L/Dm1Vu1Inaa3e5LpuE0rsL+xzZx3YPGYjgVTvI1NinUIDLxIWtCUAS1/SKnjJGP
	Vl1hygkZZQR8ErHB8PO1uqQAZVra/7hlp3GVyZM5ELwSIlAWDRJWJgTMsI/EKCJ3
	yXeFw5CuXB3iXECJHPzRk+gKTJV7c/rkpb32wAN0mPz6LRDNVMG5AB6A+m8ES9Ew
	5DV84k5Hsl0iDasSeiViQXwamBuVP/DVrNzeX42tD7CvvxGwQ4D9WgwCIfx43nWB
	NStIeeFf6FwxMuxsc6WeALicntNa28jB2pWU1VIXTBPoF0Q737kW/VReUQk/QXiy
	IDc7Aw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9unbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:30:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso7007271a91.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779442243; x=1780047043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAIFtLKu+vGu7qZ4vvvbMM2OnE0zcwInjzx49aFw+LY=;
        b=GGryQmYVOeBYeaPkVULnB7TamhkP+thOcAZVg0jwEsxqP708G0vH3+/kf3V8Yd0OOo
         r0WhzjLmpR6kaVdaVnehs1dCu36cudyVUlSzTPiIFh5Fc53wiyVrcO+Bl/NBYdSCUuM0
         UTx+0I4akzXVh3UDmUtydPtakpM0DsfdHY1sXxTJkuK6ESS1z2vdryoPCz23+uxRWQqX
         LtzHzCsL3CkLQJAviQdajk71nRfJqhEuBWk22dcDyushGAn/aTFnPOr0AclmdOBwm4xi
         4PWM6xTpI0WN+5fmSvGy1C8WOUnTfX3l/i0lkyiykrl7ZO/HNHLPtIUkCPSU/7+6Sx0N
         Pvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442243; x=1780047043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAIFtLKu+vGu7qZ4vvvbMM2OnE0zcwInjzx49aFw+LY=;
        b=hwA4wDw5fmNxxTD+++3B/jgMoB6dXZINL27nsJan0hlQhF4/zPRK8jW7Gm/atC9Qof
         jLES52dLrO/slXdarE2MEgQ0w+HrfttQYbwKn7Jm3O4ygPqNIB7GKlJpaosQHmHaqdJ4
         +Qfk2eI4QQs4AJCX5QzrMXCzRwtTNXsxmm2yKIyVNVc8TWlazenw8lz+eytDVliO8HF9
         WBc1x8BxrKPMgMKk9VIOClrWKFM94JYrsbqGWX7Jxjm0GrK8AbHeZMD3hSmgQgG85aSp
         iAbiNwtsXojn4Lz7GjMPbHbfKXx3ix1TuR71tnxm2Dk5L9lmItSMarfKDU9/Zw2u8jee
         esXw==
X-Forwarded-Encrypted: i=1; AFNElJ+rWsMECFPys6YLPYsiSPB+jgx9g9oJB6JFjmZIsR+YfDZH2qUoSop3nqnvGqHo9rNik2GXuFDqnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fiG2UlLwruTCWZO1kUI20aYx/59eumkut1YXAfM+VEnkI7ea
	jIuqgedX3vymlNQRmNZEpr/Hm2PlG9Xwy1zOcDOKEUJwN0E/DHuofOqLcGUyVQ4LC6LemP1UOzg
	vphBEhvLt2/D0AtcZ2zK+9VqTZGmbP4pFXVaNVkrrORiCwSwp8SymHED1rBiIpg==
X-Gm-Gg: Acq92OFFv5B1+hXMoJTxaTmGIpiGqOINlu6SN7hGL/CgbDVyFFPZ5iHWNJHYSldgNqx
	X1aAR9BCZlbC1Fxc34OQIJuclyKiP0bibNkoOaIjrH4aA1fvbSHjze52plt9C9nhDE3dLq43G6Y
	AzoOzYhlJnB4DKMIsYQTys4jh3MrbMDUawDOIo+ZA5ggIh5jjpfSPfSgt2QZWDtsFzY5U6AxrjP
	SWDFyHunNKJdZ/V9TN8K4dNPjTZ3aizTSWoIYBtdJ/108giCwU8dmbrC7bL2jV4zpLN6s0zwPlV
	zx+tPBTA73P7dRW41G4ADlHofnOe0vdgvmglvJZgRYPowiyii6fqhgnp3xlTJDGZEv4AFdIo4cS
	xnkI7Lzs/lulCaTHjelvRrF4MCRw/QwA7HbSx9ZyUNaT3mGiTNjOgYKff8Vc=
X-Received: by 2002:a17:90b:564f:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-36a676f5108mr2536999a91.1.1779442243286;
        Fri, 22 May 2026 02:30:43 -0700 (PDT)
X-Received: by 2002:a17:90b:564f:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-36a676f5108mr2536970a91.1.1779442242763;
        Fri, 22 May 2026 02:30:42 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723cf27csm1400022a91.13.2026.05.22.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:30:42 -0700 (PDT)
Message-ID: <b9d6d3b8-ce3c-4179-8e78-fc7494ba322f@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:00:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
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
References: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
 <20260521-shikra-cpufreq-scaling-v3-1-883c13d1e514@oss.qualcomm.com>
 <20260522-massive-hopping-oxpecker-d9dcca@quoll>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20260522-massive-hopping-oxpecker-d9dcca@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a102244 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KaersKY4o62IQMGDIjUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jTADN694R1cBSx965YGmWy3WH_2JYG8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MyBTYWx0ZWRfX45HlC7RYgPga
 H8+oCx9FdUAoCiVSqXL/F+ug/bdsHsnnd7ad8eBAuQarFSngrpCgCOcD7Bt8AbChPJV/DJRHfuI
 qk1cuSCwupBoS9WWGwzFq6IqZjN8Ll05i/k2mmkP/8BuSKXxWd/301NoDwiOIIvnp1TRDWFsMnS
 h7jYirthiRcK0Qrvy5s/Yuk/aWLRA29z6u4klguEjn7jH+6BUR/JKSVr81opH/kMYo/IUgxc0R4
 4qWEa53co94TsIeGvz3yyr79sf8J1Bj+jo3kZAw6bmZ+9SBaJi3CkirZlz6SjHQlpyN18AUNYM1
 mjbElgpppDwrVCZ7+yEojR1YNp2wAE6/cwepDFqzIcVYPuLxJQZqJkSNsh6VCt1gyEybLRGO7wZ
 /2LwVMmxaIxVh5M8lGwqpSkGSiPSCjdHuhu2q/CfcvGCF4F8lIXQP1MU4aiUMEppzKNCXyIGHjD
 mc4YGeOI5cHe3va6E1w==
X-Proofpoint-ORIG-GUID: jTADN694R1cBSx965YGmWy3WH_2JYG8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220093



On 22-05-2026 12:05 pm, Krzysztof Kozlowski wrote:
> On Thu, May 21, 2026 at 07:36:04PM +0530, Imran Shaik wrote:
>> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
>> but supports only up to 12 frequency lookup table (LUT) entries. Introduce
>> Shikra specific bindings to represent this constrained EPSS variant.
>>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   .../bindings/cpufreq/qcom,shikra-epss.yaml         | 96 ++++++++++++++++++++++
>>   1 file changed, 96 insertions(+)
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> There is no "qcom-hw" schema, so no clue from where did you get this
> one.
> 

Actually, I picked the reference from latest Eliza/Milos commits. Will 
drop the qcom-hw prefix, and update as blow for Shikra and post next series.

dt-bindings: cpufreq: Document Qualcomm Shikra SoC EPSS

Thanks,
Imran

> Best regards,
> Krzysztof
> 

