Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B38366061
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068670; cv=none; b=S6aYb6t65odnlpSBeOBjwu+JdC0O7V/rD/Hm+P2XCg/Dl8YoAJsIdeR9S7Ifh3BHr/uArG+NdzknZLvFaQg8ACTwwupPa9kyC0y2+xTtoTvLK95CtSonFXOgssGReHqFz20c6f5aXxL+FYLOfa9R3Yvg6AVoZPoECI1uRNfInOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068670; c=relaxed/simple;
	bh=mMLM17OLqCzNo5IZD4nfiMGsCGFVcsILcFj63m+i2EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKJR+CRGRMwCnGUqF6EKSQ3AfQ0QE9ipnjij1bzSCJNY0ulrBnnnJZCoEn2iBRbG2+f3a6h49JFa/yHxFtu0mQ4TPqAOjSROgsfZzLIzNSQAdR8hNrtYK5PTWVFL4sT3vUbUkFmBF8wZksnQHMJXPrOGLl1NBlIo9GD874nuRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPpU/Hxo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdy28f1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPpU/Hxo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdy28f1m"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDL1s82335081
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 15:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZAuVxoG3HqgiU1oF0drP5uB/3W43L42VcXs8UsExZCI=; b=mPpU/Hxoo6BS5o9j
	fGLdsg0SZBpffoam3X74D46jKMME9RYPKHi8t1xfrzm8e6p6LDE0UjrIP+VKjjBu
	oDzv6uYEfMRBA6Sfqbgry13p06LKaKJnVW2jbDuWy7osmAy0dPsaRa4Zze+8p1To
	10kiUhUqCMl5pSBsRxiqmwdeav/NuYbte9ApIMXkC55fx1RKFbbc2FfvGa0224RT
	KDRQ9ZIDSetk9JGUYGT99oQaYJvhCCNIP+ESZweEpdIfdzruQW5tofq71TtBI1e5
	zD/hsU4SYj8nofkFM2fYgsRbIyPZ4Zv50KZkkgZ/CxOiXrvCdBr5jQJE5hA0bOzg
	FcJzDw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj2f8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 15:31:04 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-439bb11e411so20047853fac.3
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780068664; x=1780673464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAuVxoG3HqgiU1oF0drP5uB/3W43L42VcXs8UsExZCI=;
        b=cdy28f1mmi0CWIM3150tINBl2SHs2BzaTEXhi4D8EzQlY64n8pny5yiOW2nvhs1ymq
         0SpTHJ2zOPBXzhLZP/Go46iKwoF5E1S0qSN4uycjNtT3uWw8G4FUp8582f6AECMQR4rx
         B6wsu4fFFCI8MDNRa4zSo3JP+EaveHHxRKuKj/tm27/Hr3tWphWjlfeo2bN63xr40x1M
         LnEaqZRzWBWHB95UqHCiRzWpVYwwtc5cMvG8GOoRqUmbPBKjtVVeKcSvxI5WJcN0J+nR
         it5SHXjw4hiNikfKSMdngcLof4HIV9toTV+x/4ZJH9JXHnmpPPs1qN6tsdESoZ43Eiix
         quNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068664; x=1780673464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAuVxoG3HqgiU1oF0drP5uB/3W43L42VcXs8UsExZCI=;
        b=DEgzlyYZiz2uVc0xkK2ETYtcCM/AlQJrnNermyR0TJB9yofi0b3bXN3Y24qUQ9MZUO
         rhL0XghPhQUN8eB0dHAdcEdx2WaUuIcLlS+GtRzpwU+NypCklutpt28E632NLbj5xrpZ
         ZMgrdOvYkX18q/iHMVFLLQ5Yp8RMRaP1NgALmzcQ+ZPaxv/qrKA2NoXq+fhfiC6LY1Bs
         pXp6IEpb7yLp06Ozfaul6lPXyDrF7dAMPGdB6tbMl4yRXdami/jXI//v1U3qxmzAW83I
         2R1lz8xjptZSoM+kJ7Ej44AkDN4cI7IFVeSlHoCIsU7p1oO7PjexrJSJ7fvAPgMRASso
         N7bw==
X-Forwarded-Encrypted: i=1; AFNElJ9pStxB6n1AQrHoWwWvuHDAYPToUBUsQhKOLiaSXPnmMVZmBiYh9UafTt39/23W2TJz3Aq8ZhySdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6zYdd575BdHV1azQToHBxbQRdIQqEPPWaOlHLqWUKZkvcuA2
	dVZshZiUBYTWJ/aPfll9nexPmGNvcoJQOnm8mxYRqkCYviSgYa7NtRhJgEjhUU8EQXgLwureiCh
	fOSB5yqXk1VXNsSvhmZidkn3XgidEpk3lFfpoLuo/PtmYQtYxaMrR74iCGk4fgQ==
