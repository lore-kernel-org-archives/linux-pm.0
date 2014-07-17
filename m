From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Thu, 17 Jul 2014 11:21:25 +0530
Message-ID: <CAKohponX1Wkk0ZOpV6C4i5pQr35b=zMN0L7mjfHVZDwq_A4ocw@mail.gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
	<1405464473-3916-2-git-send-email-skannan@codeaurora.org>
	<CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com>
	<53C65F03.1050609@mit.edu>
	<CAKohpomKF_TvpPZzEwocOK33RKnLWLtE2cPK6hk7YuhTVaNg2g@mail.gmail.com>
	<53C6D90A.1000402@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53C6D90A.1000402@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 17 July 2014 01:26, Saravana Kannan <skannan@codeaurora.org> wrote:
> No it's not. All the cpu*/ directories for all possible CPUs will be there
> whether a CPU is online/offline. Which is why I also weed out impossible
> CPUs, but you said the driver shouldn't be passing impossible CPUs anyway.
> I'm just picking one directory to put the real cpufreq directory under. So,
> the code as-is is definitely not broken.

I may be wrong, and that's why I checked it with Srivatsa. He is quite familiar
with hotplug code.

Let me show the example again, its a bit tricky.

I agree with you that sysfs nodes for CPUs stay as is with offline events, but
we aren't talking about that here. On boot when we are trying to bring CPUs
online, some of them may fail to come. And in that case, as confirmed by
Srivatsa, there are no sysfs directories. This doesn't happen normally and
is a very corner case.

Still think we are wrong?

> Sure, I can pick the first cpu that comes online to decide where to put the
> real sysfs cpufreq directory, but then I have to keep track of that in a
> separate field when it's time to remove it when the cpufreq driver is
> unregistered.

It works this way right now and I don't think we maintain any separate field
here. Subsys-interface takes care of the order in which CPUs are added/
removed. And we don't have to handle that here. Just fix policy->cpu
at first cpufreq_add_dev().

> And no, we
> shouldn't be moving sysfs directory to stay with only an online directory.
> That's the thing this patch is trying to simplify.

Ahh, I really missed it in reviews. So, that's why you are looking at first
cpu of related_cpus.. Hmm, so it is quite possible that we would end up
in a case where policy->cpu wouldn't have sysfs directory created for it.

Not sure if that might cause some hickups.

@Srivatsa: ??

> So, I think using the first cpu in related CPUs will always work. If there's
> any disagreement, I think it's purely a personal preference over adding
> another field vs calling cpumask_first()

That's what the problem with this patch was, just too big to miss important
things :)

I now understood why you had these extra cpumask_first() calls.

But having said that, I still don't see a need to change the current behavior.
The important point is kobject and links are added just once, no movement.
And so, I would still like to add it to policy->cpu, i.e. the cpu which comes
first. And this happens only once while we register a driver, so no side
effects probably.

Not every platform is going through hotplug/suspend/resume and keeping
policy->cpu and sysfs node aligned atleast for them might not be that bad.
Though it will work for any cpu.
