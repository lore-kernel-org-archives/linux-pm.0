Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896353F4845
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664827; cv=none; b=YIw+RbRKDJUhwoVSspao5DNOXDNmTGzwlIbpUNRKDLJW7SpuanYwJlpwtLMVG4PgA4B8wyYYoj/7K5i9wERmvSHlMhCeAmr8rDTVWxf2W1zusXtjZXsMkv2F6HW9CDlxIhzOqbZYmpgo/0pqMFYAoX5NykLv4BWucznHpJzikv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664827; c=relaxed/simple;
	bh=BgEnJG2nNkhRJIZJeG8X561rJtevfoUEeD+oPlrNmok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0XOOHgteSSOQfrJGWPNm9Q2gcNBa/NXvHDIm0iJAuaA780b7MHuySgKdFFFREhXgn1q45cV0JA94WgqqfhDhykkg485ZH67zfh2S+Mk5kc5Vxuii3QRaCt6z/sm2uTTdBZp16Oyi5px7WXdEGCc8spCZWj+eHijNhLCUs4FUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m9PbrBrK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZkSNFwg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m9PbrBrK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZkSNFwg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65575dYD1502306
	for <linux-pm@vger.kernel.org>; Fri, 5 Jun 2026 13:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7TgQxra7IxxwKvFp5QOL3rJaDB0A8hZzWZrioo4dbSg=; b=m9PbrBrKrGeu/52v
	cGHEWwt3NrrI96XeLpIN4EnnsRJmm5zBC/PQIsoehQ+b/dqntOVY8siShvGQoNzM
	GipeUixXIQTHsv5zpWaw0TkL6X411nn+K01POfAhUfiMFHPG16QgYHpvhmGiG2/+
	OD+akoHPREx95uhbjPM1WUTWCsIZEC+b+ViPi7t4ny0vgrP3X2sFn4vlR9Lthgcm
	BzesYet1Y5O7vmgXt4BGBSrw2zyDdWSOmDfiNwO7pE5NVl2PHYJktbroOqaPXCfS
	YGFjP2q7EQUKdNopMuMshWWOYGCLdVd0l2Cx8wbguPa1e1gQCPz0N3H489v0rKPo
	KWfTrw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eksrwsad4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 13:07:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso2599304a91.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780664825; x=1781269625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TgQxra7IxxwKvFp5QOL3rJaDB0A8hZzWZrioo4dbSg=;
        b=cZkSNFwgHMdpRJoi6Uj8qlxtToePLCkYeUsrbBHj67o6tn9bz57W2EC6D7bUNqzsdF
         2bgc57+TxoxxROl0kDWCW/baAkSbhmtVzALpNrmB4wbWbLQPgujj+2734Iu2LQXTiXVR
         /8pl0AUDsEPHbMEQbm7IGchsdllFQgIu3PzcEmdnhei5OjU4l7wJVZaB+yhtBSRUvgEa
         t7LQ6bvEBIFG1m3V9s4xDYZXXW2CM2u7RHa9DSk0gx6VHvUtdTPQBhTKqoW5NkOM8rwf
         4bNrnrn5nf7R3VYZKuWk90Fibdgfdnm/OUXpPtT1lsTZp1/pSYQg2ZZvahZkhjZZ/7H+
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664825; x=1781269625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TgQxra7IxxwKvFp5QOL3rJaDB0A8hZzWZrioo4dbSg=;
        b=Au7dm19tX73B7qK5w1zhUOAl9n3KqgeJP/nJNFO1OjMfLMow4lvwrBJkzqIRBJeBD9
         xmtRcTm3RDsmBagORgcawS6DVL04lVUqDxigFHMnwcmIwaCFfjObmOP5JPHazHb0uGi4
         4b3jpS1Ez3+VQYUcgn3mObDnQokfe4hj/BMhOxH55gLKmStf5X1EdNq4XGS6wHUPW3ej
         KwIsPla3W4UwaATlSsDIk0oQscHjWs7R4QlixGOPZe432yHie1kYzi+GYUpWvc95YgbW
         EaWdOaqA4BD48kLtBTwhBY9Cb4M9wXTi5wTGMVif6y49BpMlPHr8AfiClQOFfhOiMbkC
         Eu9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+rgzFSI9GGwcO0YvZDi0ulcGwutfTWrR3Ba3Ha0xkqyuZ7ITuMuz0Vt3parMP/f/HQhPpYCql6OA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+kv/vH6r6lAMpzHFLVyOdu01lkP8EO8W5Mi1k0HURIJ+qu7E
	Lvs8C5fHg723DScGN3NNWiuS4LswU39dS9jNb8Pt6NvG55DLaRUjQrjjv1X2RSlLkyjYGaLFjF4
	lnQTY5+rCx1rXzaSisrj0FeEP2k5Hd46momTYgky7zG1apSWvmUdzsaTgOM3rXA==
