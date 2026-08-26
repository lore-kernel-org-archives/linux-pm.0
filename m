Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE63AAF67
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745301; cv=none; b=hXEnaL9u0pdXdIIX/m7oYdgPMMNoyI/fr2DV8GIg/St/bbPMYPBzeplvfdeKqBDoO61rmpPWwoamk0BYBtrazTtNE+9aHhTdmadPIbilAYwSuxyAM7vU/rGdmrFxaq3uvyrxx8c4G0+LOw9ba/8ScdhegZ0W0XtWgBNwHlU5C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745301; c=relaxed/simple;
	bh=1bL8SHeY4H85ODVaWl9myp8bt68czbdVcvClUWMwZgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wpm0Y46WH7rA0CIzpRaOuobENKnZcxhynF4rV5n9UbsfnM9wkkvtkn8ms2x2CN38TVCeOTCJnQHZlv2dpqL4qs4WoH73QjFOU4WJ+eP646Epkqu+11/zzgWUc3XfZwm77vkREKcXx/lLB6b1DkqfRxmTBHc8Gktta5kQolIIk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxtAFUjT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQcPRL2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxtAFUjT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQcPRL2H"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGTTq1658496
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJXhURYbF22u5h3SNtJoh5SZFJhDJmU53UX6OeRXsy8=; b=LxtAFUjT3OLnYJSo
	iTXTYynpeMBZks3L4NGPbINgsPIJu/3jPEXJrSKSfDkvAvKsbOgS8/xA2pH/39Rj
	yy2dHdNl65obDPrQPNthxMCMAMWgHh884PzNFcJq4nm9LvoKh4XsgA66eT1Smh1r
	AXIulxLmeOEBewWZYQvqjjTXLgC+yyjIosqmLJImuEwzwtk4RStmdaAJiANAkP0V
	1xjbgX7vtwHu0a0qX5p9DOuVIYsgr9KNd+A9Et/Oto7ZZmbAvd4euQCNwqFA4O2p
	eDfabYu69tKt10PyiZ60B4SJyK0M4vABOiJW6TOx8CkqbOwx8hGEUuuTRvWtum8T
	o5/1SQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1s2tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:54:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85326b426c0so764997b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787745296; x=1788350096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJXhURYbF22u5h3SNtJoh5SZFJhDJmU53UX6OeRXsy8=;
        b=dQcPRL2HyYx1eLxkjH4eHTXn7P/ISmBL4ZnUtYZ1oynh7D0+JWr6EXuZA4k4Esr1Bc
         /GEYM313En+7Inr/w3VKZ3FHWmsOc/6NMHlQJ428N6UFuu5PrCn+Xa/bHWdRgyo4yp+o
         QfAeOw9Tg6A30MvoYwKDGEcUlnOTciey6luH198D+818TtBqciwN/g9SQorezdo0t+f3
         EbtILsqL/0+Gc7fK5lkZ8XKRGfjMp4UFay15Zt+oOhnNpdi6PQTxo/H7YBpdPOQOoN4F
         okM7tIpgMJco+e8YUxYuO5yxKkzq/mnkOU1H1f6ckLbAp6FUwtcsz0XXVPKF9Ff8XxVB
         5adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745296; x=1788350096;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJXhURYbF22u5h3SNtJoh5SZFJhDJmU53UX6OeRXsy8=;
        b=BCiTAxYFJ4ilHYJ0kgCHeY7vaJJJ91o9y7bKb+3TAGp1z4UT894ibMtUOXzk98TleB
         zN0S/+xszowodT6fmAJNuGjYXB6HP8IeR+wIucqT9nRsqHGj48RphfZLteC8/Zv21lWL
         Q4dcyewocwNJll1M1aBWYbtiRyvGnnBhrPJBNn5sdreM7IpoYrKX4SpNEOv6Gx+FebGV
         073dbjb1y53cCGwbE+Z2m6AjLgmyovdlZbG4UeY1SgHwsj8sxNsOsgH+9Fgt8eNaJPGj
         +mCcECJC1zXfCRuyJx3fdmmnLe9mP798vkkPw+P4/85osRFTAghLC/Vtwc4WNTV1AI6d
         kZiw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr8pCSbbmIcGq+TX6rGofi2brgjShEr19GLaQKKzINc/d1poe6G34eLLqnu4uTEnJeBjdPRFniaA==@vger.kernel.org
X-Gm-Message-State: AFuF++lMPMljSYOMSBmIUbVL0KBSZ+EGi8ZH2OHzSqK+vfiCEyei2Dlo
	JN9r9HmJrRS+IqWBstlQyUVBV9u5D6FPRsabT0v108LEP5/yZG804bMWKnfBdBHuYRGvqtV8d+Z
	eKisINtE/PoGcbpppGZ5IkIEJrawbWdt65Qt4A4ild3ecXsAbnBQgIZTEG/X95Q==
