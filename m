Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B74A64F4
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059499; cv=none; b=WD34gTIHmcyYC7r/Xa/kU7qEUaFGAVZZ7MzcKpUS++nUzAR5vdjb4lMMvZebtPXhGJbJ4LphurJBBu+8Q0QGlctbSs6yL83slBT7VDSjHg3GMA4o/EU56or5TSkX4VhHU8N0b/WrLi7aEyFCPbrOxFbOqWry4s/yWxrODFaqNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059499; c=relaxed/simple;
	bh=13gHV+V/vKo2wCISeUaDehyMyz0li7+PEsKi6r7N6O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuFGbY+tjoe7qs6wE+fyTUecqync8lceLWpTdAs5/fOTOBD0R3lVNzaUsh6FH5PqN1cHT82hVo3S2y1a7syEpomOv8Uv/jV8YcG1pubDj21XD1N8U/O8OApYSuxO4zeXO7lTApYWDcx4znjrJ93jrNCbpbTso4dQ1dzBxHEpuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cmm8/1Qy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hdp9WTDc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cmm8/1Qy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdp9WTDc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M0eYQo3044076
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 06:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C814naZBWfuhRBj7+Mh0CMDgtTYhHaoCxzc4iufRXTE=; b=cmm8/1QyUQmg0qKO
	C8Ufl9aengIsZO7UFWYJn7IQjeOW1lCkbyAaX7T+407/Kv/0p0YaAY1Sgramh5wb
	JbqltIME1235WuXpTNdsJhFmy1gxo1n+hU0lEBY5ioxN4lxdIW6PQnZPLaM7s60Y
	DwxTCqtm2drDjJzgnGJsD/TANoHQGPjxDxMedk7WMIAyCovenPjzknlKzG7Ziij8
	VY3Qj5OT0A/UtwbPygd1hijMHMye4js0NDBtdvytKKJmB9FRyZXxNj9jLLdhHWC6
	u1Z+rPbczHnViHcDSQAjNDd+BBnb0rTo8I0pAlIY4ZLrkRxC7Vi4EhUmC5Ylbm3y
	Y8yT/w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbas5w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 06:44:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so5155962a91.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790059490; x=1790664290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C814naZBWfuhRBj7+Mh0CMDgtTYhHaoCxzc4iufRXTE=;
        b=hdp9WTDcPxN7fMB9Be0cVNxRSabnt9AHpXA+XruCwRNraCDWXaY0o7T3R9tCpeuov5
         kRWox4WVFApid14HJLvKaEdsrtsJWgxptT58rhwRNfANBUFeU3v7muyFejhJk0c4kvcM
         N3rNykx/ehf5dQuVJ5eXbRRF91ksTaEWtck2TfN59xpPQqMQUdTU1tMaky4Xxbpw5O0Z
         6R+iH9JsT/mLasvax0+OjriFp/HXMKCCGHrVCwTMYC2Ui2OE8riayhWvv7hMJBVv5w3b
         yl56McXZiAjaPzbe6V+wnPw8jgiuUKbrxz6T3XKpAs3TwJ/dR63zo7A934A0pmca6CGH
         21ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790059490; x=1790664290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C814naZBWfuhRBj7+Mh0CMDgtTYhHaoCxzc4iufRXTE=;
        b=Rue98CO9xKRfgnfsKNM5MmorBy71nXHhRRFFZFWNEqj47nbk6W0sF2H6HV/r/m2oev
         1TXsdNoOebuxkmYmIVXz2HMC869KPVHHU/NSCatUxxcg49fH0B4ptmwmCYOba2NEbkij
         HiyU3+9SEd7GVs0A3djPDtML40j6rf12edTx7+DXFo9z0jKexzUjvuwMkpGk7oxZ5ang
         es8SOEe8oPBgpdtnEg8eXRB84sdz8C/vcqFNBwPr92+44ZmyaDqrSWxH/7Qm4WFvEELo
         eyJqpCbfQEraq3XZwcVoCYFvhsonJOd7/FGUMtSZNLC4vD3DA4b0nh/Wb+CiKAO58UWI
         6gEA==
X-Forwarded-Encrypted: i=1; AKwUvByPc2hxBFwWhFh9wME4skJGAjOq3sN6tiP7zeM0R97HoZRdaDlKBi0I/OrkbuE4HWwx2Jv6I+O31Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kcwZ12DsZRHy6Y4aSzigxBP6Au2056DGSRkL18sGW5yeyLO1uG
	hofonejAC9/FV3YFBeAiJkVRJrHHESJ8f47ZNe06bfO6l7ASFf4V3LtBm/tsVNSvfhY3F3NF483
	MbMHAkiW0uc7As9tK53jtkDbHY2oZb0oyLK7xQnS8fH/cgApR5Kqn+F1PSa92w7QQlRco
