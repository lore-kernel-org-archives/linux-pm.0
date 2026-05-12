Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D639FCD7
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577597; cv=none; b=L4zWAHyupvq/LIo8mr4aEcocdRQDxHmU1uqQCFIlHHoy9MxbMeAoMBI7S/TWJ7dVTOidtyF45BwlYH7LS1CG8eeZWsgJljPsrr82srks7pQlaWLgittBFy2kCrQcGI3d7l1Aq9cvzxmiQlC2fIWKpEbhff/Amsy5Kh3LuSxaaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577597; c=relaxed/simple;
	bh=pQa+x7m84PBnmw8b+C+pFcE/8l/E8CLRAzXl8GXueIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNntoCTym95oo/+0MHVxBMhL40+za/DajGpTXnnQBTBaIWtG78kTJiqh4uOZ4wV7iXrJo16W1nB4oww2Y7fKCk/MTG3fq4NpUNi3T0Yuhn8PllijV1OKLdzjNEcfF3v9PLT7ECpPtIdDMuVdM4/+hAhq20n8do01VgZ8WsBjrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BY8GzujJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DYEm6525; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BY8GzujJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYEm6525"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5FoAG2803758
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xHMNfioUWjUvEEM4IfMYI16LOJp6emUsmPwwwed6elY=; b=BY8GzujJ3GMovGR4
	a2g1cmvjsN0xcT+qpKy0zu/SRhzEgm3nI2aGqeE6sI0lGwhfEJV93HeC6uzLOxE/
	xwxPwf9EBcf5s3CuiRvbaYstS10Fw3Cae8ctAxaPOG7kXFZUlmis1dEowjOS0BCl
	VTmzVH7c5MEdcwzq2NDyLROiNgQhGR6M0Kc2ULU9EoUCKa3WPffSPk5s/FGA7/wR
	CybFBHFwty42lBLjfDf5r4n4dj07OWaJyYUCNMLEqTzItSXLYOD+FCc+GK4SlRq6
	AKhcJrb2RZ9iQzL0jloNvoEInH6YaU2mQD3mgP1OMRN2JcblQ9hhiXix3GPxCCGD
	AJp4LA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv3agu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:19:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514ae0edeb6so62005181cf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778577594; x=1779182394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHMNfioUWjUvEEM4IfMYI16LOJp6emUsmPwwwed6elY=;
        b=DYEm6525d2evb8+ltLyVAA8LiiwsNLCHvx7hLoROM7l8UG97ysnYtgBkbRwCqeU7EA
         WWnY+oFE+uKnpr5robJdzkvcDaMj5A3w/17XN44Q4msoUW3/rS+WqZrX6m3c+RCGBIGU
         Q/MRTuwqDnZvi3JPQ58eG8hl7Ho93sMKpNFQ1seT425jI4tR6fdsx+acJE8ghgKFjPM/
         vze5fd6OINED/DqwHgu33TPQqF7FddrkqKuTFDjEERM6tPvBhRL7bQ2XfcQjc8w0dpbQ
         PKgVw5J8pCy/Q2zqrkls54GDdENw9t/HADQbHm91C1D0LduBUs47I3JRtysVwwrXAa9R
         bXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577594; x=1779182394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHMNfioUWjUvEEM4IfMYI16LOJp6emUsmPwwwed6elY=;
        b=HvlbVCDvQLJm9soZEP3FC81WALxfauyNSYYkCekXVHTFyUHnZ7BnF91iXme0Q+ppXC
         NtCH9TqvG6CHjXhFZIPx06qk/sbFQZ5HB7C2ZS/Dmdnu/hDZwfmp7X2/1pf9pVJioU96
         IK2fQpfubLmNvSL/6Bw/MwSYNYeHKivWI3lZol7NNUKV8BN9RdpwPs7mXth/rH6+j101
         OQvH0tIOFYbadtx63eWJFFgY/T+SwozAUceemafLXQZ3kCS76b+xwlBrrvuhGFymzu6Q
         gJDrpOGv6PaJhDiU5j4kVqqiBtHBCkYJYge5gFMhHRUxLYody2oQn3m+4JIAW7Zh14Ya
         OGBg==
X-Gm-Message-State: AOJu0YzPta+X2p0HzOqpfSouPCcqhEZEuZaCMvy+W3d2lYj/FBzxOzGZ
	30AMFim6lXi1Y76lJ8lRK/2Yo13X5s+s6or3/yjiuvf+WK65ob1Uu4uaRUXYMpfhR1bLYQgK7j9
	xcQtJ3qPqCNPaCGPDstQvihb4x9PaOlHKFSM1znaXp2GzxquXs2dc8zwT7Qi3lQ==
