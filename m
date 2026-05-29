Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A87367297
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040719; cv=none; b=Nilxm29d4WlyFZ0qA3uLaAraZACA7eBFe+wMrdmty6gnKdZcqiMe4SU9geOEweg9udrfUXHXkgdEYqLwvncb4oGgsYip7FbdHBLd+1iIIglIPNZo0jnNieZgiCEzAFH950SDwBn8QIQ7GwuHx3CBYe7oBWIveK0M3nEZsNt6zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040719; c=relaxed/simple;
	bh=kdHtlJ+3Ahj+Fi3fYCzDqvHLYhDIMcJzfjP8AfP++X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocr1BfR5frIKdI6K+aOtzCSWhdV3WhNxSIMzBgYODnkBWXYZWm+Lp46pxwl34GGosPTQ/Rb5bXV2ezOUjDY96rReCBpMJmXZ2P+wVcBsPGSeeo8iSsDxsmoqOfVXWeMdaXfr/EFl+Xgi1mA+K4Ii9blobxLBO3qVjCc0JspeIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKmL6TMk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKmL6TMk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-369576666d5so6735484a91.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780040717; x=1780645517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J//wIcuD5vVJ3zW/nhAOCIjIjm3fWsJip8Oi2c+mv+k=;
        b=vKmL6TMkvZ8RJtrmRkg6HgUyQ5zKlp97arAXuMk9lZpLDMFIfBek9Fv+YF0H+a3Zou
         OMWSiAz8wL1a17+0LOdVj5Pr+u7kXvqWdH2iw0Urbslima/BAy+Z2jw51QT4t4q6AZDV
         Ds4BMKSs6C+Liq06+CjaTeS7fd7Xe6MnUDiVCRDJDj3I082YTvx5DF/1BPnHXmNWZToL
         TndPP36dzIkviipz+Oe6Ocnq4RjvFAzMzoP1stUnzbAerN8BylRAuf/fJrGCt0P2ORUQ
         QptNhPMdmBWQzcq5zPTd/rwHhaxu1gPk7yVq/8b47zkm5ySwP0PpkE0GiJYDe8MplfnT
         qq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040717; x=1780645517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J//wIcuD5vVJ3zW/nhAOCIjIjm3fWsJip8Oi2c+mv+k=;
        b=KwrBzH+vJ6piSk1PFMnp3KoAlEiABmDU2oP6WGT2gSCVK96XeEZimQQOUM3f9/48Et
         OAy4yDAc6UzFTui0Cqvp3uecJGR3OGFPgVjCYF6dFKi3Tuc5y+/RBG70OWmlQCEXPC1I
         vkI9VWKecew9Xt6TIAJMK8q2yUDT4r4oKxluTzcTgKjfV6JgSxoCA0B8YLlb7uGzUX08
         P9mtmBofbBphrkIZteF1ENEsWjK1oMmEmUPLtmkKI8gvEVYnmlL38/SQEks9tS+gA1ov
         ug2QaBNHUkYbCzmgLUTc1zYOopjQvYupt3BPzrKG2w3LMjiycyPui1LSpG6uSuRsvbV3
         LnEA==
X-Forwarded-Encrypted: i=1; AFNElJ+LlyeRoVSEQjKUghDBS/az2aly7yi87eH78itG+pcjpWnTEIU0UIR1YrU8SrsopzOTfwcq/G6EEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYnpiLfhgKlzc6c5OwvjYC2FYCrDhQNq08opDzOkn3PqQk4/s
	9XzuJ1MBooPC9yzJ+mSw2FivPntHKmIzBcU3o3ghcVBoVhFcVjFzEGFrEYHayjIcTQs=
X-Gm-Gg: Acq92OE68KWXOBbkARFwe6qkZW4DMMRMONt7zyDUnVgkaBWjMLTyYOY790Cmqrmo4bf
	hDiVoPk0YqhJrNErYf41hs1ByAPS//WuyFFRAjGJGSTLItbKT0vnMuWhHnyY2NFku7hXJ9z41GB
	wZcPQbUGowUfWvDKZ9O+fuIGIr1uXWOmZmAyclTZOuEntGwNVDt+nq1KClKEYe2KyAeS0ezEVkS
	bLPEBGeUlYr7H7DhLhGqv5d/OOmPHhVo7Ju4p9W+NoyFMaGnoCbGVZFhCzIxGjUDybgpar/hrpv
	9U2SjmgOP5ZIL/D3uZBseQjuCzC2KsYQ1ycfBVse/cHUnZnz9XVaikwJJJirYrudytfACd5c8NR
	MmAvnWeh7BRyn/cdi/ZfMOnBu8KL5gXjZKpl1Gc8EVFQDGSrdqbGS/7AvP8XDEvMUygDGVwayqh
	EZ6BhTRGgLIFEDVasFCFzsFkEYhf/6wgL57w==
X-Received: by 2002:a17:90b:58c4:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-36bbcaf3037mr2086182a91.10.1780040716856;
        Fri, 29 May 2026 00:45:16 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c341dasm1202989a91.15.2026.05.29.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:45:16 -0700 (PDT)
Date: Fri, 29 May 2026 13:15:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/4] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <y7yal6aqzbnxy5w2b6daodzwrjus5wpds457bkj4ikbysf42ah@ynmxgrwc6kap>
References: <20260528090913.2759118-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528090913.2759118-1-pierre.gondois@arm.com>

On 28-05-26, 11:09, Pierre Gondois wrote:
> This patch is a follow-up from the serie:
> - [PATCH v6 0/4] cpufreq: Introduce boost frequency QoS
> https://lore.kernel.org/lkml/20260317101753.2284763-1-pierre.gondois@arm.com/
> 
> v3:
> - Added Reviewed-by tags
> - Return 0 on cpufreq_policy_init_qos() success instead of
>   a random positive value
> - Moved policy->min/max assignment out of cpufreq_policy_init_qos()
> - Updated documentation

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
