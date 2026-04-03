Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09723590C3
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238346; cv=none; b=CpWP3XSHj4k9MhoVylSW0RhPmjqZN1WN3qUrnBEH/TBC+oAE7RZuAnSmnDfIpR8JPf9yFMn8CxPx/tWqMCX3c4uRGo2kZBtx7Heg9UQFxDZeIQgl5B19m7oAxiJyFdPulBXRvbJ4w0G+g+SM+wsCXo6jvHSfmEtgmlKkY9CA8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238346; c=relaxed/simple;
	bh=793ilWMo0AtuO5x03/HxCDAGDn8y9fcCAsLObzmOWQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFUsmNjPvM6WrccTqfQA23fpGtyNSa4wweX07OXG1eQax4WcK/iSUC4INKEjHmi7yDxfmDnL3USx/OgusjvqPkmR6LNPnZMcdKzBgxp+POtKH8DIx9zoc42E5P32YfKk/Yrx4oXFirnckAyob90+JVZ5IvFabiT7bDuXYNmMxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFRVUBvZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d/WuHH5l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFRVUBvZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/WuHH5l"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633FDNYG3449844
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 17:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BcRbm4HgwKmiNI6qxpLJK0dsTMaJBwVAMn+5K7yoUOs=; b=KFRVUBvZOe2C0zgk
	e8tSDQsHTE3yxdNVLr4Csc4+WzEaw/yFbEGpPxRr+o7SdiPO2uIIxWKQCeYai7f1
	8VOMvMRjoCwtBIUerLOoj9EIwHjuwwSTCOM+n8NEBK9k2LpOXYsnYFEq4UVeHXgo
	zTddW1L4sMsncNekJEOFJRldvhmP9CZ5P+LmbXbOzdhhL3C4+h55g2JlKYGkLV/D
	GAMkmb1gg+b5j3buQe28PQ4EOlv1T0oEU6s97UklIjxIouG54erk5HZ22DEMRwpt
	Jrec8/3gieGPqSQDQx6j5q9oY/aGigao8fza4VtqinJco7GEd5+5YKwuRqfdVzE4
	EOH/Zw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da8u59spd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 17:45:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so999629a12.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775238343; x=1775843143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcRbm4HgwKmiNI6qxpLJK0dsTMaJBwVAMn+5K7yoUOs=;
        b=d/WuHH5lFxa8ac31yVvkE1mnCTTbt+vrZMSrmCXUiQq566hCa3A4uVvz4SPwS5sQHR
         7uo2++yErR0dd1xrQk+P+kEF1LWOZSwWaen6qRTFo/5A6KY66qdef+2KUEYnvZiyxfrV
         9PFQ0sntFFrEWVWDy+Xpess6qbBMoWdJUrbmbsEMwMGH/vmQZEmKjumthP1OiVMy2Khn
         6OmBhtjSwNrCzL+HbPB2kxXoe2ZVRJOvXbqNweWIqduUXD6ifcAsOc1Dn/ALFmdBwKFA
         wQ3XLfm6BNDlfJVgIAUHeCo+dH3hUJWP8oBx25Kj/Ugwg0IojjP8h80ebxB7Jp0L0XuF
         JdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238343; x=1775843143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcRbm4HgwKmiNI6qxpLJK0dsTMaJBwVAMn+5K7yoUOs=;
        b=SWEHhrmvtttJNcisGZnL8BZP34WO2FQH90VtK/VQ9kxl0pRz1Nqf+7PW/A9HGcxrZl
         FLGhzzU9fGKB8GHGqeJNzLCzhO+uxY+jtvmnJrXFDeDusWN9aAa/G+YjkPV9QlxPZyAO
         r0QaSODAvL1+j/98UpzZ9UMTcnTZHw6Qm7Kb4hIusMlaJGJhV4qbiwVrPePsnWb0EeuT
         FHLkWQkJVMEntoDqc4r6WiuvUbzWGhLqo0RySc1AbN4h3IGFfTEI8coNKfUl3Z9CNp7N
         B+QB0FupITSwBVVnQQQaUFcKSeeQc3S4mkOh6aBh5Mnhgqw+5GCSNOJ/1vqbaTrt9ixs
         BXXg==
X-Forwarded-Encrypted: i=1; AJvYcCVmqynAu2XltODBftia61Z4DhRWzXcBmcS8vAYnV5rfkS6JuJtMdvTmNbPNTf3lrB0Mb78ZkTWaEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsjkuP+CnBsPRsrlXnp6Tm8GAxj/g8FCebqNjDl1ITZTidvVJ
	brv5Zti/gY+QVdqXzoTAyuP1nk1BoldqXt1L/zgXkMeF1jPfhAQO1xZETkxXkNxFN52ka3ETaXt
	QF/g5c8pqTwHd2KmpUWOT8meOpYrE461Q8ss3rBzzjRq8Xtnh30iH7ccDqRK04A==
