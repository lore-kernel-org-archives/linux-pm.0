Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352943B49F
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144492; cv=none; b=doN+Gwv3kj0yFYbqt7wsmW8XFx6d6j8u/5TF3CCQOJ37ObAxHV1gq6vKwloPddgqb3nHREaiNUWnJfgacrz8ytpg70YYREtGOFtsB9cc6NvXZhI6R6Vm2hy85R//3NWOUoM0hYvCRp9njgaXRL7Y86xwlz6VSH1ArAdPHbK3Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144492; c=relaxed/simple;
	bh=LEJvde1T1QgWV4JszP/5nGakWdX6yAxYHLWmT6I4mrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck44xyQwIbO6a+JVgOzUINn0sQ4hxh7RqNh4STpWph292LDeyN3Inrot2if5ZlKcxvuTgwUo/uKL62Gx8Um29RkGOZELfW9vzcelYeZQoPFLa4YOjuxMr6z9kMPi3VysRtgKuRByx8DO/oyy8OixJyRDgbfkV6Y9p6R61KEcxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVLbI6WG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVLbI6WG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1194224a91.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144490; x=1789749290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drA4MbAbfA7Yk2ZplEVuf7AbjA5LPX00J45ZkvRmoLA=;
        b=IVLbI6WGRbFI1xnN9QU+FbHVOA8KUFwuNO0fkeJVWjFvTPtRCv0Rxu/4udk9c+uvjW
         f2v0IgliQLGZrg1MTS9uuGGIfGykmjC02VGaxLXefzX2J6nTsCe7anc0JLng0Hd8B+/J
         BDE+CDae7VZoAfWeyh7cu1kvAZp9T71oP+UF1lUj8dKEzI1HW2EkxFcf56ohy4bXnKFy
         zK8ExNB3YC0aLorMb+JTAIJZcggXZ492Qt1xAbaJnMkB5vHwTB6+AE9+CtgAapWknlJz
         CS6trkDAHo7vKkDdPPXYaWZKpNwUUT38qxcVfWKr/ps8e9B066BNNCRLdiDbWylnTD1R
         Jscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144490; x=1789749290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drA4MbAbfA7Yk2ZplEVuf7AbjA5LPX00J45ZkvRmoLA=;
        b=susHdjpz8OBu/IvfCSLmYbAhByfsyByD/Dtby8j0McmwgBFxpEr9l64cjrihuQuHs6
         xjXDXCpv27Hn6X7NIEVx12YWt+xbdzprmm+TOK+lTzH9Jt/8D2lezt4mHSQ1taZaRmqp
         EUlpy+itW0w/YQ9LvB9k8QAEsKyXrdSu0ybCdyvv9FSr2jxzddBAyT3B0tfWbksCINyZ
         h+kduBC97yU2HgXP2piBIT+Q7QmR820xu1hNQo9OjtLiWD9sHF9K5D7T/3/4JUhOA7D9
         n6qbToNq6mnXuW1GeWwmcKK1hJp1YuzEpVYtlC0VLLlJFX8CF8mFGfDoEZnZHwB/RKev
         v6cQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvgccVNj9QsMQL/V6Oytm+mPT8ASw719nOGGXqUuJcM9I5ewkt39h8oA97dlDGUWy7weq6Ufds+g==@vger.kernel.org
X-Gm-Message-State: AFuF++m/Nqep9t+0qOgkUZJoqNi0EnQUV1zRJw348g4O4leXJDfckdQI
	tzBv6vghI90Hle9VGM26xU9iI7UiPmlz7/xdBMVKy3jRMCc/TcQXI8R1
