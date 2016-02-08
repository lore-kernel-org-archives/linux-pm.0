From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 09/13] cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
Date: Mon, 8 Feb 2016 13:58:49 +0100
Message-ID: <CAJZ5v0gwaO0yBWKODdEzMwYUGgQvoaBv8Qt9_yCSJub5P1ftMg@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<5934f94cccdd9bd512b9ebdb0fd7134aedc8f1b5.1454931189.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33462 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcBHM6v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 07:58:51 -0500
In-Reply-To: <5934f94cccdd9bd512b9ebdb0fd7134aedc8f1b5.1454931189.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We have got five common sysfs tunables between ondemand and conservative
> governors, move their callbacks to cpufreq_governor.c to get rid of
> redundant code.
>
> Because of minor differences in the implementation of the callbacks,
> some more per-governor callbacks are introduced in order to not
> introduce any more "governor == ONDEMAND/CONSERVATIVE" like checks.

My most fundamental concern here is that attributes that don't apply
to a particular governor should not appear in sysfs at all when that
governor is in use (instead of appearing and always returning -EINVAL
which is sort of silly).

That doesn't mean the common code cannot access them, though.  They
still can be present in the data structure, but it may be a good idea
to set them to special values clearly meaning "invalid" then.

Thanks,
Rafael
