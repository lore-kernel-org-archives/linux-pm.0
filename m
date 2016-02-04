From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Thu, 4 Feb 2016 11:21:08 +0530
Message-ID: <20160204055108.GY3469@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <20160203155428.GY3947@e106622-lin>
 <20160203161059.GH3469@vireshk>
 <20160203172009.GC12132@e106622-lin>
 <CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com>
 <CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com>
 <CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34323 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbcBDFvL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 00:51:11 -0500
Received: by mail-pf0-f177.google.com with SMTP id o185so32897147pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 21:51:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04-02-16, 00:50, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2016 at 12:31 AM, Shilpa Bhat <shilpabhatppc@gmail.com> wrote:
> > Sorry for the delayed report. But I see the below backtrace on Power8 box. It
> > has 4 chips with 128 cpus.

Honestly, I wasn't expecting you to test this stuff, but I really
appreciate you doing that.

Thanks a lot ..

> > [  906.765768]  Possible unsafe locking scenario:
> >
> > [  906.765880]        CPU0                    CPU1
> > [  906.765969]        ----                    ----

This race scenario is perhaps incomplete and difficult to understand
without below lines:

                          Governor's EXIT         Update sampling rate from sysfs

                                                  lock(s_active#91);

> > [  906.766058]   lock(od_dbs_cdata.mutex);
> > [  906.766170]                                lock(&dbs_data->mutex);
> > [  906.766304]                                lock(od_dbs_cdata.mutex);
> > [  906.766461]   lock(s_active#91);
> > [  906.766572]
> >  *** DEADLOCK ***
> 
> This is exactly right.  We've avoided one deadlock only to trip into
> another one.

As we discussed on IRC, we haven't introduced this deadlock with the
current series.  But this is what Juri has reported some days back,
while he tested linus/master on TC2.

> This happens because update_sampling_rate() acquires
> od_dbs_cdata.mutex which is held around cpufreq_governor_exit() by
> cpufreq_governor_dbs().
> 
> Worse yet, a deadlock can still happen without (the new)
> dbs_data->mutex, just between s_active and od_dbs_cdata.mutex if
> update_sampling_rate() runs in parallel with
> cpufreq_governor_dbs()->cpufreq_governor_exit() and the latter wins
> the race.
> 
> It looks like we need to drop the governor mutex before putting the
> kobject in cpufreq_governor_exit().

That wouldn't be trivial to implement as we discussed.

Okay, here is a proposal for the current series and the series's you
have post Rafael:

- Firstly, I would like to clarify that I don't have any issues with
  rebasing on top of your series, it should be easy enough.

- One thing is for sure that nothing from these 3 series's is getting
  merged in 4.5, as we aren't fixing the real issue Shilpa/Juril have
  reported.

- I think the first 4 patches here are just fine and don't need any
  updates. They actually do the right thing and makes code so much
  cleaner.

- So, can we apply the first 4 patches (which  you have already
  applied to bleeding-edge) now and do all work on top of that ?

Again, I can rebase if you merge your patches first, no issues at all
:)

-- 
viresh
