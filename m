Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7263822A6
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871282; cv=none; b=FJFyYjZdlXB5EZjJq8TuTcj0RUoGaFIBYQf1aH8fev9tbE8hDZs35OLSbT9D/2QhZrV9HnTQoguI128Rnm7oXDIxrT6UoXedYRvntI7q9VBFN3EHsz1hiTrAil9SJ7V8aMpLYNqaUeqgn7IImxXPk8XNsdmikBFKpeNP3FgSjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871282; c=relaxed/simple;
	bh=gmlc2x3Sx9TTXS2SnEsXIeKsBRFp3YpvrWD1xNAK2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udex7wEZ2YcUBlYexexv99qhDLaq5+FqTOPaWC+mcLUYtUHtUSBxEa1B/UdTmLgQyTKryBFgH5sTnOEKV8goFQ5C0ORTRt4jgq9XuMbSuA4a5SKfH63M7dWONs8aZezQjL4LVtpceSW34fnqkxbfhg1o90NR9LTC4v3d1QUaxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2+p+fQ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TkC0SvdX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2+p+fQ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkC0SvdX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7OocC3659765
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YB5TdQQBRKdo3NZtG8wlUHn81r0WZQz2AuX2RuLMVLU=; b=n2+p+fQ4wCRjumLr
	9veJ7nFFJGeEtOdWgOFs1ybRBss+PDVGhQEGMHlenqzHC7hEbextHucdEabVTKPO
	UOtTPWPbi8QjLPE501VmZkFaTl2Q75ETZrOeKQdZM0z+YDRG0p6qRc1ICku8bEXd
	PvIxR6mt1kAiFrA2poopOGmsCvcn0Uzt8gjd3SzeGVsXgCsDgmbUgdMzKBi1PVne
	LtXdnX00ovAhka7v5I+VbhEbQfaLeUimLF4RoP0o0sNnHhfS8HoQj6pnpt23f/o5
	GTiLs61/miBQehGAdMak3r/Zw6Co1CEX41JdKufLNRgMkPQSvidbyCCyVOHRdnpr
	F9LEpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72h4e8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 12:14:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-519fe742290so348791cf.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781871277; x=1782476077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB5TdQQBRKdo3NZtG8wlUHn81r0WZQz2AuX2RuLMVLU=;
        b=TkC0SvdXMnxdbJ7qh05Ekxyl99PsAU1gkNU54/1uBRpDtcA0R622RyEy16xgoJTToi
         yuGiZmTg+9zExR6YMYfJzFIG9MEgt5muZnHiy8ORukw51uhLWVMpb+NANPM9STdY224Z
         ZWsYeBLbMOnpBI6ztwNvk2ealERPtpi9nHMXgeY6lKfbeEBDcpX3PzuZQPFm7rgmRv5d
         fTedEnXAj2X9mVgDmp2snoFa2QnoBmwuAollcrvKlT7bXP5zqCxF4UzV50hclZIT1MUx
         C9AIV3va97s1SVtdNrLIhH3NmesRvwgGcmakP3NhsINxjYAnXGJGBQIaoDkF2d7RP3LM
         uA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871277; x=1782476077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YB5TdQQBRKdo3NZtG8wlUHn81r0WZQz2AuX2RuLMVLU=;
        b=DnESjV1AjqQO6tc56Rfc/za9BaEvjVhUy/+DDJzZvfyFJgpfxMzv8By1cJ4drR+xbk
         /UdFFvEahLJsLwm/svpCbXGET0Bq09iGKBatPIgx0DXYzDv07GPLhdhMFKMl3MECKCkh
         7d+CJgiUy5u81a42WEH029N6SyClky58dWXyJI+Mq4EOCqA0L2Na+2QajT1tH3h4A8+U
         MZkFbIqZkulovopk6cSTveosiNXfM+RGVe0/kIZ4499lqSy+JDhWsY+RGSsESVxQdXI9
         aEbmkIsWLik9ml7BNGItcPrLY45XyumTGWsc/LzljsgHh1gygWvyZH2u3pMLaEEwSVXl
         hRXw==
X-Forwarded-Encrypted: i=1; AFNElJ8dQX2PFBX2eq3x2fR2UsH/ejr608EDbeDRkpu0c81sruaaw3qWyW6NvvF9OoUX+T9WvNpbF4vCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jCO7NUzyySNtpHNlCJHr6TQ1bkXzCBBEhrCvqF6Un0IG95E7
	ythpiXn8SAdNUfHI9GERl+b1dXQlLnXWkuAHWZmMrvV3pPUH9DLC3bbx8ZpVb3Ond0DM1Wq9iVM
	kqb8oJyUJO5Xm+/TQV1SAtwKIGm9DQfYDx0vXWoyH7BmElEe5JwFEx4MKIT49Mw==
