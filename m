Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9E3E9C33
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190373; cv=none; b=Ou19BdNomgrzpgd6ybkkPLZHiQ2OI0gkjP3qvBbWkcN4dCn206Y2KDM1bJx60DFmOvAqxmq5VPb0wX2+v6xKjUbnABB20kaG/KUPBbd7WxaZlr/P+afc5/YbfA7wR6HA3HTaNKOGUPpmarFuFTUdvErlYGPZvVrNnwf2wXDulQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190373; c=relaxed/simple;
	bh=q+6jNicYHEog9W5cz/fKmUgJZeWJ1WiJ/ZuiIeV4VVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/jcPFpb7BqBTP2TLywYBbU9nkT+uPDorFhwIcUDXvT9nupCtefBlX2GqLKOci/n5itS/r4FbK1mfQGiCp2QRLYWt1BL3iiHkHWETKq062oS055Xi8ItkdiTGHhvaKXE3Y+hsB3RPW4RsF9ZOguMCMG3al0wvI35TW2BjhBY5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0ugPDNo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fHuieGt3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0ugPDNo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fHuieGt3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RLbEc61917386
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 22:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ry72JwgEvXd73DohO8iBMeZj+t7GqtVGA//x73T4uLA=; b=e0ugPDNo0ISdZDDe
	cBjCUAPil8HSTyye4XyRI9OnQjLMhrzaJL3URm4tqk4opkB5X0wQG7b61AmzHymG
	gvH8QaFfaEKWOADlU2UgRVmw+QhxS2jdCQwmCy678HVNHQU5g7GphiJledHuGX/v
	Qn4c6cBFYr4/g/yWZI5OeY7Y6x0EKM1Ttdc9Fjp1aDdtHGAkAT1Ju+A9K20B03S/
	iUbLDJaha8qR9JrH4UzYLK5ZgO6evXX9YRgzzxlOR+Hve2GCuF4jfwzHlFsI7dIl
	eZwmKYw6plPmb6o3Lu3QdN8j/R54HJz8A17vGEfr52H4ItBTbS1DtVRMfjpJ24k2
	3iyCwg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5h8p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 22:12:51 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eb7dc4e28so88029787b3.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785190371; x=1785795171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry72JwgEvXd73DohO8iBMeZj+t7GqtVGA//x73T4uLA=;
        b=fHuieGt39S20mnNpXPMYSPowEJ1sixBvEZRtR1Ya4Fqmt6koJPeJvQMC5v9f4XFP7p
         i4Au0M2V5YgbrZM1jLQ/uwueV8z5FBCDjYUAfZHLfGQwJ+mMO43B83J6RJaFllb1IB2M
         hsYzIxBS19NU7dOmV+/cS83yfgH5MeN+mw1N7nnVX4mJP7iblIGaBf8fwAkiZ1W0dvf/
         yeSossGNfJkvg02MhxO2wkImM9aoeZ7xOitpccrj1fSGqJMEBNfKI+G3D11nFiBktz/I
         q9fgXvAfU4K1dKlEPdsUge9CjbSZgYFny8t+PrmdLC196hmUeImenfjpFzpFCEbag5lb
         YdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190371; x=1785795171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ry72JwgEvXd73DohO8iBMeZj+t7GqtVGA//x73T4uLA=;
        b=s9BeO2xMl6fdCupDM5i6GDcJ4oujycEx9kYT+QmqbXE62Tk4SytXHv2mUI/24/x5zH
         O4RZdOwS+zJecm829vMZ4YaMd9anGop507fv0n/hXbbRnSCZ0Asr38HQHGvtwUeU4S6p
         vRiE7K7lnRixCuG5WztNV0PgHS3fYfLnbk/+XpqqJmtIOy658D3A1w8IcZq13Gay/Ad5
         FKlcHLSwxBTSiK7w1I9EkXymi/if1k8VK3amAgC6oWc+OVIAPSBXwx7gGA6qsiv62WuH
         aQ738kAAzDO/EYnpq9wrY6wTJw8+EJN0YJZySCtgxk9SjNN4RGlF0u4fPBC+F3BQmHyX
         iy4w==
X-Forwarded-Encrypted: i=1; AHgh+RpRvJe0si0u7o6RgoDNz+OZ7K2dOwnEdsOPTG+Sz94DFeSe3rq/Wm2KV4kFJn+f/ClRPrd2FhkqsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVQIZ8LyDxSmavnqvZXsLQst26bdNhql6CFWd4bT8SGl0xrXe
	xPCMDfR+Ez12HYwLhJ7Ph5eZrkn08G/W0+RjXEmMQptWUwbmAzMKx2ZGKy4OzqZtZ2nutCWlcAv
	6dKt6u55/LXH4v9ylhIh4JgnYLsuqfkK2oeq/iM/3e0pkVSYwc9Ioaf5kdef9Iw==