X-Gm-Gg: AYBFou2UB/2HyygKNNWEqJAHmyK29SxtNnpFMAj6/bF58Ub8bPbi4GjDrwsKCcdv7zP
	WyxWgluhtGiMVJh073KPgG/nXVLrHtUJY6Vp3ywhsz5+csv3Eia1BF4xWbwzIELmfJwcSQxYVN9
	KUw/D0ke32PnVSWUpwoQ/HVnYhsqL/OI5Yf8bms7FtgqR33rzetfDyhUxura75uPsm9p3LWc5Nz
	FzOJPewU6gesMlMlR1h4xuQl6/k9f0KKtkoFPpop99KqSXhrVCSgxg4t3pkD9Pve3PwPF2wFkJI
	ZS3I1IJubZZFA8ZwXDwlZ27F+YmL2uCvyiaPy7V5Qt9CiuP/79inQoSihrmc+aXhXokQaCltYzz
	xRYXr17aBdpxAjOJEga359GgFfuQizw==
X-Received: by 2002:a17:90b:1850:b0:39e:6bec:9eee with SMTP id 98e67ed59e1d1-3a0731503d4mr220812a91.12.1790059490239;
        Mon, 21 Sep 2026 23:44:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1850:b0:39e:6bec:9eee with SMTP id 98e67ed59e1d1-3a0731503d4mr220774a91.12.1790059489671;
        Mon, 21 Sep 2026 23:44:49 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6133eab7sm2572025eec.29.2026.09.21.23.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 23:44:48 -0700 (PDT)
Message-ID: <42487beb-29af-49f3-95da-a05ab7faf8c3@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 12:14:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
To: Bradley Morgan <brads@mainlining.org>
Cc: avaneesh.dwivedi@oss.qualcomm.com, bleung@chromium.org, broonie@kernel.org,
        chrome-platform@lists.linux.dev, daniel.lezcano@kernel.org,
        francesco@valla.it, groeck@chromium.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, mazziesaccount@gmail.com, o.rempel@pengutronix.de,
        rafael@kernel.org, rui.zhang@intel.com,
        sebastian.reichel@collabora.com, sre@kernel.org, tzungbi@kernel.org,
        umang.chheda@oss.qualcomm.com
References: <2F1E7C6E-897D-40BF-A37E-EAF42C4A0CA5@mainlining.org>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <2F1E7C6E-897D-40BF-A37E-EAF42C4A0CA5@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5NSBTYWx0ZWRfX+jaBJsJkN6fO
 kQVYz+SVuwX1zNGZp6fjIhVTVNvkWVmS2SJ7drDqg5AN3qEuM7Jz5IwbXDI+lOn+Y8QoCmgGM9N
 5y6xLK4ZC2+nQcs6lapo0DOsHl8w05HsszRvRkSO//CnU0bRk823Me6vYrUxJvDSk8H0IfsbP2y
 LFQ5hGpQOoDwvmrSG6AoJnsvy/bPwNgRN3vXXmP9NAmWBgu5zCPTrxnKRwTAc5uYhG9Fa/aiqdQ
 WgRafhp2flo0CkbcNpfIyRFPwjDmPhXPOOpNTp7aHnkSyUTnaNyUrP2NyU4/kT6IpWsJAoymB5O
 7kTK9GmkruOfG/1VLQIdQqqOECuYQUMqw0XAXBXESoFPtmY1PyXK/ab2J1fe2+Kp+nCiFjBj5mZ
 RkKXgkwULzjftTO204TAnr8v83D3DELJfB0j3V29BrC5LwjL8G5oRjXN+r3YgZAbuszGgWSxf+7
 YTaQHQ3p4k4SghHodeA==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab223e8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=lrQciHWGQPAY86nPn80A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5NSBTYWx0ZWRfX+0TYB7IkTyrd
 8rF1iC5TQYzw3j+K4EfR2VqiYrRVrtaDKnPqykG+MsEJ1btFRrfAY8/j8O1bZeiNZYDHZQoenHB
 j7w/MFleUTT4Vbp9/EHWnJ0Wzrkf8Wc=
X-Proofpoint-ORIG-GUID: QlcVFOoYn6E8aSi_tV_cqROMSm9MDjF6
X-Proofpoint-GUID: QlcVFOoYn6E8aSi_tV_cqROMSm9MDjF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220095

Hi Bradley Morgan,

