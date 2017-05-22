From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Mon, 22 May 2017 16:25:22 +0530
Message-ID: <20170522105522.GG6510@vireshk-i7>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
 <87h90d2mqm.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33999 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbdEVKzZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 06:55:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so78950318pfj.1
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 03:55:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87h90d2mqm.fsf@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 22-05-17, 11:45, Brendan Jackman wrote:
> Hi Viresh,
> 
> On Mon, May 22 2017 at 05:10, Viresh Kumar wrote:
> > The rate_limit_us for the schedutil governor is getting set to 500 ms by
> > default for the ARM64 hikey board. And its way too much, even for the
> > default value. Lets set the default transition_delay_ns to something
> > more realistic (10 ms), while the userspace always have a chance to set
> > something it wants.
> 
> Just a thought - do you think we can treat the reported transition
> latency as a proxy for the "cost" of freq transitions?  I.e. assume that
> on platforms with very fast frequency switching it's probably cheap to
> switch frequency and we want schedutil to respond quickly, whereas on
> platforms with big latencies, frequency switches might be expensive and
> we probably want hysteresis.
> 
> If that makes sense then maybe we could use 10 * transition_latency /
> NSEC_PER_USEC, when transition_latency is reported? Otherwise 10ms seems
> sensible to me..

So my platform (hikey) does provide transition-latency as 500 us. But
schedutil multiplies that with LATENCY_MULTIPLIER (1000) and that
makes it 500000 rate_limit_us, which is unacceptable.

@Rafael: Why does the LATENCY_MULTIPLIER has such a high value? I am
not sure I understood completely on why we have this multiplier :(

-- 
viresh
