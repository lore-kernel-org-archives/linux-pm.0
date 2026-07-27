Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088D34B1AD;
	Mon, 27 Jul 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150633; cv=none; b=BcQIZSdHD6BNDTDzkAP9liHTJB4PcXMIXq9mdf4tUe2/8PrvEMX1lFrAC9Q0SN7adINa5Bk7BO4PHlB3AzRF2y/GCkqcvP1WUN69ZKGlKRxNbYY9cz/DJ0J6Us9a+b6phs2GNj0Iw9Wy7YyRML4EAJug/YK+YOnQVMqGUP5Q1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150633; c=relaxed/simple;
	bh=QKO9lbMTBob3NkIoChN1b9t58q06pcd1zYqZNCrXl8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mgd1Uq8U/mlrDzg4voZoRGbdZXqylM+ZOedfPbVRTiMELxEAiYxkWGdMbD1yK1toJvDJYK95Dnw8503NZuYNrKMFaz9SF/gltKc8ucZNViKmSe/atB2SNChQpx2vtuBBNJCX2Y08O7RA2h/uFuuLStAJtKSjV83krVKGRnTL1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1Vqpc+Ip; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1Vqpc+Ip"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qGlhyl0QgTqQJuJzB1qy7KrRgVCa5Qg/xO/DDzmxrCo=;
	b=1Vqpc+Ip7QNBF4L6ubPwOXbw9BzZ2m/j9wl7IF2L5Gxc7BE3GVa4ib7LoZBQ2zNCCYKL1hRMF
	XVzEdijzNQT0RVnuRm1Ker/kV6iRAj/nsG8oXM7EDrJ1dnBLajzEKddelhB3I4X0z5EU55WF7mS
	ncRpnvcNZtC8XemELP3UefU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h7wcj5RhCz12LG8;
	Mon, 27 Jul 2026 19:00:53 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id B01F840577;
	Mon, 27 Jul 2026 19:10:24 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 27 Jul
 2026 19:10:23 +0800
Message-ID: <65e5d124-0fb3-4948-9b06-fd42cb5643cd@huawei.com>
Date: Mon, 27 Jul 2026 19:10:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance limits
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jie Zhan
	<zhanjie9@hisilicon.com>, Pierre Gondois <pierre.gondois@arm.com>, Sumit
 Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, Ionela
 Voinescu <ionela.voinescu@arm.com>
References: <20260723215634.1062264-1-christian.loehle@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260723215634.1062264-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 7/24/2026 5:56 AM, Christian Loehle wrote:
> MIN_PERF and MAX_PERF are optional CPPC controls. The cppc-cpufreq
> target callbacks nevertheless populate both values for every request
> without checking whether the controls are implemented.
> 
> cppc_set_perf() consequently passes a NULL register descriptor to
> cpc_write(). The write fails width validation and its return value is
> ignored, so the failed access path is repeated on every target request.
> 
> Check that each optional limit control is supported before calling
> cpc_write().
> 
> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d3a94100491..7bac6d5da24b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1970,9 +1970,9 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
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

