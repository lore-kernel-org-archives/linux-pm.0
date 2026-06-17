Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36A34FF79
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715649; cv=none; b=s3S6zyQZFLW9/4UH1sQTxCxvbR2LFs1ucK+Lo9HdneTfts9Q5SM2499MlnHM0PLFx7KFpW/rsK8Kw9/o0PWpaaCJzK98JeTTh/hrQe35iwq61oH/npkwLwP9iGHbKwDmYJV74vii2UM3iksWw2qq7gg8jVCBdQe3f6FV9FDN8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715649; c=relaxed/simple;
	bh=aCyu/2R2wNUHaUekzJBrFVgx2ifniPlLE6qSjsta6JY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OTUHjk95xG/YNtusoUZT7TdU2Dbww1kLRIU9KsfT5IMkwo6FWEGizAOPPG4CGacB3dla8YFzplhNMILmOTF1tkv/TShj6wmqP7BwdCnBV/nYJ7j6FU65VNPR4PikBNAEn0tJfNlhCufY0i4mGrj8yMrrehSxmJe1f1SUL3zR1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/hSwO2d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UDxBTzGm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/hSwO2d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UDxBTzGm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFpSo53284174
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 17:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Us2NERInGXlSBge5g4nKLlp+I4DfWzF94oT7ElTZCk8=; b=k/hSwO2dWpiQ6gRx
	KItAsa9klKu6hK6Hf0kmTDcwpNTG4jqYcMYkKCOOuRkdZm9w8asNG8ZVeB4Cf6Eq
	ewgnlE1GqCP3LNRpCF+kPv84Gv1V9lGff0dFzPJouKS9cdNsBBd15oez9S45jSd+
	uS5GlFWdZEvx6X8zEqSHf9UKm1uZwR6U3UP8pfUStYitrB7P84DAT0B9+nACZKgO
	Xak/75URRoUR6pSV3XinRl/hdCuQ9vwSvcbfL2S5fjkrWfRmAiwZLADxyJiYVDu3
	xMYR2Jy5jpIBnDNfbeV/qJXzMsx5W7EL+bHwQhWcxxLftHPtzVW0ywsfhcSzxsNq
	3ipq7g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevmh0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 17:00:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-842b0dd8107so3663024b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781715644; x=1782320444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Us2NERInGXlSBge5g4nKLlp+I4DfWzF94oT7ElTZCk8=;
        b=UDxBTzGmb+oiTKdvBjeg0KutFyeEayCenush6oK1xaUCS3pq4DbPf3TCahgtHLaNGL
         +93oNQX8we1mPxlBuWFZvlTzds2jHuvgc/KB36tbcqkLCIZ8YLROxJBqC48km/dsqogb
         hyaf+7MfjViYsWkk5yuMhfCnRY6aiF5xpuLeOHEWwCaEi8/jJ3iDHrVD3w/ee7ACLoTC
         Z308Xp8nRZGZOt6SVhrFsZy+LzKwKiT1akHJ2w1D8SaIio8r5EUuaxc3TBp/EUhE0u5B
         AZwY89OoL8JlJVjb3psqrP/4/096SmJFG+etb1e4xmYHS7yO7nqmMv7L52mCC8glo8ug
         xqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715644; x=1782320444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Us2NERInGXlSBge5g4nKLlp+I4DfWzF94oT7ElTZCk8=;
        b=ZTNeh0PyGH9RaO1TPYBGJkShgPw+I0JPJTLLflfb94YGqcOO1Ybf73/8ZY/htP27CZ
         NdhItrohyAJzLGRlQBhpXQcoAmtaiOuyxEZPJwwm7u4NBTl84+j2vma4RWZvLwM71sJj
         2NcUe/aYCfxfLqdqS4hxY3m/tPhLEdDOkN/dkC2+I68fd43TLt8pMUXLWcEQZqJiWHDd
         WQJRbSGneiX/5Qk7HSjwbfYsu5yqKDwwCvwM5sXQRQtcQ8radml4NHq3EmEPnvNRY22v
         qKfGh/UjpkQ8cxyQuRAZFMoOPKILLetyd0ez7347rOj3nj9S5hzcM8YVLtaodqdirfpS
         mg2w==
X-Gm-Message-State: AOJu0Yw0knYHX5ZYCwQGLAOJ23UekV3p9OydXonuDMaXFfVoeWSQu7fB
	9Zaky0CbRvQdQ8PZDq/+OpeEE1D+JctGwZrXVw7ouUTE1NSWGV55X205sTH1cITT9e59msT6dq3
	45W6o0vE1mYWeDJTqKvVsx70iMRUSMqg+FrP6EG2S7q6SQiEyDkAluuRFXASUjQ==