On 22-Sep-26 12:03 PM, Bradley Morgan wrote:
> On 21 September 2026 18:44:15 BST, Faruque Ansari
> <faruque.ansari@oss.qualcomm.com> wrote:
>> Hello all,
>>
>> A system power-state transition - a shutdown or a reboot - rarely has a
>> single, unambiguous cause, and no one component sees the whole picture:
>> the
>> PMIC, the watchdog, the SoC reset registers, the bootloader and software
>> each
>> only know their own part, so there is no single source of truth.
>>
>> PSCRR gives these sources one central place to report side by side. Every
>> provider keeps its own view - several providers, and several reasons
>> within a
>> provider, can be reported at once and are deliberately not collapsed into
>> a
>> single "winning" cause (a bit of a minority report). On top of that it
>> adds a
>> software-backed recorder, so software-detected reasons - under-voltage,
>> over-temperature, a watchdog pretimeout, a panic, a controlled reboot -
>> are
>> captured too and survive into the next boot.
>>
>> The NVMEM-cell binding a recorder needs to pick its storage is still
>> deadlocked, and several projects already need the framework, so this v13
>> posts the framework, its reboot/reason infrastructure and the sysfs
>> documentation only; the provider drivers (NVMEM, PMIC, ...) and the tests
>> follow separately once the binding is resolved. One built-in provider,
>> reporting the bootloader's device-tree /chosen/reset-source, is kept so
>> the
>> framework is useful on its own without a new binding.
>>
>> For followup drivers, see:
>> https://github.com/olerem/linux-2.6/tree/v7.2/topic/pscr-v12
>>
>> Changes in v14:
>> - Ignore v13, it was mistakenly posted as a reply to Oleksij's v12
>>   patch series.
>>
>> Changes in v13:
>> - Rework pscrr_provider_register() based on review feedback from Francesco Valla:
>>   move the pscrr_root check before allocation and narrow pscrr_lock scope.
>> - Carry the series forward with Faruque Ansari as author and Oleksij
>>   Rempel as co-developer, and vice versa where required.
>> - Link to v12: https://lore.kernel.org/r/20260731095959.296056-1-o.rempel@pengutronix.de
>>
>> Changes in v12:
>> - Drop all provider drivers and their tests; post the framework alone. The
>>   NVMEM-cell binding a recorder needs to pick its storage is still
>>   deadlocked, and several projects already need the framework - so unblock
>>   the core now and let the providers (NVMEM, PMIC, ...) follow separately.
>> - Rework into a multi-provider design (per-provider /sys/kernel/pscrr/
>>   directories); add reason tokens and a built-in /chosen/reset-source
>>   provider.
>>
>> Changes in v11:
>> - add missing break reported by kernel test robot <lkp@intel.com>
>>
>> Changes in v10:
>> - add some add Reviewed-by tags
>> - regulator_handle_critical: set pscr = PSCR_UNKNOWN for default case
>> - make g_pscrr static
>>
>> Changes in v9:
>> - Remove redundant pr_crit() messages before hw_protection_trigger()
>> - Replace psc_reason_to_str() switch with static const string array
>> - Mark psc_last_reason as static
>>
>> Changes in v8:
>> - Use DEFINE_GUARD() and guard(g_pscrr) for scoped locking of the global
>>   pscrr_core struct
>> - Replace manual mutex_lock/unlock with automatic cleanup-based guard() usage
>> - Centralize backend and locking state in struct pscrr_core
>> - Prepare for future multi-backend support with clean encapsulation
>> - Improve sysfs documentation
>>
>> Changes in v7:
>> - document expected values in sysfs documentation
>> - make write support optional
>>
>> Changes in v6:
>> - add sysfs documentation
>> - push core part of the reset reason into kernel/reboot.c
>>
>> Changes in v5:
>> - fix compile with NVMEM=n and potential issues with NVMEM=m
>>
>> Changes in v4:
>> - fix compile with CONFIG_PSCRR=n
>>
>> Changes in v3:
>> - rework to remove devicetree dependencies
>> - extend NVMEM to search devices and cells by names
>>
>> Changes in v2:
>> - rename the framework from PSCR to PSCRR (last R is for Recorder)
>> - extend the power-on reason header and reuse it for the detected reason
>> - rebase on top of v6.8-rc1
> 
> Hey, I dont see the use to PSCRR, are you planning to ship any providers?

I have already posted the NVMEM cell provider support as a 
separate email thread.

https://lore.kernel.org/all/20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com/

Thanks,
Faruque Ansari


>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>> Faruque Ansari (6):
>>       power: Extend power_on_reason.h for upcoming PSCRR framework
>>       reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
>>       reboot: add parsable tokens for power state change reasons
>>       reboot: extend psc_reason with power-on and reset causes
>>       power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
>>       Documentation: Add sysfs documentation for PSCRR
>>
>> Documentation/ABI/testing/sysfs-kernel-pscrr | 108 +++++
>> MAINTAINERS                                  |  11 +
>> drivers/platform/chrome/cros_ec_lpc.c        |   2 +-
>> drivers/power/reset/Kconfig                  |   2 +
>> drivers/power/reset/Makefile                 |   1 +
>> drivers/power/reset/pscrr/Kconfig            |  33 ++
>> drivers/power/reset/pscrr/Makefile           |   2 +
>> drivers/power/reset/pscrr/pscrr.c            | 633
>> +++++++++++++++++++++++++++
>> drivers/regulator/core.c                     |  16 +-
>> drivers/regulator/irq_helpers.c              |   9 +-
>> drivers/thermal/thermal_core.c               |   3 +-
>> include/linux/power/power_on_reason.h        |   5 +
>> include/linux/pscrr.h                        | 107 +++++
>> include/linux/reboot.h                       | 108 ++++-
>> kernel/reboot.c                              | 165 ++++++-
>> 15 files changed, 1183 insertions(+), 22 deletions(-)
>> ---
>> base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
>> change-id: 20260921-pscrr-framework-25f48818efe8
>>
>> Best regards,
>>
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds

