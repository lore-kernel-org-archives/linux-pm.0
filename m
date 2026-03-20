Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A93624B8
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998716; cv=none; b=bMzone8KC9AkypnEfy5tliWUnU5iDeyJskFQCzg4ttemVnGXs3CdZ3YVX2UEe7StiWlJggU7U9uAUaWhVguxOFtBHXqzpEZQ0v5Pu3n3tSyjLbZLHUGIvsqGoezNcGtSDlnjIq7DcMTolhN5t7FAj629tLpJIeCULuJkGKRhvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998716; c=relaxed/simple;
	bh=QcphJ6XfrgQC+QCDJ7rbWnnk4+4nCKSR/+///uJuPyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKUQe5eSoL6kxnV5HzUdDcdWXscNzXiWXfzdf3xYkqSHAJzi6fgVYmGH8grY//KbeLr33tCizypoCKpeiaxtjt1Rm1QVGMN6xqUT93dKH5wW7xH8CC66p1A4fA0XjllRww3dqtQZJ7VJ4Jf/9yGMM2VKfhZ3V8I2UZB9we+uo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtEF6yQn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtEF6yQn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso209987a91.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773998714; x=1774603514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxEFwxpBBp6KwxcNtJtDpAloPp2vIcayiRpSN9Ce+5w=;
        b=jtEF6yQnaoX4lVEw9dpLD5m1S/sK6OyKlkDkGIBpb8CQATaYpnEwTo9T+byqpFLm7S
         FOHKXqukyVMJiOr5l6kip+b0bleUW1H1ZR5ea5SbjMeA/F+guyvzQA6BTX32wzSZ0Sn2
         WEvhtChkjgP7oYItVNU/Ne1vyMX4M3UhlJFLGovs7Rc34QDAbuBoFJ/+tN50/YPuI87Z
         FsRkmmn2TSJsbJ4Ruo5+m0/2tqQiURoFPCOZ/wE3akz/LqwI3EmNMJXZbFHVtzebhMBz
         9yyycm2XwdHiStAbY+3SxkFfO37BhoEYpV6Vu0UmbExf+qZwmCiUGrDOLC8wWp++9pCE
         bdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998714; x=1774603514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxEFwxpBBp6KwxcNtJtDpAloPp2vIcayiRpSN9Ce+5w=;
        b=UpMpSEuEveiWktEz8+MJAyzpxmZjoq8R9TNiZVisv/uyQvtV0ZzXEqf7MmqF6eQ4ak
         eJGBq7Hy60HJc18Ju+ZqZUwDWHHPs4KhOrAqugsLsRE/H9Rg86CVZ4FdPrLhGCMbDd//
         gjV3mCdCQ/FcIH4RpEiWpKxwnmVSAER1kfBZgubaCSL9OGotn/UAReo9p/BwruCtGufI
         c5hBSrj7ZTck/Tw5Q3vuud0i33fxkPpzZPqbtZiy0sM19zbl4LXcfjGWdpRcHwCjv4wS
         iSjHFXBqVrfhYcptfZIWQU6x1hhBD/k8yHkSk8jb2VglIljghwuQv1DlZK0oeOwVPLyz
         Xt1g==
X-Forwarded-Encrypted: i=1; AJvYcCU4lfi2qwdbGLuu5y5Ya3TNLXqh/PqBA7BHsf3wJmXIfMkDdJxEszvWwSoI7zpHCXGUcQgFvqyRqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CyFnTTpl/towqFZ0uEMvDEG1MAtDwy40R5miPeUzgzYJpUit
	NomWGHjPPPAHr+c6A9dx6As1vcWVeu7+9n9KQQjD9QEqr2Is6gEtebhCU2tK93UqMrI=
X-Gm-Gg: ATEYQzx2gjQ6k+neDt+Y3FgL742tQJgbZYA9cCUGLKCsujmsfr9uapL6dEgMQwDJZfC
	IBPPm4QGzbYUn7r9w66jcgbEAs5DslvzreNRv7jSHfPXHKZpo5GIhj59xg1ZGOVEjHpGaatg5P1
	a9l7lo/EO6xVrsm+0Hy8fj29g97+WU3z6agRI2RuLC0KhjxMgK+LsI4LPEh50VLot9MK609LTFw
	xTZfJy8/W7xC0e0GyiYErRMEi1rKOmu5NYfDFeCw6zfrFo6eNnxaNTeOJ1dy2kRRD/n+MYwffLt
	yTbQhx/wTWoh4u24v56Irb6YJGza+itubBHbi3vlnbrONEXkd7qCXXTO3YNxcZzxRoE+UPBhvjD
	0Naj5aEFgJauZHF36YUPAq/rZb57DrUA6OccGECH9hsV/iywybwVP1eF+uJ+RbC5guQMzE6G+vB
	YmsF0s7OI98JaYLOyKxMM9pNpf
X-Received: by 2002:a17:902:ccd2:b0:2b0:5682:6973 with SMTP id d9443c01a7336-2b08273d0d4mr20896135ad.19.1773998714196;
        Fri, 20 Mar 2026 02:25:14 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm16109535ad.84.2026.03.20.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:25:12 -0700 (PDT)
Date: Fri, 20 Mar 2026 14:55:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
Message-ID: <jwkiwrbghgxhazh75cehdjlfrml2gb5dt5navlh662l4k3fefe@gnwu6qt5og6y>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
 <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
 <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>

On 20-03-26, 14:48, Viresh Kumar wrote:
> That change should be fixed with:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913..1f794524a1d9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1427,12 +1427,9 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>                  * If there is a problem with its frequency table, take it
>                  * offline and drop it.
>                  */
> -               if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
> -                   policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
> -                       ret = cpufreq_table_validate_and_sort(policy);
> -                       if (ret)
> -                               goto out_offline_policy;
> -               }
> +               ret = cpufreq_table_validate_and_sort(policy);
> +               if (ret)
> +                       goto out_offline_policy;
> 
>                 /* related_cpus should at least include policy->cpus. */
>                 cpumask_copy(policy->related_cpus, policy->cpus);
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 7f251daf03ce..5b364d8da4f9 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>         if (policy_has_boost_freq(policy))
>                 policy->boost_supported = true;
> 
> +       if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING ||
> +           policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_DESCENDING)
> +               return 0;
> +
>         return set_freq_table_sorted(policy);
>  }

Posted as:

https://lore.kernel.org/all/65ba5c45749267c82e8a87af3dc788b37a0b3f48.1773998611.git.viresh.kumar@linaro.org/

-- 
viresh
