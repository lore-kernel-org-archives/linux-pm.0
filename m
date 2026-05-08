Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817173815EC
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235282; cv=none; b=pul9yVMTObEg2fMq1BiuxjPQzN4+2JLXlSjm8DOHwTOepgMexqeojgJSkjqzA5Hn/P8v9vOcQI4vdhFQPGmb6Nd+Jtloks4JFAOpgAniHf2S5OqNaSqHFATjpBz9c3R45YrL0HvZHO4MhsiBvdpcLcOMGu+qYT0vsltooJryga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235282; c=relaxed/simple;
	bh=G/yK8s9gKYEo8zu4FU7GEKz/Pk96ZlyphPxLtGi/xgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzpWSl0t9ZvkmiKAmPJ+iH7GZK4zXlhbxoJGLecNIB+Uw+wGNRSSKYcbgJT9/PC3QdN6//iTja8Qxm0zOUL7KPb8gWMM70dmi5SA0dtIGLvrUXv/ZHehKAtrV8EdqETLwQqC3GAR95DDIZZZp6nof6LsQSEjKfKPj18UjNyupXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QU5slfrF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QU5slfrF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3664a47f893so468712a91.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778235280; x=1778840080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LMslR2cWXf0QzltzoHgts5puSewE5+hJiHjVqgZcFGI=;
        b=QU5slfrF2RvUerXpRh3miSKSZiujfznnO6rjWOxQTM59fYY7mmiaV/yT2GsvFABJzG
         o4LjQmYxN5vsCcBZkjc3T8Uz2M/m1dzz/q4f37AuQt4PmGkPPpGkoS9dxws1RCd1QRia
         m3U20qAfQAGNviiGPwzdVFTsoWGn3W1q3Iuxx8gz0fntgnpbwnyMiyrePCz9c9azTiLb
         ClMSjvCKEq2fIIbkhTO06OSjgd61eyXvK+arlh987JAKcqG3JqdfgG8iEQ2CAdFy8OCd
         y/vQOk3XbQUQGOTzaMDbU19uNrWV5UFftdgsq3+K0OT1p3stseT7l9hL+ZAdTuGfbOdH
         g55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235280; x=1778840080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMslR2cWXf0QzltzoHgts5puSewE5+hJiHjVqgZcFGI=;
        b=o+qSwTroUpta5dH0KW5fkwFK3+SfCQenrjRac9fhlXxVeJkOsHI7RxZmRzba1OO5Lt
         GG4VZUJzo6h6i+luDZpf880r4es9cHkFXMRhe1fZrXb04ecO8sEx2m8zqwLd7jsJ4Y72
         Fh4kRyDpARAomZcRvvFj2n67NJIeCYGPeRY7WEaxuO2wHAQ8iYVIZjCe2KLPD5xFNnoN
         hum2WbN9erJVgJhHSgahWL3+06L5Gj2Vkon2mC/mPSTBvmqjWHAiR1ICJvoOn/UiRq+Q
         ux8x9MbyFvx4hEYTqWD+S9XcE7U5/ymYmucfdEbgP54eMUwH/GhJePcNSaePxgljExNs
         VqzA==
X-Forwarded-Encrypted: i=1; AFNElJ+KLwZok1ib4W07VRQs9fbHWdQJvmzbv1ykCSANjy7bj6tULNwQwl+mA2NxiQpsiS0/+SW5gUOg8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyErfZI9kUaOOnleq9F1wPjfPShaN+4nSuyzOhdEoPICK98gW0a
	JqrtaqZU6eqZzomW3ellqhXU0LbVU5ERwprans+jdiz0bCXRMsUJrrTYUwRV2DZrR8o=
X-Gm-Gg: Acq92OEtCB7kwuEdpzvnUx3jPBEAxLNXb6tvafKZeRzx/rsQpOnYhFFhHuoQ+7+ODbk
	YCK8Ic2Yi7EKN+vdWZkAh32vT3FwJiHa1Byi2f0GNJgOqyYWtihx2/OJWwuhxatrXX2ZuQTc+hQ
	LBTvLdCLCJnwMAYelNj3Zs4B/rzO8Gv+5PPjh3FXgfLEWHrdYpBbtgMnux4sWR5stUVsZ5qOh6R
	jT7S5zvMDi/w2QYrmVZ3fdTN7T9yQMN5HHER2ipD9S59WnJ4CHOryburvIanMr+Bjy88rvfuo0b
	6Di4lleKEqUrTbi+gjShSefZRLuYQlyehK1+jbpP8XF6kPOOjraqLJTOkdOpcDQ9UN55QIvSqnL
	qXc4f7r3ZwBdW/s5I8W3dQuWL3zGYO6BltCNPUXIxeIzUe1dfGBBxYbjJWFW6Pt7UOu/0Bom1la
	3ppU7ipYWeoG4kppCddIaBPFY=
