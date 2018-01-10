From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes
 because of lockup detector watchdog threads
Date: Wed, 10 Jan 2018 09:38:29 +0530
Message-ID: <20180110040829.GB3335@vireshk-i7>
References: <1515184652.6892.26.camel@nxp.com>
 <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
 <20180108040121.GB4003@vireshk-i7>
 <1515417622.3207.5.camel@nxp.com>
 <20180108151450.GA30937@e110439-lin>
 <1515426694.3207.28.camel@nxp.com>
 <CAJZ5v0hnY+2pL0LGAeQv7xZcYN42+_azKH9cGGLvPU1iO6fmWg@mail.gmail.com>
 <1515508985.3310.8.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515508985.3310.8.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 09-01-18, 16:43, Leonard Crestez wrote:
> What I am saying is that as far as I can tell when cpufreq_update_util
> is called when the task has already executed and is been switched out.

Can you check if this patch makes it any better ?

https://marc.info/?l=linux-kernel&m=151204248901636&w=2

> My tests are not very elaborate but based on some ftracing it seems to
> me that the current behavior is for cpufreq spikes to always trail RT
> activity. Like this:
> 
>           <idle>-0     [002]   496.510138: sched_switch:         swapper/2:0 [120] S ==> watchdog/2:20 [0]
>       watchdog/2-20    [002]   496.510156: bprint:               watchdog: IN watchdog(2)
>       watchdog/2-20    [002]   496.510364: bprint:               watchdog: OU watchdog(2)
>       watchdog/2-20    [002]   496.510377: bprint:               update_curr_rt: watchdog kick RT! cpu=2 comm=watchdog/2

Probabl update_curr_rt is getting called a bit after the task has
already run. The above patch moves the call to cpufreq_update_util()
to enqueue/dequeue paths and that should fix it.

-- 
viresh
