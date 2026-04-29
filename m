Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8578339B2D
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482977; cv=none; b=mPEQAy6oam7qmuwtFBUAzXrn4Ol8UMJDj41583/LwIN/J6w/kU1sAplqhi9iZADgri+veHRuSib5C0RwXy8Jz+AQI1rZtddpu5nLYn97jNJpI1PLdWNFqZ2CCLmW0FxUq2mglbbeY0qgapcUa/xiJ/IMicpMtiv7AgBfzOJrzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482977; c=relaxed/simple;
	bh=MsBhThXBOL7FXkcrmXSBCXSaa9bFMViErbsSDfLMBwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9UZv3kzRKG2a+MyRRU32shOsVBdWNtJV7xOv6F1XvHF2snn3SgjvolKHhK7AYo9u1chC0egTSwjBviXjL+EiFrV2MqZJkMCFrCL8czGqwXKkMGOnayv3zfyXg6SkBgMfxmNGHCJR+VEpGBt5GMsxKkgWmsgTiiOvfa3S5CS3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GfMZtjN+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9bpj1GU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfMZtjN+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9bpj1GU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF3sUm2094208
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 17:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMxYNFxFR2tPReBltRPoY8GIp5YswuV6ifrNHfP0XAg=; b=GfMZtjN+zIK4VOAA
	BNXRZya0yClTFAhjLemCDUj7FZhy/b2Bn3vaBrbWSFt2qnQy9lx0xat0R6U1IPVB
	pYeTfn5wZ2dxPzpOt+oLeqVNmBMKwXju8ntHQwR8JrF2us5yAOVYesb44qA/3vbQ
	KE2wuN18n59HHBMGOJdAl/BEeDWWBa+Y/iOFZEEYG2JwBeFJBjAKMfqYsDJyMGRR
	d+H1thTYB3wbYnziX/9U0T3HXf+z85CtzfBaigMaw/74aCBFLPQUmNfuLFdacjcb
	h6uQHuvLGAqbV18aE8s8MNaq84uHh/PKscuMwJMYeqr/GmsI67/+i0OvqF0QPR2L
	0GJsWg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3tffm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 17:16:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4678c6171so307275ad.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482974; x=1778087774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMxYNFxFR2tPReBltRPoY8GIp5YswuV6ifrNHfP0XAg=;
        b=c9bpj1GU0pcUnNYM3H+2s8bWdQiO8/7FrlPWRxGHK6gH7/UhUDIEMjtjKrXpxMCMzb
         hvYWJHLPJ3e9mZS08vMJsuUddjdwj1vD1I8h+qaN2x3l6KgHcXJKf47THNCXfr0me4Ck
         zz2CRTxjd1J+9ESjF5R24rN+6jC1wouCw/kcUOEN5scRkq1mNM5Ze2CWO1I/jOLyOqX7
         MPKZUYesoLvUOILCm93TqkgCP0+phBQmo++0YWxLHiaIk1oj8XXuairKZpu5l2o8hR7i
         ZazupPR0IL7lQ1xZsWLwe967KjcZX3V8Un6g2XVMCt08c7tzRp2V6RdzcjtXfIFyyfIO
         yvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482974; x=1778087774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMxYNFxFR2tPReBltRPoY8GIp5YswuV6ifrNHfP0XAg=;
        b=YBCBzNpAWhHWxumkzwQMFaS340l/RV9u7LwT4++Do4vcbnidRUNNO4eR3P8ZF5znuG
         F6M4bNx6IpCZajOB4mOwwqzgn/2ceJH2/rk4hO7oEnh/I+KGYLzuOF4Z0jAHTRTG/lf+
         jVFqfwEqmSWWNlPRHmpN6c8D2N8z+OVoGnRCoo1glW69UHVRwgT6/cRlAQJukNH+VkZA
         dlKpQmvy87//6LlCXRhLw7Ybz5ndXHyfUnkSBTfetHOYor/V0+YXSqqCDb4ED0jVKhMk
         8HYMqNMjvJrdKAaOjixX+SjpRxAhmfeEuX5u1Glbdi+rujzQaWiH7YK5Kb3NLousESXU
         Oy3g==
X-Gm-Message-State: AOJu0Yz/pK1Y3RajEKlavDEnvgPSvsnTh3rMZF0rhGUKUq2Ljco9CVOW
	b5ssfthxdRwMxFVfsuZvZyE0hkxMmvo3AFArX7L4mA7+H1sDVGY4dPHgNmCT2wiL7wF8oswiM1R
	JPNQdfVJeupTOjcJCP4fOQClL5rlS9EjBBw+ps6bgkDSBuHBAbWFiBS7mmjv8ug==
