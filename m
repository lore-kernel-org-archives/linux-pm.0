Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1348097B
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910624; cv=none; b=sIOCYSz7S5uGbm06Svrc5N67qsjsex1ZlHwM+fwjBfdCTxeV6fbLd5e+r2EwJ3olUTidOBlEtIqMJAeLiJ7/VZvQZzf1TIHkbuDtefdoTXYvNoD+hi4Qc+/LWS7fx1U1dHAg5rdsruC+RLG7s9VStCQi0GddkoSOfPmAp4Trkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910624; c=relaxed/simple;
	bh=hdIYYpVLSeX7+svp6SZ8DMOKqflnF52FNs8KE0Y2J3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVsBaIwPZgwP6fiZtHRwBEVUhlii5TMwOgDqQUca8JIyn4X55cU4R8BQtG/cNkl5xa/t991PEX8N2uuJv4CaHTlgYRHso/PEQNiEm1E0xRk/3MeqD/QH7RFtxWPsOqxrEkwAI55dLkSrGmo3G/O7wSm9HgkIZfCCHv3Yt3/i4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/U6gq8j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jdy0OADN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/U6gq8j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jdy0OADN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8O7h761381
	for <linux-pm@vger.kernel.org>; Wed, 1 Jul 2026 12:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/OJQwxG66eoPwHB57XhMgHYByUU3ZhNy+b3VmI0FVH8=; b=c/U6gq8jxAU41MoF
	i+4cbo86vaXqtO4VTz1j3LuCB1CaF6b8u11rAv0ejfm3CEcoG8oiF82NruPVi8Fq
	DIAQVh9FDqSM/DXuXfvxSEIKEzBYwKNfF9YINoyW66dMhaLi8VNOoKztK6UzEnvz
	RG/rxG21Zp9tlw3AHieAXbz19X64XeICHg+x/kSZQRD6WqGVNN4iF9yYEYJ+dGMU
	1FAFiUclAOUWXcmCfND52cyM6QbcStUzYXljIUHAAhZq8mSTOVUP39H/9w/DSu3P
	sX0Z+FM9R8B9S58/0QMBRcZYqouLTAqpN0/Dh79vg3SOXeE7JPK8c1WULwcHdsY0
	u8U/+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd0q7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 12:57:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fb51faa63so681735a91.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782910621; x=1783515421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OJQwxG66eoPwHB57XhMgHYByUU3ZhNy+b3VmI0FVH8=;
        b=Jdy0OADN9DhK6uLgBXpdb2REgTDYx2HIauqRqbHUcWTpjvox05FxU1vwE5Qa2xPqXa
         vvEeIgt+wA8uFJ08gUjoVUvG5o5fOYVTmX/5HVur83MxC9Y4BpvoNTaRZQwnRUmJ7wdT
         KRhchg6gIoThwk8SrlJikb6Vxk4ufLoF2FlBJCrHuV/ZkIQ3fCM9gFBKJh/rx9EWBbjV
         bASDzfHXDxmnMNy1jss4hW8XxHV9fhB8bCcG8kXOAawPZ6ldX2tZAdOus6bnJye8ApA6
         n67THh7Jl78XFBCySg66OsoNeevCiLIjdt1/U88NkEF4NPChofbfWSWGwBBqELAGskIo
         NUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910621; x=1783515421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OJQwxG66eoPwHB57XhMgHYByUU3ZhNy+b3VmI0FVH8=;
        b=IU1PDQboAjCVoIQveOO5IVLAzCeCug49QhBJY5wfYe99luoUSbecQ5tQYz+gQA/wXW
         oQbzLRo/HacX1S8d6YCsz3/iOQ7L6v+EIh3tJt7Qs/rtU5n7Mua+RlAsPDPXAkvvQfdR
         mGhah0+EWFE9S5Imq2U3oYLwNQoOl9UwS47E2YlIuH2h1IZYoV2LJk4JN8pdk4KiFLpE
         uUainsyVeLRTkZAcU2CnYCOnuz8Iw2t5FpIpgsAUXUFpgsrAn/ujwvRSBATHXaxmPM8J
         XFoRn8CDAFdKeHN7Rx0oAlts3uP/h2DOnrYPW1u16LDnKkLJ+5GZzxcyEl8dGKGkzE6K
         EjrA==
