From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Fri, 28 Jul 2017 11:30:54 +0530
Message-ID: <20170728060054.GU352@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <597902DA.8060608@codeaurora.org>
 <20170727033059.GD352@vireshk-i7>
 <597A452C.7000303@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <597A452C.7000303@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27-07-17, 12:55, Saravana Kannan wrote:
> Yes. Simplifying isn't always about number of lines of code. It's also about
> abstraction. Having generic scheduler code care about HW details doesn't
> seem nice.

I can argue that even the policy->cpus field is also hardware
specific, isn't it ? And we are using that in the schedutil governor
anyway. What's wrong with having another field (in a generic way) in
the same structure that tells us more about hardware ?

And then schedutil isn't really scheduler, but a cpufreq governor.
Just like ondemand/conservative, which are also called from the same
scheduler path.

> It'll literally one simple check (cpu == smp_processor_id()) or (cpu "in"
> policy->cpus).
> 
> Also, this is only for drivers that currently support fast switching. How
> many of those do you have?

Why? Why shouldn't we do that for the other drivers? I think it should
be done across everyone.

> >The core already has most of the data required and I believe that we
> >need to handle it in the governor's code as is handled in this series.
> 
> Clearly, it doesn't. You are just making assumptions about HW.

So assuming that any CPU from a policy can change freq on behalf of
all the CPUs of the same policy is wrong? That is the basis of how the
cpufreq core is designed.

-- 
viresh
