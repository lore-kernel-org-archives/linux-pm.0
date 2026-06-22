Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533C331200
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141092; cv=none; b=UT2jA00q/r2EH6o7q/BiC4ML0O+Jey2ubd0eG+UwDyETlbdlOHddW8ae1o9Yxd04bHt2CfxezVs6/Koev09TAHhFc6coQsDh9I8ZMgHG+O2n9DNxPlMY4kmnx3GCRIHHc4UAK+OZlUUmjqZ1SZ3W3OREuzSRMbtaup8XgZFpMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141092; c=relaxed/simple;
	bh=5TOax/FcPl473BwB62zs13y+Z4q1fMt0Z6E3J+ZzaMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayzhNg8rKvrx0yTpyQdUXa25o84gFsaYyaZOhx1dMZ91fFHPrTC+vAb4iaXcni/d/RQFoQSKGUlp3QFFW6+uhM9/xvlwSG6sP/YU06vf4qUFcMLGJyX4zYhLDw3Eath0BLrm/JuP8REpFGofl8rLJam1VWxmCTYps68bG8dG5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7n+Ofjw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J9blrjs0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7n+Ofjw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9blrjs0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFd8g773584
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 15:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	htKbuZhzlRPYjkFPiuqoTZ0KiMQ3XGNYDjU5yi/M/b4=; b=R7n+OfjwHVa3wUO1
	iJRAda8FuWuXwd4sQBZNFVfQzd/ZpG3qF1h2Xu+rjm2w9mQupT6yG0rMx5YdnZP9
	osBJjTdkZN6h6nXz9ANeLBzZ64YLXDvdEdr4APPWC/mKjbFZ2emR+C7AxbORgVie
	0Be6zez7KfXdYIrNObUHaPiWOufDhQhkNJYb8ePxA5bCWfQVRta6XMubIRF+W2GB
	u8N1ET6Mlk1fSelnzJy0po/KG6XqAWjjG/Yadz9KiGzO1h3L22DM79IGfyWxiFG8
	j6iJU+Txx7dMA3+hDoS4OnidkO4qD1YWoH1w+LJUJ42pA+VsG9VP8nj0e3Nnn6JJ
	GrvCig==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj9318-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 15:11:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2961932b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782141089; x=1782745889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htKbuZhzlRPYjkFPiuqoTZ0KiMQ3XGNYDjU5yi/M/b4=;
        b=J9blrjs0b0ElXwaQeIw275UzFEzDi0BmaKAL7AO64hiAZyCwER1EBz3asqaKVEezF+
         pogQLdOMrZIEoJhPbHFrr+jKDSYIdxVir4zWH6+YhhtzKT+6DY2GYN5bkSW+PQojHYHD
         OqBwX4YZoNF7DaGLFTjNIq3xriz2jhGt7Vantt/zfh/tTFcSqpsr7n7hGqW8ihpMcVjB
         GcM7naakReuCzyyne1KBUk6JbEcQTkHRqaWNr7TvmQsQkyQTam+zYs9Y7o//AStkqcik
         at3PyHnY5Y5LX/E3Ac+Sgn8UzONTxfj7f8z0OrEmPOAN2Ifixv7wadvuQZTuOmQN1T3K
         YJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141089; x=1782745889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htKbuZhzlRPYjkFPiuqoTZ0KiMQ3XGNYDjU5yi/M/b4=;
        b=YLyAHUQywucn8qmHDJvyS/K4idaHW3RbzdSBYwmJ1HAekZ1Wf7uMC39NPBGtwEpYlx
         7APKgb/0uMijbhvtHwDYJECWPdaUaK0HAB8rv6Py7TUhdFj4z/fsI4F5g64zmdV8Hp1r
         hKXKh0IqKCjWwVYyZ7q/M87PzpL92N5qMksXqMjOiPHnck9N5dxNnE+7f03SLv5a4C0k
         5Clzm+oOAD6OxFsbopgGKMM6IXe4B0bB/xnweJSngyi3oxsBL6vaZ/7d48fm1NdJJZrf
         Uqw+OnorDLAaI/PXZd2ysqfOFx+qfWjFIdDti2oR8REbgLaCDJWmBN+/CiH7nz5L8H7O
         zqWw==