X-Gm-Gg: ATEYQzxKeAyxrsFoKpoO4lSotgtWQXHMtJDyI8zCtm7SUDh8E+k3FTnGh7fxCQKw3+F
	JkHuDxa4EcaYRK4VTglBnSwSt/WDTvu7z4QdRf8K+OtS7qlXV3SBuHmNFJHTw1mxz8Cud6J1/qo
	KSufPFfwWjFilyoZsfuBVcqvdTdffoY5hBhqfHfbkUix5/qOvKPJSlEKDxlD7y8T+Q1L7x756Ir
	bEzQX8pRdJCKLlU2/mlUyFoezPoRlKbYpHiq92uRdnUSB7ZNFEDBSRE2fmFy3GuKf4zOlES2rD2
	EtSnaCNiZd9JCTozmt66W3hx/m2EdnYPthfFXRM4M9YhbyWw+pY0hBQvZVcclKFvehVcvKNu6rB
	I+UC/0r11iKgcyvmZ0WbmCxGMg0Wg91ymDCT6Taak5f4S77UqJaUCNPLZ
X-Received: by 2002:a05:6a21:9995:b0:39c:4ca1:345b with SMTP id adf61e73a8af0-39f2efadfc1mr3753185637.38.1775238342813;
        Fri, 03 Apr 2026 10:45:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:9995:b0:39c:4ca1:345b with SMTP id adf61e73a8af0-39f2efadfc1mr3753157637.38.1775238342245;
        Fri, 03 Apr 2026 10:45:42 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.227.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563597sm6988128a12.16.2026.04.03.10.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 10:45:41 -0700 (PDT)
Message-ID: <547c006b-231c-430c-a69e-f80334c4f81f@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 23:15:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
 <acaMPgRALnoUIHMC@lpieralisi>
 <93a78bc2-4fd1-41bd-bf4a-b433b06fc218@oss.qualcomm.com>
 <ac0trUGsRBLPS+ux@lpieralisi>
 <da6f4566-a719-409b-80a9-40ca89e3e721@oss.qualcomm.com>
 <ac/hru3IIiU0+Lp9@lpieralisi>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <ac/hru3IIiU0+Lp9@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1OCBTYWx0ZWRfX9RYPsbO/1VRe
 1aMmUtHjOGvxU8OJu7N4pkQKXyhdhFBmeqQDqVyX8O1XPW/+xYKyAhi1MjO4L7w3octbPr7WNYA
 +BPD+viCWYtAiaK2I2IfSQhs1O6kNHJNBiGqtC928EmQ0lzSJrYfrxtgm3bifOwCnQ2JI7yVixS
 SiNUITRQMgCk0V7+UvM5pSOK0hqZnkac/4GDjZyovBELTFDzDVr4xgx4aMNvOaIlnl3KkJkvUga
 9gBe8TXNssC97ZUypwb9yGryH5EjcQvCY1yJbkSQXOUkSiorXY+iNXU7t9kXVDerPezIpxWdZjI
 nm6/wtUXuz+5eTtE1NseGxvDUOpKWFhKkg0dXgLBfcqzZXwTjWbkClSL032EM2ZFu9hH6WSaEVK
 Fumy3ZWjf8WUPoi9hDvgeSgxc05yRKJPFgPL62049T9Vfm0Uj6Vr9KxhTekU2RUeRn+PbM0hAK3
 5sR7ZILSL2XcXIOpMVg==
X-Authority-Analysis: v=2.4 cv=W5g1lBWk c=1 sm=1 tr=0 ts=69cffcc7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=2dos1RgzJhmu1+008kacPQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=F0Qtw4M1lXcpx3oWCRwA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: mnoj_ru_ptbB-gOi5wiWWpqxbPakxt12
X-Proofpoint-GUID: mnoj_ru_ptbB-gOi5wiWWpqxbPakxt12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030158