X-Forwarded-Encrypted: i=1; AHgh+RriXV5xoxGynx8nHsyqgl3p0cESKWhAcp163gNEkCErUBXFK/PI2d3QgkPoHxle+7bj0Q3oOZ6Jow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HyWU3gRVrsDiovj2qxijiHKQYGjvAnMWSl4YdSpchn4vQW+D
	k/Pdtsg6+68gxQMse4HS+RvMikQms7qKD829jzxqXy1cDRr3H8tUU4vKnORgPhdvaHom+e5Jc0W
	eQG0j3UFB+z6BHRZyC+Apgq7LLaz3dZFrKjTjxf7Ex4vZIXE5nZjCfK8/IoaF
X-Gm-Gg: AfdE7clk9M28D0rrjl5KNBxt3zth38Nweotepj4VPIOaHU20o4HEV8923khawer1p1V
	fx8svpKx9iGSymwJgyHTBdBi9Oot2FSCVJEJfZHOakv/spBx6oQh+/rzPJ4fTGxZZoCOgzNHugC
	JITBRj/y7aC/kjrsYNVE3k2jeSPte4ZbQTlUUgflFLwMHLMYH0Bd3OK8QyBnWPNIypP6fDTc4St
	c4jFeWrNhZywHseZfL1FE3QIZSyYBdBhf190qxQhlYhxzrSrmpVj5M0dbgguJYKX8ttuFNMv6q1
	GrH/eYEHxCe75GX3jfA8ITQoPj3jmNGzzd2zBgjAM3tZ3ZDJfBVEAD9xFHZkZQkKG9PE14BS2wb
	H/HyKNXI2UMwfyMfWulLlz9sy+SS3QpmJTPkrAWKW
X-Received: by 2002:a17:90b:520d:b0:37e:cb9:fd7d with SMTP id 98e67ed59e1d1-3806a04dc16mr5209498a91.17.1782910621055;
        Wed, 01 Jul 2026 05:57:01 -0700 (PDT)
X-Received: by 2002:a17:90b:520d:b0:37e:cb9:fd7d with SMTP id 98e67ed59e1d1-3806a04dc16mr5209457a91.17.1782910620416;
        Wed, 01 Jul 2026 05:57:00 -0700 (PDT)