X-Forwarded-Encrypted: i=1; AFNElJ8kUoZoEq3ud8ajaRjCM2rJiIZganoAo/GoK5qERn8uXw3muMD7HeSzS5NYEnlrqfpFYiSDKXRKLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5L56ptDvEuTv/rzIqt0s45GlqGW4jOlWM5WtTKxFBCV/JlzD7
	WYoNq/fa3Cc1u39UCSFkfrV7Q1ypX+p/FyYsoLTtbOdReobTSNowcfAMxlsCicOxTQwYEAYCgw8
	WTW+tJTY+vwHljmbGKODnVS8AmThxHpG3Tzj9njQo18oMU4fs/6U+ngE2Ou/v0Q==
X-Gm-Gg: AfdE7cn+mi1eE5VGS/EbiYSgKEfajvAhKX3a3QnNvo8PzmxDOEycN8FcOK18KJDiyVH
	vLWI04Qwr5FC2gV0Uh8+18bnfuJKAaDAXK/ixUySb4ia+2H34Ly4/IjGl76Of1B/I6v1QT59GlG
	ITqs4/vB6eDWVP4dMr+zBfjjJLUyJ7u5Gpzl8egfl942wfWQYUoQF/R8dVDocmjihBIKTYXrrAI
	08V4CZJffWKGcep8n8rZdoDRFRg5oWDEOHMx3UOUheHgrg08md9dICT162udHuQjumrQQcuAY1x
	Qhtkv+tnFkwVypmms9ngqUobNJUssdEAsc6QgKxZ0A/UfciitQu/Swq3CP2ZopXl4iOa0erDS8M
	jq+s+THPJxvor19OwZzE/vqBMjIatFDfgwHbqgpCOOF4=
X-Received: by 2002:a05:6a00:1745:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8456255d210mr11000524b3a.31.1782141088485;
        Mon, 22 Jun 2026 08:11:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:1745:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8456255d210mr11000469b3a.31.1782141087893;
        Mon, 22 Jun 2026 08:11:27 -0700 (PDT)
Received: from [192.168.2.2] ([49.204.16.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564eca7fcsm7906357b3a.52.2026.06.22.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 08:11:27 -0700 (PDT)
Message-ID: <83a3fc03-f873-4bba-90a6-d8147ab64710@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 20:41:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>
 <50d92653-b403-402d-af82-a037114c3aab@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <50d92653-b403-402d-af82-a037114c3aab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jjmKG2_IYVhVFKbXhM9MT8jla4G5kLin
X-Proofpoint-GUID: jjmKG2_IYVhVFKbXhM9MT8jla4G5kLin
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1MCBTYWx0ZWRfX5xqeme6sk6eZ
 hlnpDE2PVKhLOF7S5uTOhr7W/xtFYPliLWz/Krc7Q1yDwXPCBEtRmBzVklw6VhOT0NEoFuMOb1/
 EFiXNLNQDXjgH+PRWdMB4LAXgKekXEI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1MCBTYWx0ZWRfX4a6yOlvKdKqm
 5ESgQA44O0bSl3Wdeskc0Wk/lm2jkDkNJvWgiljrhdh3BrFGTn3ugm4QVzK9MfeprXXZcjUg0Uz
 D8nHDXRYu4U9P2TrP8BkDalamk9SFrD2LdBahnktSxPuAPMeh4Xk7/mzR8uKWv592msjf1DqeaL
 J0nrWa1MqHdPMe9K/am1QiCLEHyvqH+f4PhrJjBID6goY+fE6/AERtF6e3lAhwelSrd6f6wxpUA
 uU2dDcIiOmSOkDn+rgedkAkU/wOskwBDernH4fkEXZ0zhu5fOO25OZeLx0KgjH4OIcMyp/ajqpj
 cAIsP7NTuEk8enRDzCxfQahoxW4XqdMRWnQcJidmhSf9Sis2iC9loabaSzcBDbOOf3PqOE+w5cs
 veUWgcp8q+iIqMsGvboquElve4f+YdZY7Us94w03S+HEKkXMMVo1IBuBZbFs+FMFgSrrPwdy1/S
 0lbqmyiRpp8+UiB+JTw==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a3950a1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=V0wrQAR20Q1u/UIyJlYVXA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=ZBGX7F9o7YTsjpKyWPIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220150

Hi Konrad,


On 6/22/2026 4:32 PM, Konrad Dybcio wrote:
> On 6/19/26 10:39 PM, Manaf Meethalavalappu Pallikunhi wrote:
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
>> index 000000000000..4c6e6cbfbfe4
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
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    power-limits@ef3b000 {
>> +        compatible = "qcom,glymur-spel";
>> +        reg = <0x0ef3b000 0x1000>,
>> +              <0x0ef3d000 0x1000>,
> 
> Don't we need the range inbetween these two (base=0xef3c000)?
>

No, it is consumed by firmware.

Thanks,
Manaf
> Konrad

