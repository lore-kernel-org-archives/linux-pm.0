Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34A3CF95E
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104111; cv=none; b=gDw5v9ew+qKnlyH73sojySOROEIZDoQYLFiW1JuUL5OF7PEKtfDt426Tw/V9ECFEBPf2jn4YlPw95dN7DJi10vGL7YFuQH3IjfSoiBYkiiZUEvudyo6rdyL2AObWOZdLQvajpS6+BkN+IKRE4NIyGYdmKcoavV+hOANub2bBWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104111; c=relaxed/simple;
	bh=B0uti1CPQbFicBnvePoAwv+eP7JNw39gAjbpVG28OJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYZ7V6fcXtzDvOqQJ0VQDphqEbI3iL5wGtqBwR0YOR3eWO4u9SmJOY2RuPaf1Vri3APcW3JrSA6kmADhJk2C7arhYsV6xZV2Pi+Ms/prN6Kx6ubXZm74mdfdxbc4AD1RQ1DemmmuUPm3rLtgAdpLJDXmqVmovEC/9+8qh3FcLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRW7UznB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUPKl1QN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRW7UznB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUPKl1QN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67781BnS3179140
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NRpx9LYw7i4KLEj8Owphyt5EH7uTHU/Qvcis/HYmUgU=; b=oRW7UznBIqcAT3Mt
	hoUJbNhpbaaBoVJoqSlzEy/3VOoIHF/lK6Isg3cxKv0QTOf1af26Lmj1Iu0Hu1/h
	5KoRTD83CfwzGciEaP3donn3VPqE2f9qbGSAJSedDwiEWt3DLKyuF2vWCq6MXzyV
	Qd6JXcr+Ozr2+a3wfyHJzeLcfIL1sJMg8ouix7a+VBX6hknSetpc67TP41PXerjy
	H8UVN57C4LWUb8Z9ZiL/I+dRuBe8XVIyNSyZ/bWJvRlsIz56TvAcVkcwNSINy5gZ
	CHs/oAxlExV9u0ENIfaruk++yHG1/bHIhI1Kfazo8kIHRoSu/v4srJ5Wbb5JvTVi
	TGP9Iw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jkq1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 12:01:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso34694481cf.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786104092; x=1786708892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRpx9LYw7i4KLEj8Owphyt5EH7uTHU/Qvcis/HYmUgU=;
        b=JUPKl1QN9NOodI0Mbf7HbAxYCOg/Nr2tfq9PIUxfBjbXJOjRcEfDK9+68FFZ1fHJHN
         +R/N7Wv8Z1nmCkVeuIuEMQZZwQX6vIR0UybM7SxfxkQOwzvRBEtF5OcVi0r/MNsSp7M6
         OhGD8ad8+Zz2Anq+eDkoPJw9hUuLTUNW+Wj+FUiDpgmjoyKtljkBDNHUCvFGfUuwC27V
         Gw8MO46zQtGKDHxgvtlX7SJ8sfzyeqFjoN5OJ+78j5n5wTN/Lzzb+TUn3tv73+g9sBlG
         f2/qfKozxr1kgOTtjLbGhAlBiAAQ6SwBKbP0EP5tTNCOZqKSimWwVUiaiZBAwEr5I/mE
         5tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104092; x=1786708892;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRpx9LYw7i4KLEj8Owphyt5EH7uTHU/Qvcis/HYmUgU=;
        b=ZE3UrGsiZvAc6W5szmvyPQzTprwFD0yOHMI0TLcH/QP5XgMmJ8G8yp5dTSS5/S2Z+x
         fcRH0K9ExU4gw0VtguQyY7J+Uq0OEr8GsKFr4gtzR12eNnJO3evMoQbzyzLyPg3keNQF
         Ef6gzCZEbm+p2cgrDAdptHhWr7Unq8fn9+8RMDtP8BUeFAoT8lkLcEDfVExtSnW0TgLW
         J9sHysjugfyu+VlTH2v4S0II1mV2ZjjAhEkyz0sOvs1MYc0GTwV8wGI8VGWuwBA799NK
         OZ8aTsy7tFJNkcQ3ty7mC+IoghGhxO57p2lQSiNPhM+du0RfQGgWCz2NKi7UuD4oQJBS
         eCjw==
X-Forwarded-Encrypted: i=1; AHgh+RqrlbYNaGhNljDamJmDUaIlP12yMInoOig7KYr8FE4w1B7cLO858BqKgREQX8NcVr58S7TbYaDJ6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2KEfDbdSDAXo1yYznmRilMDJ2e1YWxD5Gf0I8s9Gq+vF7FGd
	LNqPOjqq9/Vi9fOryC6IMEbbMYbzMf/Ur7j1enli08iCyWYsI6xG3dp6fLQC/VhD4fEfI/oqdm5
	RMJVCeCd9bIHYrvIOjhTMU+EnETh1dwmHm4/FL1DwId5bS/8ubynq00mQAmBScQ==
