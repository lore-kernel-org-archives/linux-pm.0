Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC571363C79
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208061; cv=none; b=efdtSmo+pi+fIhTz7LRTZtRxpuNm7oGgs3TfpGoKX8251m/GJp0a3Xr4aNV7GFb4DATgpjm10KtOuRPDp+Kv0ERbSolW3c8ZICcJSDM2Vteqnov7esuaQZFundM/LaEBLHWpWtGBsmukQ0/odq8t7X5JtFBcwCNLLBPa/9Pk+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208061; c=relaxed/simple;
	bh=ZFXjWZJ8Yv0VUo0VzxGtfovaoA1ZCFVBqtbCKCuuY6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvlpBfMCsrTR+JPTva26zxEVbBakMshhS8IwdvCmyXTrY2tkcQ+M4elUXY3L5sy0e5W3wjAN4jqqiSth2uYQQ/F8GjJWUMkiyJiQ1iRp0t5ugFuIpw6grKh+OiY72W/ziHb6514D/Uxm1nimA9Te2iaHxfaP9BGXngzLnoUJEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWWQdKqg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fTPza3f4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWWQdKqg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTPza3f4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N8kimC3355629
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 09:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dT3ZqB03YeVKv3AnZlUlVxas300onzHYiYQqPphtYjI=; b=YWWQdKqgAT3uRMP9
	ka82y0gtDjXKINfzPufO+dbfLuOFgYay/FuVXlaC2b/K2FY6xDGZbyd4EMmfNZSp
	1oatqPEZrYXWmZs3YwcWkJCNI+jwJ13nnq99r68LmdD5hvMhd6wjImkBCtwS0Iwh
	0yAKje4wrlzgsh+dFUib7ky5erT5bgLA4lZKpkcBRnqWB382T9fy1VUExTRpiF9l
	M/H3+aWC1zUOba9lone+ka+Wim+C4WMrp12tiHvsXZak3dOXmTvf86VhZSBLKVtc
	tpr+nWWyG6TmMM2RM2iDs2tJqG+m935vzUB9R8sl8121UzvVtzYdwlFJXjkdpFhy
	m1JUYQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx38a3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 09:47:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423970cb30so4102314b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782208058; x=1782812858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dT3ZqB03YeVKv3AnZlUlVxas300onzHYiYQqPphtYjI=;
        b=fTPza3f4E8CCGcf5vEltZdLXZjilUEvzJ7BjdKR2lMTPQf9D4jlyzDe9i8buT7QtBK
         fICPs4JW2/S3e7NvustNbcboaW1N4xzpXP1aRhnuFgpuK6XN/zQFh2FCjTgjx9JCoN4X
         koR539CSlp5fC0BVE4MYm/54uN/tY5WN2tBhbVPAk7DTOJSY7OLiFswhHuzCD/u8DGBm
         CRxofFtzgRi4E1GSsgH9R18Dzj76vQ/8/sVK+W7JoZgoK4fPDnSGGbWyNExSFV0BQRDx
         YSR4RMMMpHWo3/ypRftDZJ6/QODbvgRaVXGkBuznlsip2sjMDhGVbJimKbzGnPW/5OOv
         JjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208058; x=1782812858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT3ZqB03YeVKv3AnZlUlVxas300onzHYiYQqPphtYjI=;
        b=JIP9P/fAswlx47XZ/BJBMqQlLMeNpLetM99Qv3KeldKhN5+KwOsy1si35KUBvzBRAp
         CFi7MeYfnwxDHUyGwKeOD7ulvhCJajuyDUQNqkHZ86YihNXzLJ2f3r9V89cKUYQM2wxF
         7vVKcXfC0+KeosBhaytxZRREufoAj/SKlL+pBon0nfUlfXU3haAl8QuF6rcdoGNyrUb3
         IieNE94AwPWoXHvwDkny1t3t9Z7o2inyLsTc45GqfJwkuwLkSsmfNcUTC77GYh2lNheO
         wOfJ2CmvwPLjF5eLJwCRG+/rnMUx/L9fAbytMoOM0Q4jIF/P7+AE3Q07aT3l2Fkh11sg
         1mSg==
X-Forwarded-Encrypted: i=1; AFNElJ+8JavIfT07UWZWEBaEFNejWF7XsCG4Vy6HLCi+VCaqfo1SNAip9xgkDt4RFDelkvjXb3cA1frgFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmKxeCzx9E75Oc5MOYAJLfeNuFEKL/vBKReW/+Bf1vpm4uspD
	LUlOsCQSh9N9jOnO+ilvu3WIEGZArVohxG0i1A++pTSexzr1mU9dOn0c/rCtL9k45eS0ewi/neq
	Lo30Nv2oE5/0p2DJvFaaVWiUSJrqsHd2m+yy6AR/+JQurIEIZ1xkJM/66UV06Ew==
