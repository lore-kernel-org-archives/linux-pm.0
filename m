Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1043559F5;
	Fri, 10 Jul 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672461; cv=none; b=YfuZfvqOO+S1EL9TKbHELm5dEbtmwCPGQLyO+s6/XT0aQM4eU1pHHSL2VBV+hX2yNxrnN9vV4brHVKkHbNZzyrk6+stZDCOmKJpeT+xyiGtJju6c5quNe4IIdCYhALMMIU81EK+qX1Sej29grWHi3x4DgCfDKyRHYYRd+XN+WL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672461; c=relaxed/simple;
	bh=hoNFrqeb+5Si8JgjkfwQEJ7zAnDHR7M8m8edQoUhEBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtZdNXV49KF1oveVTzcrvn2pETsnCUpLp1Rk/dcJoYrS2P69n87QnG3cd+5kPcaEk8Bv6nohHZHl/az4PPlvSFzJTW77cZ+LxGq0R1Ep7YawOf7VlBJpihercusl/LLpQgtC55Q87+nEK15S+HYJ8mLkXZB8gVHZA2Xf8g3cXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mDGE8OZL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mDGE8OZL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E11E1D70;
	Fri, 10 Jul 2026 01:34:14 -0700 (PDT)
Received: from [10.57.2.73] (unknown [10.57.2.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289143F85F;
	Fri, 10 Jul 2026 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783672458; bh=hoNFrqeb+5Si8JgjkfwQEJ7zAnDHR7M8m8edQoUhEBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDGE8OZLaqNwD+QpSFyxIzt+6llBGIOwg9W9kuUa3wjU8zLr0d5iFFleR4XTM9GvL
	 YDaWgnyGDFx2WKdASHuUPjrQdc4cHI2EeRrdF6VvUYl1TSIx1Ctg6zEgkwweKyX7Fp
	 dDcOJ3dT4rRTkr2n5kRn8klsx171uVYS8/ht5Jj0=
Message-ID: <1ac9ac29-f79e-4d2d-951f-0a43bd66e2e9@arm.com>
Date: Fri, 10 Jul 2026 09:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 pavel@kernel.org, linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
 ke.wang@unisoc.com
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260710082447.5160-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/10/26 09:24, Xuewen Yan wrote:
> When drivers wants to alloc a new em_perf_table to update
> their em_perf_table, they need to use em_table_alloc and
> em_table_free.
> So export the two func.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/power/energy_model.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index e610cf8e9a06..277aaf1b19da 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -201,6 +201,7 @@ void em_table_free(struct em_perf_table *table)
>   {
>   	kref_put(&table->kref, em_release_table_kref);
>   }
> +EXPORT_SYMBOL_GPL(em_table_free);
>   
>   /**
>    * em_table_alloc() - Allocate a new EM table
> @@ -225,6 +226,7 @@ struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
>   
>   	return table;
>   }
> +EXPORT_SYMBOL_GPL(em_table_alloc);
>   
>   static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
>   				struct em_perf_state *table, int nr_states)

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
