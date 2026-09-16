Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8374B8284
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577562; cv=none; b=V+agQG7ARfozgE7c04F3YjsIbkNl2/AJyfQFSYdZRo1rj97/1DEIHJ7JNM4wsxcGSCbcskdDaLGspznvGwhB3Vj1ak76ZgqYoC+bldnkgHsnrEUToNwkdKeknwXcnjuwL6iltCgDddexEAQdqDxN6RtK0qlLWJTkFic2yr6koV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577562; c=relaxed/simple;
	bh=3hb2s1nE8GbWF4nFX41LjIjY6GWkRYkXDkCPa4Nu+74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIMdqGQUclc9jDjvyWFsyqN6pCuXhi4/XOmHQE46j4C+rkqHzgiN98xs93gqF/hnSTvEaILPrvVhqp9g+Dn3lFxgecS5O5XN6fIhR6a4fQBkNy6r89PzZX17ww5vZL/E6RfJIpYpxgPFyDq0JmbF4aCq6VmJ7RYHQ5F8n9Ueu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgNvJxP1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgNvJxP1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed9866so10754815ad.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577550; x=1790182350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1jCbTheaiSUBkfYGV3xzwMyY5fdH2jCKLwykFGBBIE=;
        b=AgNvJxP1DMnYNwLESwxLzqy4FJq6Ru0Y+xKhQl4JZTnJ/oEz3AzyUkNtjQZDk75+lL
         NbTXNnUUCJCWMYlYMrLpq5bwqwh6oQQHF7rfrqYw8/5ttFFRYwaJiGWGxJvSPnp/eKNv
         L8M1dSHegANyE7VSneb3fqA7UUKsAP5Y6h69JS+y1rhxR+VHbZlaOqR8HOguTY9xYjJ1
         I8HZKcNKd+nzU7ElY80D6ehaRCjRJYcR7X6iB14S+9So0KyI0zyaEzspsqNLTijuG0e+
         /QF8wtGdsbs1uWTRcT7w073idLupnKJ4cT7dlAYyehm9Bl16qRpZohfnrqfiThkslabm
         9X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577550; x=1790182350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1jCbTheaiSUBkfYGV3xzwMyY5fdH2jCKLwykFGBBIE=;
        b=HuT+YcBBUMJw760XYpdcQ5C7TqfxG/btmc8BehLFEpMsLJ6ojIsn3VHWMRppNKlk+E
         Ly/PG2D66bG7LiGS4G5wx6wvDdyb7sMochOz1o9UXjznUz2wwWAIHV33bHzbbsCg3Psi
         y+eWfz31n+QDgcBYrnNSrBFGYCMQ2Hv2egm8ebZxr3a/UuB4UL+DCNeu/TKNIRMbU1HM
         pc0LvCysCWIRNqYronBz1VoTWl3Z2a4loi5wF10TSPAEsE/oOeNRptArXjk7NOhpJlBh
         o7Jxz8hlr1+OF1JqoxHdfLpcXQLPr0NXwf5EjlMxXHyXqTKT5Uu1Y1oqfXS2DUz/h5+k
         jeGw==
X-Forwarded-Encrypted: i=1; AKwUvBz10vWC/2C1j6K2x6DayQvNtavfCuKtr7i0BdQaC4TEIFAIPSkTD+kGPXQJl1kfwl+8ieGqgYsjvA==@vger.kernel.org
X-Gm-Message-State: AFuF++mIrZIAw9DGKC3Ak8YMCIHXxqmsKxs7oPzlXxggQF+1w5rIhKlz
	kRrygSQwy5Fl6vB2Osz+rQ4u3K4Yw7Dm/pfgzJPSf1DPQTJ/N5bI1RlH5u4KlR2KNPE=