X-Gm-Gg: Acq92OFhvD8cYW+Pa9gbgxpHummWR5bSOAzWB9BwLBRTRNWPMQdlm40mHBoZ5rGNQ42
	iVT4ursZL5H1/Dj7zeK5JD/e+Mv02zehacWctL14P4RiJoLcGKRIFTTgnWKxyi1lajzM+T6xBzU
	Qpq+/NSv//b2vIzLq6EIyYbVihErK/vp2WBYO9lVcKiqkBaqINPeqnZI66EFKwluRnEeBjBfY59
	MVLcMWhkH29oKGdSu44nRDQSyKvyyeF7hVZJkYz5Nv+YDK7BRiY67zo/l+s5xP04KYvcUsD63/D
	y1yo37o/Hu9ww4fefhb24mEdlElmY9JyNtStqvzVconZLct1BhnNbfOSBRelZCAslMx4QfVSHax
	HruvPPkMWtw2OMsvH9hakX5n+pGyMTvzVhVSpjJ2H5NlZ2R8Tud3bfSQm1NLB/l7ZKzZQfmArlx
	Gyt4bXro2EUqzD4BnO2D1blRIBPo8EcUTk4KUENBWQCbKuXrus25E=
X-Received: by 2002:a17:90b:380a:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-370ee344da3mr3723657a91.1.1780664825196;
        Fri, 05 Jun 2026 06:07:05 -0700 (PDT)
X-Received: by 2002:a17:90b:380a:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-370ee344da3mr3723615a91.1.1780664824698;
        Fri, 05 Jun 2026 06:07:04 -0700 (PDT)
Received: from [10.190.200.113] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c6748f9sm6311530a91.5.2026.06.05.06.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:07:04 -0700 (PDT)
Message-ID: <53c7251f-0984-454c-a9fd-d6712dafc295@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 18:37:00 +0530
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
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=L5ktheT8 c=1 sm=1 tr=0 ts=6a22c9f9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=W5qrNhqdD0BlkYEQxcQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEyOCBTYWx0ZWRfX413DtQKltXRs
 0jTgHK9EYLr0hl9eXS4JIIfBrUwULaeh25oyieCFEUsV5hgBCyESPKrZsjMQYFRapDOI2ZV8cCs
 NOtsNQB3QpdpH8soryLI097zZx6RmLlYR09wM7TH1vW1TBDBW/iqs8YWcg+Da+bOL2LCPE93BvO
 s9t/rAxvyN+uR+eJ74PQHmO7H8zxJfT9UExOEAZ/SH3JwCs9PJaifKPXWaoOoVx3R1xM/3sUqOr
 PQFIXMoPhX0guWfmUr4dxNEsq/sT48olT9raaST+tjn6L4gKjrYCftoBQiuKHkWs9pw8Tcgdthv
 vffwoK0kRbcRdlpPyw2kcqiFch2iDLopnx/fXkpR30kbl/EZfdnOiEqxeL3cnJuKOKvmk8hWBhF
 RdOEB1X/UeCbzisxhWBr80tvpcJZs375OvotoV0qR/ZVCxYapk8kMyzwfAaxU18kZtvo6S7LpgY
 p89kaO1Rfo4+OrFnTNQ==
X-Proofpoint-ORIG-GUID: i9lzQdTRZV14T-jPE6gsHSWDrz8eRmB_
X-Proofpoint-GUID: i9lzQdTRZV14T-jPE6gsHSWDrz8eRmB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050128

On 6/5/2026 4:00 PM, Sneh Mankad wrote:
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
> 
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> ---
>  kernel/cpu.c         | 4 ++++
>  kernel/power/Kconfig | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bc4f7a9ba64e62d76fbb2b362f243c918defe5bc..1c878db1d9cb6df0e31cb55343851aab4e38a3a0 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1478,6 +1478,10 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 */
>  	if (cpu_hotplug_offline_disabled)
>  		return -EOPNOTSUPP;
> +#ifdef CONFIG_PM_SLEEP_SMP_CPU_ZERO_STRICT
> +	if (cpu == get_boot_cpu_id())
> +		return -EPERM;

Should return -ENOTSUPP ?

> +#endif
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;
>  	return _cpu_down(cpu, 0, target);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 05337f437cca29da57864583166d7f9abd526507..0b342b3a4a5650a1927dc4805d1515e1d9e067c6 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -401,3 +401,11 @@ config ENERGY_MODEL
>  	  The exact usage of the energy model is subsystem-dependent.
>  
>  	  If in doubt, say N.
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

