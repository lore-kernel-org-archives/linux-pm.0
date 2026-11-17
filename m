Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913595;
	b=wTXjKViUJgeFEwFTPNVjnqa4FxdHD62rKMRH+Q3bVAcHZpekxPc/A94RKOG4nwNtmB3b
	 Q4iNIems76baXfcO9C3gurSz+LeksZNMW3Ap75IZ3hW8AFPFgJJSVKSXg+kt+ae/hzWBl
	 m4hGpPzut6Y8gTbhVszCiQaMbSLPIle0SyJWwIGg1JwuAIhnliHJu2ESwtWnkeJtD0CTR
	 7Se8NSRR9rN0E+oRbZPgeDR2zKi383OsYvipPzpMHBOj733pTyWCih1gJW2mpqV3yThpF
	 d8/oMJ1Bz19DrKukRvzGW7snbOwwoLA4tIbLIjfIMhcBl5Fnm370MFvDIc2DznXtlSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913595;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zQK0/cS+Hx5iaKVj7t0Wx1EeMLw++dccUq7SklaMz2Y=;
	b=nZZTgoGRFiMFRAhzzNih4guhfnZgEccijt+DnBOsZxpcFa2VJ9uFHh1S3EkdPcedK9aH
	 5cX8MXdW1xOS8x7XXTU7OpcD7DS3YAIjP7dQQJz9fj1IJ3tJjAH9HUnbrffrIYUQM0heF
	 tWSPn6gly133yVzgt/GiJhGSNiZwHz0jYKuj3+nOD9p2ds8m1OpGSv/faiNEvaNtSSbW7
	 Zxhg7XWlsdEyx93IXhN3N0hSsa7aAt4npylR7cQJ//gPEEQQewu6ugx4GKW5PozVhamds
	 1ffJYS4HQLtfEaFOxHoolril7wZvLqkd3HwzzFJjPccDdkYwsUAGg9WyN+Ilr6iYYYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gkmr2NN7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A80606A31C;
	Tue, 17 Nov 2026 11:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gkmr2NN7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985831476;
	Tue, 17 Nov 2026 03:06:29 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8188B3F763;
	Tue, 17 Nov 2026 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794913592; bh=TxfFF/v0mXYBQ9TN3vzz9eVpedAI+KSw7wIs/PKquzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gkmr2NN7R4w4J2vdZjO8sR6GYogKE1DuMYLduiE/YBtDq1/IMtY62TVhsn/5ptHUd
	 tsDlVJK7qNUvSVDs8cEr/k3WXcxhC4YH1Jr3+idT85iGZUzTy6gJVsSweuogN+Yons
	 8hzJGYO1Hkc6mHRSQhYRcy6khSqOnkjjN8T6S7NM=
Message-ID: <47ef2005-97ff-4841-8a87-5093323e1914@arm.com>
Date: Tue, 17 Nov 2026 11:06:28 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: Enable boost by default
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linuxarm@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
 wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
 yubowen8@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mojunjun4@huawei.com
References: <20261117105240.1113405-1-zhangpengjie2@huawei.com>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <20261117105240.1113405-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 10:52, Pengjie Zhang wrote:
> The CPPC driver leaves boost disabled by default when Highest Performance
> exceeds Nominal Performance. Userspace must explicitly enable boost
> before governors can use the full advertised performance range.
> 
> For user convenience, set .boost_enabled = true in cppc_cpufreq_driver.
> Since cppc_cpufreq_cpu_init() sets policy->boost_supported when
> highest_perf > nominal_perf, the cpufreq core will enable boost by
> default only for policies that support it.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

That being said it doesn't apply cleanly on bleeding-edge, so you might
wanna rebase to make Rafael's life a little easier.

> ---
> Changes in v3:
> - Drop cppc_cpufreq_default_boost_init() and set .boost_enabled = true
>   statically in cppc_cpufreq_driver (Christian).
> - Link to v2: https://lore.kernel.org/all/20261022075901.3436021-1-zhangpengjie2@huawei.com/
> 
> Changes in v2:
> - Drop "even" from the commit message (Christian).
> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 957fa7775260..1ea16e95c0e9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1059,6 +1059,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.fast_switch = cppc_cpufreq_fast_switch,
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
> +	.boost_enabled = true,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",