X-Gm-Gg: AeBDietrNqFO4s2muZZB/WZVZLTrm9M+3c/d/N5e07oln5wEb1kRS8H1yYszVpi8fvW
	8BcGntIyqiCs9IfVdNmHLkMeeDJdwL1mXLGqUkJrc5IpG8BZd8gWMkStClhmVF3o0bhZZ5Vv/ru
	B3ZPt5BMqfuS2qghR0HJbEPgKaoErFQjZac6uAIr2AQU7q4q4bWtjZ3U9xxMjPJR75/PJFINZIs
	nnNvwuOI3tPGKNQdlScQ+JiuYVaZELNt+qYYOHT009BgAkwxBZjLhAyesF4Dxldjcrc+FHOn6Bt
	rp4oT76jdBVzfNuqRGVSOTpiCc9c3q52vd8iSwZWsRmR5Yb50AbGdgxNUpDoKOHEfbHaC4JPYIc
	am/Q36T46UlC7GkC6wXtjUaxZS4i/DQH8H/hhWB9U918vval6eR96EbG+Ic3Sx1fBzQ==
X-Received: by 2002:a17:903:11d0:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b97c3df3d6mr82119485ad.1.1777482973779;
        Wed, 29 Apr 2026 10:16:13 -0700 (PDT)
X-Received: by 2002:a17:903:11d0:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b97c3df3d6mr82118625ad.1.1777482973066;
        Wed, 29 Apr 2026 10:16:13 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.226.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988785db2sm30726005ad.21.2026.04.29.10.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 10:16:12 -0700 (PDT)
Message-ID: <2e77bf2c-4335-4147-aa90-0192e2a164bf@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:46:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 05/13] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-5-dcf937775e73@oss.qualcomm.com>
 <e494ba66-3f8d-4d71-a82e-b37f5b34d45d@oss.qualcomm.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <e494ba66-3f8d-4d71-a82e-b37f5b34d45d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F32A_AHiwe9rVhoq4WwUh4tSaaSsURZ-
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f23cde cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Y3Rdv8TwbQrKP7QTPRCa6w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=2MFqQf0nztRcsXl5dLQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: F32A_AHiwe9rVhoq4WwUh4tSaaSsURZ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3NCBTYWx0ZWRfX0uR+679Xbi7l
 78nEJ7cL3jlKqidEJPLlQx+ByjFD8qlrt28/pqddYTwxT3pl+2XUQOjCHapd0tjOCZhZaEgbLGk
 XAkB0nTkl9fOAXL9VmbzhbY0bb6YOuhExR2zM4LxhLxEbbbqQEgNd2W9H8dUD7hDf7orp1WH/Iw
 jiJ7AQ/2RGKUawyg5jnUuXKE7HbMTCUxZeIbsqREE0TqEW6sMAWQbOw79wnYc44Ao6YACDJ0Tof
 YZiIzukI2DyWVspS4JGq1Mls2nZOO94jSSoKuvCkXUOC29fFNygnaYhfsk0ZFTijWlSKAqdNAOO
 Z1UIInokAcW1EBBEE0uOmeVYldYzJuezXUB3W+1IEm0RKQTW2SV2SbW7r10SdiYjVtQugZTk49m
 aLmfV21RiJUkxIe9jX4Vjbye5hhme4BGA1IbksyUAdz3yCBo4iPpCb1gY+j23irKZgncKEjaVKw
 mQQSIZgAJ5OG/inJE0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290174



On 29-04-2026 20:10, Pankaj Patil wrote:
> On 4/27/2026 11:04 PM, Shivendra Pratap wrote:
>> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
>> Currently, both the PSCI core driver and cpuidle-psci-domain bind
>> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
>> introduced, would also need to bind in the same way, leading to several
>> drivers attached to a single device node.
>>
>> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
>> PSCI child cells. As the first user, register cpuidle-psci-domain as a
>> child cell.
>>
>> Update cpuidle-psci-domain to probe as an MFD child and use the parent
>> PSCI node for power-domain traversal.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   drivers/cpuidle/Kconfig.arm           |  1 +
>>   drivers/cpuidle/cpuidle-psci-domain.c |  9 +-------
>>   drivers/mfd/Kconfig                   | 10 ++++++++
>>   drivers/mfd/Makefile                  |  2 ++
>>   drivers/mfd/psci-mfd.c                | 43 +++++++++++++++++++++++++++++++++++
>>   6 files changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c871acf2179ce16c80b404027e6b969c7787a6bb..333b01fa00b8fbd15e6f31a6b9af47600411624e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21239,6 +21239,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/arm/psci.yaml
>>   F:	drivers/firmware/psci/
>> +F:	drivers/mfd/psci-mfd.c
>>   F:	include/linux/psci.h
>>   F:	include/uapi/linux/psci.h
>>   
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index a1ee475d180dacab245510674514811aec337ad3..1a1316d11e0a2e4f61801586229f5104e2435865 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -36,6 +36,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
>>   	bool "PSCI CPU idle Domain"
>>   	depends on ARM_PSCI_CPUIDLE
>>   	depends on PM_GENERIC_DOMAINS_OF
>> +	depends on MFD_PSCI
> 
> Should this be select MFD_PSCI?
> We're seeing bootup issues on Glymur when MFD_PSCI is not y

sure. Let me check on this. We may need to make a change at "config 
MFD_PSCI" --

    config MFD_PSCI
         bool "PSCI MFD for psci child cells"
         depends on ARM_PSCI_FW
   +     default y if ARM_PSCI_CPUIDLE

--
thanks,
Shivendra