X-Gm-Gg: Acq92OEWk9lSjjka+OOdZqVg65b1btuZboc441lVk/xE5LPJkQnULyRgB93Pp0yA38f
	XjkBQLlUuIYR22843PDwQ7uuYQtu/4hp9eVHQawzd0OnyJAckO+BfAlNsJQ6aTeX6XqD1oZL4Ui
	TDBNgDd7ym2tg5D17hTaK3aCG1MVUGTggc3K0pwzGKNtT+EwTxrTvvg6Hjd8H4wpGza026xrNbp
	VwV5Uw3uZ/nR968Jv7et63d2u1AWQ5A1B/MrD01jpSeWzWDiIWxsI5SmSOV9aZwfKi2UZJJZDgZ
	7L8PxF6BuFs8SKT0+JsZI/plip2jnA5/fEOFzAty/xUJQXLV+SR0kIVbCwqfceHAsQJrmNhF/yV
	/jvuQjx+DTA76QQrvuHZpJTlM7N0M8IKP6BqPdUhCM3RyqX2gbuc6nghjdORXl2gU3kADA1giGR
	CFFN11iuHC
X-Received: by 2002:ac8:5804:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-514cef5f533mr37460101cf.14.1778577593845;
        Tue, 12 May 2026 02:19:53 -0700 (PDT)
X-Received: by 2002:ac8:5804:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-514cef5f533mr37459911cf.14.1778577593432;
        Tue, 12 May 2026 02:19:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm30575148f8f.9.2026.05.12.02.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:19:52 -0700 (PDT)
Message-ID: <06073a6c-1f75-4dad-9309-9bc47a2b4708@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260511071024.3130247-1-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260511071024.3130247-1-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA5NCBTYWx0ZWRfXynorgw7oWGbH
 tRpP0yTy6LDNN9RpnO2/VnCPW0VdafePmG/1B8WJh3KG1lbscUkRIznyoblQ4ZhzlV8Uqp58FDU
 3iTLIlSTYaJCUJfdUHf5x1+sgCgIgmtdlFBtkCE22VtFxpMwtmLOxynXnIkuG9RUD8K9krWh8Kw
 048DsMhzZH/7NthIOBxPiyP/sRa9kBvY4cOsTgNEVHPuMnnSB+SxhjzuGCeCr1T/xqoBcQ8XswI
 1z9udC6zHnKjJ6XPAbLaVi9Z0B81d+aYo4OAMLK9ulCTTYrHapg2XNqWTK7M3UKuF7yH62GG2D3
 Mykq7WKNURU4Ojz/n/+60PfwjlmPia2VoGjuSGKOEBTdaTYb+PjhEStSKZRFw2+BzQC0iLO/gC4
 xK78JeSqinqUcrb+rkO/NtrILNGp/rp58YaB5XvZtuueIgtB4PIzQjjbEneFGgFlXw/eiQQdInf
 c0CAl9VU5yij79qfLDA==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a02f0ba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=-FAaCMRnIu1Sos4PegMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Es1QmK_qmugiOZoxfaxynFNWGUhyUQMX
X-Proofpoint-GUID: Es1QmK_qmugiOZoxfaxynFNWGUhyUQMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120094


Hi Priyansh,

On 5/11/26 09:10, Priyansh Jain wrote:
> The existing TSENS temperature read logic polls the valid bit and then
> reads the temperature register. When temperature reads are triggered
> at very short intervals, this can race with hardware updates and allow
> the temperature field to be read while it is still being updated.
> 
> In this case, the valid bit may already be asserted even though the
> temperature value is transitioning, resulting in an incorrect reading.
> 
> Hardware programming guidelines require the temperature value and the
> valid bit to be sampled atomically in the same read transaction. A
> reading is considered valid only if the valid bit is observed set in
> that same sample.
> 
> The guidelines further specify that software should attempt the
> temperature read up to three times to account for transient update
> windows. If none of the attempts observe a valid sample, a stable
> fallback value must be returned: if the first and second samples match,
> the second value is returned; otherwise, if the second and third
> samples match, the third value is returned.
> 
> Update the TSENS sensor read logic to implement atomic sampling along
> with the recommended retry-and-compare fallback behavior. This removes
> the race window and ensures deterministic temperature values in
> accordance with hardware requirements.

In future, please add the '---' annotation in order to have the 
changelog below not included when git-apply'ing the patch

> Changes in v2:
> 
> - Reverted merging of the valid-bit and LAST_TEMP register field logic
>    to preserve the regmap differences between TSENS versions
> - Defined valid-bit support and last temperature resolution for all
>    TSENS v1 and v2 feature structures
> - Defined last temperature resolution for Tsens v0 feature structure
> - Dropped tsens version checks in favor of valid-bit capability
> - Computed masks from resolution to keep a single source of truth
> - Minor code cleanups based on review feedback
> 
> Changes in v3:
> - Remove valid_bit, last_temp_mask, and last_temp_resolution fields from
>    struct tsens_features in tsens.h
> - Compute last_temp_mask, resolution, and valid_bit on-the-fly using
>    regmap field definitions
> - Remove field initializations from all platform data files
>    (tsens-v0_1.c, tsens-v1.c, tsens-v2.c)
> - Remove the initialization line in init_common() that was computing
>    last_temp_mask
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

Applied, thanks

