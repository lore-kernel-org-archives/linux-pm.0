From: Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: [PATCH v2 4/6] cpufreq: schedutil: update CFS util only if used
Date: Mon, 10 Jul 2017 10:49:39 -0700
Message-ID: <aede676e7d75a4cf6cffb7f8953b9943@codeaurora.org>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
 <c04bdad3354a0ee0aabe63fe813fdaf5@codeaurora.org>
 <CAJWu+opqoBzYr7fZJQ5RP=72ci6xKsh2Jes0GJe_L1x8dZW+dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJWu+opqoBzYr7fZJQ5RP=72ci6xKsh2Jes0GJe_L1x8dZW+dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017-07-07 23:14, Joel Fernandes wrote:
> Hi Vikram,
> 
> On Thu, Jul 6, 2017 at 11:44 PM, Vikram Mulukutla
> <markivx@codeaurora.org> wrote:
>> On 2017-07-04 10:34, Patrick Bellasi wrote:
>>> 
>>> Currently the utilization of the FAIR class is collected before 
>>> locking
>>> the policy. Although that should not be a big issue for most cases, 
>>> we
>>> also don't really know how much latency there can be between the
>>> utilization reading and its usage.
>>> 
>>> Let's get the FAIR utilization right before its usage to be better in
>>> sync with the current status of a CPU.
>>> 
>>> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>

<snip>

>> Given that the utilization update hooks are called with the per-cpu rq 
>> lock
>> held (for all classes), I don't think PELT utilization can change 
>> throughout
>> the lifetime of the cpufreq_update_{util,this_cpu} call? Even with 
>> Viresh's
>> remote cpu callback series we'd still have to hold the rq lock across
>> cpufreq_update_util..  what can change today is 'max'
>> (arch_scale_cpu_capacity) when a cpufreq policy is shared, so the 
>> patch is
>> still needed for that reason I think?
>> 
> 
> I didn't follow, Could you elaborate more why you think the patch
> helps with the case where max changes while the per-cpu rq lock held?
> 

So going by Patrick's commit text, the concern was a TOC/TOU
problem, but since we agree that CFS utilization can't change
within an rq-locked critical section, the only thing that can
change is 'max'. So you might be the 8th cpu in line waiting
for the sg-policy lock, and after you get the lock, the max may
be outdated.

But come to think of it max changes should be triggering schedutil
updates and those shouldn't be rate-throttled, so maybe we don't
need this at all? It's still somewhat future-proof in case there
is some stat that we read in sugov_get_util that can be updated
asynchronously. However we can put it in when we need it...

> thanks,
> 
> -Joel

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
