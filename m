From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 02:07:10 +0100
Message-ID: <CAJZ5v0i3WLgu8U5cmEQtfUDy6-LXN3g7auSVjOaMEHd_gqVzvg@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
	<20160202154717.GI3947@e106622-lin>
	<CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
	<20160202170144.GL3947@e106622-lin>
	<CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
	<56B12BEC.9070603@codeaurora.org>
	<CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 3, 2016 at 12:42 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Feb 2, 2016 at 11:21 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 02/02/2016 11:40 AM, Rafael J. Wysocki wrote:
>>>
>>> On Tue, Feb 2, 2016 at 6:01 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>

[cut]

>>
>> I also don't like this patch because it forces governors to either implement
>> their own macros and management of their attributes or force them to use the
>> governor structs that come with cpufreq_governor.h. cpufreq_governor.h IMHO
>> is very ondemand and conservative governor specific and is very irrelevant
>> for sched-dvfs or any other governors (hint hint).
>>
>> The only time this ABBA locking is an issue is when governor are changing
>> and trying to add/remove attributes. That can easily be checked in
>> store_governor and dealt with without holding the policy rwsem if the
>> governors can provide their per sys and per policy attribute arrays as part
>> of registering themselves.
>>
>> I'm sorry that I just keep talking about the idea and not sending out the
>> patches.
>
> I think you have a point, though.
>
> The deadlock really is specific to the governors using the code in
> cpufreq_governor.c.

That said no other governors in the tree use any sysfs attributes for
tunables AFAICS and the out-of-the tree ones are out of interest here.

Also the deadlock happens if one of the tunable attributes is accessed
while we're trying to remove it which very well may happen on read
access too.

Thanks,
Rafael
