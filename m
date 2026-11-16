Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825501;
	b=xdiyiZbmJWunmZflvUdUnBDbGAgi+db12T1saGOKOX4ZjpnNuSG7O9SpufBg7hcUWWuq
	 YLGeHJJTucfc2zk7Uqc++p/3EM3DsBScrvxifeqc/VaKzEAOx+qvCEwybrCyfTzKcEFZl
	 SyLV+DrgAUkoCB9JbYf5/k2lCumvFynNlCCA4ejEdWFxhK5DMX8K4YEIG0H+1tWob/RE+
	 UwZD2mE202cY+rbz+RW/xdDu88MPWstbpU9gBR5v1E0ooeM3vV/v2IVQwPed6H3JvC39D
	 7LMjlxVAkpPTLrLOox9Efhpat3zaqd8rLJGasemBXMIp6kwy6aDkE7PAkNbwWPhZrfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825501;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ub1cgsKQvi9dfnD6CjlmKOfwxg0yHV4qgHxNcSbdmJo=;
	b=DbYwwVbOPveXBCZlNSbUnC5McQNM57MWIFUiNN4yZbrpEHCEHhOHXerzBkOGF1ON/so6
	 QMzBOVOoDAtKqsJJRBZi61R+PzF/QcuF5HACcKLAcoRoAf3uGC7fOzG4VYeWtrPeWzvre
	 9MGsaF7yAaCpEsTY1BJNL9x33R9S/VXAhqyMPbZf2ZU8vdQImB4ruN7tjvoSg5fL4WN84
	 i3iF+/GvhiVY2LvHH/hOLCUa+4oSa1Jvgm2mNByNmIQtSMjfFyC+Oa7PvuIf4eS2Pz+6U
	 uAVI1cycWBpGvgGezMwoW4IMGoy0/Cu3qIxsMjm7oM5cFpT0INBzBLL2NgG8ePX0bYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mEs+MA5J;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D05606A323;
	Mon, 16 Nov 2026 10:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D05606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mEs+MA5J
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42B8C1476;
	Mon, 16 Nov 2026 02:38:17 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02E93F632;
	Mon, 16 Nov 2026 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794825500; bh=QKMB5Y4VnZlSzUr/y1WfclgMsCTxE5HNfOLSGjJJjZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mEs+MA5Jcn045bE0bbWvA4clsJ91WvqRepmFl2DUaa+V4mc+/hIuYfim2PcHu2mSW
	 tsGHByCw0u8bwNAW60HS4UR7RLEKgtMRBEHc1E9q5r9sJRD/BKWGYdHys8h7OHlkIw
	 uBrCOJokH1ZAFEGvRtTrUqFKieboeg8x7LEEiRQE=
Message-ID: <4259f4df-3528-41c4-b3c2-51d7ec1d43d3@arm.com>
Date: Mon, 16 Nov 2026 10:38:17 +0000
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
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is
 inactive
To: Avi Weiss <thnkslprpt@gmail.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, zhanxusheng1024@gmail.com,
 zhongqiu.han@oss.qualcomm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261108145028.2483131-2-thnkslprpt@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261108145028.2483131-2-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 14:50, Avi Weiss wrote:
> sugov_hold_freq() uses the NOHZ idle-call counter to determine whether
> a CPU has been idle recently. When NOHZ is disabled or fails to
> activate, the counter does not advance, causing schedutil to treat
> the CPU as continuously busy and potentially prevent frequency
> reductions.
> 
> Skip the busy-CPU hold when tick_nohz_is_active() is false. This
> also handles systems where NOHZ was enabled but never activated.
> 
> Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> v2:
> - use tick_nohz_is_active() instead of tick_nohz_enabled to also
>   handle NOHZ enabled but never activated, as suggested by Zhan Xusheng
> 
>  kernel/sched/cpufreq_schedutil.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 14405a614991..50249cc1a594 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>  	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>  		return false;
>  
> +	if (!tick_nohz_is_active())
> +		return false;
> +
>  	/*
>  	 * Maintain the frequency if the CPU has not been idle recently, as
>  	 * reduction is likely to be premature.
> 
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd

