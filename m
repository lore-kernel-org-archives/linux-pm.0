Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6200E3F0A87;
	Fri, 10 Jul 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672604; cv=none; b=bOi2sGlj439nL2xdQkNiJUgV1PnWepzF8D0sn2f6+C05xuIkGcadO5kFd4OTvMFwKSP7IL41WL+lwwdiWWMOxZWUfMgxRW6eGGBSCOMuJjlXHPRdg49Rvi2KARyFRJ11jl9m0A21wfZKz8xVkP1BmyfVQ9x0gkvjG2c9ldNdpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672604; c=relaxed/simple;
	bh=EePZcFQwKrwrLYDibFOvEzrQFD8zhPH0ocybDLk+skc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo88uXiCl4kIGHdGUZQBeCu7vVfb2V+DBtcThdXAfq0EzOGU0b+/DG2YN8+e156sfhZ7xg/LBlS0y5wLxGUr9lrGnN89KWTSLML+Dlqw/9WuzVXnpzXx+LrsQ4y0486LbYKFFCkmVhlE08EyL97iwYWfpONsmv7NhsbtoS/6vTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rGI0XtmF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rGI0XtmF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857541D70;
	Fri, 10 Jul 2026 01:36:35 -0700 (PDT)
Received: from [10.57.2.73] (unknown [10.57.2.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696FC3F85F;
	Fri, 10 Jul 2026 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783672599; bh=EePZcFQwKrwrLYDibFOvEzrQFD8zhPH0ocybDLk+skc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rGI0XtmFxm/LMdz0E3wfb2lAPuX9q56+f1ODBvNRzGbjM2HLDUN47QtrFkyH2Z1of
	 elE4ClKiZ+UU/pjd990F6Tlwm+mJT9BHd9qKljs1qM831JiHPkdkKBjfxntLM6dULh
	 0QKb0HQGNB5zVupSjbHAWdfiBZfvHh9VEfmyu9X4=
Message-ID: <4a67bf2b-2d0b-4ab8-b2f8-33f3345494c4@arm.com>
Date: Fri, 10 Jul 2026 09:36:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PM: EM: Validate new_table in
 em_dev_update_perf_domain()
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 pavel@kernel.org, linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
 ke.wang@unisoc.com
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <20260710082447.5160-2-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260710082447.5160-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/10/26 09:24, Xuewen Yan wrote:
> Add an explicit check for the new_table parameter in
> em_dev_update_perf_domain() to ensure it is not NULL or an
> ERR_PTR before proceeding with the update.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/power/energy_model.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 277aaf1b19da..4d75e1b3c20e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -331,7 +331,7 @@ int em_dev_update_perf_domain(struct device *dev,
>   	struct em_perf_table *old_table;
>   	struct em_perf_domain *pd;
>   
> -	if (!dev)
> +	if (!dev || IS_ERR_OR_NULL(new_table))
>   		return -EINVAL;
>   
>   	/* Serialize update/unregister or concurrent updates */


Make sense to check that and catch possible issue this way.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
