Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59243361958
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477695; cv=none; b=G48OagEdheRg5jA9XivDzobKgWTm89eByca5i8E4U9AJGxpqZmC7kPtQniVd+gclgwaD82LLWLdrNmO0GQJlCuRTWIBeBURcX62Q46g/GvoN5OqQRuxuM5oGeeEJlmnK9PJm9WA/jD5MfkR18qVzxaVlCMU5et8YOVO2FcP7zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477695; c=relaxed/simple;
	bh=9IAiwHERiQkQn/Ry44QWMoA1P6ukK6hO/AKfFxIf0tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKmmmp37OJh1pe0AHhcTAkgYoEwufKD/ZemGDslczECjJzk3sxQhoAmvxxue6CLIUwNJchli3gUe2IAYwEj3IFB0kn0kAuOsn/rFSZAXXpCB+T7qAkG4Vq7LMj54hF1C2msauUtExlt1Vtcr/M3VArIQpeYzouiZBZllZxf9cnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/poziHw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdrIhLxV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/poziHw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdrIhLxV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5nnJk2972751
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=; b=Q/poziHwoBoxGXeZ
	Ww+9uNCbsx/K5rn/sz/ShHj3cgIJ7SiLBM/INrNavhUajMIRCr7GY4zcmSqTsfbg
	mOuoRD4IvirrP/KqYVJWbshAWQbI9ctWToTqn1da2OYx2QwEbaYwAQoVLvIdoSv7
	gKs4WZxdhYVIxCAWvBZXKXoDwXAa8IrW4C37/yU1LfcIxiC2s7KUmDCydRE+5ftt
	ycUrhVDcb7nVPOreLbyJG9TIIl+XqRt2EeYnwmf4cnnY4f72wzS8es17ctt+PetD
	mq705IlDY8udmWrbBUUecs/pqVOfajOLbx9uYEHW7QZRXg9KvIcVXCXnoEpWZZU3
	aEoYVA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frnwd01ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:01:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484b9fb055so1932142b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785477692; x=1786082492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=;
        b=TdrIhLxVvNZIB9n3wJgQfheU9ZQPFBfAMOZW5BQmzSyeNVm3a1BV+v74tCwYQTEAw+
         qsNoCdaqGwogTZmKpgclAnWotvA8iIkGiCAn+w9o8f6wbFjWzRgwRkDKmIHQ91VBOj8C
         oAsuUo8YnQ3M09OxMjOxUtmOTKuJDYzTgkepSyu6MwVo3HSg4xBIVvHO9VoWMTTK4yAF
         CzttcvoMoz3foxCZMBsxZqsioqGfbF6MAV51uRC/gitzgwYyezPrcqMsLv63LNoN0b3e
         kBSBWkpYsAABBAYvqJMSWBn+ptaMd/Kys6tyqpvUswXe6mqGr9CJWxNGsNOpfLOUBw/v
         HHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477692; x=1786082492;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=;
        b=Nfp9Nbhg5Hfpfm0B+Q5kPm3n/cGrMy5hfxHkBjil7Yiqjpf7aB50WxNYiXeUkLCHN2
         CZU1L76Ub1rqAgzTz65Zv3HKmTk+gqv6VjlGhF2yo/GdMXI3dVl70Y+H+GLO5T+ZSMhv
         Psq1o6SzRvUns7I9IcCwv5t0yQZtzD3Iw6VmI03Mb6nR22hXgKt0AxR4t3S5eMdQLlwm
         4VjuPFHy25XhkasULwQGr+kugTqtmvtLC++9ZzyQ8qchDvLYcC3Wjd+Ev+nZDt/XuWdh
         zeq5AmwneGvli7I49ef0F16aDzd/Uq+SfVBm969qxixqBDwKZKhnp6HV3G5MfBF++PCc
         rP4Q==
X-Forwarded-Encrypted: i=1; AHgh+RovIRoPeY23XtIXtvvVFw6KTGsrt3ZOE4h0rcoFfHhBakF6aXMPBi6eTKC1toFpwn0sBVEO5IpBKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxunDHhWHecSBGbF9A2RDbB8XXBnboW0diBszmfaamQDoXNvoL6
	+uJvTQss8T/SYcI3Mlo2lJg1TA7vyWGSYn4+Cy1vNAcSrtV8PJB+TgZb5IuT0MM89HbH++R1XCx
	Fjn9/EBLJf/+YYg+1jyG55uqhUHnAoZTftpgRVyHRG4y8cm4GScVja4KnEUtDAA==
