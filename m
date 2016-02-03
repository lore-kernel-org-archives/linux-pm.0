From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 03 Feb 2016 12:14:44 -0800
Message-ID: <56B25FB4.10404@codeaurora.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org> <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org> <20160202154717.GI3947@e106622-lin> <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com> <20160202170144.GL3947@e106622-lin> <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com> <56B12BEC.9070603@codeaurora.org> <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com> <CAJZ5v0i3WLgu8U5cmEQtfUDy6-LXN3g7auSVjOaMEHd_gqVzvg@mail.gmail.com> <56B158A0.6060604@codeaurora.org> <20160203065442.GV31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52099 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbcBCUOr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 15:14:47 -0500
In-Reply-To: <20160203065442.GV31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/02/2016 10:54 PM, Viresh Kumar wrote:
> On 02-02-16, 17:32, Saravana Kannan wrote:
>> But if we are expecting sched dvfs to come in, why make it worse for it. It
>> would be completely pointless to try and shoehorn sched dvfs to use
>> cpufreq_governor.c
>
> We can move the common part to cpufreq core and not make sched-dvfs
> reuse cpufreq_governor.c
>

Let's do this please.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
