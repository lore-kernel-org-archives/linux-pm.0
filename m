From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 09/13] cpufreq: governor: Move common sysfs tunables
 to cpufreq_governor.c
Date: Mon, 8 Feb 2016 18:33:30 +0530
Message-ID: <20160208130330.GH8294@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <5934f94cccdd9bd512b9ebdb0fd7134aedc8f1b5.1454931189.git.viresh.kumar@linaro.org>
 <CAJZ5v0gwaO0yBWKODdEzMwYUGgQvoaBv8Qt9_yCSJub5P1ftMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33919 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbcBHNDd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:03:33 -0500
Received: by mail-pa0-f54.google.com with SMTP id uo6so74781019pac.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 05:03:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwaO0yBWKODdEzMwYUGgQvoaBv8Qt9_yCSJub5P1ftMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08-02-16, 13:58, Rafael J. Wysocki wrote:
> My most fundamental concern here is that attributes that don't apply
> to a particular governor should not appear in sysfs at all when that
> governor is in use (instead of appearing and always returning -EINVAL

s/is in use/is not in use/ ??

> which is sort of silly).

But who said that I have made them available always ? Sorry, I didn't
understood your input.

I have just moved the show/store callbacks and the struct
governor_attr definition to cpufreq_governor.c. And sysfs files are
created only for the ones that are valid for a governor.

> That doesn't mean the common code cannot access them, though.  They
> still can be present in the data structure, but it may be a good idea
> to set them to special values clearly meaning "invalid" then.

Or are you saying that we should move all the tunables to dbs_data ?

-- 
viresh
