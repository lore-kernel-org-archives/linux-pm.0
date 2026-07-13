Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF431330647
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961795; cv=none; b=Hirnrjar4DKfgqk/yiY7HHr16K4kh/8mQwXJlcHwylrkImvfpW6Gv9EztlxhaXE5xE/B6pDgXPAlStFFuoaYGLglxmx3IvF+aweJDkIpHeEaJaeP6Lfo/y9wzPqqmvEVAfRD9y3AHqVvv144YMASKj5H/J8etsXMZoCnWCn9sMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961795; c=relaxed/simple;
	bh=YOVKcvBDcl5QeFIAYmJr3NYTVxrvLURqfEhDCmXKHeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=looymN9NtPVQk3bm00FI5ShbDUTYbN5+UXP9XERqaVIPvrwAF+H2tWQ89/BcMFtty9kFHRgbuB0FE4hs1WF+BfhS6lBQJkXEt/qqtQPHjgo6QHMwag/qapz8RZ2ztLojHws7lCgWa8hV5lG20OUuHsojIUih760Doxtu0InCxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JX2omM8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNWuKHD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JX2omM8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNWuKHD/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8Bis1611581
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=; b=JX2omM8E8z/tMLmH
	FL2pZTMG2ZNKDMkAxp3C7yP+5WQJrFXtyg0G93RezL4by1z73TfdjYg+GZ5V2y6b
	v9IPI6yW1X4RWTUjziCnYbxSN3KmV84E27YfHYPmPKxsfcS5rbor+NJxHNa6TiIE
	nPjiXm0guxkHo/C96M82y8uqyrN1Iotf8LGOopff3oV2yB+A1tVmgnQYlAz4S0JA
	OIz8oXPxgZ1Z2GUGC9l3oKCNHriAURIGjKGDLEaW0elNxWQ21GhFoD9BEi6cn0fL
	dVtrBJ699iuY8ApfH4PVYDvTMPL3JqdlGkGugZ/kxq/PMU8dGz3XacS4ltGiYiYB
	bpZItQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qsvbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacd6d37edso48863725ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961792; x=1784566592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=;
        b=gNWuKHD/NteJBvMZP8Strr9kH93zeDw1vj5LYjmTe0LqDi8/JQDREOg0432izjV/jG
         zqXD0lo23VqJ9YFPnImzV27Ty1+qckDfVKM0RjN0H8uwKHFana5axBCktTbrmmeX+lUc
         UvrySwLP+N6QZDZx8f6ecR86yfdyFgpXds1V1Z0/YFqd+NHO58c08uXhmqNkPFFF3IZ0
         Fyw4tRc4b3E2jeWQ3tTDpQWLv7QnALu7DBLG2DxAc5onRPHUKQ5MQ1XTba16UfjTn/lV
         9AhMVj3BULnQxUCP8y4+/yJ9AoU8RSdFvJalRua78n+FNGnc+HP/arg9M1dmeLsHL97N
         T0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961792; x=1784566592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=;
        b=I/XluSujLWyQwffXDXV8PoZuVGLYS1xvtWlYumYqGYD1hQYzoJxPhVBtkvoS5lHObq
         SA6UlLOiSPGQhoq9cwNiCufRRVW/GVrsci4g5r+6znFpcoi10KqLq9GwR7h+TVEEXehT
         X4mVN+762fUlQJtAmZ49AG8WXSvMOLAMlVCp9zHSLue/f2g2j/5IQef/ftbPQJQOVMbd
         rkjH234cwmkcfpJivtVEXSVeyKXu3LYK07giCjQUywGIvb7ihkn+7Um/Jh/jw7pcLcuh
         2fO7kNulX6JyMhP7eQ652nu1GXjuTUfyh/MPYRdKlMDBUjfFjIpKyPzkaHbeCO7OB4jh
         1rbw==
X-Forwarded-Encrypted: i=1; AHgh+Roa02uNVobSjTAeNZYDIN2Z5fNaRI0LNh1/lFn8u0Fa6suYLaRxbb8hDpnTtZ/9ua9Qi/kvS9UQlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3rglaaGoktKTL3PYJslxjBskaOzrVQKxf11cd7AZf2wXKMnN
	/8Yl5Znu4PiLCE+nNgOzgHZih7yBIxcyypWME8WoF17NBf/LGNMaV7WprefvKKxQGUNP89wsOqs
	FjIRk1cHbORoqT7jm5TKSrpbNsDix1WHH07+lDKNTpK+Fz0TZhtEXb58oaiUAxA==