X-Received: by 2002:a17:90b:4b12:b0:365:b93a:1ebf with SMTP id 98e67ed59e1d1-365b93a2061mr10857729a91.4.1778235279561;
        Fri, 08 May 2026 03:14:39 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da41080sm1836493a91.1.2026.05.08.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:14:38 -0700 (PDT)
Date: Fri, 8 May 2026 15:44:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org, 
	stratosk@semaphore.gr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>

On 08-05-26, 14:46, Zhongqiu Han wrote:
> Nice suggestion! — I think it aligns well with the general direction of
> addressing this issue and relying more on the cpufreq core.
> 
> That said, I have a concern if we drop the decrease-path early-exit
> check while keeping the existing condition:
> 
>         if (requested_freq > freq_step)
> 
> unchanged. In that case, when the system is already at policy->min, this
> appears to introduce a governor-level oscillation, even though the
> effective hardware frequency remains unchanged:
> 
> Consider the following scenario
> (policy->min = 200, freq_step = 100, hardware already at min, low load):
> 
>   Iteration N:
>     requested_freq = 200
>     decrease path: 200 > 100 -> requested_freq = 100
>     __cpufreq_driver_target(100, LE):
>         clamp -> 200, target == cur
>         -> without CPUFREQ_NEED_UPDATE_LIMITS: driver not invoked
>         -> with CPUFREQ_NEED_UPDATE_LIMITS: driver is still invoked
>     dbs_info->requested_freq = 100 <- below min
> 
>   Iteration N+1:
>     requested_freq = 100
>     out-of-range check: reset to policy->cur = 200
>     decrease path: 200 > 100 -> requested_freq = 100
>     dbs_info->requested_freq = 100   <- below min again
> 
> This results in a repeated oscillation pattern. For drivers with
> CPUFREQ_NEED_UPDATE_LIMITS (amd-pstate, intel_cpufreq, cppc_cpufreq),
> the driver may be invoked every sampling period even though the
> effective frequency does not change. I'm happy to defer to your judgment
> on whether this is significant enough to warrant further changes.
> 
> Given this, may i know would it make sense to adjust only the decrease
> path early-exit condition to use dbs_info->requested_freq (i.e. the last
> target actually requested from hardware), rather than the idle-adjusted
> local requested_freq?
> 
>   -     if (requested_freq == policy->min)
>   +     if (dbs_info->requested_freq == policy->min)
>             goto out;
> 
> With this change, the scenario raised by Lifeng
> (dbs_info->requested_freq = 400, idle_periods = 2, low load) behaves as
> follows:
> 
>   Iteration 1:
>     requested_freq = 400
>     idle decay: requested_freq = 200
>     if (dbs_info->requested_freq(400) == min(200)) ? NO -> continue
>     200 > 100 -> requested_freq = 100
>     __cpufreq_driver_target(100, LE):
>         clamp -> 200, target(200) != cur(400)
>         -> driver invoked, hardware: 400 -> 200 MHz   [bug fixed]
>     dbs_info->requested_freq = 100   <- one-time transient value
> 
>   Iteration 2:
>     requested_freq = 100
>     out-of-range check: reset to policy->cur = 200
>     if (dbs_info->requested_freq(200) == min(200)) ? YES -> goto out
> 
>   -> Stable from iteration 2 onward, with no extra driver calls.
> 
> There is a one-time transient where dbs_info->requested_freq briefly
> drops below policy->min, but this is harmless: the existing out-of-range
> check corrects it in the next iteration. A similar situation was
> discussed before [1], where the conclusion at the time was that
> __cpufreq_driver_target() already performs the necessary clamping. If it
> would be clearer or more robust to add an explicit guard
> here, this can be revisited as well at your discretion.😊
> 
> [1]https://lore.kernel.org/linux-pm/20231005105746.ikezg2buza2qwvig@vireshk-i7/
> 
> The increase-path early-exit is intentionally left unchanged, to avoid
> altering the behavior in the scenario where conservative idle decay
> would otherwise be ignored when the previous requested frequency was
> already at policy->max.

What about this ?

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index df01d33993d8..c7ec11de9a43 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
        if (load > dbs_data->up_threshold) {
                dbs_info->down_skip = 0;

-               /* if we are already at full speed then break out early */
-               if (requested_freq == policy->max)
-                       goto out;
-
                requested_freq += freq_step;
                if (requested_freq > policy->max)
                        requested_freq = policy->max;
@@ -124,15 +120,8 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)

        /* Check for frequency decrease */
        if (load < cs_tuners->down_threshold) {
-               /*
-                * if we cannot reduce the frequency anymore, break out early
-                */
-               if (requested_freq == policy->min)
-                       goto out;
-
-               if (requested_freq > freq_step)
-                       requested_freq -= freq_step;
-               else
+               requested_freq -= freq_step;
+               if (requested_freq < policy->min)
                        requested_freq = policy->min;

                __cpufreq_driver_target(policy, requested_freq,

-- 
viresh
