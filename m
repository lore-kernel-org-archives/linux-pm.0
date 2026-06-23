Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88842371D05
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209696; cv=none; b=VRmgo/+E3dNRn2DeQ3LnAvh23ngm7jfiIDqtoINEcuTkLB1RYyAW9cvbtpow10zmSkZ0bGuRQcwGhKQSr/KAPmG1BJ1sB8uhp+888JNF9RjsxN0pxBaMRyNkAJU3GP80fD0LwUobMOKwxXPf+eyIKL1VWjmHurr7nEkw/apy4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209696; c=relaxed/simple;
	bh=h/l3OOAaPAcU357lUDWxx/hld8kSuU5DLqCXyjmPc0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib2cIhB0zBcmNnvrssqlqWdmKuWa6WDcTxcVVcBLAsH13UpV8lPmlsOzsFusoLPzfHkJeyzJvUVSvNxfuXw7dy0URh1tdg3V4/8Vx7YTbKRtosotyN2avolHrZWFzXXKreMjyBk8bXRq2BK/l+jrQQ1+t7nY6PDTr12g6zPPe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obgNGQwX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WFzUrq7a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obgNGQwX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WFzUrq7a"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6dPw13631300
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	450XRmBYB9coVCv15NJUq1Jdx852zTHOAZqDbpHqzRo=; b=obgNGQwX/4KGfduk
	G7YSL/nqDnO+4C71caPRwXRIjqhPSMLd16oDTQhNyGFF4+eGtoibZMOVuzVZZAWY
	gUX070zC3AvaK4qHIAsqX/0FDzASldhd7WElwfABHgxETvNhHwv7mWcqOPkKCe9D
	593YdlRwAX0WAE15seXs9jumiXcx/yRzU4/oWtEA1ZKnG+pj4TyQ8mkTvN1AKJFc
	14txsSZPxBZ6kZjpvsgJkWuSwvN846wEchNsxIiuN4L/GqjL7MGkHUyyWV7rxmUh
	gEnBB81QRJMEzV4Ie5A/6lk9Z68eI26cKFACx+jx7vfDiLNf0GHFD0OqGKy5zPZS
	4Ku4jA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvs06e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:14:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c2d0a8b5beso59520765ad.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209693; x=1782814493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=450XRmBYB9coVCv15NJUq1Jdx852zTHOAZqDbpHqzRo=;
        b=WFzUrq7a/bFNnKd3vAq3EFAXwopAWAvBNqkVVap8gI/PLnnfso8htRyAsRyQFhHh6A
         Sims8BfYANYU0FcZxw0mn4ESPvJ857HAKnS9mKnsJuH3SKi1tFZH+oU7A3pqOAy9yR1x
         oM+PjYkMZKEc47PZNLSxuxxF014etOhWOHUOWjxRQochGUGs5xutcf2zePs1BMAJK0fS
         +zdOwetoeDWuH9Rg9jByacaHMdhkOKV9kTsbuwpxvLdkT8TDdBmsisIa6iXMutXg/Ruy
         Y6zLD0rOc6YspVQUbE/2NqGAEI80z43Oe3ntXPq8/qwg2LoJ5NPymKLcerkWxB84Q6HI
         C+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209693; x=1782814493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=450XRmBYB9coVCv15NJUq1Jdx852zTHOAZqDbpHqzRo=;
        b=tGKK8GNcZPkoHJtZfnLqW1kamqd6y4h5L2BQdJz7xZSLsQ2qiRHwqmFKShLcSN1xsK
         C8YqcPHvhUT8rxJKtW4pSvV8Jo7Ek3BArGI67TggIp16l2xOlEWHjrDZXBeomDgb/gUM
         evtQB1KtQKjgQpnabuqYO2GareGYrsXp1jjvb0AYZOwqQYttQXU+fKz2t8wpkqyNzWM8
         oKd25IIB36ez9+QqVuJZsMehw2N64vGeJIcLDu1wMlUp37A9DwbA/EEv9ChhiNDD4kmD
         Fdg9v1lQmsvnW+Ov/7CKM1WOtP9KazidasQ87ef60vJ1l1veW6fB/VvmjUyrVXfy5jXD
         5iUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmgLUVVHL/bDk8o1SuOLZQdIz6V4wDJhvOl+Oz1ilCD0J4XEmvXjSLChAkdvQnVvftMurwyKtU0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHa5Hp2oFjEjObjkWTVB/YBkpfpIYSOdDzMVuD5uZkvHIS2Jo
	GnIxhg/xi/zj7ckJL2+jFbAX+BgfntRPFlctQ8RmkSyN13vi4BgcFrDAzPtLkhT/n8Snp0SZEvf
	yhP8jeJNhVEME/nguf9cmmIX27HgQjqmomgU2JFNeaMdcG3op4X4a0t3tg5R5GA==
X-Gm-Gg: AfdE7ckMzG1aNdNJkUGx/pImAmru5Yj8MmITYHc53WAT3Twq4HysX4/FkJkw7u53m9P
	HUo1BDC62NnjAOdpAp5tQjPDSmLq8ZP8SqYbnEYC4Plvv8L/2GEclCliuUMu75gmh1Z0Xu1MgJF
	ZMh0bP9fKEYAJkHGz/NzXXwpPvLqoYqEugFGDZa1002g6Q5Nny6dJi2/QCsnjcHJ1VO4eojFuol
	36I7msM3y6VN4suojWArL3GfAA6T2pT7eB0OvNRgMVImFySTYqwsJsymRDT1tUMXppRLl743dRE
	mryIFfMxYT3anxLKMllmxnm5oFItvHL7PvG0x3pbqH3LH/DR4acdZf3z3PPbIya+vKXE+YVCp5k
	sfCqzZJXlTI+9T68g5fSBPEQnXkscv3e2ApyYTjw=
