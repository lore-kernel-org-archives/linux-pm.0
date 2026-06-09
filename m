Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3933DD51D
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990517; cv=none; b=ULGeS7pw8LBaVyYoARzZ5V/NxNPkFb+z6Uld2ca5hj0HQ6Q5fuCeJH1tmsdDoQbnCOwtnySpcQ6DAVvvqBjYwA1C/rutGQUJLp34moAnxyZAUXVEHw+mHr8ZzmNgEnv3yJfnEyQN3SMqV2Wki+S4uq9nHf4QF5meSxXa4ti1rLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990517; c=relaxed/simple;
	bh=wWzRFvVVGH2YX4hnEDoIFpmU2i1p5wbNU0mAYgwDTRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKOs7at0nqvfLwFQN8xk4fPWJFLFIMzCeDEgLBDe75MXXNi6ozp/wXGr9Yp1jluL1qqd+y04Bw5hWl+MaUn2tlExT4sa7ekA/MMDIEmWmkWd6bq8qJyD726Ecuuel8mvjgXeJkhb0C8lZ6CBI01nAy+MWG250E92a/jlDqLAe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZhxkBsl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbkYg95E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZhxkBsl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbkYg95E"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wdtN1515146
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 07:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+MUlD26qjSFFsWjNX5Rl/mqpEy4GVQMqKYLWQMQpVuk=; b=TZhxkBslo4cZAcM6
	BVjKRTXVuRQClIKX62G6lhONmrJ0R6f+2e4K/EK8FJALlHtNhN7FLT+QXLymro/d
	pLFrMVe5iA30sq2I8E5DN6hum5LgyV0YyxWHc7yV1nEl4XZr3hleSnN/+efBbnEw
	7rEgbYJXTX9LL59SjddK5hA8Lx3u/fLnhAmi0f+1OKSInr6sfXp6SD5vwu2SJiBq
	so+v6+vPNVGGAFC4VuivWgKe/m66QzclDk2uzcRYEhArV+IGZn8vCJG9Mf2mZWYR
	sQv04mdXM2H5riO2CIKB5+hNx9+47Lk+IUFH83CfSTl/yJ2Zrb/nMJ40q6mBCviq
	IQX32w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsvck6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 07:35:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so3019927a12.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780990514; x=1781595314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MUlD26qjSFFsWjNX5Rl/mqpEy4GVQMqKYLWQMQpVuk=;
        b=LbkYg95EcV2chb33sO804lxtU9koEZc7qpbBBpUTJHY9F90xsF4UFfFtuXAcH1OxFo
         Isp6gldE3jjvVq63XiP1+qdsypEVYCD/RqX8PCRSEbHfYCGDzKe2kRy/F3V1+5XFr/KW
         e515Yn9wtnZxoZ4LJLObnrztVLWsONozdx4+3wh+kSVs+o4Jvwykea4SweBsaGYlHC7R
         jtfSXWPg4vfcPEg19rJujaDyKHtJAR518zUn0AgbKl+PV6vz9os4d0RFbQY1F2y12GLp
         ae5kFLvGLlolqd5zmRBfbycptFFYdnIW7XhzodscDnG2gFLUbAdhDJnX5VMWEElTr3Zy
         U0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780990514; x=1781595314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MUlD26qjSFFsWjNX5Rl/mqpEy4GVQMqKYLWQMQpVuk=;
        b=cW+mqS4qT9CnnSQEGTM0kod6vsT0aGUQctxON1+Ukb2D7lVxpw6cvVrRC+e1pPyZ6n
         Vvl7aZJtmaTjbYraJ+wg1YJbNwENlPJNHpYc2SfX6grlGG6yE1WlVYJQkMODiKwtL/RG
         z/zCv06QIgigS2AuqmMwoARdj5pSZKX7xsKNAanPSY4IZEeQQqVbqneOB53NXxR23CwI
         Jv3pPNoZ4ALdwPtLD84i0VDj8X2Uz12pI31mgQG+Ixk9MvzQMy36azzbLwnZsfwIZhhX
         sBBoIeHeNN3cBKXDdjNU/AKymbilEEmPQu60u8vLKnmJHRztMqJBLmfHeJq3Nri48Eo2
         DYzA==
X-Forwarded-Encrypted: i=1; AFNElJ+HBfJiSho0UVd5fqB8H5cJH67/nQdgzmkxGw28J0LbBQk5PXpHof5T1iORzyIcYbTyo/BpkVfwgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpq9fGbzebDB8LbgBWzgCsah9IZmh5ez6Zv3XNBh/PE0r0wi0
	I6m3URr58WePzL56QCRZrZMs0MukWc+oazXjeMA7WF5DyR0kE0djWmLT1rlGXaPl3ozy2J1wcXg
	hvRB+JHjzKNLkD9sdYAaA+HVBirJ5iE8yerYOquyOrKk2XKHFUZGMmnqnA4JiL80zu5hcgw==
