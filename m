Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB2372663
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112138; cv=none; b=f3HavNyLhxtzGaXFzkGLlZcKjzMlojfxPQLjKYxFluXebAx9aTgzPVFyJ6ttFJD8zQ0jh86p17bgWCbXZAJ6+dlU9OJF3kwVD9vHA6sOmvAatf54N/pGtqQETjhWHHIrX+JgQfhYkVXj/JEvLWm9Jwg7oXKDvfBpfQxrd8d2rJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112138; c=relaxed/simple;
	bh=/QxAox/yuhLx/SfnR5Y6PevoCIlAq2j810Q+gZAdCGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jr/DpaX83SRmJ2/IL4OiTLvZ6mQucrBLCcfDOV8BvYwrY7LdylCwcDLI26b5P/wplwnR0msDE5cZbpbPmx4r1AxiExmS3ETaEseIHK9qL99q0ENPY/Me3Zl7BiFBewEIUUliRVEPLg3k/g2tA6c1ZD09rHUkEsYqfEnA5cV7xBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqAjdI3+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KRhCB1nG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqAjdI3+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KRhCB1nG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CflCu1035618
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6d7JDTDSs9JtLo2+JHJjhDzBPh6JhyXr4gi+9mpChc=; b=VqAjdI3+lkjuMtW0
	KVkXrlkN7hpT5mDAVmJlTBC2dd3x+iIwn8VKrGAjeO8mJJsEpGGb/5Y/et32GkuJ
	ghnS7tGuRB28+dPbjCAY7g2bfUFO740/61AN3BjE8G7Dgp5OCNTdN0BMGJyeTxNV
	Ui1HmYs+JqooqidFCTd9oveze0YTg0xEP0djWT6txm+o7u+HvH5+yZC6CGPxBqWK
	prVq5j3kSS3k2ujREzdXB7uzxjbOHQk8ZvcHwLQGNwRevHj9pEt1NR0cRb9zlCWP
	jCogGWrVlqnkwpTSbmk0GmtPaaTNfDLPrNHKuRtNlqxr1OHBVy2KNhJkt0Axdx7U
	fayCOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwege0ncc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 14:15:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so37224431cf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786112129; x=1786716929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T6d7JDTDSs9JtLo2+JHJjhDzBPh6JhyXr4gi+9mpChc=;
        b=KRhCB1nGqUrbzyYVgyYW6r6t2mhf5nWV689ztG7jH4Y0Pg52ooEOeur/aoo6BUorY4
         MHfBRWdZL+4u3hNdvQsObAZJ9TYCTAzJ29d7fLLZs6gM8Lweammo66aEhIziR/f8ztT4
         QAnSycSuwRkrOHTlhOrAMBxIr2qfH/P1sXT9OXtVo2JMLePe1bebib1vVjccLMHe9eXQ
         7PL4FOTP0b9LQ+H4FWH6vMSIa0+9RTREQ5wy9G31E/J+fIRPXUppmvj+LUI/XKOuckxJ
         qrOL8pBml5AxfpXiEqdjVSqbk7slCWYSxOEz/6dqPYdI8QcG1hmO0ZclMy7lCzN8yWg4
         d/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112129; x=1786716929;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6d7JDTDSs9JtLo2+JHJjhDzBPh6JhyXr4gi+9mpChc=;
        b=Cb/mA03nbE9lCjaQXsBsedcD82UL5c1K1tuzMVGkUwD9DHjHnZqFBVTU/36w2rRCn1
         1yGReX9TrK1/Ek9VT8qNQ8zilzJtKGo1KfEZjGEmOO/WU93necY3hHX8ZDO+BLDSj/j+
         sU0mW3ZiNyUxdQXe57iTZTikPRa2HqBTq1P3FJxDolpllhibn8qYo16qgq0OCJvUIUAD
         ehr4ifceEuWSgSmftwSCN2dcAMN/k1YwKYGU7Dr2QtQMf6FT0m23/DoOlxTUQU5Uhz+R
         23DDz/iBKmKqoe1PKzBooR/MCliaUQ6CGsC6msBDMjR4ZBudoQzA6V/GiP32FM2idJXv
         o4lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rolto5znchtgV+3s1scL7Nhpk84/JI32/e8m4IfeLyApzUPYVapAV2AFZEbd8zpCRE54keB3xlNKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaazzKr3itVHA1FuNklphRqsXO7CKVhEqnHgE8lhvOdxKQU7H
	hVn6Kfd0sQtllsTOB8zolG4krqffwLsXRUzbElBEhYCADYrogI7Nw5DUWYzW9Lmm2CKVprh1gRv
	OwDpWhMG1l3DvZREtLxH47d4wXUmJjrViEEhHI6hli0cRMz30Q5tvBplv3I1Nhn/L7QnoDk+Z
