Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4374346FC3;
	Sun, 19 Apr 2026 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776571760; cv=none; b=CS++aAbT0vLuR4QRoTjrmS13GwauihkFim+sB5oG9fgUZhNRyZ+JJ1zAXidyZD0YeNKMrLIauOiKD0TuahbNMarbcUT//8rkQr3SriWa4k13dTS4PubBDdMi+QOM2/WB/A6liFBGDaX2egQmWVAvN+Oci0Gc+mdkbp5Ek9BBXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776571760; c=relaxed/simple;
	bh=B2V0GySMBor9Pj4xTZgLLcI3x57DyEYfoSsJ0Rf87C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI34e5jBerVJ9DPn6uFuskH13u1n9XfDg2o3Lo96kiesV09daYzNxR+rO10i5QWZe74awzIbVhv8T/wrtW4CrTUxdSvYz1UKcgN8gRDcllA3Zv4t46GX/FKFG+t6+o29cbwCznIOVAaaJHZk2/ZwdYmh+hiSfjeI1/ZnW2IcXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgiikl2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgiikl2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EDFC2BCAF;
	Sun, 19 Apr 2026 04:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776571760;
	bh=B2V0GySMBor9Pj4xTZgLLcI3x57DyEYfoSsJ0Rf87C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bgiikl2H4XT80I/AbrYQvvf+xxK+x3iTJrBE3KLtGPOWbuaq06vaNQHUm5wFurhxm
	 TGABMHHZkZHX+Qt/odNpdgKOfZ/tQ77Gf3Z9U2sRTMvNndQuRn3tkhU1Ekyx2GezDD
	 kpnSnnZpftgXOakKXwWx3VU9kjybjaAk6TXRYgwuArE+PjASJ1OZvsQhFA5VsjKt/d
	 yax+ppYegYGcyXXxAVbIRrVkUMyfiw4HpksGHuHv5tF53tA0LtGrWzs7ng4CKXAN00
	 HMr9y0blDs4GRn/84G45HdWdrz7Y3EJK9Q6v8nLdvVODtZntZliXdtdg8WDCwwA0HC
	 f6GvC7LYOZkjg==
Message-ID: <c135b5b8-90d8-43ca-9017-96fcffd747c2@kernel.org>
Date: Sat, 18 Apr 2026 23:09:18 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: clean up dead dependencies on X86 in Kconfig
Content-Language: en-US
To: Julian Braha <julianbraha@gmail.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: gautham.shenoy@amd.com, Perry.Yuan@amd.com, skhan@linuxfoundation.org,
 ray.huang@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417230652.305414-1-julianbraha@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260417230652.305414-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 18:06, Julian Braha wrote:
> The Kconfig in the parent directory already has an 'if X86'
> condition wrapping the inclusion of this file, meaning that each of the
> individual 'depends on' statements in this file is a duplicate dependency
> (dead code).
> 
> I propose leaving the outer 'if X86...endif' and removing
> the individual 'depends on X86' statement from each option.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/Kconfig.x86 | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 027e6ea2e038..9afceb1143df 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -5,7 +5,6 @@
>   
>   config X86_INTEL_PSTATE
>   	bool "Intel P state control"
> -	depends on X86
>   	select ACPI_PROCESSOR if ACPI
>   	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
>   	select CPU_FREQ_GOV_PERFORMANCE
> @@ -36,7 +35,7 @@ config X86_PCC_CPUFREQ
>   
>   config X86_AMD_PSTATE
>   	bool "AMD Processor P-State driver"
> -	depends on X86 && ACPI
> +	depends on ACPI
>   	select ACPI_PROCESSOR
>   	select ACPI_CPPC_LIB if X86_64
>   	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> @@ -84,7 +83,7 @@ config X86_AMD_PSTATE_DYNAMIC_EPP
>   
>   config X86_AMD_PSTATE_UT
>   	tristate "selftest for AMD Processor P-State driver"
> -	depends on X86 && ACPI_PROCESSOR
> +	depends on ACPI_PROCESSOR
>   	depends on X86_AMD_PSTATE
>   	default n
>   	help

