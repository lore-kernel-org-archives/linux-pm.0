Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480A3D3CFF
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214827; cv=none; b=isS5MBjuTuVkisJ8/tc97reqyGcLzMQL0a5PbaPNV0MoWbnCcORSLJbLiBzwDlVpXdqmynplFRnhW5LGZziv6ZHLBE9gRmmhBFJdLqntvekfd8qQTrzjnrAlFZEfKL3UPsfc5k3ECOFjKfPOciZlneBrPPy7XKYMIlE5Lc8E85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214827; c=relaxed/simple;
	bh=cU4q+dAxzjz/DdxxWO6hFG4V0bYZzbvaND34NUZu7PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFUOr9yR0CxIQGDU/NGoVYTKkJQwtVHO83uEQ35cTCMpDYiH24iWcK8hL6up2g7LPFT3twFGoEYzsh0V08i2wipcC7ELdF0du/qMGXCBP4NSKqZiVua5/Xc8RzmYU+boNd04Wm4TfgOi2zQDV+CvE+Xa6f1KvCPQCa2L7BbQqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FsMbsDLm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ls3C33MH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsMbsDLm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ls3C33MH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXghO3753484
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gbpIZDM+t+BqRGRuIADnoesPyoKgyGdyq6Z6YoV5lU=; b=FsMbsDLmantxocyn
	GDmJ0rr0zG+63KJzsBAVKtuY84dmLWjSvC0jgE3gzbeE7d6qwHEqYz4OtYrV8USp
	akVXYilcHHwAZZdlALHByn6Q74s9ywJeorYQtaeq18OVTyVuFuVd2gL93TPOJnWS
	5gUysLPiYiie6A10Jwpm8WheWus3ILiRTz2XoPoMoOSOaIEkipFBfj9Zk0oEpDkx
	DQzsPZMl7Hrdjpw2SJ64s/fJX60/Zi94k250/v2aA9OA9KUF2mXYf6HLM+Kt0Pxh
	WILOyBVEyH8GHmVrNJO86tagACKzrX/OjJQlTiNOgeAPO/OKInCcxGwROj5qAFGo
	el++zw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gxks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:40:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so1240410285a.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782214825; x=1782819625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gbpIZDM+t+BqRGRuIADnoesPyoKgyGdyq6Z6YoV5lU=;
        b=Ls3C33MHU/77W0GkOR3u0/+7YRm5lmgP8apVeIhthxI02S0ZkAB+YR+9qLuwSbEdp+
         2oa3OEDuYNKJKodmNPCPZgDjkNRTqqKzxghSI/5uGOFl7G6krYczjuBlXwZW3lQEvoZe
         4zjkc5sLx4yJyqnlH0IhJSP9tnuja18UfyWZyUEqjvJwuusCmBe/xeH2rTVB7JOyY/J4
         3gSAMl84ty3KP6tH5lW3XHMX53RkWx3IVt0bk8rLqD4NoHXYw0x9N0IwSgGlP2FH2pQp
         2S06GKWV8EzY9Vg9mU7Mydm5so4c1cn0LGtTwkJ5byD/FelEY4p4BGcaQ+VzIyIYOCDn
         RvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782214825; x=1782819625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gbpIZDM+t+BqRGRuIADnoesPyoKgyGdyq6Z6YoV5lU=;
        b=Fc4usMSn9UMTPPlK6z/D6M+AP9Gdz3TCoCnQo9kVCV15ZpJqNj26RBgk/wbTvj57Kc
         MGpFHor5yNEXtiGJUmwRWNbaiD8z2pQ+BmYeIdeGb4ruTler4B0jLh5DVU+FNIcP/jSe
         fi24QLWCB06gV4r001tBhBVZSXSQP+BrQU5bWD5+u39tWb7wtEDPPK4uWvLhlWns8pvb
         F9PHgj3jnPNjYiB4bWYtRHMW6iycuyzU6L9KU4vRp02VIGsvsZfMmY4gW/xm/73WHMN1
         JaXEui5pOwOWYYBgDOJajMGEpGaDC+xTLrDm/rfY6bHocP487Ve/5QSuJrqJi+YbrX3y
         RTYw==
X-Forwarded-Encrypted: i=1; AFNElJ8YQKi4c6TMiFEKR4TuwcIBdqY2l41eu2cPGMV3otWVe+dm/DNRLNYVZ68PG8VmWFWDbSNMhWZUHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypYEWErFpLSyedsNSPHKZtAafwaE5mMH5xTfd2FJTFqloMgQow
	Bx11IMz7vmaLsi0xtK3qXlUwBove9QGHI5fWNZaUR25zeceCumYKHGt+6cR4IiYLy33nenqCQa6
	zto2UdJPESXBhtqQlPIikBO/BCeEoGytst2JhPYGAQ27g5rITqbl1yOiHTJwc+g==
