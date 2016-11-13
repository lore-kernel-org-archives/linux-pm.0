From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Sun, 13 Nov 2016 15:46:07 +0100
Message-ID: <CAJZ5v0gtmEUriThmYEeaEwoY2DmoDvDZDrzDv=fjRLsXKan+9g@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0gMDoLrdCqxnyUQqWydqj6Ot0ssf=P9=hOk_bOG9gCi0Q@mail.gmail.com> <CAKohponvq3vuzNvaGE7_Pn8vM54AMPZu_E8yRyeytegh-bjuzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponvq3vuzNvaGE7_Pn8vM54AMPZu_E8yRyeytegh-bjuzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 12, 2016 at 6:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 November 2016 at 03:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>>> @@ -478,8 +484,6 @@ static void sugov_exit(struct cpufreq_policy *policy)
>>>         struct sugov_tunables *tunables = sg_policy->tunables;
>>>         unsigned int count;
>>>
>>> -       cpufreq_disable_fast_switch(policy);
>>> -
>>
>> ->but why is this change necessary?
>>
>> sugov_stop() has been called already, so the ordering here shouldn't matter.
>
> Because sugov_policy_free() would be using the flag fast_switch_enabled.

That's only going to happen in the next patch, though, right?  It
wouldn't hurt to write that in the changelog too.

Besides, I'm not actually sure if starting/stopping the kthread in
sugov_policy_alloc/free() is a good idea.  It sort of conflates the
allocation of memory with kthread creation.  Any chance to untangle
that?

Thanks,
Rafael