X-Gm-Gg: Acq92OE3C0UiwboVxbtrLYUHVmy5WOvvkTdv/ssnWMoYIr/gQ6ULd+ZK6Xrtvex1u7N
	5xlDx5y06rse3obpLcasK4G87ELwEZfZavUn2Bmga0tD20oq9xbGnOyObn1z/5w2/z15pcfGjAE
	G7VO0qbE7w6Nst6wPoZqNrE9zmIR5LB4zCJ8FTKrXASzw6K2YemVq0TsX04DNziMk/qEae0A+2i
	YfO//gFyeaxn4yO0aMsxZ2zuj3mLAwUXPGZTogW28LpR9iI/b/2+xWMeKgRy81H6mg4D8qhSBmL
	LE/k7ylfWni9vbhc6/zgDjLoNJ/j/MskgcG+MVF/h8xyz/tgNtN87W0C4JrUAZiNMHtUsHJjUye
	2a15KI/K03JBgBOzttMu/1YDuIVWqUGhDDpo+Ao9vqNExxyaCRKr/0C0003+ZYH+P/B8vs2XpAi
	thOdFMDHLraMPzaJQtobw=
X-Received: by 2002:a05:6820:20b:b0:694:a339:43af with SMTP id 006d021491bc7-69e03fc582amr1552680eaf.28.1780068664090;
        Fri, 29 May 2026 08:31:04 -0700 (PDT)
X-Received: by 2002:a05:6820:20b:b0:694:a339:43af with SMTP id 006d021491bc7-69e03fc582amr1552643eaf.28.1780068663453;
        Fri, 29 May 2026 08:31:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0f74fasm23434745e9.4.2026.05.29.08.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 08:31:02 -0700 (PDT)
Message-ID: <305d2570-4ffc-4d48-b831-e1f695d3dba7@oss.qualcomm.com>
Date: Fri, 29 May 2026 17:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vs/3/4/ 00/11] Support cooling device with ID in the OF
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <a943706d-d413-4ed8-a0fd-a3234c66cd8d@oss.qualcomm.com>
 <CAJZ5v0hG4aNrTR1j1DX+xv7cBNwsN4Y+qa3eFfXtLrrDBZ6kCA@mail.gmail.com>
 <41eec804-5678-475d-b0b2-a5c0b3b005d4@oss.qualcomm.com>
 <c66d527a-17d3-4419-a0c4-676dc92bbe43@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <c66d527a-17d3-4419-a0c4-676dc92bbe43@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NCBTYWx0ZWRfX+9Wbkx7+m99n
 Ift3l0vo/KIxQl5JaKqc09/BeaTnujzW3FYVs2ExQdAIQSkrqMyoDCaFjQvC152rcBVdj/39QG+
 FdZ0YpYeaZ9SgQ+03L4Thfn3fa0uS0U0Yr/NwIHIZoz2PuywGLmykQXkA5FtuRPa53liFnUa5QH
 8L5avjPgLJxRkW/vpquvsHcH3i+kCN/xxwXJ1MCeL2rbJh7/v3RqpI3sjeR6z3CT/T8eyNPVKq3
 cKpxqXBMT5JyY3CDQEHyvLG/EuxZ3r44bhX1YXAeoWAWTC+yFqeEOgQey4sakbpfhNgJUkvlayr
 qw/PDQPuyumh72mPW4vTqEolD+TqXliUiuOIoY9CJ+RfrSGB7GEBVGIXkDlh3WC1Cd3sKfUJvT/
 SE5FcCdDJfDUT6as/jLd2mVu3eNSuqbyqQe9nYQRSNXfeWXZi548dLmY8lTl3cN5UBtSzxQ3u6V
 734JpOPBfQ1ZnQJX9Aw==
X-Proofpoint-ORIG-GUID: OepgsIxv7ZNCOnUeGp-f7ixQRCbI3EzF
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a19b138 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=7CQSdrXTAAAA:8 a=tVIC-DNTeUxfuNkwxZcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: OepgsIxv7ZNCOnUeGp-f7ixQRCbI3EzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290154

On 5/29/26 17:29, Lukasz Luba wrote:
> Hi Rafael and Daniel,
> 
> On 5/29/26 13:41, Daniel Lezcano wrote:
>> On 5/29/26 14:35, Rafael J. Wysocki wrote:
>>> Hi Daniel,
>>>
>>> On Fri, May 29, 2026 at 10:35 AM Daniel Lezcano
>>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 5/26/26 16:08, Daniel Lezcano wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>> ---
>>>>> Changelog:
>>>>>    - V4
>>>>>      - Reworked splitted functions to register a cooling device and
>>>>>        merged separately
>>>>
>>>> Are you fine with the thermal core changes in this series ?
>>>
>>> Generally, yes, I am, but let me have one more look at it.
>>>
>>>> Is it ok if I pick the series in my branch (and may be send a early 
>>>> PR) ?
>>>
>>> I have no comments, I'll respond with an Acked-by to it later today.
>>>
>>> Thanks!
>>
>> Thanks
> 
> I have re-ordered the patch 4 <-> 5 and the compilation issue goes away.
> If you decide to do that feel free to add my tag to the current patch
> 04/10:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks Lukasz !
