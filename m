Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79E405C41;
	Fri, 15 May 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883300; cv=none; b=Kr7ywacJaM6KWWUfuD2ScIPuwRddsOtLOVWs02dolt8cQqdikQOyiA7qPTxakRx7Iik5kyU/1HzT7kuf6XKar1McdDLQIaXjolDYR4powEYoKwEZiCgo1G90WgE+155V4iscOFOzu3yHGjaCC1GkODvkt+1jyRDEyWiRMBrV8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883300; c=relaxed/simple;
	bh=jtBOm2uPnQYFmHSs1M/Yo/0rcke+5LEHR4oPThHOhZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrY+1FhGWf3UfiUG1F3qZ/ATUxI0pfdvehZJBUtHwSi+/MsmHHHn0Clm17jD64sBvVxj6YQH5saYkaIUfBrsvbeEh0QJf2fd0lVvjVBcHPmy+mlhc27Lrav7ObYgxZEQMlRhcul2NOKaoRxeq9F1UgbizTIhTkUnHsVzZPG2gpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iiVNrNKX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiVNrNKX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1zobbfP4WB+3+tnZ3vazEKyIHxBQmbIB/DheGdu717s=; b=iiVNrNKXTsWSokzcQ919SL720G
	O/TkcfxKmdlMg+fgOOcgbUHgrQbfR7uNLTxklxsuXzYoI8vvvbAoT8VkSOm1dm0j46SHOdn2hhld+
	7aHSuxcdQtUXDpRpJNlJbFTceu8QKixWs/HbEQsV8QpgLY3ItQmFAIRhnC5/gDwhUXamV/2clFEyF
	ANaEaeRasQjB0Z4cvvu3BpWJ3vXpi3fEvkuzsfl0j18t/Zl+c+P4SAMlTaF8tTZLk0AbrzB9gtAD6
	65c/FEnwS4l86rBW01G7SVI1E0NzxW9W2SCoHYayBNuLJ7dtTA9FjgreemAl2qM7J9vI4BObllToC
	YaVC617w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO0o2-00000009bil-0mKg;
	Fri, 15 May 2026 22:14:54 +0000
Message-ID: <b4516579-c4bf-4ddd-843a-30d4a4992519@infradead.org>
Date: Fri, 15 May 2026 15:14:52 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, mario.limonciello@amd.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260515122624.1920637-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 5:26 AM, Sumit Gupta wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0eb64aab3685..7e4b3a8fd76f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1048,6 +1048,22 @@ Kernel parameters
>  			policy to use. This governor must be registered in the
>  			kernel before the cpufreq driver probes.
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance

I just noticed that we should have both CPU_FREQ and CPU_IDLE added to the
legend (meanings) section at the very beginning of this file, but that
doesn't have to be part of this patch.

> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register
> +			support.
> +			Accepts:
> +			  performance, 1: enable auto_sel + set EPP to
> +					  performance (0x0)
> +			  default_epp, 2: enable auto_sel, preserve EPP value
> +					  programmed by BIOS/firmware
> +			Unset: cpufreq governors are used (auto_sel disabled).

-- 
~Randy

