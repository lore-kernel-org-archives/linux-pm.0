From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 09/13] cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
Date: Mon, 8 Feb 2016 14:24:39 +0100
Message-ID: <CAJZ5v0gqCiBj3uPoe6dzA6c6pLXJx5Mpyz0Na2ZX9-YJ_KyVgg@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<5934f94cccdd9bd512b9ebdb0fd7134aedc8f1b5.1454931189.git.viresh.kumar@linaro.org>
	<CAJZ5v0gwaO0yBWKODdEzMwYUGgQvoaBv8Qt9_yCSJub5P1ftMg@mail.gmail.com>
	<20160208130330.GH8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34477 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcBHNYl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:24:41 -0500
In-Reply-To: <20160208130330.GH8294@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 8, 2016 at 2:03 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-02-16, 13:58, Rafael J. Wysocki wrote:
>> My most fundamental concern here is that attributes that don't apply
>> to a particular governor should not appear in sysfs at all when that
>> governor is in use (instead of appearing and always returning -EINVAL
>
> s/is in use/is not in use/ ??
>
>> which is sort of silly).
>
> But who said that I have made them available always ? Sorry, I didn't
> understood your input.
>
> I have just moved the show/store callbacks and the struct
> governor_attr definition to cpufreq_governor.c. And sysfs files are
> created only for the ones that are valid for a governor.

OK, I need to look at it more carefully then.

>> That doesn't mean the common code cannot access them, though.  They
>> still can be present in the data structure, but it may be a good idea
>> to set them to special values clearly meaning "invalid" then.
>
> Or are you saying that we should move all the tunables to dbs_data ?

Well, maybe.  I'm not sure, but that may be done later in any case.

Thanks,
Rafael
