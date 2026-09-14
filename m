Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430604457A9
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385005; cv=none; b=CHkddcOhY9Ashb87lkvK6LpWSd7fFO5OENXyeYysEOrjPpVn+yPTdPUZpQ5WsGUKjmlTmswBFb+evxnf9TR3CbymvDZtEKvY6zpOXuh6ZajKoVN8oD7O3tVZfxMxIFrQjaMgFHqNytFEzt58CcvQ2jDCoKbreo1vbNUq75BWvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385005; c=relaxed/simple;
	bh=9NTdtJ/TSp6i9fELQDWEuFYvwbqy3ev3R+H2YTC2xv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT5EoDEIpp7Te4oqOcM3x7V6t7ufoznIjKGmyQMxjHRDhCcG0yI4B5MjCjPmbeGHcjimkeRCjEekax3bQbjv0oh3QMSLfxSTihMU4BYv78n9CuMU8lpikMwluBfLY71vgVVUUmClHK2eWeCo+qLZT1SgplVKBWSyPT3l3ZNF174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/WVOCmY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrOOQXzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/WVOCmY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrOOQXzi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAmLbk4032481
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=; b=E/WVOCmY/+5Enkgw
	YEeOQ9dPHJUB8CWxTR20yFYOlY8UkoMJaYfEbZw5mtWvnO47B9tf1wMQPeafNwuh
	wcPa+7jFxuwllxPm+71b/159YFvZtg/2RACZvfhGXsdX3lRflqfucbjNfAT60rpW
	nT2W6tgRlLZN6L+MSJ/TNerjJkANtic5DzviOrYF00TQxSgNoyEqEGVr9kcRPO/3
	gIuOu7yV0ud+xAE5Z0o7WnQCbf35GMdm9FpQLiSsBTvoxEBODy0Mr28DtrxMTC/P
	1BajQAshRn13edHqPJho+jbGH0cD+CYPJc+8jjhbFR5E60BgJZv+Py3P6XJNpBgD
	ZRcYpg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq8abw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-938fd633df7so48946885a.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789385002; x=1789989802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=GrOOQXzirK52iSooMZE7aNbwrzlPThQRsTBf+/yQ2diMYPaPjPObO1I92W0+n42Xpc
         bfrDY7y1QsvQ5HB+fGXHAi3ymOIfpxChe5Lu0RKl0pDHdgfgROAhRU2z/lW875G5cgIv
         abNpxGCU65AgRptauwI52oMjrvJiWvN338ZPF6/2BHZ+bh5U+d+Ml0BU237tVzuRYKTH
         fGx1UY7isrUExwaeILSu8JWHaU9deNktPxdi7leBz2SAOfOPJH1stAPWaD3LctFyXxFI
         HgeXfee9ZohILXrVoCBZMHIst3arUpSdGb+cYpJwsz6QzcAbsPLqw6z2Aem0GcjKVc3l
         yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385002; x=1789989802;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=kq8Ci3PsBDpUkzMFflfQ+w8iwCfBMCULoRWzyzHSj1H34LqJoYF+1u4I/dddf7KGsI
         rcDlMikJC02RngaXeO4UQ7WUOyv0yGrL8ZgdpRVPa2IBdrsX9YEbH+mQnhMjDZax+Toe
         2soV47/HPfWS+GEEmAWD/6IOWu1u730dBSewK1tETBakKwlVjoOiPd+kpqPHonilDq+u
         pWuFpmif1pFXtCAVG+3qseE9qyUA9PWxsmOvTKO5FOTH5N1QSwwakw2lG1s/sy1sRFEE
         WFA/ubVn3wbVMP+r2aqEmp/TlXRTqeVfr8qdTCxwOtK6q5dOhVuZPvld2FzJo6EbpKoB
         6F5w==
X-Forwarded-Encrypted: i=1; AKwUvBzB5XtHwqa0YYWJ0DE27jTGgZL504oMMv7jBjeIF0Qys9emGLvMsZ3KferZEYs7nD7e6VJ6G98jdw==@vger.kernel.org
X-Gm-Message-State: AFuF++kezPl7YuN9WCYASrAekvnwDCoMmZbvrWBxyNOXFWEKiDAQejcj
	s2hY+yWUTR6mJ7tpWyCP/lEa0+5gMUHw1HBsZbJruAgzyFxT53ghI0rA7A4sEb3O45E/lk7z/jj
	V9B/fbR4WyUxTBr8Q5gEhA9uW0iXOO3A1CrGOV07vy8/Ch4qfEvxGV6PPvJnJqA==
X-Gm-Gg: AYBFou2UZsI/3MEFiFNe7Bd16hvrpau3fe27Y7RZZwhP5SBaOZNnh82YwoDOhYdo+mY
	PoKRaBR5Gig7kietDerxDVAwRgCOUJR/l69M2EFaYBCNmRc7c8q89WwjnXB4CJyL1y024oeqrbP
	Zc43TvkTniZkzLboVJrwjCqLRVGRhuRZluQMkmOYokvyiMjeuXbeUMfCwY/o46fRznUgOrux9+0
	BJrmtOoUi7g9DTHAa5p/zSFjqJMZ8v3modqSxhUurjnsTucUCGQaOvqsFAOu4Sk8lG8DIFTeyrO
	H+nctwYACjfNOWdJnKyoEl5m2+JBMcY0k3Eabhp/g5dWSafxKagmtE3PFqcNtR8E5DtBOB5VR+e
	Nfn6pBhyYOKlE8cLoe7JBUw==
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214250985a.3.1789385002626;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214244085a.3.1789385002074;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296601f4ccsm406660866b.20.2026.09.14.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:23:21 -0700 (PDT)
Message-ID: <757e124a-4c7b-4d3b-b73f-19e7e39f2677@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX6Cjn9iAxGIVc
 MUNoCENFmHl+0Jva9N+HZjhbG1wmHYMRHnOTj1AwLUaqVA5A4BBNdyH8UFQmKZnwo3lOICW2fho
 7nXlmBY0azV5/KVqCkEpvDgpPcx/mwXg9dBBQ3Oo12IAkEU9GCHsncENbXcgUr5gKfo0QQ+Tohk
 yAMjpamtxreJHaMMXbW6R/9XN+RH0eL0jY/UGPcBVrlqf29BEFL5UGB/o2rYZiCQRSKk0Utu4aC
 fdu7ZxGVGz2xUoanSe/QnIEPI74LshnYriRIT1T+bLjX1SSsDBrD2IMiTXEtVUSqIgf7gHaCokV
 uSufXmTiIIe7J9iFG0quEQPHoV7nb57s91h8jTl9PQLbVPU3Uz4ZItlQIbUvXy9zKly0ESKgsk8
 YA7lIiyUl5e+Zs6bwDS9ufhLZgcGDqks5E5Lgwbg3KKQG1xIz1a8SfjFgYS97e4GjB9vSXl8utB
 4bzZRTIixhHVpmWOr/g==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa7d92b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 0_U32holr-op1sGNZHc3MY1BW6zY51-F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX9dlObNtfPE0I
 qG+KbosviKo+YDo7R+4D29JfwlaCxXg2Iz0nSKnKYsEPbNEIBoA3alOOZt11oD6SjXk5bWN9pTT
 76Wlzk8S/zDWUBoYJvZYlAcEo1uefn8=
X-Proofpoint-GUID: 0_U32holr-op1sGNZHc3MY1BW6zY51-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140161

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
