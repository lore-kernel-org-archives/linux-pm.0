From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Date: Tue, 8 May 2018 12:00:03 +0100
Message-ID: <20180508110003.GC3752@e108498-lin.cambridge.arm.com>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
 <20180508100227.GB3752@e108498-lin.cambridge.arm.com>
 <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Pavan Kondeti <pkondeti@codeaurora.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 May 2018 at 16:04:27 (+0530), Viresh Kumar wrote:
> On 08-05-18, 11:02, Quentin Perret wrote:
> > The sugov kthreads are DL tasks so they're not impacted by EAS. But even
> > if you take EAS out of the picture, those kthreads are assigned to a
> > "random" CPU at boot time and stay there forever (because that's how DL
> > works). Is this what we want ?
> 
> Okay, I didn't knew that DL threads don't migrate at all. I don't
> think that's what we want then specially for big LITTLE platforms. But
> for the rest, I don't know. Take example of Qcom krait. Each CPU has a
> separate policy, why shouldn't we allow other CPUs to run the kthread?

Right, I see your point. Now, with the current implementation, why should
we randomly force a CPU to manage the kthread of another ? IIUC deadline
should assign the kthreads to CPUs depending on the state of the system
when the task is created. So, from one boot to another, you could
theoretically end up with varying configurations, and varying power/perf
numbers.

> 
> > Looking at the commit you mention below it seems that you did the
> > testing on the old hikey which has only one cpufreq policy. Did you try
> > on other platforms as well ?
> 
> Yeah, the testing wasn't performance oriented but rather corner case
> oriented and it made sense to allow other CPUs to go update the freq
> for remote CPUs. And that's true for big LITTLE as well, the only
> question here is which CPUs we want the thread to run on.
> 
> -- 
> viresh