On 03-04-2026 21:20, Lorenzo Pieralisi wrote:
> On Fri, Apr 03, 2026 at 12:05:27AM +0530, Shivendra Pratap wrote:
>>
>>
>> On 01-04-2026 20:07, Lorenzo Pieralisi wrote:
>>> On Tue, Mar 31, 2026 at 11:30:09PM +0530, Shivendra Pratap wrote:
>>>>
>>>>
>>>> On 27-03-2026 19:25, Lorenzo Pieralisi wrote:
>>>>> On Wed, Mar 04, 2026 at 11:33:06PM +0530, Shivendra Pratap wrote:
>>>>>> PSCI supports different types of resets like COLD reset, ARCH WARM
>>
>> [snip..]
>>
>>>>>> + * Predefined reboot-modes are defined as per the values
>>>>>> + * of enum reboot_mode defined in the kernel: reboot.c.
>>>>>> + */
>>>>>> +static struct mode_info psci_resets[] = {
>>>>>> +	{ .mode = "warm", .magic = REBOOT_WARM},
>>>>>> +	{ .mode = "soft", .magic = REBOOT_SOFT},
>>>>>> +	{ .mode = "cold", .magic = REBOOT_COLD},
>>>
>>> These strings match the command userspace issue right ? I think that we
>>> should make them match the corresponding PSCI reset types, the list above
>>> maps command to reboot_mode values and those can belong to any reboot
>>> mode driver to be honest they don't make much sense in a PSCI reboot
>>> mode driver only.
>>>
>>> It is a question for everyone here: would it make sense to make these
>>> predefined resets a set of strings, eg:
>>>
>>> psci-system-reset
>>> psci-system-reset2-arch-warm-reset
>>>
>>> and then vendor resets:
>>>
>>> psci-system-reset2-vendor-reset
>>
>> Can you share bit more details on this? We are already defining the string
>> from userspace in the struct - eg: ".mode = "warm".
> 
> "warm","soft","cold" are not strictly speaking PSCI concepts and mean nothing
> well defined to user space and even if they did, they would not belong in
> the PSCI reboot mode driver but in generic code.
> 
> Spelling out what a reset is might help instead, again, this is just my
> opinion, I don't know how the semantics of resets have been handled thus
> far.
> 
> If userspace issues a LINUX_REBOOT_CMD_RESTART2 with arg, say,
> "psci-system-reset2-arch-warm-reset" it is pretty clear what it wants
> to do in PSCI.

ok. got it.

so it predef-modes.

reboot psci-system-reset2-arch-warm-reset =>goes for => ARCH WARM RESET.
etc..

> 
> Again, it is a suggestion, comments welcome.
> 
>> yes we can move away from enum reboot_mode and use custom psci defines one -
>> Ack.
>>
>>>
>>
>> [snip ..]
>>
>>>>>> +
>>>>>> +/*
>>>>>> + * arg1 is reset_type(Low 32 bit of magic).
>>>>>> + * arg2 is cookie(High 32 bit of magic).
>>>>>> + * If reset_type is 0, cookie will be used to decide the reset command.
>>>>>> + */
>>>>>> +static int psci_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>>>>> +{
>>>>>> +	u32 reset_type = REBOOT_MODE_ARG1(magic);
>>>>>> +	u32 cookie = REBOOT_MODE_ARG2(magic);
>>>>>> +
>>>>>> +	if (reset_type == 0) {
>>>>>> +		if (cookie == REBOOT_WARM || cookie == REBOOT_SOFT)
>>>>>> +			psci_set_reset_cmd(true, 0, 0);
>>>>>> +		else
>>>>>> +			psci_set_reset_cmd(false, 0, 0);
>>>>>> +	} else {
>>>>>> +		psci_set_reset_cmd(true, reset_type, cookie);
>>>>>> +	}
>>>>>
>>>>> I don't think that psci_set_reset_cmd() has the right interface (and this
>>>>> nested if is too complicated for my taste). All we need to pass is reset-type
>>>>> and cookie (and if the reset is one of the predefined ones, reset-type is 0
>>>>> and cookie is the REBOOT_* cookie).
>>>>>
>>>>> Then the PSCI firmware driver will take the action according to what
>>>>> resets are available.
>>>>>
>>>>> How does it sound ?
>>>>
>>>> So we mean these checks will move to the psci driver? Sorry for re-iterating
>>>> the question.
>>>
>>> Given what I say above, I believe that something we can do is mapping the magic
>>> to an enum like:
>>>
>>> PSCI_SYSTEM_RESET
>>> PSCI_SYSTEM_RESET2_ARCH_SYSTEM_WARM_RESET
>>> PSCI_SYSTEM_RESET2_VENDOR_RESET
>>>
>>> and can add a probe function into PSCI driver similar to psci_has_osi_support() but
>>> to probe for SYSTEM_RESET2 and initialize the predefined strings accordingly,
>>> depending on its presence.
>>
>> Not able to get it cleanly.
>>
>> 1. Will move away from reboot_mode enum for pre-defined modes and define new
>> enum defining these modes- fine.
>> 2. get SYSTEM_RESET2 is supported from psci exported function -- fine, but
>> how we use it here now, as we do not want to send the reset_cmd from
>> psci_set_reset_cmd now?
> 
> You do keep psci_set_reset_cmd() but all it is used for is setting a struct
> shared with the PSCI driver where you initialize the enum above, possibly
> with a cookie if it is a vendor reset.
> 
>> 3. For pre-defined modes, warm/soft or cold - reset_type and cookie, both
>> are zero, sys_reset2 or sys_reset2 decides the ARCH reset vs cold reset.
>> 4. For vendor-rest , we use sys_reset2 with reset_type and cookie.
> 
> Yes.

Ack.


>> All above is done in reboot_notifier call at psci-reboot-mode.
>> --
>>
>> Now in the final restart_notifier->psci_sys_reset --
>>
>> If panic is in progress, we do not use any of the cmd based reset params and
>> go with the legacy reset. So we need to preserve the values that were set
>> from psci-reboot-mode.
>>
>> Did not understand the proposed suggestion in above usecase. Need more input
>> on this.
> 
> I explained above. The reboot mode driver sets the command to carry out
> depending on the string coming from user space and whether PSCI supports
> SYSTEM_RESET2 or not.

got it. working on it. thanks.


>> --
>>
>> One other option is to have a restart_notifier in psci-reboot-mode, with
>> lesser priority than psci_sys_rest and then handle all the case including
>> panic and sys_reset2.
> 
> No.

Ack.

thanks,
Shivendra