X-Received: by 2002:a17:903:1a26:b0:2c0:f807:9bf3 with SMTP id d9443c01a7336-2c7423d65cemr145303395ad.10.1782209692787;
        Tue, 23 Jun 2026 03:14:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a26:b0:2c0:f807:9bf3 with SMTP id d9443c01a7336-2c7423d65cemr145303055ad.10.1782209692306;
        Tue, 23 Jun 2026 03:14:52 -0700 (PDT)
Received: from [10.92.171.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe785sm99740775ad.66.2026.06.23.03.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:14:51 -0700 (PDT)
Message-ID: <4d0f96d7-3848-4442-a8e9-243a6c4a3495@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 15:44:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: qcom: Add support for Qualcomm MBG thermal
 monitoring
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com>
 <20260601-spmi-mbg-driver-v1-2-b4892b55a17f@oss.qualcomm.com>
 <7478c540-a5fc-4238-bba0-5b04547f57c7@oss.qualcomm.com>
 <487f0ed1-dfc2-4f7b-94ce-60045017a663@oss.qualcomm.com>
 <5ad33cf2-3168-44f2-89fe-a7fe1420f8f4@oss.qualcomm.com>
Content-Language: en-US
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
In-Reply-To: <5ad33cf2-3168-44f2-89fe-a7fe1420f8f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a5c9d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oS_SqjwSy1YzO6rVN58A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX0F5Xv6WnBQOH
 QUKlMNVJxKe4HDg4ss6xHLRw40Vd/JExdOQieeT9v9eSwKKZWrM5s3JJ/wcr1SMOiBFMTEGX0Mn
 NXnr8JG1/Y9bG9I5dZht/0FH5+oa96U=
X-Proofpoint-ORIG-GUID: Ym214-qcdFuJ6LSG1kM5DHZhe-oV24Nl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX84ptvW7M7csJ
 tTdZXx8ZDcvjIJs+ORlN3KrbfAurIbRHtMggvCiKLRZ8zbp1k1piM8MpWOZoTqkJjNOhKn+5Vsv
 MN7cPAghHGiVhRMiKHQAO+qJkZM8RbnY8f4FteHzB09sEgTG+MPzQEYNprJo32njnDmremBEaLi
 2lsLgreWK3NhWVMubXHH64KXvt43I9Ngo0ylJMZzy3WPpf6vPsE4LAYHrpG5MC0wmQAXDnj/Hcb
 weXXSiPgR/McW6TtWL7Hs6TfuR/YAD/vJO0E3/qiJ9JATp8HA6u6tvYZs+/alzrzHxdXuFIb/9C
 /QWP5SaFVXgE+tW8eGmMy+lP6DZoPA22SuTkGYcmXdq6yafxbACf85bHdWWaZYUwEO9qAP2kg1s
 oCRXPN8iN2qHFD9vQZfDAxlHvyLcfg==
X-Proofpoint-GUID: Ym214-qcdFuJ6LSG1kM5DHZhe-oV24Nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230083



On 6/19/2026 5:44 PM, Konrad Dybcio wrote:
> On 6/19/26 8:45 AM, Sachin Gupta wrote:
>>
>>
>> On 6/16/2026 3:40 PM, Konrad Dybcio wrote:
>>> On 6/1/26 1:01 PM, Sachin Gupta wrote:
>>>> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>>>
>>>> Add driver for the Qualcomm MBG thermal monitoring device. It monitors
>>>> the die temperature, and when there is a level 1 upper threshold
>>>> violation, it receives an interrupt over spmi. The driver reads
>>>> the fault status register and notifies thermal accordingly.
>>>>
>>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>>> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>>>> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>> +    /*
>>>> +     * Configure the last_temp one degree higher, to ensure the
>>>> +     * violated temp is returned to thermal framework when it reads
>>>> +     * temperature for the first time after the violation happens.
>>>> +     * This is needed to account for the inaccuracy in the conversion
>>>> +     * formula used which leads to the thermal framework setting back
>>>> +     * the same thresholds in case the temperature it reads does not
>>>> +     * show violation.
>>>> +     */
>>>> +    chip->last_temp = temp + MBG_TEMP_CONSTANT;
>>>
>>> Will this work fine if the user tries to set the max temp supported
>>> by the hardware (i.e. is there headroom for max+1)?
>>>
>>
>> In the current implementation, temp == MBG_MAX_SUPPORTED_TEMP is not accepted (temp < MBG_MAX_SUPPORTED_TEMP), so the last_temp = temp + MBG_TEMP_CONSTANT path is never taken at absolute max. For accepted trips (strictly below max), there is headroom for the +1C adjustment.
> 
> You check for `temp < MBG_MAX_SUPPORTED_TEMP` and there's:
> 
> #define MBG_MAX_SUPPORTED_TEMP 160000,
> 
> so passing temp=159999 is "valid" and after the addition it becomes 160999,
> which in my understanding is outside the range
> 
> Konrad

chip->last_temp is only a software cache used in one place, 
mbg_tm_get_temp(), to return a synthetic “trip violated” reading once 
after the IRQ. It is not programmed into any hardware register. So temp 
+ MBG_TEMP_CONSTANT exceeding MBG_MAX_SUPPORTED_TEMP does not cause a 
hardware out-of-range condition.

Do you see this as an issue?

Thanks,
Sachin
