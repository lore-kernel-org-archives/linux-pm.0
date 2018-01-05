From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes because
 of lockup detector watchdog threads
Date: Fri, 5 Jan 2018 23:18:07 +0100
Message-ID: <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
References: <1515184652.6892.26.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41981 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeAEWSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 17:18:08 -0500
In-Reply-To: <1515184652.6892.26.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> Hello,
>
> When using the schedutil governor together with the softlockup detector
> all CPUs go to their maximum frequency on a regular basis. This seems
> to be because the watchdog creates a RT thread on each CPU and this
> causes regular kicks with:
>
>     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
>
> The schedutil governor responds to this by immediately setting the
> maximum cpu frequency, this is very undesirable.
>
> The issue can be fixed by this patch from android:
>     https://patchwork.kernel.org/patch/9301909/
>
> The patch stalled in a long discussion about how it's difficult for
> cpufreq to deal with RT and how some RT users might just disable
> cpufreq. It is indeed hard but if the system experiences regular power
> kicks from a common debug feature they will end up disabling schedutil
> instead.

They are basically free to use the other governors instead if they prefer them.

> No other governors behave this way,

Because they work differently overall.

> perhaps the current behavior should be considered a bug in schedutil.
>
> That patch now has conflicts with latest upstream. Perhaps a modified
> variant should be reconsidered for inclusion, or is there some other
> solution pending?

Patrick has a series of patches dealing with this problem area AFAICS,
but we are currently integrating material from Juri related to
deadline tasks.

> Alternatively the watchdog threads could be somehow marked as to never
> cause increased cpufreq.

Or maybe just replaced with something that is not a thread?

RT really doesn't leave much choice, because it basically means "I'm
important and I have a deadline, but I'm not telling you how important
I am and what the deadline is".

Thanks,
Rafael
