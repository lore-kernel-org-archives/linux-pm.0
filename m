From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes
 because of lockup detector watchdog threads
Date: Mon, 8 Jan 2018 09:31:21 +0530
Message-ID: <20180108040121.GB4003@vireshk-i7>
References: <1515184652.6892.26.camel@nxp.com>
 <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38035 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755076AbeAHEBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jan 2018 23:01:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id u25so5114458pfg.5
        for <linux-pm@vger.kernel.org>; Sun, 07 Jan 2018 20:01:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org

On 05-01-18, 23:18, Rafael J. Wysocki wrote:
> On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > Hello,
> >
> > When using the schedutil governor together with the softlockup detector
> > all CPUs go to their maximum frequency on a regular basis. This seems
> > to be because the watchdog creates a RT thread on each CPU and this
> > causes regular kicks with:
> >
> >     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
> >
> > The schedutil governor responds to this by immediately setting the
> > maximum cpu frequency, this is very undesirable.
> >
> > The issue can be fixed by this patch from android:
> >     https://patchwork.kernel.org/patch/9301909/
> >
> > The patch stalled in a long discussion about how it's difficult for
> > cpufreq to deal with RT and how some RT users might just disable
> > cpufreq. It is indeed hard but if the system experiences regular power
> > kicks from a common debug feature they will end up disabling schedutil
> > instead.
> 
> They are basically free to use the other governors instead if they prefer them.
> 
> > No other governors behave this way,
> 
> Because they work differently overall.
> 
> > perhaps the current behavior should be considered a bug in schedutil.
> >
> > That patch now has conflicts with latest upstream. Perhaps a modified
> > variant should be reconsidered for inclusion, or is there some other
> > solution pending?
> 
> Patrick has a series of patches dealing with this problem area AFAICS,
> but we are currently integrating material from Juri related to
> deadline tasks.

I am not sure if Patrick's patches would solve this problem at all as
we still go to max for RT and the RT task is created from the
softlockup detector somehow.

One way to fix that can be to use DL for the softlockup detector as
after Juri's patches we don't always go to max for DL.

On the other side, AFAIR, Peter was very clear during the previous LPC
that it doesn't make sense to use rt-avg as the above patch suggests.

-- 
viresh
