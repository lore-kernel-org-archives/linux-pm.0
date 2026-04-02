Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3492D978C
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111837; cv=none; b=gZ+uuV4/RpV3Ko0RO33p1jPNNUo3CgGVG6tbiVMk2t3Jt4JRkGSetakgK27l8lvd1KLYsjpsqFCucFtVpSnwQf+3XICuSNQcclzkdjrzmyl2kFv8DY9gtJQU5PdrK/r2SvY7Ket4KYIqXC3wZ7V8/vs+71kkqyh/gFE/cw8tLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111837; c=relaxed/simple;
	bh=2ID5HnImRXBwq7m2lS4nX4rs2HBuzrgCxIPBw39/5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLrh2oUNuFps4GrOW8NHvqEvK8aHzeeEyp9HHA/TSGq0jdyV8jQctGuM4/aj2QFFDNmGnqz7mcxB3yF7Za8eC+katDMNT3y1QsGWe0a682JZY2a/hzuk1DEkliGqI6nVneXMVmtSKZGs1SWAQLmQVCaOG2+JjcyY7gHEkTDgDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akfIW7Ce; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akfIW7Ce"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so2844095ad.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775111835; x=1775716635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8/3v+kCVvzkJZkARRBkgOLxtlDKiOvmDPq30N7asvM=;
        b=akfIW7CeGmdyA2MoGFcwcjliX7UHzOsvxi+mYUw/QR7IjBDHW4rWQMaRnvAcT0QSmS
         5QDOAW4Dd2uKTvLKe6ZhQATXRz6ZQXoJir432UlGkmGPxjHiZmuPdju1YwPD1I95EB8X
         tdncDLhQ9JbRX1eoZl+zA2Jp9qVMgc4cby8PwKcWojR+E4SQ4X/YF0qgWqs280y0DKs2
         6mloYPlS4cZv5E9JohWbJyAL4pecXDVY2yniC7H5L9BOzDGROXbP+tgYDIyQgOeAxfnI
         6imRnN9NbW59m1hZIGeMOEPqBmLEtPowhreLc5Zn1kC1QwuWa/r9uPhjPqndf1CrYd7g
         HIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111835; x=1775716635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8/3v+kCVvzkJZkARRBkgOLxtlDKiOvmDPq30N7asvM=;
        b=C549quxr60CbEAj2UZgGBefVNrsRWeTHWSaw28HA6vIj0M7lNCWKie69336UU3666A
         dhAJ1DtYBxmVIWwFVMw4jg4EV29g7V3voOzVVldnwel9lI8VeJ328AZ5VFtcPDIcCBLO
         fwpAxNNDMMGiqBxHs8hH/WB4WcCDehdxly20ypc3Q4loFfUzLuqGuAU9u++fCnNpuLPS
         MZGmNpGd+xL4ZWE9/73B00H+hpLNGe/wssZPsjaz0Ufr0Y51erIArJNNia+1ncuNuQ1N
         ODp3HEu3DYSn3enkqCe9U4iPD2X9/cyLN6IiN06Q3SlnngvcptySge5bMz5Z8XzyU4Py
         nRTg==
X-Forwarded-Encrypted: i=1; AJvYcCX49vB5QV52w55Gj+qzPA3QlYG6REirUIosOaXK1aHYjmpfO0/9EVYieE1lxqL4zUQLs7RlTzU2ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QQDCYfIM+rUGUvJnl/04TkuGWHezy/yByoAYsjOrd8DZ/NqJ
	8LWFlL0YfwvcjELotr097565kotX0HGc/lKRX7FYpS5TQ1VCNwgalVOcz3Ry6fC0jJs=
X-Gm-Gg: AeBDievEqOQnmxb5el/lBFtFOmzmzS5NQGOEnaIAWLUZlNWBcWwbPLJyEhDgFr129/a
	PM0w8CS2UjNYgdcABzGiTjtVU74vanqMAhjKWc3tTISh/4kZjoBeeWJTHfWlVWMtUk2bWg6GlBt
	L7fGJeU0KwcRAfnplgQ7uKNnQxyoCWRk1y4em5eZThRT9na503ArltEsMdLf3F93GxzJ0QCJ0Fl
	5UKmQh0n/2D7nIfQlCELJ5RjuYMktekui0A0oHZNDUiNL25EGTk88ZiZpXdYdXC3uWcpoMg+uC+
	cyQbpfuYml95kAeTLv6X29h8gQl7lamtE8+l3f/jjEaszxh7nI+6gT+t93OvAJAO5LIPkuzzTH3
	B6jEBLDSbAsUvFcCqHHhNyp8jghmQwMNyc2xPT4MHbxNQ4yxVds+UhSzQIwMKQkyf9GW/etn+6m
	tvHGRd17TuLnrZtpgxoo0PBR2p
X-Received: by 2002:a17:903:198d:b0:2b2:58b6:3dae with SMTP id d9443c01a7336-2b269d14011mr58436245ad.46.1775111835057;
        Wed, 01 Apr 2026 23:37:15 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm22677075ad.27.2026.04.01.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:37:14 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:07:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
Message-ID: <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316081849.19368-2-kprateek.nayak@amd.com>

On 16-03-26, 08:18, K Prateek Nayak wrote:
> All callers of amd_pstate_update() already have a reference to the
> cpufreq_policy object.
> 
> Pass the entire policy object and grab the cpudata using
> "policy->driver_data" instead of passing the cpudata and unnecessarily
> grabbing another read-side reference to the cpufreq policy object when
> it is already available in the caller.
> 
> No functional changes intended.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v3..v4:
> 
> o No changes.
> ---
>  drivers/cpufreq/amd-pstate.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
