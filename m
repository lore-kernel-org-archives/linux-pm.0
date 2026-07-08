Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A430DECB
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482289; cv=none; b=dhZl5JroDa9cGsDYTUkk8yg4kHM1DA0ZcoEsrZr3I6i6+dAwMhqquvXwrrFubdHaiEnUeZEejhbsjSwJOYBW5Z7C2GMekyi8PNo5Lrh5Ubkxf9bfb1LQVm0DtMunvpySmE5M5Ap60G676IA1JLRqCybms3zyyW+ygH2unY2/LZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482289; c=relaxed/simple;
	bh=vi+z7ArioaYABeMCb7dXLdYq66yjqkr56H0E7WY1jA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKKA1U2hFXYrCt88Uqak3dweXHhDmORotmo5Qt1W2uMtoo9LJa2f81U9+HdpO6rE8xdEYVmDoijjMrQ69CFZn3Fvm0+Q1RJpFKMcZpKOmaUutz3Cx0Ugf5pmxrSi2ZZytpu7PXClwXvudHSxCJg8/XCcPWDs1kpe7layrVe6o+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezAtGVm/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezAtGVm/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad225673bso2032015ad.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783482288; x=1784087088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aXLkN0PmqTEt1lBkFSFb7UQxeZp7cKS2BGvjYlrYiWc=;
        b=ezAtGVm/sQqcCcBSxlKjlyOKuhNpf51l2PYxGZDt/V/gf+78AHP/KuPHyHGskHJz53
         7zGRWnOpofeD5ljtjisAsSsfl98UfOlG6fhRA9wHcOBotQPXU0GFNA5OD1l7srg4iyhC
         u0eAH9y3s28VBvZ7oaFDn7JRYQk3wwOo0fTkex/y1fch6i0gY8RN2CEveJxeKmi1bkVT
         OIfWpNHcgs1sNE9L8clDmxgf1FKw6PWbB9fPpCNugGbvQ7vNGFr1bUwH6+1sCElQNywG
         CXf3Qia0M5Jcg6IAxRP0xEU85am14wUPBbxEUzmfQE0YcX/6H5cQYNEP4lflrX4QVUp2
         irjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783482288; x=1784087088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXLkN0PmqTEt1lBkFSFb7UQxeZp7cKS2BGvjYlrYiWc=;
        b=IlwiH3OAUP5sChWXsCwlstyLc9I3uhiKkHmKjECAW7GpJ2MxOArE1BJJMLkQLlekBK
         FfPYOEP6DFhS9v9I4x+tqAvDGJAiRbeomCSCQiMQNQ7B7IY/4Qumbs3BgeyiFMzi4ufz
         RcKmAGOuA3Knf9peITvREh6k05BMdcs2+/lXHM8XNcRVI7HjRsXS9nXohhGG8lQ4V/w/
         cDb9caC8ctELiPZbcB8Rv5HYXPlWaei7LhmGgbWkgQjVXQFQ02RorLHx/MEb6aPNmmnM
         wAn5XmrwM7EQLDJa0YVI0XZl2hn254oudFhyESjb1HZ7Z+3buRURZMpMOXWP8qCgrLmN
         ZhnQ==
X-Gm-Message-State: AOJu0Yx+ythEQVNJ6+p18JE05JZaY5z87Qu+sFxALjUILL9zR9zMal5m
	3qQDK7oOlsVk+d4TuMyEKbzBKn+5kBFzllMUMaAqCBSJoiw+jNwoRZ24SONY8qmvU1M=
X-Gm-Gg: AfdE7cmywPFw/iluWM8/ANRFN6nenmP9P4Z4VR8hg5V3Hj+SuNjwuEjdycmo7IlLllj
	ngZGgJCO4xvZu70TpsCZKrnRLhN1jxI0LPnsG/YjNNsHbCNGUBg/DlPNdmQCWoA4AcOF46N9Y1w
	ojqBjwG8ytEtEMjkTiNAJjF3HavjFyIdMGHMksEi/S0WxlauIpMG0FqyNx0r6fVMU6JQENgQSGA
	83yr8erxOMrRalRwT+59s8iFBg+SggVhfzvd0zmQnMh20uKqJujCWp2yqXBxOShP8fplcnQWeyq
	jI1HMm8YM6Agb6jgBZQHJSsWXxznQi+6f8yzC9+KJY8DLEIzCERBE+eiFAcweeuFvzDlBwPZSYS
	3yzTdnUZitO7ilqni+nt1Gg8xRaA7XU/WhIkEcUwryLKtnlDceFKjDSaaK9+r+dai91l9no1NfM
	FbcN8OkkbeLAlZ
X-Received: by 2002:a05:6a21:512:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c0bcfea433mr665100637.21.1783482287869;
        Tue, 07 Jul 2026 20:44:47 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm14918056c88.0.2026.07.07.20.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:44:47 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:14:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Dhruva Gole <d-gole@ti.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1] cpufreq: Make cpufreq_update_pressure() fall back to
 cpuinfo.max_freq
Message-ID: <xdiwzy332y7inq4nnb2ht3xklm7acye4u3b3ar4psbak6rax3l@zsa6icmznqfx>
References: <5086499.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5086499.GXAFRqVoOG@rafael.j.wysocki>

On 07-07-26, 19:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If arch_scale_freq_ref() is not defined for a given arch (like x86, for
> example), cpufreq_update_pressure() will always set cpufreq_pressure to
> zero for all CPUs in the system, which is generally problematic on
> systems with asymmetric capacity [1].
> 
> However, in the absence of arch_scale_freq_ref(), it is reasonable
> to assume that cpuinfo.max_freq is the maximum sustainable frequency
> for the given cpufreq policy.  Moreover, there are cases in which
> arch_scale_freq_ref() would need to be defined to return essentially
> the cpuinfo.max_freq value anyway (for example, intel_pstate on
> hybrid platforms).
> 
> For the above reasons, update cpufreq_update_pressure() to fall back to
> using cpuinfo.max_freq as the reference frequency if zero is returned by
> arch_scale_freq_ref().
> 
> Fixes: 75d659317bb1 ("cpufreq: Add a cpufreq pressure feedback for the scheduler")
> Link: https://lore.kernel.org/lkml/CAKfTPtBuRLfYNnR4w--cFZYZy-R8gaPEgVwCcaMmbCcJ2H-muQ@mail.gmail.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2590,6 +2590,9 @@ static void cpufreq_update_pressure(stru
>  
>  	cpu = cpumask_first(policy->related_cpus);
>  	max_freq = arch_scale_freq_ref(cpu);
> +	if (!max_freq)
> +		max_freq = policy->cpuinfo.max_freq;
> +
>  	capped_freq = policy->max;
>  
>  	/*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
