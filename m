From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Thu, 27 Jul 2017 09:00:59 +0530
Message-ID: <20170727033059.GD352@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <597902DA.8060608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <597902DA.8060608@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, eas-dev@lists.linaro.org, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26-07-17, 14:00, Saravana Kannan wrote:
> No, the alternative is to pass it on to the CPU freq driver and let it
> decide what it wants to do. That's the whole point if having a CPU freq
> driver -- so that the generic code doesn't need to care about HW specific
> details. Which is the point I was making in an earlier email to Viresh's
> patch -- we shouldn't be doing any CPU check for the call backs at the
> scheduler or ever governor level.
> 
> That would simplify this whole thing by deleting a bunch of code. And having
> much simpler checks in those drivers that actually have to deal with their
> HW specific details.

So what you are saying is that we go and update (almost) every cpufreq
driver we have today and make their ->target() callbacks return early
if they don't support switching frequency remotely ? Is that really
simplifying anything?

The core already has most of the data required and I believe that we
need to handle it in the governor's code as is handled in this series.

To solve the problem that you have been reporting (update from any
CPU), we need something like this which I earlier suggested and I
will come back to it after this series is gone. Don't want to
complicate things here unnecessarily.

https://marc.info/?l=linux-kernel&m=148906012827786&w=2

-- 
viresh
