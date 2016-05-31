From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Tue, 31 May 2016 11:12:53 -0700
Message-ID: <20160531181253.GI9864@graphite.smuckle.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-2-git-send-email-smuckle@linaro.org>
 <20160531111451.GF9463@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33669 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbcEaSM5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 14:12:57 -0400
Received: by mail-pa0-f52.google.com with SMTP id um11so21409788pab.0
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 11:12:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160531111451.GF9463@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Tue, May 31, 2016 at 04:44:51PM +0530, Viresh Kumar wrote:
> On 25-05-16, 19:52, Steve Muckle wrote:
> > +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> > +					 unsigned int target_freq)
> > +{
> > +	struct cpufreq_frequency_table *freq_table;
> > +	int index, retval;
> > +
> > +	clamp_val(target_freq, policy->min, policy->max);
> 
> Rafael will kill me for this, as I have fallen into the same trap and
> copied your *incorrect* code :(
> 
> This is a useless statement unless you do:
> 
> target_freq = clamp_val(target_freq, policy->min, policy->max);

Well I wouldn't worry too much, I copied it from Rafael's code in
cpufreq_driver_fast_switch() which also has this problem and needs to be
fixed.

Perhaps clamp_val could be changed to force the compiler to check that
its return value is being used.

thanks,
Steve