X-Gm-Gg: AfdE7cn+ij2IOwJcjEMG+nxlkL5n4CioqhEU24NJf9c36Ec+qaXL/DRSCiuVdyG/Tst
	HUBbbf+7h8/HGSOWpfSWeOUGI4l75aC9aXGI1g6I97yv/heoOQgxsQBdlNGJA1Z2ZmXBW89D/HU
	ewZ7H+1XVTMg3ryXEiBgn96jiQMUDHnJz8h8Kh37GGptOLZsY+DABge6UQVAIO/LDwC40g4lhek
	lCciuYrC+T0XoQjTMIsaouTD2C8vYJ+a7G+i7JO08gIm3iAKVMRfx3JnjuKBALxVHLK33nAB/3a
	ZMuCVzINLE3jVeFZHhNPRo5LZAbEuw/CviDwDB5fIIelNIiLLSvMDrAEGzxjw640ti9xSI60Wmm
	a2wl5S/+1tWVd0kRdkyCEE3gZnZ8GLx/XmnA=
X-Received: by 2002:a05:622a:41:b0:517:8999:6c50 with SMTP id d75a77b69052e-519fef5752amr3187471cf.8.1781871276931;
        Fri, 19 Jun 2026 05:14:36 -0700 (PDT)
X-Received: by 2002:a05:622a:41:b0:517:8999:6c50 with SMTP id d75a77b69052e-519fef5752amr3186881cf.8.1781871276235;
        Fri, 19 Jun 2026 05:14:36 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-696edc880cesm855827a12.8.2026.06.19.05.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 05:14:34 -0700 (PDT)
Message-ID: <5ad33cf2-3168-44f2-89fe-a7fe1420f8f4@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 14:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: qcom: Add support for Qualcomm MBG thermal
 monitoring
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <487f0ed1-dfc2-4f7b-94ce-60045017a663@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDExNCBTYWx0ZWRfXw42J7e9Dxv/g
 Qbm9PzVlHQkngzTGt87kotpWXP7l0wHptEEbWwXvW95/GTqMV+/n2mSB03U82h5XbpOeAuhdt7o
 vsf0oHnLD5b696WqJLt100Pa8TQ/gEGrpt2OjG22BdOM9NL4xdicJ/xwzlaHZQFMHCupQ53MoPH
 m5q2ik3BBUFn/Uc0w6sX6jjcSPeD7Kh9WZuqOR4Es46WlL/kPdPTrWXAdojBPT8V+ukTksav1oL
 ePAxtL1aoFTaoaLnPaN9nUcWOJTpH/jtxERtY169ApET4AFGAcFgUxY11omhMIQa70B2e9KR4fY
 /XfaDuU2JcUAZquPTrvzOmznOoEyq7x1RS8wKzw9DvtFoK/9Ki4IAKiZHUC82SgzhQvAhVLKCPS
 T61bWzYDN3/9XbcS8ys4ZEmFbMN1urHLjJUGPwKO/NUk8xpBu7USjBSASqz2WtbHvX6Rv6/HIIB
 HlDz9K5ke/+AeEMCTig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDExNCBTYWx0ZWRfX7SKZkznvcrui
 6dgcQ8vwzLfgS8kkz5YjPU3hpgbPfyFuw0a/x1DW/hyIefb+/XnWHRRz9bBUDG8E9uErYSJ7c7K
 xqioVURhI2f8mDtIx3HweqTEYZuVHAc=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a3532ae cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=JThlKoFKImu4mk-f7WUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BxfgjqzKWbCDRNB6oXLa_d2i4XWGPdlQ
X-Proofpoint-GUID: BxfgjqzKWbCDRNB6oXLa_d2i4XWGPdlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190114

On 6/19/26 8:45 AM, Sachin Gupta wrote:
> 
> 
> On 6/16/2026 3:40 PM, Konrad Dybcio wrote:
>> On 6/1/26 1:01 PM, Sachin Gupta wrote:
>>> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>>
>>> Add driver for the Qualcomm MBG thermal monitoring device. It monitors
>>> the die temperature, and when there is a level 1 upper threshold
>>> violation, it receives an interrupt over spmi. The driver reads
>>> the fault status register and notifies thermal accordingly.
>>>
>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>>> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
>>> ---

[...]

>>> +    /*
>>> +     * Configure the last_temp one degree higher, to ensure the
>>> +     * violated temp is returned to thermal framework when it reads
>>> +     * temperature for the first time after the violation happens.
>>> +     * This is needed to account for the inaccuracy in the conversion
>>> +     * formula used which leads to the thermal framework setting back
>>> +     * the same thresholds in case the temperature it reads does not
>>> +     * show violation.
>>> +     */
>>> +    chip->last_temp = temp + MBG_TEMP_CONSTANT;
>>
>> Will this work fine if the user tries to set the max temp supported
>> by the hardware (i.e. is there headroom for max+1)?
>>
> 
> In the current implementation, temp == MBG_MAX_SUPPORTED_TEMP is not accepted (temp < MBG_MAX_SUPPORTED_TEMP), so the last_temp = temp + MBG_TEMP_CONSTANT path is never taken at absolute max. For accepted trips (strictly below max), there is headroom for the +1C adjustment.

You check for `temp < MBG_MAX_SUPPORTED_TEMP` and there's:

#define MBG_MAX_SUPPORTED_TEMP 160000,

so passing temp=159999 is "valid" and after the addition it becomes 160999,
which in my understanding is outside the range

Konrad
