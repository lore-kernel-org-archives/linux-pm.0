From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Mon, 9 May 2016 16:53:16 -0700
Message-ID: <20160509235316.GA30310@sky.smuckle.net>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan>
 <20160507061310.GA15728@worktop.ger.corp.intel.com>
 <20160507063051.GA23722@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36528 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcEIXxU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 19:53:20 -0400
Received: by mail-pf0-f173.google.com with SMTP id c189so83840148pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 16:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160507063051.GA23722@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>

On Sat, May 07, 2016 at 08:30:51AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, May 06, 2016 at 02:58:43PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Commit 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization
> > > update callbacks) overlooked the fact that update_load_avg(), where
> > > CFS invokes cpufreq utilization update hooks, becomes an empty stub for
> > > CONFIG_SMP unset.  In consequence, if CONFIG_SMP is not set, cpufreq
> > > governors are never invoked from CFS and they do not have a chance to
> > > evaluate CPU performace levels and update them often enough.  Needless
> > > to say, things don't work as expected then.
> > > 
> > > Fix the problem by making the !CONFIG_SMP stub of update_load_avg()
> > > invoke cpufreq update hooks too.
> > > 
> > > Fixes: 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization update callbacks)
> > > Reported-by: Steve Muckle <steve.muckle@linaro.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Rafael; feel free to push this through the pm tree.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I already have it in sched/urgent.

Looks like this just missed 4.6-rc7 and the release email for
that doesn't suggest an rc8, as it stands...