X-Gm-Gg: AR+sD10QqKXgFZEVMmcOVsgVMElgQ9v70yH1ViMKjxEC2WFgINimMQWCcgFGXS/naDx
	yXc4sr2F6cfA6lKs5OCwoRSW1pj4VToHxkIBEe0lq6m6QbnX7xfLmcoCGQZTZtPyvmM7kTT33ob
	Myn5CyjmlFJoIUwggo7x+hkjnMoysp1tWiVLKAEdPO1KmzjShX/A+Ngo0w+fYWFQo3c0zzYH533
	QPePrg/acpttIjcQgOMmmjETpkuH0V+fJETY+3NxP3RUXuFkdy9ezmFgMV+UpxOTan4NpqE/j99
	PbJ8aLYARSIut8jS08eeBj6iCQOcWrKNAAdpi+M5vIOAWY5kd85HlFg4W+LyVyFjd0r5NAn/2+r
	jPhaTQf5+K0/Vo12iVl6biLCpH0ux+D2JYR8=
X-Received: by 2002:a05:6a00:6ca7:b0:848:2e7e:353a with SMTP id d2e1a72fcca58-8536ec13a78mr13481238b3a.0.1787745296237;
        Wed, 26 Aug 2026 04:54:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca7:b0:848:2e7e:353a with SMTP id d2e1a72fcca58-8536ec13a78mr13481100b3a.0.1787745295712;
        Wed, 26 Aug 2026 04:54:55 -0700 (PDT)
Received: from [10.217.219.186] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cf3e982sm793514b3a.54.2026.08.26.04.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 04:54:55 -0700 (PDT)
Message-ID: <4efcdf15-286c-4bd6-a75f-77fbca07e7a4@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 17:24:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <8af7a34a-da4f-492f-a51c-cc420edc5e6e@oss.qualcomm.com>
 <e000c3da-32f5-49ba-9aff-b2b17db23927@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <e000c3da-32f5-49ba-9aff-b2b17db23927@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mS3vfr2_AVp4bEcAY6JOI7UewIyKsE2W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5OSBTYWx0ZWRfXzznpNlFU8S6G
 M6F+Pdbh4jAcpdyfu4UCfDUbsgWfgPYk4abqjdkfcYl8upOW4c68YGYPASLVYT1ECrucHM8LZnY
 9LafVpEQItGmMug65Yy+/q+Za1VkFwFjJKw9dlq+DbzzqinNk7MeCKkhRzu8/J27vPwf2vAjrvY
 488crXHa4CC9dZB1yJEHRt2th7pJ13dUXrlNo68WYD4C0UlSxC1edyc1q9vllJAer83nCYQGmVO
 S5tRIwsrh1hIAwvafdqLcZh0qj0BJUQE4MivoC0y4UeapgD+bpmJnY58OCCilC6W19ju6z/bFBS
 u1YE8AlavjOzOReP2pqyEHugFAm9KEUpaRrPBfvL7zGxuZo/Vf5az2SJFaLujZ4B1cmrzs5XDHD
 ro34GlT3kv5Qmu3Pgws7QsXs9dWqhngdsdMIoOo2kILiSLR3YOIwqzgkNehhUr9T2QHEIUieWZc
 I+cUTC8NwzYdoguSPyw==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8ed411 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=4Fh5LKrImxLeDWyZwEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: mS3vfr2_AVp4bEcAY6JOI7UewIyKsE2W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5OSBTYWx0ZWRfXw4I+w6TDLGwg
 tKtDrou/pBuXCYlQKmvOcYfmB2y6RAHBjL0LZKQxtD2iDWNjTnTa8tbAWAreSluf5AykypXK0mA
 5Yp5Rt0Cbmgw3gFHvjcNP1RNHEsHYpw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260099



On 8/25/2026 12:38 PM, Praveen Talari wrote:
[...]

>>> index a23554d101fd..4561e2d235d5 100644
>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>> @@ -213,11 +213,11 @@ static int geni_i2c_clk_map_idx(struct 
>>> geni_i2c_dev *gi2c)
>>>       return -EINVAL;
>>>   }
>>>   -static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>> +static int qcom_geni_i2c_conf(struct geni_se *se)
>>>   {
>>>       struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>>>       const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>>> -    u32 val;
>>> +    u32 val, ret;
>>>         writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
>>>   @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se 
>>> *se, unsigned long freq)
>>>                    itr->clk_div, itr->t_high_cnt,
>>>                    itr->t_low_cnt, itr->t_cycle_cnt);
>>>   +    ret = geni_se_set_rate(&gi2c->se, 19200000);
>>
>> hard code ?
> 
> Good point. The 19.2 MHz value is not intended to be a permanent 
> limitation.
> 
> This matches the frequency currently used by the I2C driver and 
> therefore preserves
> 
> the existing behavior. If support for higher source clock frequencies 
> (e.g. 32 MHz or others)
> 

This is already added in driver for 32 MHz and also AFAIK, support is 
added for 3.4 MHZ which considers 100Mhz. so make it something which is 
generic. Hard code is not recommended here.

Can we store source freq selection and continue with that ?

> is added in the future, the requested OPP/performance state will need to 
> be updated accordingly.
> 
> 
>> May work currently, but if higher frequency support added, source may 
>> change.
>>
>> Also you have added in commit message, but add a comment also here.
>>
[...]