X-Gm-Gg: AfdE7ckOpBZW4dlKY0ILTj1yKN+dmaoFpCTFzTudDgNx5Yf1CY1CpaqBaUVakGXu0lz
	bcrLKMat9xRS3eLfoniHM1P8GHIZKpeh1y58jEmmydOVBhSqHOvijMv75aA8CVOJuYxYq4WVSes
	VUmysyDt3rKzwOVdlSx82s1KIzh9ufWs8joqGPsi3fstJ3ghymemoub3MPxEDjcctWawtYn7tf/
	jPuC6tTNLmTqMKl5MijCMy0Eku3BH2yA+y7Acg+5u3XoT91RvWl/J7lG5vZCllOkJZnUOfZ02j5
	X6MUaEVtbxD3ZZ/lgQoR87n7aqmbBtcE5nlUvM9Tke5yZ/CU8zuljtYIB+FQl9zGvJ5qjN1CMaa
	ic4bgxtdWDLdkEOieMCVIMVJ73v9rH6i6D/GmRNX5vL4I7yKT2JrZqYHTW5EH+Av6QN9RowCjQQ
	==
X-Received: by 2002:a05:620a:2616:b0:914:babf:9f45 with SMTP id af79cd13be357-92646583c1cmr430162885a.26.1782214824542;
        Tue, 23 Jun 2026 04:40:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:914:babf:9f45 with SMTP id af79cd13be357-92646583c1cmr430156385a.26.1782214824036;
        Tue, 23 Jun 2026 04:40:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:21db:9254:19d9:645e? ([2a05:6e02:1041:c10:21db:9254:19d9:645e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm34668027f8f.23.2026.06.23.04.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:40:23 -0700 (PDT)
Message-ID: <9b5ea951-6880-4ce8-8764-fd6bf2bd57a0@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/cpu: Disallow offlining boot CPU based on config
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a70a9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=W5qrNhqdD0BlkYEQxcQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: h2trnKIfa8pVJAXcZj7mZUJ-gu_yfDlY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfX8+faXzf1tKAC
 kg3h2g5S3VOYpDNcff0NE9QHoT0+ppjWWpLPe5Dk5WYXfzuPHCyq1YNiEI78CUAJoRGTZTOeSJu
 rM0xb9THUGbtw9NWDF+aFWdvezQM0oQ=
X-Proofpoint-ORIG-GUID: h2trnKIfa8pVJAXcZj7mZUJ-gu_yfDlY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NCBTYWx0ZWRfX7oTaIC6WlMgB
 JuN9EFD/NPjNgMs2H3uYWEKnZmHvLXYSa5oN2jCHlwtKBlE9wWsmL3rA9y3/mWMdSN0hTJlhhUB
 SbgGZ+GhbAB86EEVoqo5a7oiHs5uslzCslXGsU7GnmWBJPjcIg4t6lbGOZACb3ic2nXF6DFJUDC
 tWg/CKXL7zmzWPRggN/mzshZlcgB2IqroAf8OAqi7wgPM8ukOZJNlx1Hm+WubnTGminhOr8dJ3D
 +iA9o2Vwt4B2WJ951NFCFSpkS12MUbXhkzzz0GolmTkYpDgYq+Zh6mLYB9KlV2eZTnJnJDkiT2t
 m3ocFKSWPMxiHTgYsnLeHfMKCZn9N5aPR5R9szHKkO6MMH7fce+m319hMlTljF9RT7jvfPJzojj
 XqUTvyXgBqMhfMFhA4anskEwwYQt243/wHlab3vEhcBkMTIGrW5QjhrvyqH1sf9WnSAA7GDMnF5
 eTXYLLiQetcS+yI3E1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230094


Hi Sned,

On 6/5/26 12:30, Sneh Mankad wrote:
> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
> retained.
> The hardware design on these SoCs forces a constraint to suspend and
> resume the system on boot CPU / CPU0.
> 
> If CPU0 is already offline before starting suspend to ram the
> freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
> proceed further to invoke PSCI SYSTEM_SUSPEND.
> This leads to a system crash.
> 
> In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
> config and when enabled prohibit the CPU0 to be offline.

What is the status of this change ? Are you planning to send a new 
version with the check inside arch_cpu_is_hotpluggable() ?

> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> ---
>   kernel/cpu.c         | 4 ++++
>   kernel/power/Kconfig | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bc4f7a9ba64e62d76fbb2b362f243c918defe5bc..1c878db1d9cb6df0e31cb55343851aab4e38a3a0 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1478,6 +1478,10 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>   	 */
>   	if (cpu_hotplug_offline_disabled)
>   		return -EOPNOTSUPP;
> +#ifdef CONFIG_PM_SLEEP_SMP_CPU_ZERO_STRICT
> +	if (cpu == get_boot_cpu_id())
> +		return -EPERM;
> +#endif
>   	if (cpu_hotplug_disabled)
>   		return -EBUSY;
>   	return _cpu_down(cpu, 0, target);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 05337f437cca29da57864583166d7f9abd526507..0b342b3a4a5650a1927dc4805d1515e1d9e067c6 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -401,3 +401,11 @@ config ENERGY_MODEL
>   	  The exact usage of the energy model is subsystem-dependent.
>   
>   	  If in doubt, say N.
> +
> +config PM_SLEEP_SMP_CPU_ZERO_STRICT
> +	bool "Disallow boot CPU (CPU0) offline"
> +	depends on HOTPLUG_CPU
> +	depends on SUSPEND
> +	help
> +	  Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
> +	  has to be executed by boot CPU.
> 
> ---
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> change-id: 20260603-disable_boot_cpu_offline-eb4f55ac96f2
> 
> Best regards,

