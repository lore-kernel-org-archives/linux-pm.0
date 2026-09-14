Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31E3947B8;
	Mon, 14 Sep 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369494; cv=none; b=u40MVZ3zHmzJwn516UeY+CP7qd/66ErFxXoqc3ghXhqPR/7J2QIVOZezrRy3egFVuXvP6z+ZKvON/TsTar4RXR5Be5t+R4SBb9oM2itvv2XGv/W97TYfelXpu/OFZhiZejt3W7YFIDohoTWnPOyoR23msl4/h4by22CakYF7FSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369494; c=relaxed/simple;
	bh=pNtlqXsBGCXtcZenUVL4HnAZIU2omYNdHVskCp9kiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqVl1USQLWN624TnkQmGBDcxvj7ZnwGJG9ePEMTNVtJWYjuGmmP4pm6ssXyuhN1aSlehbJdZapcPXbeC6QcIgbRDPeju18vcuvNYtyoCW+HCE0bg5uc3TTtzzK8+rNJuI9vGz/e/RoLvX8j17PNtRkPmS6zPpSzRhODkoyR6ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WjzekkFU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WjzekkFU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD68A1570;
	Mon, 14 Sep 2026 00:04:48 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911B73F59E;
	Mon, 14 Sep 2026 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789369492; bh=pNtlqXsBGCXtcZenUVL4HnAZIU2omYNdHVskCp9kiQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjzekkFU7LYMsWmvbH6omfz9eiehQlIy1DvkIwSKBzOu4bgxWOpLpY1XNyvADEjc/
	 RIYrNIPjgGfO/oXQusxaDuL0uJ5dWRQDa8FiYsXRiU64kEK5zQqVdxhrIlMp79EAay
	 u6GeTXpPrBV01pmQNMaH2U6JcIVCltzsfFxz7cxE=
Date: Mon, 14 Sep 2026 09:04:39 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, jonathan.cameron@oss.qualcomm.com,
	sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
Message-ID: <aqech7ctaPnW_U34@arm.com>
References: <20260910063440.4677-1-okerixx@gmail.com>
 <20260910063440.4677-2-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910063440.4677-2-okerixx@gmail.com>

Ack.

Thanks for the patch.

---
BR
Beata
On Thu, Sep 10, 2026 at 08:34:39AM +0200, Oleg Keri wrote:
> arch_freq_get_on_cpu() computes the product of the frequency scale and
> the reference frequency as a u64, but assigns it to an unsigned int
> before shifting it back down:
> 
> 	freq = scale * arch_scale_freq_ref(cpu);
> 	freq >>= SCHED_CAPACITY_SHIFT;
> 
> The product is truncated to 32 bits before the shift, so the result
> wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
> i.e. 4194304 kHz.
> 
> On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
> kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
> the CPU demonstrably runs at the boost frequency: a fixed workload
> completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
> kHz, matching the 1.171 frequency ratio.
> 
> Keep the arithmetic in 64 bits until after the shift.
> 
> Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  arch/arm64/kernel/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..0eca321ff113 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -245,8 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
>  	 * (see amu_scale_freq_tick for details)
>  	 */
>  	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> +	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;
>  	return freq;
>  }
>  
> -- 
> 2.55.0
> 