X-Gm-Gg: AfdE7ckjs6IXv8INdUBtCYPHAMDDT5a+op5hbcxl3B+d+DkRYmnvtJvW13B09anaN30
	plMnLEp/N5NSYkGpux5UxWS3q0Q40kAMpK3OMv3ti/jHRBkS0PvocDNywObnMNM5gyBG4XZ3iXh
	qzdVVrDzYFwEZPJVfmB+mXj83DdQ0Rz2k1eJgACe7NFPAm1S/qAomEbW2Pv8aeDDWEUyXCxzUkp
	9GZ23WXOFHDCYqadArvtP3DSSd0Us3/Br6xDqgRgJm4IhTdlhq3WhQ92RiQgdlXjK6tgBCPVYZD
	zq15ghR5EVh7VJ1BtroF9g8g4IU+Q0u8lg4xIbWx6wwLHnVf4IqV15WNnVz+VG8GbvwnnRsFGBj
	pjFq4M5j2a7Z06WHOsC/hzepc2VG7HmOQWOqkRHoaiBhTCg==
X-Received: by 2002:a05:6a00:9a4:b0:83e:b443:965e with SMTP id d2e1a72fcca58-8459707afc1mr2244888b3a.3.1782208058396;
        Tue, 23 Jun 2026 02:47:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a4:b0:83e:b443:965e with SMTP id d2e1a72fcca58-8459707afc1mr2244862b3a.3.1782208057841;
        Tue, 23 Jun 2026 02:47:37 -0700 (PDT)
Received: from [10.92.209.135] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8cd9csm9737902b3a.21.2026.06.23.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:47:37 -0700 (PDT)
Message-ID: <db8f06fa-0dda-4a22-baaf-8a708d43e113@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 15:17:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>
 <20260622-armored-witty-tarantula-84a28a@quoll>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <20260622-armored-witty-tarantula-84a28a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3a563b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=ZBGX7F9o7YTsjpKyWPIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: NVVn9NFFCjs-ZPRsTuv1hpmH3M-HOcY-
X-Proofpoint-GUID: NVVn9NFFCjs-ZPRsTuv1hpmH3M-HOcY-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfXw0sT/+iUFCY6
 a82BrDQPNVYl2rZRNY4bJJ1YX6W77a+dye1VKdZpSpaVfW8b9ZWhp+c+6jrWDDZ8t9XkQYvb6E2
 ofR0PwBV1LH81ocayBQi9qkwKaAyoNY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfXyrA3VOPv8sOB
 JB1jUw2Hp3shmREpOfNpBANnvG4e7GQvmXcjRDGK5YvLmh7Me9HPw13KLZtfzyM+Z0dYDxemIiH
 HfGhSnX4ADPxzDEZqaaxhtxWo2YKCdhc/2Kf7pfa9R5s/Hv3PkLMis9wMYCvrY7nHNj5KKBPAO3
 k8tk03JVdvGS6GGbruUqR3y0ouwLTPVbsklDv7ie4ieQYJX6lAbkFp+V0m7Y5jp07nBUiEBNiGp
 6ZFmNkxxZydCtQeIpI4dZNgWhgfpcXfSBB+GWYlYdK0OpgqDfKfWn8M0sz2KdaVp5P+R+qQSSOY
 AYiu0H09Xw2Ntd9koJZPZVScJqtJuwHrwuWWT9v1b45zZ9n50namaMpRkpNw9Fx0Dcd3bdPVNQU
 9rrb0eKqPjhywIzYfWXU8vkxZrSQPHAeB8o/ARAJoy2vyAB8Qz8MlhNe322xS14q0TP2SCSF3mX
 pu92MWt+wTr75bUFXbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230078

Hi Krzysztof,


On 6/22/2026 5:58 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 20, 2026 at 02:09:08AM +0530, Manaf Meethalavalappu Pallikunhi wrote:
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
> 
> What is "limits" directory for? What sort of class of devices fit there?

Added for devices that integrate with the powercap framework (exposed 
via sys/class/powercap). These devices are responsible for enforcing and 
monitoring power consumption limits across different domains, such as 
the system, SoC, or specific subsystems. Any other better directory ?

> 
>> new file mode 100644
>> index 000000000000..4c6e6cbfbfe4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
> 
> Filename should match the compatible, so qcom,glymur-spel.yaml

ACK

> 
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
> 
> Please describe here more what is this limiting capabilities.

ACK

Thanks,
Manaf

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,glymur-spel
>> +
>> +  reg:
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +    items:
>> +      - const: config
>> +      - const: constraints
>> +      - const: nodes
> 
> Best regards,
> Krzysztof
> 

