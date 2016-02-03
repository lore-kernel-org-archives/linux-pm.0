From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 12:24:42 +0530
Message-ID: <20160203065442.GV31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
 <20160202154717.GI3947@e106622-lin>
 <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
 <20160202170144.GL3947@e106622-lin>
 <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
 <56B12BEC.9070603@codeaurora.org>
 <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
 <CAJZ5v0i3WLgu8U5cmEQtfUDy6-LXN3g7auSVjOaMEHd_gqVzvg@mail.gmail.com>
 <56B158A0.6060604@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B158A0.6060604@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-02-16, 17:32, Saravana Kannan wrote:
> But if we are expecting sched dvfs to come in, why make it worse for it. It
> would be completely pointless to try and shoehorn sched dvfs to use
> cpufreq_governor.c

We can move the common part to cpufreq core and not make sched-dvfs
reuse cpufreq_governor.c

-- 
viresh
