Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18165434E56;
	Fri, 24 Jul 2026 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890630; cv=none; b=mpgP/FQR0zn74QBja+TaZZMbWBPihZUX3u9Sya532VccP7Q+THBFU2VXJqi36OXy/hhNcYnC2V6R5YQx46SbcXsxGpFys80gPOR+kSEk02y9FcrlTt1+ca+6tewNprNDjr2OQyue011rdGv3NSwpJy/1lNfKNfvvXzbao/CL+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890630; c=relaxed/simple;
	bh=2RBSQbYDTeuXXLocav1yRe2/RgnAb2/Km8HnhGY0e08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFxhMaqAkGS84A5cbCtciUtIZ42YukSk7dIR7RW6cj2yCKJNcOJdJHJf6iGQ6xlU3jGm7L8yRTwHzY/F4ZpdxhbxsuIPSCKNI4Nnq7Q6iGinW6W0lTIPaYBzWqBy0fmnNz96+xmqyCeUFDRNayI5YUhjNeVSqJg4YJDvO7Vn4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAy9zjgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAy9zjgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE471F00ACF;
	Fri, 24 Jul 2026 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890629;
	bh=HNZCDfzMuhhtWweqDxFsT/fsYX8iP/hZP8VOncK09IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XAy9zjgJ9tn/MuAhceyM/OGgoPgT/QwjEt14/sij3Muq1jJlYX0IZTujk+BQPBziR
	 kyqAFvo4aL+9ktscST9XVyxYwOxvPwrIUjty3DoNHm9EKcb1tfIDewOpog3MY+os+7
	 MlgDmZfunwGhg2YkgP+e/O1H5BAkKJdjLe3fU7dENzBu5CkbQEenaKefCtvQpo8tCQ
	 7QNVblvzInZKdo1IjIK5GdaP5jHJR9sARecXJJCtDjbzB5Iwwj4c+G74sSW/GaIK/g
	 RMqq92tyrKZs4oe80YIWMZExQdLlfirC8nkqoPeqiIVtI20oT2LP2RqUP+4ymkVXYc
	 QgyouXfVrcO4A==
Date: Fri, 24 Jul 2026 11:57:04 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance
 controls
Message-ID: <20260724-astonishing-hysterical-goldfish-87f8df@sudeepholla>
References: <20260724104042.1481804-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724104042.1481804-1-christian.loehle@arm.com>

On Fri, Jul 24, 2026 at 11:40:42AM +0100, Christian Loehle wrote:
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

In general, can't be set perf_ctrls->desired_perf if and only if
CPC_SUPPORTED(desired_reg) ?

I see cppc_get_perf() does that but I assume you are catering for some
other access that may happen before ?

-- 
Regards,
Sudeep
