Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9A28C869
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394264; cv=none; b=Q4NkslvtWMiQf1O0Hw1hN2Bgn5YIvzazQJcp3X/yBA1uNCKn8BPYzolZrVYIE4UTVsZCEtWS6NymBUV+0crBHCpRRmYLPmWhf0GSvaGAstzHPxf8GFG0VlHtKtWRf7ShYTgLRouwmcxqgyV6aguRNx9tCteHXxS06HqxLj055qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394264; c=relaxed/simple;
	bh=FaoGWORjfmLsGMc7hDkNh5+9Vx8EZp+wsnO6iKrytRg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EpROPnMWX7pZhYFD6XckHB8l82cmicaZMg3gileHigCZLxqtBvlWdRgWTBcljcbzNyv0JKKlBMHGoiFIRRJMrJFTk63c6KonzyYvuOQ72dktZMlYzKlvtXpI7U4+Ajs11IgITgKaPdKTEkgeAmEqkgAw82jQRJAUav4Ill6l68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ml0VidQa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fOQOxioh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ml0VidQa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOQOxioh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6527gSkV3302623
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 09:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gKrFZuQAG0a3aCq2kSwLA6HFHDfSA7RjUUcLjgAHyTk=; b=Ml0VidQalj29yJsu
	yjtrGcwJfFwI4bUKkiGPkA64nbJfMJPF7txo6qLnsHeKQRxXb/1WesRQl6mKOMbg
	S3ZZ0uUzvjIoHxHwATSbrl4fxCBZow+sBhWoHIQMYY6t1QHKleEVYnHHX4Fmsg2h
	HjGvTIYxiOUilZ3t9NJQR49EZF7epF8pYG3PBmdJxyRPLirUUMtSzPxcAfi49FQ8
	lxjK+YLD92qCnNjbrWY8fttXN1oWlOvhV7/6DGiaxr6jirzJWgePxVPvkPX8cjr1
	DtEobXlQ3CfNufWByrUTt4Qz+Um/WUJS5ILhPKgbeD9lwsxsJAEyIKqQEQhWihGR
	R1OQnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18gjc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 09:57:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a236220so49479421cf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780394261; x=1780999061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gKrFZuQAG0a3aCq2kSwLA6HFHDfSA7RjUUcLjgAHyTk=;
        b=fOQOxiohX6243eZF7mJyRC8Y0bAWQGhvPqACyujLqzBK6TwoeRGdFUNWV99GU4dzgu
         KvXN0sETaRKRpt8YBftPBr4m109FIznwk11a8XgBwj6EEgkZwd7wTYfxbdI39OEyhzWJ
         j2XjsXv4zMLCrR27nnpIJ2JwhUyH7zBsHw0quPOudGK5EapjR3/jLACCcInB0FKWqf/F
         zpn/BHWIWNXTTgGRiqzVhic5YBUOoiUHiA8MR03SBnO6R90r0WxZHOquFlG03GuDjaiu
         AUUz8avQLqBppFNogGzdeOepGsGcnEVkmy70J7lPAoJc1GjjX9ijdAKtV9fZny1IzTgV
         v+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780394261; x=1780999061;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKrFZuQAG0a3aCq2kSwLA6HFHDfSA7RjUUcLjgAHyTk=;
        b=MapSjIVMyI/U5lJZiXXu1Dj7akJRfXOvhMqvTy3bQ6VE99WvcAJgvXzC0nqH4PA6j/
         hvS+K1EJQkuC6AcTbG9BEZKAuco4ygs/nN27WAdfO7eCcDQXXnNqXMqtP2Va2r72AzzM
         XbXTf6lObRa6+dgScfiV6y6TRnXmNa6OOv+FziGWyRodhpkDU0SIHer/BHkGffupKTAZ
         9vIm28GosNf49KCJTSki2Pq7idUp0Npm1U5eCl52EjzoYk4IX2/dfH7c9F9o+HNCsY2k
         X5RYELV1Yz+73GARgWxZhoW10qPC0mwPFjBrjG9neFlZpifPWVR5xxGBbRS11iK8lhIr
         NhPA==
X-Forwarded-Encrypted: i=1; AFNElJ9LXxXreaMb5bbm7Ay5MOjuNnVMmAIUtudgoUNEHpOOHHI/j3uJudyWHkIf0BGA0G1FrZyMrjK0WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds9BRcxKrXhetHjH4Ed+GQcmMSGegj0qEgPvdPXQvWSDf2vje
	q9p9WzCOab/5EYANQXZNeIAFVB/wdjjDuDzJUjUIiJJ3QzX4Jwh1vWrjRhN5sFp0CP1s04l6bbf
	eVDBIgiCr148HPstyFJNyzDnUlNaXkA+wX1S1Z58vxDXd7NeVFIb9BlVSUeoivw==