X-Gm-Gg: AfdE7cl/lWf/v9Sr71VtaHHbMZ1Pm3n0GMXj20hoZA7MetN/lVhtjmtlAxdhMAwb677
	nt+BW1LPONATPisy22EvDVkMtRhh+uRtcqu2GcLXUHW2mH3QXBZaInftSwngBDME50ppIB+O1po
	ek9vExhYl+zm5YSGlPVAcQNhWhW6cMB16zc1i0BWZp6TVNe7v7m8LenCtxERP694GWSXqvvOcs6
	GG589VLQPyYSuhZvGGGRKkjwXTc4y787nmH73cqUNedmobo+enLvaxVmqikcvyQvpqmP3I2Y3we
	Q+N1jIDOtmC2hL2+/QFeOAaA/DdimMK+/JEVasverETaRLP+8Ftr4QkofO0Q2tkZwBo0yvAbhAk
	XiVj73feM9GSPJsMQ5epTIcu6YICpcIvkBXHMQnmrBxjOGw==
X-Received: by 2002:a17:90a:d403:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38dc777b95emr10042724a91.24.1783961792562;
        Mon, 13 Jul 2026 09:56:32 -0700 (PDT)
X-Received: by 2002:a17:90a:d403:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38dc777b95emr10042704a91.24.1783961792124;
        Mon, 13 Jul 2026 09:56:32 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm76694721eec.27.2026.07.13.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:31 -0700 (PDT)
Message-ID: <cda89e9b-fa5d-4a17-9427-dcdadc0d8491@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <aktEMg55d6J_omaN@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aktEMg55d6J_omaN@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfXyiQvQRJLympy
 HTbiVlMaKWwK0ZjYX2qmE0r8Zx7dKrRaVovHkwLa3zyt3Ep22VUsvkyhu+IX9efXCygGYfpaZ52
 TftJA/qWvtQDaI/CaleJMP7EF8hBHg6JOAMrhOW8cTf1yY0azef5U2yZxd23qN+QTrrROpWOarz
 Af6Lyl6dd1o0n0f2s3lm8+iWMusikulbTYp1kQ4F5XNI1lyGis/Zxm7vQA6+mznupkrBES6csyc
 1v50z1/RCr/o8Ug6PQP2tXAyq0bOjZHfzOLA4WUGTeke/J02Rquv+Nrq2rsHa/dIj7gEVErCEZE
 TPCXESdOMOZ1CVNEvGGS+yfr+hsuJViRKFVVcAUjeYnIwOzARHxpIj5J1lPWd3iPJzLwdR/12Yg
 gqF/+Na7O9V9+bTyigcA7l3QX4aw8PmruYWxT6tHqqDGDBG+2jJFrUEfdZDiFs7S37+B0sqZmSI
 iAFhcKxnXnArmW32z/g==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a5518c1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QSFfxCxHlpgOv1NLln8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: dhxS3fybgRUjiCkfedeMhBQQD2wyoZLV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX0uNSOtoFPV8G
 YdjSj2B33kpjsJIC/Kl4xgfyPMjmjqXhNOZaoedT4vBDa/Buu5putzgYp3ctJX0AAyRoLaLHWa9
 QqZhmCv8tUkQW5+tc03hnDYrwErA3FQ=
X-Proofpoint-ORIG-GUID: dhxS3fybgRUjiCkfedeMhBQQD2wyoZLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Andy,

On 7/6/2026 11:29 AM, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 10:23:35PM +0530, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
> 
> ...
> 
>> +DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *, adc5_gen3_mutex_lock(_T->dev),
>> +	     adc5_gen3_mutex_unlock(_T->dev))
> 
> Logical split is slightly better.
> 
> DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *,
> 	     adc5_gen3_mutex_lock(_T->dev), adc5_gen3_mutex_unlock(_T->dev))
> 
> 
> ...
> 
>> +static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
>> +				     int sdam_index, u8 tm_status[at_least 2])
> 
> This function uses exact size of the submitted tm_status. Instead of creating a
> complications to the compiler with all these new fancy attributes, just pass the
> sizeof in an additional argument.
> 
>> +{
>> +	int ret;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
>> +			     tm_status, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
>> +				     tm_status, 2);
>> +}
>> +
>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> +	u8 tm_status[2] = { };
> 
> ^^^^ The only case for the above function.

Yes, it might be better to call adc5_gen3_read() and adc5_gen3_status_clear()
directly now than keep them in a separate function. I'll update it this way.

> 
> Also why do you need to nullify it? If it's an error condition, the compiler
> should be clever enough to see this. It's not that complicated code.
> 

I think the null initialization is not needed, I'll remove it.

I'll also address all your other comments in the next patch series.

Thanks,
Jishnu


>> +	int sdam_index;
>> +
>> +	sdam_index = get_sdam_from_irq(adc_tm5, irq);
>> +	if (sdam_index < 0)
>> +		return IRQ_NONE;
>> +
>> +	scoped_guard(adc5_gen3, adc_tm5) {
> 
>> +		int ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
>> +						    tm_status);
>> +		if (ret)
>> +			return IRQ_NONE;