X-Gm-Gg: Acq92OECTldov5w8qk/8Tk2KqZczx2Z1jUfvGr6L8R6j9ZiPRjRCFp3ppu5KGgfyVFZ
	WznRlRTQuEl/MxHu9Y0W/04+2bSYjsNe1b5Cx+fyGGJ0fHSkcaDNcMiM9kEwbgWF0TR92lDqCrL
	tBmchp4JGG6cfOpwYhJLGvXUy7F9vbW+IQ6WWKl2CY4J/u4fcDr9k1DqVAvUFrz1ctOpt4RjUmv
	Swg9Zc0pqaKFbE62ieo7zgOl1kkA8ZxZJZ3O7QCdMcBMNjvT2ZhPa5rnasvcBbtiWjUlfajDmqh
	I971+ALH0AAG63dCBx/+VDSUOIs18ZShsSIYhc3+56wdHp64d+MFS5t2P+vXj18vPimXbLHuX3a
	WphGgPEV0As64O212DfxMTBcFQDaCdu7Nj6AzxqGwYd1cBgpb6QBXNcTJlqqIRit0rLM=
X-Received: by 2002:a05:6a00:a21e:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-842b0f97f5dmr19916199b3a.18.1780990513911;
        Tue, 09 Jun 2026 00:35:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:a21e:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-842b0f97f5dmr19916141b3a.18.1780990513245;
        Tue, 09 Jun 2026 00:35:13 -0700 (PDT)
Received: from [10.92.193.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828836efsm20221481b3a.38.2026.06.09.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:35:12 -0700 (PDT)
Message-ID: <5ab6d5b8-41d7-421d-bf3d-370371caab4d@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:05:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-1-75356d1b7f94@oss.qualcomm.com>
 <3c441940-e4e6-4626-8ff8-36db41409644@kernel.org>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <3c441940-e4e6-4626-8ff8-36db41409644@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rgyKiC5A8rlR_Y-FKT4EwrebQ8eYT6cr
X-Proofpoint-ORIG-GUID: rgyKiC5A8rlR_Y-FKT4EwrebQ8eYT6cr
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a27c233 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=vAWKRZcgqgyjYCNlygsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MCBTYWx0ZWRfX9t+/Yvm/ef33
 D38qUxcNWMbJlCM6V1sUznFtDGtxD6NzPfl17eXNBrB8blX7mHSU1g5jAyeQXxa7zSiFEMwKgMR
 w3AoNSuMQTbISN90EkZ+t/oZdb16qkzZqDRD5Rl+MU6VhAswgrzB627o7O+wrhew+lB+R7xVgIy
 JKRhRdEc2CmWSXWfEfiUqqdlQHGm5Pi+Rjb3iCxymhJwumgRT7f0a0z1AIszwtft+f/wDdb3IVL
 TvmfY6JRO5r2dJADYcJZJy4Zm15byeAy3fGXGQkxFJwj77VDQjdVnIRzZ0C4RZGo8Gjal19/r63
 LEsDFf4gZhCvsIrU1WtxpB121W86v1mWbwKMdNajfnjafFX3CAIKXuQxCbGL2usqtPpekU47JAl
 h6N1F2O0jde5qqAX9iARG37OvseEfJDtpcHY0rVWzHHD8knYX//u3f6J4AqlwcgI1efI+RzO4V0
 01RfXqMsiNuQtrcP06Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090070

Hi Krzysztof,


On 5/30/2026 5:59 PM, Krzysztof Kozlowski wrote:
> On 19/05/2026 12:49, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various domains.
>>
>> Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> ---
>>   .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  6 +++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
>> new file mode 100644
>> index 000000000000..e9bb70c3a3aa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/limits/qcom,spel.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SoC Power and Electrical Limits (SPEL)
>> +
>> +maintainers:
>> +  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> +
>> +description:
>> +  The Qualcomm SPEL (SoC Power and Electrical Limits) provides hardware-based
>> +  power monitoring and limiting capabilities for various power domains in
>> +  Qualcomm SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spel
> 
> You don't get generic compatibles. I think I commented about this enough
> of times.

ACK, I will move to platform specific compatibles in V2.

Thanks,
Manaf>
> NAK
> 
> Best regards,
> Krzysztof

