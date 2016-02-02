From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Tue, 2 Feb 2016 22:57:32 +0100
Message-ID: <CAJZ5v0ji==pvgWJNdhV1DZkJ7FDfJqEhmOf=DE=BTmotrBw+Pg@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36188 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbcBBV5d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 16:57:33 -0500
In-Reply-To: <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Invalid state-transitions is verified by governor core now

What about the governors that don't use cpufreq_governor_dbs()?

> and there is no need to replicate that in cpufreq core. Also we don't drop
> policy->rwsem anymore, which makes rest of the races go away.
>
> Simplify code a bit now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I won't make this change just yet.  At least not in 4.5 (provided that
the other patches go into it).

Thanks,
Rafael