X-Gm-Gg: Acq92OFCogQl6tOFjeYgjKXA3SenBRoWntNITVXY30uf4GMvrIEOtr9wT57IxLUP0Ff
	6eR43dhVgtUnCcznnl0ZqQZcP7C5dIwQCrmLkcgSpZzGO73XGdXnkQnppiT3wzd2aodbrSKiHkZ
	lR0JLFUnZLp1ijMLBMYRJys8VeY21jLPGvX3Si0a5nTCJ0R+FAQuQhRn7ss1JguFE2a1TzKBeVM
	CRLLIhsfZN4rOGlhKe98kmzgoiAC56VYr6ZCHMGFfByyR/PkAynPQJT1b6PIMbkOtU4DW+PHrkh
	KFj6mmwQp3fX9xubyOwU8M/A1VEeChO7OAa6aZELNDso2tYDkjZgk6CUM/F8A3yePxoxceXwpVJ
	JKoSQ3pSic5RlwTdE38wpql6yC8/+bsbfFssDwn0eYEomGdM=
X-Received: by 2002:a05:6a00:4acc:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-84524480c2cmr4841090b3a.14.1781715644374;
        Wed, 17 Jun 2026 10:00:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4acc:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-84524480c2cmr4840655b3a.14.1781715639106;
        Wed, 17 Jun 2026 10:00:39 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.224.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9cfebsm15151639b3a.9.2026.06.17.10.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:00:38 -0700 (PDT)
Message-ID: <f0336ce8-e5e0-4629-ac51-f3c42bf3d9a9@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 22:30:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 00/13] Implement PSCI reboot mode driver for PSCI
 resets
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Florian Fainelli
 <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <0c6636b0-f6c7-49dc-b335-2b4fac16b848@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0c6636b0-f6c7-49dc-b335-2b4fac16b848@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2MiBTYWx0ZWRfX5A8oALamn4Oa
 ySbHXrfESmXwcO9TpU9QMaTzpX0eB5or6EmIJgQVpIoA1hy6QYclnXaCqjrsADujzjCgM3TqVso
 UAlG6b+2SU6ooMABuctLzIMEqvvgHLUE6YYXZtej1JHUCSzGqglfcDt9vTKdfYT/0LWUZbN5L2S
 ZhdLDv9n4eSciCjmd5kgMCjpZoR3iHrryGzO6ADQcPEUNogR1NHD8OX6s2JY/PvUibSamArP3Gz
 GR3sjQ2A8nGz8/1RFAzB5uEhzpJ+ZkoAGSzvTvfmPiKYoP3ssk3/fdba35hz57dQyBPUhgttQyF
 UdZYUhxVPe1hXtdWc8PSXGAmyf9w3bE5u3J0+M5IQRPtWjUW/M/zPLZnEB6GjxvIS+kSe69VOCu
 V4SZ5bOsmkZRm7jr8poCcMmLjaQ77Uwrf2CZXTaQGlFBHY0nC8qZoiRZ390ObkBAkmHUYqeXimC
 ywhAHOwttc1pn9XCMQw==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32d2bd cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=44Clojva6rUT6T7xBPZ1Pw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=yyym-DC1bhT9zQtRc4EA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: -sSMpNhYnQZJqQc0Z2uouuFeXCOF4_YO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2MiBTYWx0ZWRfX6nvs4eq+9jk5
 KyXvjfiSSf+GiflxSHoZSuvmCuIFz1LuMA7ecCfQPCx3+ZaUx24md6C7tzCyJihkNTJK/oWYMDd
 J3cAsC6TdGJSJr2EwDVoNCVuPfkcStA=
X-Proofpoint-ORIG-GUID: -sSMpNhYnQZJqQc0Z2uouuFeXCOF4_YO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170162



On 29-05-2026 19:00, Shivendra Pratap wrote:
> 
> 
> On 14-05-2026 19:55, Shivendra Pratap wrote:
>> Userspace should be able to initiate device reboots using the various
>> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
>> patch series introduces psci-reboot-mode driver that will induce
>> command-based resets to psci driver for executing the device reset.
>>
>> The PSCI system reset calls takes two arguments: reset_type and cookie.
>> It defines predefined reset types, such as warm and cold reset, and
>> vendor-specific reset types which are SoC vendor specific. To support
>> these requirements, the reboot-mode framework is enhanced in two key
>> ways:
> 
> Hi Lorenzo,
> 
> Can you please review the if its aligning towards the suggestion in v20?
> 

Hi Lorenzo,

Was planning to address the mfd, and other comments, for re-post. Any 
feedbacks, that we should take care in next post?

thanks,
Shivendra
