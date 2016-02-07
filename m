From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization update callbacks
Date: Sun, 07 Feb 2016 15:43:20 +0100
Message-ID: <1855005.ZFAA5ekheo@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <21714199.nYFAWx0Z54@vostro.rjw.lan> <20160207091040.GA6112@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64146 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753774AbcBGOmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 09:42:12 -0500
In-Reply-To: <20160207091040.GA6112@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Sunday, February 07, 2016 02:40:40 PM Viresh Kumar wrote:
> On 06-02-16, 00:10, Rafael J. Wysocki wrote:
> > On Friday, February 05, 2016 08:17:56 PM Viresh Kumar wrote:
> > > Okay, how about this then.
> > > 
> > > We do some computations here and based on them, conditionally want to
> > > update sample_delay_ns. Because there is no penalty now, in terms of
> > > removing/adding timers/wq, etc, why shouldn't we simply update the
> > > sample_delay_ns everytime without any checks? That would mean that the
> > > change of sampling rate is effective immediately, what can be better than that?
> > 
> > Yes, we can do that.
> > 
> > There is a small concern about updating in parallel with dbs_work_handler()
> > in which case we may overwrite the (hopefully already correct) sample_delay_ns
> > value that it has just written, but then it will be corrected next time we
> > take a sample, so it shouldn't be a big deal.
> > 
> > OK, I'll update the patch to do that.
> 
> Great.
> 
> > > Also, we should do the same from update-sampling-rate of conservative
> > > governor as well.
> > 
> > Let's just not change the whole world in one patch, OK?
> 
> Yeah, I wasn't asking to update in the same patch, but just that we
> should do that as well.
> 
> > > I did bit of that this morning, and there weren't any serious issues as
> > > as far as I could see :)
> > 
> > The case I'm mostly concerned about is when update_sampling_rate() looks
> > at a CPU with a policy completely unrelated to the dbs_data it was called
> > for.  In that case the "shared" object may just go away from under it at
> > any time while it is looking at that object in theory.
> 
> Right, a way (ofcourse we should try find something better) is to move
> that update to a separate work item, just as I did it in my patch..

No, it isn't.  Trying to do it asynchronously will only lead to more
concurrency-related issues.

> But, I am quite sure we can get that fixed.

What we need to do, is to make it possible for update_sampling_rate()
to walk all of the cpu_dbs_infos and look at what their policy_dbs
fields point to safely.

After my cleanup patches it does that under dbs_data_mutex and that works,
because this mutex is also held around *any* updates of struct cpu_dbs_info
anywhere.

However, the cpu_dbs_infos themselves are actually static, so they can be
accessed at any time.  It looks like, then, we may just need to add a lock to
each of them to ensure that the policy_dbs thing won't go away suddenly and
we may not need dbs_data_mutex in there any more.

Thanks,
Rafael

