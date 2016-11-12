From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sat, 12 Nov 2016 10:52:35 +0530
Message-ID: <CAKohponr4=8Bf9C1=_YEhsvDXm0t2vXyGOnrrEr6HaMKzVOcnQ@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <d9caf98b-706d-d331-89c4-b75120589da3@sssup.it> <20161111143935.GK3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36665 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbcKLFWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Nov 2016 00:22:37 -0500
Received: by mail-qk0-f181.google.com with SMTP id n21so43212577qka.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Nov 2016 21:22:37 -0800 (PST)
In-Reply-To: <20161111143935.GK3117@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>

On 11 November 2016 at 20:09, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Nov 11, 2016 at 03:32:04PM +0100, Tommaso Cucinotta wrote:
>> >+    struct sched_param param = { .sched_priority = 50 };
>>
>> won't you have a tunable here? (sysctl?)
>
> You can use the regular userspace tools, like schedtool and chrt to set
> priorities.

I wanted to get some help from you on this Peter. The out of tree Interactive
governor has always used MAX_RT_PRIORITY - 1 here instead of 50.

But Steve started with 50. What do you think should the value be ?

--
viresh