X-Gm-Gg: AYBFou2RycKGoOTjlTZsZgJYcNjPAuG/ggUr/mNKm5LV+a3RzG5DoiETvphrI+gHCBK
	3ltnOvnbFIQ9JvUR3+bjK8wBcmbmgiOvmTbqWDgfYR4BaSaWOKRFy0APuenAH+BCZMFB7tbjitq
	vC08LOteSbb2A6tQjj7/aS0Jkl3lJ/04w63lfclvoCsEskvTzc18te3IgkzaTEa05vhwJ0+WtXH
	X9WISQYAX6e7q5n8Hig2QVUlRdVAExk31NrhcnlFkvM1IJYGHxj6dLTAF7M4GQeKjCqwB8wGKWG
	iLuXGw7lBSU+eXPI+u2z3ZAev/Czc0JbxKtXMbmocKJmrpQwDLAINXcDJFel+avaryF7UodYqsk
	vB82hJalsGTFwzj8QKyIlpG8vDqfNDqxijoP4doWSchA3RspoulUmrK0rlRWA45LrgMqDgJUVsl
	AKcr3ImBTuHRaOEoYV1gtq0OaDUDFnVoh3BWykXJ46vbTf3Isd/x530fT5QgixqmjNqy1CX5Dc8
	k4nk4Z5JLFXvu1ZNaf2u9Q1Cr7OQWwBaXENrm1ZfRfjykn+Sg==
X-Received: by 2002:a17:902:c40d:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2dd8e6368a5mr67941175ad.18.1789577549942;
        Wed, 16 Sep 2026 09:52:29 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:ad72:fda5:83e8:be95? ([2406:7400:56:e503:ad72:fda5:83e8:be95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd90c7b215sm12866435ad.72.2026.09.16.09.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:52:29 -0700 (PDT)
Message-ID: <ce80af4b-5d4d-4fdd-a4ca-3c361c542eeb@gmail.com>
Date: Wed, 16 Sep 2026 22:22:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cpuidle: psci: Initialize the PM domains in
 powered off state for OSI
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
 <20260914150146.187622-5-ulf.hansson@oss.qualcomm.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260914150146.187622-5-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14-09-2026 20:31, Ulf Hansson wrote:
> At the point when the PM domain and the topology are registered through the
> genpd subsystem, it's not really known whether corresponding CPUs are
> online and thus if the PM domain should be initialized as powered on or
> not. Instead this information becomes available when the CPU devices gets
> attached to their respective PM domain through dt_idle_attach_cpu().
> 
> This is a problem when using PSCI OS-initiated mode, as we may end up with
> a PM domain that has the genpd's status indicating it to be powered on,
> while it in fact may not be the case. In the less severe scenario, this
> leads to selecting a shallower domain idle state for the PM domain than
> necessary. A more critical problem is when a non-CPU device shares the PM
> domain, leading to their corresponding drivers not being able to trust the
> status of it.
> 
> Let's fix these problems by initializing the state for the genpd's to be
> powered off and in the deepest possible domain idle state, when using
> OS-initiated mode. The support for ->sync_state() is maintained by setting
> the GENPD_FLAG_POWER_UNKNOWN for the genpds in question.
> 
> Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---
> 
> Changes in v4:
> 	- Drop GENPD_FLAG_RPM_ALWAYS_ON.

Thanks, Looks good.
Reviewed-by: Dhruva Gole <goledhruva@gmail.com>

> Changes in v3:
> 	- None.
> Changes in v2:
> 	- Fix a bug in the call to pm_genpd_init().
> 
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b9e4ad7d43a3..5722365b943e 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -68,9 +68,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>  	 */
>  	if (use_osi) {
>  		pd->power_off = psci_pd_power_off;
> -		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> -		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> +		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP | GENPD_FLAG_POWER_UNKNOWN;
> +		pd->state_idx = pd->state_count ? pd->state_count - 1 : 0;
>  	} else {
>  		pd->flags |= GENPD_FLAG_ALWAYS_ON;
>  	}
> @@ -78,7 +77,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>  	/* Use governor for CPU PM domains if it has some states to manage. */
>  	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
>  
> -	ret = pm_genpd_init(pd, pd_gov, false);
> +	ret = pm_genpd_init(pd, pd_gov, use_osi);
>  	if (ret)
>  		goto free_pd_prov;
>  

