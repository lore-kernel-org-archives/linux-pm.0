From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Fri, 4 Mar 2016 14:18:25 -0800
Message-ID: <56DA09B1.4010005@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan> <15684081.T4iOMUSHCY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32788 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759071AbcCDWS5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 17:18:57 -0500
Received: by mail-qg0-f53.google.com with SMTP id t4so55174329qge.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2016 14:18:57 -0800 (PST)
In-Reply-To: <15684081.T4iOMUSHCY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/03/2016 07:07 PM, Rafael J. Wysocki wrote:
> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> +				unsigned int target_freq, unsigned int relation)
> +{
> +	unsigned int freq;
> +
> +	freq = cpufreq_driver->fast_switch(policy, target_freq, relation);
> +	if (freq != CPUFREQ_ENTRY_INVALID) {
> +		policy->cur = freq;
> +		trace_cpu_frequency(freq, smp_processor_id());
> +	}
> +}

Even if there are platforms which may change the CPU frequency behind
cpufreq's back, breaking the transition notifiers, I'm worried about the
addition of an interface which itself breaks them. The platforms which
do change CPU frequency on their own have probably evolved to live with
or work around this behavior. As other platforms migrate to fast
frequency switching they might be surprised when things don't work as
advertised.

I'm not sure what the easiest way to deal with this is. I see the
transition notifiers are the srcu type, which I understand to be
blocking. Going through the tree and reworking everyone's callbacks and
changing the type to atomic is obviously not realistic.

How about modifying cpufreq_register_notifier to return an error if the
driver has a fast_switch callback installed and an attempt to register a
transition notifier is made?

In the future, perhaps an additional atomic transition callback type can
be added, which platform/driver owners can switch to if they wish to use
fast transitions with their platform.

thanks,
Steve
