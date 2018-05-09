From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Wed, 9 May 2018 14:11:28 +0530
Message-ID: <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Claudio Scordino <claudio@evidence.eu.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, "4 . 12+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-05-18, 22:54, Rafael J. Wysocki wrote:
> On Tue, May 8, 2018 at 8:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
> > occasions:
> > - In sugov_start(), when the schedutil governor is started for a group
> >   of CPUs.
> > - And whenever we need to force a freq update before rate-limit
> >   duration, which happens when:
> >   - there is an update in cpufreq policy limits.
> >   - Or when the utilization of DL scheduling class increases.
> >
> > In return, get_next_freq() doesn't return a cached next_freq value but
> > instead recalculates the next frequency. This has some side effects
> > though and may significantly delay a required increase in frequency.
> >
> > In sugov_update_single() we try to avoid decreasing frequency if the CPU
> > has not been idle recently. Consider this scenario, the available range
> > of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
> > frequency is 800 MHz. From one of the call paths
> > sg_policy->need_freq_update is set to true and hence
> > sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
> > next_f will always be less than UINT_MAX, whatever the value of next_f
> > is. And so even when we wanted to increase the frequency, we will
> > overwrite next_f with UINT_MAX and will not change the frequency
> > eventually. This will continue until the time CPU stays busy. This isn't
> > cross checked with any specific test cases, but rather based on general
> > code review.
> >
> > Fix that by not resetting the sg_policy->need_freq_update flag from
> > sugov_should_update_freq() but get_next_freq() and we wouldn't need to
> > overwrite sg_policy->next_freq anymore.
> >
> > Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
> > Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
> 
> The rest of the chantelog is totally disconnected from this commit.

I added the "Fixes" tag because this is exactly the commit after which
this problem started, isn't it?

> So the problem is that sugov_update_single() doesn't check the special
> UNIT_MAX value before assigning sg_policy->next_freq to next_f.  Fair
> enough.
> 
> I don't see why the patch is the right fix for that, however.

I thought not overwriting next_freq makes things much simpler and easy
to review. What else do you have in mind to solve this problem ?

-- 
viresh