X-Gm-Gg: AR+sD11NazVgs8E3LL9qe9Gxrv7OMl+eKycPGlqlvAfMF+D0HPLLzuQoVaygUYwpvOe
	vpem3Di+xmIViY++zH1tABOMk6PAKC88hJ+ENz7SZNBFVwFxpnLHM6oLbf3LrJFdTTCCIRYxix7
	MssK4ooAcctZsmxSTBhHYAq+L6OFsSblIo9Bc0rmLGXOYG+HUWxAgk5tX/2rog/Wc4gRv2p401F
	Xz2HHtDspljv/98ndBRXkDX5KjLiytH15jdalJ44NCGHSzRD0x7PEA7qZV3LDCS4R0qoBWbhzZ1
	maVK7vVWSq1L6/qs/N2Gy9pfTmu+I/z04nq5A0dfUMQH/k5ErMD4KDtP31Mn72GsXaUsNyydiRq
	fuT+AxCn2az8pcE1B2FuPlDKzm4iZehYVEpONZ8Z6Dit7XVyUhirBSgV8vjQnaOBA
X-Received: by 2002:a05:690c:6d0a:b0:7d1:dd7b:b71f with SMTP id 00721157ae682-81f69d39a79mr35656247b3.29.1785190370730;
        Mon, 27 Jul 2026 15:12:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6d0a:b0:7d1:dd7b:b71f with SMTP id 00721157ae682-81f69d39a79mr35656127b3.29.1785190370391;
        Mon, 27 Jul 2026 15:12:50 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:713f:91ad:a282:60a7? ([2a01:cde0:108:24ed:713f:91ad:a282:60a7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6576ee52sm38322167b3.3.2026.07.27.15.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 15:12:49 -0700 (PDT)
Message-ID: <c372d0ee-7b55-4483-8e44-ea6c68c3501d@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 00:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: warn on non-critical trips at or above
 critical temp
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-critical_trip-v1-1-780d0b40bb96@oss.qualcomm.com>
 <CAJZ5v0hD7OvQfOUja7mC+nXpH2cDfYjeGMgf7WKREXt3rSNOEw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0hD7OvQfOUja7mC+nXpH2cDfYjeGMgf7WKREXt3rSNOEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDIwMCBTYWx0ZWRfX35VbZ6lLRRde
 pbnxhL+FwxX/cTbOOyADwbIgu3UusiH6+4Q6zOldDg2w7Mn/QQjfoLnqe9h1fV5SLOIEAeTQVZ0
 aq0w//Y07hQo/UQldZBpTgxhG9RiKl0=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a67d7e3 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=SSoG8QFqrpFK9BVNkCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDIwMCBTYWx0ZWRfX7HuKampGr6Fw
 07+c3M3qf8kANWuj6A5ckhS8pmTcRO6fg6L57ZEQw0CtB1hcoVeMYMxM2XHPEMtUcolK/sqpAh2
 BpvaQUVeynBydtp6DECv7nXPEQe1Fk5nV6UUuKo2Hp+Xp52/udRe56tDdHSdjc89KPUfDkJc9BL
 dq9654RXJ0XfL2miHGWL0FgQiC4x2lgSdxgfNe5mIEtG3uMKL/PaRNrhyO3GFWYPsoch/X9NYQe
 oR/6jMNmRvTCPhsZlnR6Vn92unLsJfjCUrGuhaYZdredYRfj8C9bo0bHPz7LB8SUrkWlRu3XaES
 ELgQRYdLgxODuEqs3Nq/mCOOL2U2z5lpIV8GuUCzMN/RTdi896z4GY/l9Sm0NqUGHF9Z3RK2UfU
 xOMUWQNnzv2QEJvw+cHURnp2G5cfono6vtdmM4oN4cUKK8f5Zyxk7vfGgsgLyEb1JjZ8q2V5NTP
 ++T20CgJE+8p35BSTlw==
X-Proofpoint-ORIG-GUID: -V-v5N2xctNUgVrwQ1ULx0Rppo-gTgTG
X-Proofpoint-GUID: -V-v5N2xctNUgVrwQ1ULx0Rppo-gTgTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_06,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270200

On 7/22/26 21:43, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 10, 2026 at 11:12 AM Gaurav Kohli
> <gaurav.kohli@oss.qualcomm.com> wrote:
>>
>> Thermal zones can be registered or updated with non-critical trips at or
>> above the critical trip temperature. Such trips cannot provide useful
>> mitigation before critical trip handling runs, and a HOT trip at that
>> temperature can coincide with shutdown.
>>
>> Warn at registration time and on trip temperature changes to surface
>> misconfigured platform data and incorrect dynamic updates early. When
>> multiple critical trips exist, warn against the lowest one.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> There are a couple of reasons why I don't like this, the most
> important one being the overhead: two walks over all trips added to
> every trip temperature update is a bit of a stretch.
> 
> Moreover, the messages produced by this code may not even be noticed
> on systems in the field and users may not be able to do anything about
> them, so the benefit is questionable.

Would it make sense to sort the trip points when they are registered. 
Then limit the changes to the interval between trip-1 and trip+1 ?

