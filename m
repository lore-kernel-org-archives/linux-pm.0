Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14F47124C
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813509; cv=none; b=U964pbccDylpOErA1vMfV7C4CT6AH6Ce1OwzKkw7QohfjKGe+88fTwUUw/Nb3CtDXzrSN49DEoV58kTfDAk2J6PIezPeUYE50SmNhF38SvrdWTA17CBe3e1eluTzHAJ5rdFBp+jEZnaz0bPmQtLNC2BiDdR0aFy0aaQKFImwe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813509; c=relaxed/simple;
	bh=9Ol8B4QWV5NXBRf+nSnnc5gyMNdZdIH5zliFKFF7tIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMvhlKp//LA/R+BAS1+SOBb5wwQXrLehxruAe5F1It4kvlbG9UGxlCq+DPxYiL0sUZogaO3r1zLWi7y4YRmF4gt4YsL/kMf7WVhRUZxWzWJkNvcVvc6b4fEKLo1cyLY18gKNWOf5tuKaq+4gwfKHe88BP1H9y+vve0YTSfe6tsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkUoIIZB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FLgZgZA5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkUoIIZB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLgZgZA5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NCvLeR1030450
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKQ0B+W9pZMhr76PdrHF4/xp6Zw+LCJpnEkdrdNCyFk=; b=CkUoIIZBgBJvbNtb
	9q7x5RirhZImdElF4zMeucB1GtvkPl751AgbDCA4CXbBU81JlkTyfN8OvupqcuHV
	KCm5mUsG7Sn+DXqt5d8lfUVcJ/IdtZowPp1fzHFnc+j3ab59xnlfZKceQwi4f0U+
	AG0EtKBoSEbRf7SzFWWlOwYmCJOWgzf+J5FgLWwXROuxJHU4Mkskue1dhxKLSWj0
	J1b1u0ZGPNwmLfzTqh055ibbWX4u+O4f8fGYMM+xcok4jb16YJQHqwYdiqDwePWn
	9IRrkMij2odOAlBNGE4VWdFN/XHurqaBFu7/gSCBXmaQD7MKMjP4UzRQPBH3ml09
	PwmojA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xva62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:31:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf1c86963bso5100635ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784813505; x=1785418305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKQ0B+W9pZMhr76PdrHF4/xp6Zw+LCJpnEkdrdNCyFk=;
        b=FLgZgZA5n0DXr7JyrGxax9AKdDdT5XqjJn35GKqMOetI6BoesdUA8Kh8STdgxoUgmR
         Pr5DQXYuOIs+M8NQiDjLtQReBCsQ4g78WN5XUlWMiZAo2CA+JLcSqWAx0VCNq3DCisf3
         fI75nImwxtTv5ZtoQ9PthI+9RMIjKaMcfNL+6fQB9uywgNALksqrHClDp0O3cRKh6pUp
         I3KLI8yqXAdS4fH0zGY/KEgboVcV5fFbU5iw87OhZtDL8RNKmX/K/Wrk0cXCj5K4FpoT
         lBN7TbmZYXANihcxkhTV6AtDs8MQRWoN4MBJoo2kiLnGUcPXsP+GGD1RxeCFwrQj6fxT
         6wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813505; x=1785418305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKQ0B+W9pZMhr76PdrHF4/xp6Zw+LCJpnEkdrdNCyFk=;
        b=hiaSJR3FSld9q0fQ9y20Tg8mfPtnai6GjwWjkpGuWT8VVDQ9saFR3WF4uRa77DxE+P
         yWCtJwb4/kzKkyP1m5m0fsuy48PeuCa4eL+FeLIKr3yaI9pquwn2jEr6E3A7NjDGofLJ
         9aR3slPAIBMQG/LVcfGHSlBZf1gi48ZYDc4+8jFBE7DHovorXSdU9hsPsbxY1A/gHALt
         2g37uRh2XxPbT1mA2mvFuojGvCIUO/UYTE0XKbPqLintTXk/GccJyUeQFmYfBUGorMTi
         es67TTODApQKIlJqj0iVwzGfvxxGfZNJPrgGKQ8ybLWSyLfkMx5QZs5nh4TsoYmofep5
         np7w==
X-Forwarded-Encrypted: i=1; AHgh+RoUh+qBMEf7SdEd89Rk3WQC0xSIrvGroU/yclOCJsXS3H+xl/bk/Km2i4A3bFIZX6kAlf5lsFtuxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4Cv9TiH2xnuUaJEGQj0JGwtMNbmMUPJlOfSOiphbABVtUofy
	1FepfEIUR8Yl804ymgCxPHK7FoyxTzLL5UzBxmiXPSI/nQ3kxT9fj/bdOcmanQhwYhKVFJqDwrz
	IwrdsN+1dS8UaqIsr54ktM7q4JSh4yvy3hnNLjJlE6hv/pUnyOtFpr2kIGSh5mQ==
X-Gm-Gg: AR+sD11um/ErNpObeHT5sFSmgQceuB9lQ3P6x63MCMuFNwAM4t67jzWTv6+jGRYceOg
	oyRpNwuR3yIUzxdMC861iKC6TwdHy8lupoDeVQznFgG/7iX0qr/Fg4oIHFj8gAsfzF2040P/3wu
	mjwujzVS6LeDcCeqLk32jQWUwIXN6BxQezxWaATwM4mIqgKONgf8hKlOxqB3Vgcoka7r/4QDqm7
	jHlOz2tmAMCMGMGoT5fM/cQK7leruLxztHz/UBr/E6KVkZeMmYHK9JukEoUB1S9pCmQm5rKEJ1B
	ZcmHrsLfFPKLnSLyq7dEVtMpgi6xvt4tgyolBJK7iw4QvLxLXq5YVP8/sURkxtllpJ8SQOzr6hk
	PmYnCScde47cZrGnytBj2s0RtXgPBm/BAXrA=
