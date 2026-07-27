Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B93F8251;
	Mon, 27 Jul 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150900; cv=none; b=UVU/9zWj8vihAlYNaRC85PWakBUZwRczce346nUF5s4Lfd4oUPmFkM0ZULCdfg1P/LYaGwBz8uOe9CB5sM4lAohvHUEW53vFoIHmmxJX5W0OKtD6et2JWzwdZdRP+39U45+c6v44z1k41H/2EF4icGQ/Cj64nKw+7QtsiC2X4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150900; c=relaxed/simple;
	bh=IbkBx9XspAvH/xdZaiDJ7NX2w5Ye8zRuM63x4HChgIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g+bX8DbpyoptV1+bs69XGsGaGZoJ19JCznE4eVVOtpmmTE/Tcybxpv4TD3avxVhcALCjR/kX8dNizAhrIiIm+D3N3WCV9mTjNJQkLkt7s9XO/SB+j0kfmoym2TyEmMIdyBzQO85SFxfLYruilN95qWqJ8L8lgliyiJVdaScn4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=03u6kJk3; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="03u6kJk3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xQh7wNxV773cU0+b2zVPNhmbSKzYd6c9ZfRHbrY2PG0=;
	b=03u6kJk3dKfHTKMVe48d5uITy+p3+T1R+q1D6aBdONSeWecZ+jSJaxj2yjV4W8QrrFwygnJLb
	yl7eqfP0lhu2ofFGzZo4zTRzyz5bjdtvgq1SwT5zn8dSvkLJzrW19hQCCkKLTAPkwxABI5yu3EJ
	qyXxA49N1hz+jfpa5cPuBWM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h7wjy60Jjz1prMB;
	Mon, 27 Jul 2026 19:05:26 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id B612B20333;
	Mon, 27 Jul 2026 19:14:54 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 27 Jul
 2026 19:14:53 +0800
Message-ID: <6174756a-b779-422a-a67d-d677961d99f0@huawei.com>
Date: Mon, 27 Jul 2026 19:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance
 controls
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jie Zhan
	<zhanjie9@hisilicon.com>, Pierre Gondois <pierre.gondois@arm.com>, Sumit
 Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>
References: <20260724104042.1481804-1-christian.loehle@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260724104042.1481804-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 7/24/2026 6:40 PM, Christian Loehle wrote:
> MIN_PERF and MAX_PERF are optional CPPC controls. DESIRED_PERF is also
> optional with CPPC2 when autonomous selection is supported.
> 
> The cppc-cpufreq target callbacks populate both limits for every request
> without checking whether the controls are implemented. cppc_set_perf()
> consequently passes NULL register descriptors to cpc_write(). The writes
> fail width validation and their return values are ignored, so the failed
> access paths are repeated on every target request. An autonomous-only
> platform can take the same path for DESIRED_PERF.
> 
> Check that each performance control is supported before calling
> cpc_write().
> 
> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> v2: Also added desired_perf check (Sumit)
> 
>  drivers/acpi/cppc_acpi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d3a94100491..53d09ca98f06 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1963,16 +1963,17 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  		cpc_desc->write_cmd_status = 0;
>  	}
>  
> -	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
> +	if (CPC_SUPPORTED(desired_reg))
> +		cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>  
>  	/*
>  	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
>  	 * value to min and max perf, but they don't mean to set the zero value,
>  	 * they just don't want to write to those registers.
>  	 */
> -	if (perf_ctrls->min_perf)
> +	if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
>  		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> -	if (perf_ctrls->max_perf)
> +	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
>  		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
>  
>  	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))

LGTM.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Apologize for replying to v1 before seeing v2.