X-Gm-Gg: AR+sD12Fuw44TpNRyLEjL7iuSDIUdwnpBV4l2MNRnh4QqubwH64Ld2terkau8sm76kx
	G9ZcUGgvQobeR4rSaRwXFzxcB3rxn8+10Ch66jJHVR8y7Cpf6rDSZwWozxyzWPAbcfAMoBXISvn
	P72LKihpVCuwXCXx+dJVmxnJKo5fesOBjOI+2ZzvKVm0PGSnPsQhpxJ01gO5CcEo5oCZD/wCmcv
	mH0F36I7dMr1a765AeCME3tQXZwgVTZUVurFFcS096Kk0VKlHT2stsZPgVlzCEG+phowui8TZOu
	Oycf1SeWzTan6zuy3tMcksh7GrBcqsnROiTXms4CEtqCBpRwGB66yqf2EFoYp0vrdJhxP6gGjVH
	Hd4nIOmJGN/HqP6JRWQCiX0z7ze4FaFHnANFzAx3mvtZeeA==
X-Received: by 2002:a05:622a:2b05:b0:51c:15c5:2bf7 with SMTP id d75a77b69052e-52d18e6aea4mr39011401cf.12.1786112128907;
        Fri, 07 Aug 2026 07:15:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2b05:b0:51c:15c5:2bf7 with SMTP id d75a77b69052e-52d18e6aea4mr39009541cf.12.1786112128157;
        Fri, 07 Aug 2026 07:15:28 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8b9bsm7040072f8f.25.2026.08.07.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:15:27 -0700 (PDT)
Message-ID: <04bab99c-eb54-4f03-b69a-f9f1781f30af@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 16:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/lib/thermal: fix misplaced extern "C" closing brace
To: Andreas Haufler <andreas@haufler.info>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721083230.91246-1-andreas@haufler.info>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260721083230.91246-1-andreas@haufler.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XbpOSbb9dT0Ioc7xbCNogYPPpJKF0GIK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfXx+OKWpra5gf4
 tR/jFhRX31/cxCIHOjljeHWvppl+cu5J8Quu8SOCeqnyAdnQOjazxYJkX+luFNVoCK78ZaCQV6i
 fePoWJPS0hNepWEC9A6LoAmUUiqk52g=
X-Proofpoint-GUID: XbpOSbb9dT0Ioc7xbCNogYPPpJKF0GIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfX6xK/LdDooYmN
 JWZE9fq58sd18WsYgnUuBpRdDIMnOgbPHA0HzxM9zMFUT1n3QKc6cyQgxd3NirrJFo/yCOl7MN5
 +L/k1t4yCEZ2t7LELO7x6N7xFQjhln7789I1yq2eQYcrjCefWGN47kKn2rLHaXyX69i7Ylh0oYj
 Yal+DCmion4hm8h6rBudel0EFBoQFpkBa+7AlExPHgDNWdk9PYQhuL7Gmpqi/7ZnkWWxe8IhdRz
 Tt6QJfHHZwiCIrhxAMInEKOiDlmywP3iHJVswIwpOZ5WRZtdoSR3TvRtMNoOxZpFE17wGN8aKJq
 xqwXVK9Nu5ohiT/Gdofq4zjPEoOEiFPJ/94n/tgFWDX/0yjB1EJXcDcxFPf8SZBaHRbv/fj8VKr
 wr2Ec5m/5ByrUiKsUPFMFf2lL5l4LpWAGS8Ho9fETrODg9lWirNOo9RIzc3AHuNgTxZu7ajTtss
 WcsMnxctfcMApp5wmvA==
X-Authority-Analysis: v=2.4 cv=X71i7mTe c=1 sm=1 tr=0 ts=6a75e882 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=D180SxLIAAAA:8 a=0BLcRpZjDYjvCMoZoxEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=7EgOJq3TvVZn8UhVc1oe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070111

On 7/21/26 10:32, Andreas Haufler wrote:
> The public libthermal header opens the C++ 'extern "C" {' block inside
> the __LIBTHERMAL_H include guard, but places the closing brace after
> the guard has already ended:
> 
> 	#endif /* __LIBTHERMAL_H */
> 
> 	#ifdef __cplusplus
> 	}
> 	#endif
> 
> On a single inclusion the braces still balance, so the problem is
> invisible. On the second inclusion of the header in the same C++
> translation unit the include guard skips the opening 'extern "C" {',
> while the closing '}' lives outside the guard and is emitted anyway.
> This leaves a stray '}' and breaks compilation for any C++ consumer
> that includes the header more than once.
> 
> Move the closing block inside the include guard so both halves of the
> 'extern "C"' declaration are guarded consistently.
> 
> Signed-off-by: Andreas Haufler <andreas@haufler.info>
> ---

Applied, thanks for the fix