X-Received: by 2002:a17:902:fc84:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2cfa95512a5mr29173805ad.22.1784813504628;
        Thu, 23 Jul 2026 06:31:44 -0700 (PDT)
X-Received: by 2002:a17:902:fc84:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2cfa95512a5mr29172995ad.22.1784813504114;
        Thu, 23 Jul 2026 06:31:44 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e7a83sm34671765ad.42.2026.07.23.06.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 06:31:43 -0700 (PDT)
Message-ID: <f04ebc41-549b-4eaa-aa7c-21489382f8be@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 19:01:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 07/13] power: reset: Add psci-reboot-mode driver
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
        Sudeep Holla
 <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-7-e7453c548c21@oss.qualcomm.com>
 <7b1dad52-b9d3-44a7-aedb-62911778f3ad@quicinc.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <7b1dad52-b9d3-44a7-aedb-62911778f3ad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mL6hOchgniqsHdcJrBF0VWVgiSS7u7ik
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzMyBTYWx0ZWRfX2sheIU3p6i2T
 xmnEMavnXe8+ZZUNdJMFt2DBzcRlxXLmc9cJU/m06rAONJ2PKKDjQf1sQ+tKUkJIqS4sGMm0s5D
 C6x7u8azxo98/Eu9FtIX41WU5ffmeSo=
X-Proofpoint-GUID: mL6hOchgniqsHdcJrBF0VWVgiSS7u7ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzMyBTYWx0ZWRfX8JWt/41lDSM6
 9eUTtJTWLpKP/tcWEEQLR8+MbRNhCpTMQetQPThpGpqXzvBNvYeJaiAjBLYRx0wd3dTaEdljq3a
 TlQGnkqmdgz3i0s2ZVLbOTRX5glcr7SrqD0CJmdroXE9c7O+B6sVYKCbZ1eVGZ5TXC3jwhdpbVC
 /zQZ41uAXQTh2QfKNP2/7w3nlSnTyaTNU2qD4E3fKEp9mWmAqbLfJfMmXqG+kIB9RiNsexayF2q
 CBApAvvlMxdDkHfhcmPftBy4MnvhrIKeyv5YObcZJil4PCkpGt8xCNj0W6PdFsBVZCblt7+1CTY
 B8fc6LTHQ/br6RrKrh04cU4gu+yDtPvpSZQ7rMu+Wbneau1eU5/N2FRMNm1y0S4Eud+TFkNDev1
 fKUjYrE9w+U3dZBsdDzbmV1datLuT5WgdxwwGROO5gvomUNHvbjI5eEZkGYW8isSapP2+byGdy1
 UxBPXZl44v52k5zCqhw==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a6217c1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2z0wryL4N9vVr7V_-cUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230133



On 22-07-2026 14:30, Pavan Kondeti wrote:
> On Tue, Jul 14, 2026 at 10:46:35PM +0530, Shivendra Pratap wrote:
>> PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
>> ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
>> there is no common driver that handles all supported psci resets at one
>> place. Additionally, there is no common mechanism to issue the supported
>> psci resets from userspace.
>>
>> Add a psci-reboot-mode driver, and define two types of PSCI resets,
>> predefined-resets and vendor-specific resets. Predefined-resets are
>> defined by psci driver and vendor-specific resets are defined by SoC
>> vendors, under the psci:reboot-mode node of SoC device tree.
>>
>> Register the driver with the reboot-mode framework to interface these
>> resets to userspace. When userspace initiates a supported command, pass
>> the reset arguments to the PSCI driver to enable command-based reset.
>>
>> This change allows userspace to issue supported PSCI reset commands
>> using the standard reboot system calls while enabling SoC vendors to
>> define their specific resets for PSCI.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                            |  1 +
>>   drivers/power/reset/Kconfig            | 10 +++++
>>   drivers/power/reset/Makefile           |  1 +
>>   drivers/power/reset/psci-reboot-mode.c | 78 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 90 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e1ed6abef62a..4910abafa170 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21576,6 +21576,7 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/arm/psci.yaml
>>   F:	drivers/firmware/psci/
>>   F:	drivers/mfd/psci-mfd.c
>> +F:	drivers/power/reset/psci-reboot-mode.c
>>   F:	include/linux/psci.h
>>   F:	include/uapi/linux/psci.h
>>   
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index 124afb99febe..93e4029d9506 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
>>   	  then the bootloader can read it and take different
>>   	  action according to the mode.
>>   
>> +config PSCI_REBOOT_MODE
>> +	bool "PSCI reboot mode driver"
>> +	depends on OF && (ARM_PSCI_FW || COMPILE_TEST)
>> +	select REBOOT_MODE
>> +	help
>> +	  Say y here will enable PSCI reboot mode driver. This gets
>> +	  the PSCI reboot mode arguments and passes them to psci
>> +	  driver. psci driver uses these arguments for issuing
>> +	  device reset into different boot states.
>> +
> 
> Since we have added predefined-resets support, why are we forcing this
> driver to depend on OF?
> 
> For example, `reboot psci-system-reset2-arch-warm-reset` gives me
> warm reset on non-DT systems, correct?

sure. Will update it. thanks.

thanks,
Shivendra
