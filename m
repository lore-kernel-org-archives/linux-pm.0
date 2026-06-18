Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD47312834
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762203; cv=none; b=XmPFs2hTtdAeOPMn18J8bpgxwIc4zbK8wCHnfMNlnQFmKTKgbzYA39ux2Oe7r0+d8c1Y+FVrFXWqcy7HujnUUmUOcicLyP+mscRpSBauNNT1MeQ17bgQsIZBbAOb7YMoUw4UNHO0a2dioRL98YOBggT18AT2Y5TuUkSBUoP/q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762203; c=relaxed/simple;
	bh=lHOZ4sXOmmsPp4ya5X5W3PWad9MhQ/Pxlwb21/gTaOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh7oh/9rcAYBK0mj/LO+aWUEI2R33lSf57nFN5Yt8DZ3polm+DlYDbwSowhpYin6k8Oo9VX0qeTZiC7Qe+9e7YIfa9LKtiKAQq9O/BqXU/DAb+YLhzDWpIsYhoATn3lgmK2cZfgECssG42SyFEA3PI9f5Ol/CED6aeX0d3igk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rIiieMnB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIiieMnB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84236f9b638so201271b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781762201; x=1782367001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3TutZ4KWTM8TCB6jiRN0FftHcZbM8r5yEXUWnOI/QQ=;
        b=rIiieMnBurse8ljIlKly2DHVq9p/3roTm6ujMuvXrVQDqOPpZVTlhed2pR9utmR7WU
         eES/Usrqz/X+cKivPHSKr2pdydwiCXsqhR2oWBh30u/D/iOF4Qb/UM085fnegbldz+CH
         IqItrwRvNdDsm2RwKkoQsPXzcKmayLl/3HfJmCxrVqEai2grm24pacqfmqqdLtmJ889M
         F8j8tf0Xrrcn8psr36DOTI+JwYOMUvLto9G8iBA5HGoTKDryWy8HObsdDqp/qrfPkFhG
         As+gQPOzGigtwf/+SSTAZmhb6EtrC0OoMojrha7qu+IHT6NeTTa9OsYQ8TMn09bXYmmm
         YPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781762201; x=1782367001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3TutZ4KWTM8TCB6jiRN0FftHcZbM8r5yEXUWnOI/QQ=;
        b=CkHOlZ/UxHlHJVdK6lVj6T+agWD27KWrmRdmKr9ISArhG3TiAKQYie7UqkFusHqMGM
         FoBGRcKUyjBhAh/qJ5vmntPjuW7roM1LBh9SaFI55x2dUGBt50al9BlGtFyrQ1ISTtYf
         8paYk/xKZQYa2blTblcNNiU/90joOSsNciF8/ce01nDeR4Tv1mTJYW2/yEkArWqn6/qw
         FuB4u80TyKbaI+1zCITSDV0AevA3LP2kbpsvtPmsQxxhZvPp4Wyd0qgHVzKL0xjosykV
         MMOgxvz+6NgSEw/lv3o6NudzawYCrWa3LXq/USlEPRWQxSvxMRPjuxO+c1tSwpg5dFd6
         JSTQ==
X-Gm-Message-State: AOJu0YwxiYueaBD5/224DrP4rUJJLad9+T5pDdLvtZBhAzntl/YQSk4U
	J6vnbEdJ2YHmQByTZpMxcfx5MGvwdyz6n9zskNckLB57Q9O9JqNlZNce5ZLrj5fms1Q=
X-Gm-Gg: AfdE7cmwig1A2XpaLFm4PNZ8pW1K7ygvCY299rBHGD3kkTeIAoOnxrfD3IQLUcUHqsF
	OPBC0aKRBsMyO+TrCwm69NdAnwC9ItvNY5ruPgHNmtqjjAJZBGmCzKgA+644EHPTyRBEfJ2cHg+
	3xfHToqCBQB1KYJ2H3SEhBx3nviiIyduLjQksSWhWQWAHhBBGj/+w9WSIMwd+XrUidv5NOfH9zJ
	5zhLpCTW9uPTiEAVv8RXb97NJpPQBAXT1sdTFad4YwgW8cWinCZvMChhunVfsfuOoayo7mW2Bl2
	CGohI4jtn12xcZoFF9ThUCcmWYFEG7wWmcweWBPdH1Ny4blqN3gQpjORlsSwJp3jOzZs9deX4Gh
	7M0p7nPT2Q6ejWKQqYvQNCLNlW5FmzHFrbqmSNL4SXJCu4H+rp1F+leyuXLTROR/WuIetmgdpxd
	K5dccgHH0oHmhM
X-Received: by 2002:a05:6a00:189e:b0:82f:48e:241c with SMTP id d2e1a72fcca58-8453b1958b5mr2353610b3a.23.1781762201219;
        Wed, 17 Jun 2026 22:56:41 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b055095sm21553005b3a.57.2026.06.17.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:56:40 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:26:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Adjust the .adjust_perf()
 driver callback
Message-ID: <534fzzaeg2xf3q6axlwy7gmnt234twpjda7dbjqxsealcbleg2@epvue5wxf3mr>
References: <14060154.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14060154.uLZWGnKmhe@rafael.j.wysocki>

On 17-06-26, 18:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases, the processor may not actually stick to the "desired"
> performance level programmed through the driver's .adjust_perf()
> callback and may go above it, which may not be desirable (for instance,
> there may be a UCLAMP_MAX limit set for the task currently running on
> the given CPU which should be respected).
> 
> Address that by adjusting the .adjust_perf() callback to take an
> additional argument, max_perf, representing the maximum allowed
> performance level of the CPU and update the intel_pstate driver to
> take that argument into account as appropriate.
> 
> Accordingly, adjust cpufreq_driver_adjust_perf() and the other existing
> user of .adjust_perf(), which is the amd-pstate driver (but the behavior
> of that driver is not changed).
> 
> While at it, also update the cpufreq_driver_adjust_perf()
> documentation to reflect this change and some previous code
> changes that have not been taken into account in it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/amd-pstate.c     |    1 +
>  drivers/cpufreq/cpufreq.c        |   14 +++++++++-----
>  drivers/cpufreq/intel_pstate.c   |    9 ++++++++-
>  include/linux/cpufreq.h          |    2 ++
>  kernel/sched/cpufreq_schedutil.c |    4 +++-
>  5 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