Received: from [172.20.10.3] ([106.195.73.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d4c263sm1876770a91.3.2026.07.01.05.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 05:56:59 -0700 (PDT)
Message-ID: <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 18:26:37 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
        umang.chheda@oss.qualcomm.com, faiyaz.mohammed@oss.qualcomm.com
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <akJaAesz35Ml3iW4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a450e9d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=1uYXuS+mtKqEVW6EmjfGNQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=fA3yq6K1D-CQ7x3jqe0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: YFwjJPs6SmodpmFNJUrIbzQQO7_s3WeN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEzNSBTYWx0ZWRfX+49m9lMmRy6K
 dmVpbMqCZPBnx2I43hKQZvrzfWV5scS/PIGNlfHqmv8h0j5Cc3n9O8RU7B5TDQFPONkmtO659Ta
 z7DZZQ/SAL68u+L57SzT98jn/rhXY3c=
X-Proofpoint-GUID: YFwjJPs6SmodpmFNJUrIbzQQO7_s3WeN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEzNSBTYWx0ZWRfXw/VPfjfCJ0Ri
 M4D2Few1kVXlWkVvOqpqmW6LTyoE9t8v2iijYbTvkMl8/WR01s/W/bZV7krhZnn8w8kf9lCzCrP
 9itov3wBL07EjCBLVvYwaRNxjKDNS45MCTd1uAgMaPwkEnkbfAyhloVukHBgn80PFqHwDXDOL/V
 uh5AYHCGIVdVDztLRTmX0rOyt4CnOrclZYR+vm1XF8RZEnkFCiG+qNtrAwb5ablQXl2M9Ijuw1J
 mJABS94hYDphAa2PuVE56zLGeWENXLe5xDP7FWm86tuarso/2b491AMoX/whKwV+j6Z7gg1H7WH
 3+2jlCSBO5i7CCfuSF9ymjI2CT/olQgiwIT1uw2x7ddoOfcLVGxjjvQ34ngzyLfjZ/0lt2wiF5u
 YZ9wuvkhtpydXFoKYSICKHH2JO35zvRPT/NpqECXg6YJPrh5uZgUVgL9hR4Bwx1774sqvXcIEfc
 D5NDwKxWW4nP5vFG3GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010135

Hi Oleksij,

On 29-Jun-26 5:11 PM, Oleksij Rempel wrote:
> Hi Faruque,
> 
> On Mon, Jun 29, 2026 at 04:44:18PM +0530, Faruque Ansari wrote:
>> On 29-Jun-26 4:40 PM, Faruque Ansari wrote:
>>> Hi Oleksij,
>>>
>>>>
>>>> Hello all,
>>>>
>>>> This patch series introduces the Power State Change Reasons Recording
>>>> (PSCRR) framework and its related components into the kernel. The PSCR
>>>> framework is designed for systems where traditional methods of storing
>>>> power state change reasons, like PMICs or watchdogs, are inadequate. It
>>>> provides a structured way to store reasons for system shutdowns and
>>>> reboots, such as under-voltage or software-triggered events, in
>>>> non-volatile hardware storage.
>>>>
>>>> These changes are critical for systems requiring detailed postmortem
>>>> analysis and where immediate power-down scenarios limit traditional
>>>> storage options. The framework also assists bootloaders and early-stage
>>>> system components in making informed recovery decisions.
>>>>
>>>>
>>>
>>> Just wanted to understand rational behind creating this new framework
>>> (PSCRR) for
>>> reboot reason recording and not considering extending the existing
>>> nvmem-reboot
>>> framework ? As, this framework already provides a way to represent nvmem
>>> cell in
>>> the DT and the driver as well can discover it. Would it be correct if
>>> nvmem-reboot
>>> driver itself is extended with the features which this framework provides ?
>>>
>>> or was there any other reason you decided to create a new framework ?
> 
> There are two main reasons:
> - nvmem-reboot - Tells the reboot target - What should system do after
>    reboot. This frameworks is collecting information - why we
>    rebooted/booted in the first place.
> - System may have more then one recorder or source of information. Non
>    of it provides full picture. This framework should provide easier
>    access to different providers. For example:
>    - SoC tells PoR
>    - PMIC tells PoR
>    - Watchdog tells nothing
>    - nvmem storage - tells under-voltage.
> 
>    All of them provide own opinion on what is happened. Evaluation or
>    prioritisation should not be done in the kernel
> 
> So far i struggled with DT, but may be i need to put it to the side for
> now to go forward?
> 
> Best Regards,
> Oleksij



Thank You for sharing your rational behind and idea behind this 
framework !
IMO it would be better to have a single framework to represent 
all the reboot reasons of a system and not just the reboot 
reasons caused because of errors
Ex capturing reboot reasons like ota, bootloader,recovery etc ... 
currently nvmem reboot driver does not expose a sysfs/ABI which 
user app can use to infer reboot reason ...
Also, it would be extend this framework to also support firmware 
triggered reboot reasons  ...
Do you have any plan to extend this framework to support 
userspace triggered reboot reasons as well like bootloader, 
recovery, ota etc ?
And also extend the framework to support vendor specific reboot 
reasons which can be triggered by firmware  ?

We can co-work to extend this framework  ?

On representating nvmem cell to the framework  - if not DT what 
is your plan to represent it ?
How would framework discover the nvmem cell if its not DT based ?

Thanks,
Faruque Ansari
