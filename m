From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Tue, 31 May 2016 16:44:51 +0530
Message-ID: <20160531111451.GF9463@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-2-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35768 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEaLOz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:14:55 -0400
Received: by mail-pf0-f177.google.com with SMTP id g64so73936099pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464231181-30741-2-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 25-05-16, 19:52, Steve Muckle wrote:
> +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> +					 unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	int index, retval;
> +
> +	clamp_val(target_freq, policy->min, policy->max);

Rafael will kill me for this, as I have fallen into the same trap and
copied your *incorrect* code :(

This is a useless statement unless you do:

target_freq = clamp_val(target_freq, policy->min, policy->max);

-- 
viresh