X-Gm-Gg: AYBFou3SkAc0bT78JRkedCFZ3EFx1m1OjKZzTnlw/DEmbcfLuipabhR+bNI79F5Q/TN
	K81X82A4iUGDVYjIkN+qOxpFx/5RtE5kAmCjA6hJTXIx/yhxrEQoXH0tojMvZ8lAoV5nr8C6rAP
	jjuCH1JaVvcqEpUM1/929fOIOQ2UsA2d9VRZC4SKjRR2F92+trg0PKceQkmmk6Tr68/rnaesVA8
	moDmj2SCtDp2A2OaWF9WdBMqxt+gI80NC1YSNNT829dkAZn0nKvs7/ZhucRpISbA9RIcnzxxTuo
	qlwnrIys9gnCHkmSPs/j220HInlJ4PmKINaDdM/E5+ke1zTq6tmIAt8CVRfncVEr+eOWG8fAumR
	Z204r4nxidrwkubONkJnzqaXgZMZyIKDgrhlEM7rUW2+p6xbYSOvdmy9xr2Eop52zqKDB0Ekf+k
	WX/w0EFLQwW89D3/alnlOUOB/Q3TfkGyx1y9VQ9pT9wgIRC/LAgBnxWiONZBIQq06TGH3707ad+
	vB1xOlhgxrZ4ADOc4yvt36FeJs/SDjZeZOg2E8Lnbjy8zE+pQ==
X-Received: by 2002:a17:90b:498c:b0:39b:2b10:d05c with SMTP id 98e67ed59e1d1-39d9bbfa327mr9043413a91.5.1789144490077;
        Fri, 11 Sep 2026 09:34:50 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:ad72:fda5:83e8:be95? ([2406:7400:56:e503:ad72:fda5:83e8:be95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d6b08sm6058803a91.8.2026.09.11.09.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 09:34:49 -0700 (PDT)
Message-ID: <327e3afc-0803-4ca4-9c76-249077ab9b2e@gmail.com>
Date: Fri, 11 Sep 2026 22:04:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] cpuidle: psci: Initialize the PM domains in
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
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
 <20260907111659.263324-5-ulf.hansson@oss.qualcomm.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260907111659.263324-5-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07-09-2026 16:46, Ulf Hansson wrote:
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
> Changes in v3:
> 	- None.
> Changes in v2:
> 	- Fix a bug in the call to pm_genpd_init().
> 
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b9e4ad7d43a3..4d8c63d329c2 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -68,7 +68,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>  	 */
>  	if (use_osi) {
>  		pd->power_off = psci_pd_power_off;
> -		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> +		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP | GENPD_FLAG_POWER_UNKNOWN;
> +		pd->state_idx = pd->state_count ? pd->state_count - 1 : 0;
>  		if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>  	} else {
> @@ -78,7 +79,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>  	/* Use governor for CPU PM domains if it has some states to manage. */
>  	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
>  
> -	ret = pm_genpd_init(pd, pd_gov, false);
> +	ret = pm_genpd_init(pd, pd_gov, use_osi);

If CONFIG_PREEMPT_RT=y,

psci_pd_init(use_osi=true)
  -> sets GENPD_FLAG_POWER_UNKNOWN
  -> sets GENPD_FLAG_RPM_ALWAYS_ON
  -> pm_genpd_init(..., is_off=true)
  -> genpd->status = GENPD_STATE_OFF
  -> RPM_ALWAYS_ON + OFF is rejected (pmdomain/core.c: pm_genpd_init() 
				      rejects an RPM_ALWAYS_ON domain whose initial state is OFF)
  -> return -EINVAL

Therefore, on a PREEMPT_RT platform using OSI and hierarchical PSCI domains, psci_cpuidle_domain_probe()
should fail while initializing the first domain. The genpd providers are then unavailable, so 
dt_idle_attach_cpu() fails during PSCI cpuidle initialization and the driver rolls back its CPU
registrations.

I don't have a device on me to test this path, perhaps one of the QC devices + RT config
can reproduce this?

Should PREEMPT_RT case instead initialize these domains as ON?

This might be safer here atleast:

ret = pm_genpd_init(pd, pd_gov,
		    use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT));

Regards,
Dhruva