X-Gm-Gg: AR+sD13kLb7pXRemy5+4snpQbf1duG39GI6CEKoqpQfTI0kF46fxz6NmBaMlIFlbjGf
	lfNTZLV+LeKr4kmtIh7Ax45aGB/25Msup2VMg6BE6Eyjv3LByI3fGA4fz7S4WD+wxJ66UAGGnr1
	oYSUQRrmMhavY2/PmlCfyFf6v8hplpxygbJITX8K9FRFmZwStm4cK1eYVqqLp2q0YAVJykYIiOw
	emkBy77EGPkDoF9tqKKdbTZ4RoPXq7snTGbWEVx1qPaa9jWyF3oxOsKGOgFncGpAFzXsW/m0WTp
	zaiSw1jsayA6VfUb1vPd5wQINS/h6Qhm3K8cl2V5aaeHkmNfCTY38q8l2iykdFEpsR/gKj2K6AZ
	uvR2NpxrO/Uqh7BrRTVrYCtcjquzazFA=
X-Received: by 2002:a05:6a00:12cb:b0:848:80ec:5d2 with SMTP id d2e1a72fcca58-84ed6f02d49mr605929b3a.51.1785477690452;
        Thu, 30 Jul 2026 23:01:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cb:b0:848:80ec:5d2 with SMTP id d2e1a72fcca58-84ed6f02d49mr605895b3a.51.1785477689968;
        Thu, 30 Jul 2026 23:01:29 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ed5deb8ebsm311596b3a.40.2026.07.30.23.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:01:29 -0700 (PDT)
Message-ID: <548b30dd-915f-42ae-896d-3ab8c955b0f2@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:31:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-9-973cd3a226af@oss.qualcomm.com>
 <0f56d22d-437d-409a-852f-9fbf4e303284@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <0f56d22d-437d-409a-852f-9fbf4e303284@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfXzggSlBPI9RFh
 mh866wURnY35eAxMHGugt4f05pg2mT71Sx/k3SFmoUfWHRfs67cZQGIQL14WGGIp5vhev/Ktww7
 lB6/qAW+2o/RZDXrleKayhj+7qFTp6U=
X-Proofpoint-GUID: 6cnl4lMm4cjq3u2v9xy71nf0LGSIGIOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfX26+cT1VtZJJC
 4FUy08mCB1olK+stb97DApDcZ0tGhz6t+A9DWnSTQHY+H17uAGj+ZqaTK9vbiN3imjv71qv/e85
 lGnQkPAH1S3EjHnLZHbrV2H2xSc50DFzK6tS4K7lPWiXBPh40rSitV8btPspzA3svO+VpK3LoJo
 6OS/mF/SnpHwTnWwRY7pM+YYAjfM3Xf2ddYUxbsfe8CMlIZmnPRjge+wBUJf+WDZx9OUrwmv9Ab
 zu9y3V56lFZWibSnXzjzaID08trd1YyHDEoeuOHWbwNc0hS+XlaWAn/CMFaTGaRyet06IGr8n6S
 9gT92WLlj1Ba82+sO4gW6hLnLcZpyArKs64GqRFumX0qX9ktACDIDhpIl+THTeehsVqkGdAYZHt
 yzI4pgl5WrNcUnRi0dfCErdYcGeE/HLRnkLYAZxMfUlktFc8+ynCfumUY6ZO6De3bvD6l72c9Hv
 g5bBMVttB42tm3RLmHg==
X-Authority-Analysis: v=2.4 cv=DtFmPm/+ c=1 sm=1 tr=0 ts=6a6c3a3c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=couP0MF0vw6ipDBTzhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 6cnl4lMm4cjq3u2v9xy71nf0LGSIGIOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310039



On 7/30/2026 10:40 PM, Daniel Lezcano wrote:
> On 7/27/26 16:22, Gaurav Kohli wrote:
>> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>>
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in hamoa.
>>
>> Set up CDSP cooling for both instances by throttling the cdsp, when
>> it reaches 95°C.
>>
>> Add polling-delay-passive so the governor periodically evaluates
>> the zone during passive cooling and steps up cooling levels when
>> temperature stabilizes below the next trip.
>>
>> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++ 
>> ++++++++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/ 
>> boot/dts/qcom/hamoa-iot-evk.dts
>> index 9fa86bb6438e..a146be1cb5fb 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -1684,4 +1684,36 @@ trip-point0 {
>>               };
>>           };
>>       };
>> +
>> +    nsp0-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp1-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp2-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp3-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
> 
>  From thermal-zones.yaml:

thanks for review, actually this is overwriting temperature with 105, so 
other properties are coming from hamoa.dtsi.

> 
>      ...
> 
>      required:
>        - temperature
>        - hysteresis
>        - type
> 
>      ...
> 
> 
> 

