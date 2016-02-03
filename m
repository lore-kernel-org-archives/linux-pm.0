From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 12:21:43 +0530
Message-ID: <20160203065143.GU31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
 <20160202154717.GI3947@e106622-lin>
 <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
 <20160202170144.GL3947@e106622-lin>
 <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
 <56B12BEC.9070603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35487 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229AbcBCGvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 01:51:46 -0500
Received: by mail-pf0-f181.google.com with SMTP id 65so8660698pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 22:51:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B12BEC.9070603@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02-02-16, 14:21, Saravana Kannan wrote:
> I also don't like this patch because it forces governors to either implement
> their own macros and management of their attributes or force them to use the
> governor structs that come with cpufreq_governor.h. cpufreq_governor.h IMHO
> is very ondemand and conservative governor specific and is very irrelevant
> for sched-dvfs or any other governors (hint hint).

But who is stopping us from breaking that file and moving some of it
into include/linux/cpufreq.h ?

We can do that today as well, but it would be fine to do that, when we
add more governors to the core. Though, it would only take a simple
patch if people want me to do it now.

> The only time this ABBA locking is an issue is when governor are changing
> and trying to add/remove attributes. That can easily be checked in
> store_governor

store_scaling_governor ??

> and dealt with without holding the policy rwsem if the

Are you saying that we could have taken the rwsem from the generic
cpufreq.c:store() and dropped it from store_scaling_governor() ? That
would have been something similar to what I tried earlier, which I
never posted (I gave the link to that few days back).

> governors can provide their per sys and per policy attribute arrays as part
> of registering themselves.

These per-sys and per-policy attributes really suck. There is nothing
really different in the implementation, just that the show/store
callbacks have different prototype. One accept 'kboj' as the parameter,
other accept 'policy'. I would call that a HACK as well (I only
implemented it though).

That should just die. A single list of attributes is what we should
have had initially as well.

-- 
viresh