X-Gm-Gg: AR+sD135e4iPCc+N9SaHzJWuM0QIyGZnrmgQUy8Oz3Zm0XQctK06kya/jmxasdzkFNq
	QFNZnCqIdJ2fEEZtpWz5lFg228VGkiEaleFzUx3GQc/7uOMnlZHUrODIByVbxG6aUfk0qB3MjrQ
	lBm/FCkiLrAY9yjDFR2v4T1Y0Fvfp+J9A7l81zC559zNkkgRJgmHvWJURYBAdYPDtl0FLdTqf/W
	6kp8e2NLEx8ebIljHMSPrCmZ8ZqWg/zwyPBH9MK4S7q7+gI7PHnOCAJy5c8GW62lO3nvA7iA2FE
	qxNRrUkoSrZq107kZXp3taS9eBImzTNumiTXuO1qCHfKmethdONiKrkzInOJf2N6LYDnlDNzBiY
	HWXLjZn1A+hE/P+CyfGpRcTbwRzhptGv9eDX2oI0RbwHGHg==
X-Received: by 2002:a05:622a:58c7:b0:517:5b2c:6aae with SMTP id d75a77b69052e-52ce5fbdcc4mr257610351cf.13.1786104092086;
        Fri, 07 Aug 2026 05:01:32 -0700 (PDT)
X-Received: by 2002:a05:622a:58c7:b0:517:5b2c:6aae with SMTP id d75a77b69052e-52ce5fbdcc4mr257608751cf.13.1786104091454;
        Fri, 07 Aug 2026 05:01:31 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8b9bsm5890100f8f.25.2026.08.07.05.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:01:30 -0700 (PDT)
Message-ID: <d7548617-01f0-4c1c-b708-5cb8903a8ee1@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
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
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
 <20260722-gen3_adc_tm-v4-3-011981f756c8@oss.qualcomm.com>
 <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
 <anTwleq7qTOBBr3U@ashevche-desk.local>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <anTwleq7qTOBBr3U@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MyBTYWx0ZWRfX6tiqnLPyIgtE
 4mcQy0mPU+M4pbNHR4xpd2YtOlPIg3J4fbXjlsHTvdZhzlEGUCm6q7pW8hQICO52FMl4c4RFL06
 adl0wmplV2B66XgZxv50Eui/kbpwVNAjlhwKI+e168nYqkHCjszaXNSbPU+nRd3vYyXs6Bab/tu
 uXFiaOUwZI8q48M07c9V8AZb67QToBo9SGEr6qFJ8Lar0IjmzYcr+1bXtxDZTjqNwNs8QuQaqC7
 lsoqffUG/dDv+1zHf1cz7DsPG7m8hTYmfZ/9HlvjRKiJ5+trxIzDv47Acypplt4BMLPQNqsS4+F
 X5hZM2LQVQGCUk+Meq+NaryikCTQBaVvyMFTaJbe7XW7yMtoezHAbLEPfmcJ3dEZGfvddAhnR/a
 RXVMwsfTTx+Ijsf0Y3XAaIj2LRi8O+K71HQmA5lwGAl5rB7tIp+bevjJQZ+Ye8AP6Ol+pe1UC2B
 nfL06TlZCvcBdODWHAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MyBTYWx0ZWRfX3Wh8SCJzSU4+
 J5Hb2aBFBctn4QDe6jr3ADVCrM4+c9TGOk2PC2ECX4vk7rPgi7IrBcKGCF+My7g3CyQXKQu5dsY
 EqyuGYTduJ7ffIJ8wwUjKmeuR1ajwvY=
X-Proofpoint-ORIG-GUID: Xit2mzCMakyr4lYflmPUm83GDBpFXFbB
X-Proofpoint-GUID: Xit2mzCMakyr4lYflmPUm83GDBpFXFbB
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a75c91d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=_yZyQ5FlPg0S-AIa5z4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070093


Hi Andy,

On 8/6/26 22:37, Andy Shevchenko wrote:
> On Mon, Jul 27, 2026 at 05:43:22PM +0200, Daniel Lezcano wrote:
>>
>> Andy ? Are fine with these changes ?
> 
> I think yes, sorry was on vacation. Will be at full speed somewhere next week.
> 
>> On 7/22/26 13:26, Jishnu Prakash wrote:
> 
> Formally you may use my
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> or wait for a better review (1400+ new msgs for 2 weeks of vacation in my mailbox).

I'll pick the patches, Rafael is expecting a PR soon

Thanks