X-Gm-Gg: Acq92OHvHpj00RFwKrBUxO8+CEicBL9w2FQKdDNe8po5PXIRL7UL0IT7+ToUtl29v6f
	o1MB0azTVt0Xqaj8IXSgqKJMokEB/3yhmEEFMk9KHYzhsfb4dewaRgloaOYGt42VOEVPY8ePs/o
	8rRyp+CkP3GfSQnyuUh15MWAegxEhXFViz8l18AIcZYB8K6jRNLqlvyEi7q54l2esX9eK5R/Cla
	MiJY/pNTP3BBksZBJV/QSJp1njnhM5ljDGMYqESmtt8FOemKgecvMC+gHY8flztU7erMSquNW6h
	B++gX6vgsb7ctYIZXmeQL7dcTZGMpGh055+Llk+LnpvNj0mFK9KL/D2Qp29/w2Xnig0KXUL6EAW
	pxElKTgzI7elqYUd650sYpd6m6vIQoDxzrjPkcYa/WrqSpBVqtkRPJCVqBjm/G3P8x4L17Xfvo7
	tx
X-Received: by 2002:a05:622a:790e:b0:516:e033:f5a8 with SMTP id d75a77b69052e-5173a8daddcmr155758511cf.59.1780394261429;
        Tue, 02 Jun 2026 02:57:41 -0700 (PDT)
X-Received: by 2002:a05:622a:790e:b0:516:e033:f5a8 with SMTP id d75a77b69052e-5173a8daddcmr155758251cf.59.1780394260962;
        Tue, 02 Jun 2026 02:57:40 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af0babdcsm37044295e9.0.2026.06.02.02.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 02:57:40 -0700 (PDT)
Message-ID: <59afecd4-7749-4be5-a261-a850634178b1@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 11:57:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
 <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
 <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
 <0c5033f7-1535-49e8-a502-426e54333496@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0c5033f7-1535-49e8-a502-426e54333496@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1ea916 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Fuur4Mi3Lvfw3V_heQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5NCBTYWx0ZWRfXyj6pymSDDQCo
 mqTndxcSqwMXuxQocxedZRWJn0uqRBuQd4SEQzHV6Do/VUpFwltI8jOpy4yUnmFgUft5bTtiWAi
 znZhJ0sb/98/id94Mg3HalEMELaNRW6emr2VFyHyVl4ict8hpT7Y81Gz1Mz0fnPvZsOVU1I3G5Z
 MqdtB7wFzDIZ3zZZKEqdGtvaQDE5udl1KaHeMAIcN1WX0MXlZb7met6UjMd5Z3XvWk63qTkONgE
 BpDGH3LhDtFo/Pq5XJtVMTq3QoDTcAbSTR0EZJPcubC3h/rFnLleRIJmK+lfEjqhClpztmH+Z5a
 a0u+TeiE2Nxz+/mb96rXA0IWHSOLeWrn3qOfg8W5M9nvoPBpSCDJBbFRSwvyIWWsKDkkILdQ1vR
 HEVwfcoAQHf/TTNp2dsD/RJTwgIwFXxZnnDnYHg5HSefE5Ta8WBPQWluazgOCD444nxjQT5Hq4Q
 XRfLoYn9OmMvn00UIeg==
X-Proofpoint-GUID: Wn7d02XRkABQtc-iuEL9INlZASmyEtVr
X-Proofpoint-ORIG-GUID: Wn7d02XRkABQtc-iuEL9INlZASmyEtVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020094

On 5/31/26 21:58, Daniel Lezcano wrote:
> On 5/31/26 19:49, Ronald Claveau wrote:
>> On 5/31/26 10:41 AM, Daniel Lezcano wrote:
>>> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> [ ... ]
> 
>>>> +#if IS_ENABLED(CONFIG_MESON_SM)
>>>> +
>>>>    struct meson_sm_firmware *meson_sm_get(struct device_node
>>>> *firmware_node);
>>>>    int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32
>>>> *trim_info,
>>>>                       u32 tsensor_id);
>>>
>>> Do you really want to compile meson_sm as a module ?
>>>
>>>
>>>
>>
>> I don't want, but if I send a patch to change tristate to bool, it will
>> raise a warning because 'm' is not valid.
>> If it is accepted to ignore this warning, I can send another patch.
> 

[ ... ]

> Compiling the firmware as a module means it must be loaded before the 
> amlogic thermal driver, right ? Where is the dependency declared in the 
> module ?
> 
> If the sm_meson is in the platform, it should be selected as part of the 
> platform's component. No need to have an option for that, no ?

The questions remain and PR is approaching ...
