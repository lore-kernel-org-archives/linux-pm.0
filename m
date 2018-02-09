From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Fri, 9 Feb 2018 12:37:44 +0100
Message-ID: <CAJZ5v0g4bgDKP96rivKPE-EMr7SuUhL9OO=M+MQuAjbdq9R45g@mail.gmail.com>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7> <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
 <11598161.veS9VGWB8G@aspire.rjw.lan> <20180209105305.GD12979@localhost.localdomain>
 <CAJZ5v0h9L2mMEaV6oECk9f2ob42Nr9zyqafymwvb+UP+G1q04Q@mail.gmail.com> <20180209112618.GE12979@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209112618.GE12979@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Claudio Scordino <claudio@evidence.eu.com>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 9, 2018 at 12:26 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
> On 09/02/18 12:04, Rafael J. Wysocki wrote:
>> On Fri, Feb 9, 2018 at 11:53 AM, Juri Lelli <juri.lelli@redhat.com> wrote:
>> > Hi,
>> >
>> > On 09/02/18 11:36, Rafael J. Wysocki wrote:
>> >> On Friday, February 9, 2018 9:02:34 AM CET Claudio Scordino wrote:
>> >> > Hi Viresh,
>> >> >
>> >> > Il 09/02/2018 04:51, Viresh Kumar ha scritto:
>> >> > > On 08-02-18, 18:01, Claudio Scordino wrote:
>> >> > >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
>> >> > >> we should not wait for the rate limit, otherwise we may miss some deadline.
>> >> > >>
>> >> > >> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
>> >> > >> misses for tasks with low RT periods.
>> >> > >>
>> >> > >> The patch applies on top of the one recently proposed by Peter to drop the
>> >> > >> SCHED_CPUFREQ_* flags.
>> >> > >>
>> >>
>> >> [cut]
>> >>
>> >> >
>> >> > >
>> >> > > Is it possible to (somehow) check here if the DL tasks will miss
>> >> > > deadline if we continue to run at current frequency? And only ignore
>> >> > > rate-limit if that is the case ?
>> >
>> > Isn't it always the case? Utilization associated to DL tasks is given by
>> > what the user said it's needed to meet a task deadlines (admission
>> > control). If that task wakes up and we realize that adding its
>> > utilization contribution is going to require a frequency change, we
>> > should _theoretically_ always do it, or it will be too late. Now, user
>> > might have asked for a bit more than what strictly required (this is
>> > usually the case to compensate for discrepancies between theory and real
>> > world, e.g.  hw transition limits), but I don't think there is a way to
>> > know "how much". :/
>>
>> You are right.
>>
>> I'm somewhat concerned about "fast switch" cases when the rate limit
>> is used to reduce overhead.
>
> Mmm, right. I'm thinking that in those cases we could leave rate limit
> as is. The user should then be aware of it and consider it as proper
> overhead when designing her/his system.
>
> But then, isn't it the same for "non fast switch" platforms? I mean,
> even in the latter case we can't go faster than hw limits.. mmm, maybe
> the difference is that in the former case we could go as fast as theory
> would expect.. but we shouldn't. :)

Well, in practical terms that means "no difference" IMO. :-)

I can imagine that in some cases this approach may lead to better
results than reducing the rate limit overall, but the general case I'm
not sure about.

I mean, if overriding the rate limit doesn't take place very often,
then it really should make no difference overhead-wise.  Now, of
course, how to define "not very often" is a good question as that
leads to rate-limiting the overriding of the original rate limit and
that scheme may continue indefinitely ...
