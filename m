From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with
 utilization update callbacks
Date: Sun, 7 Feb 2016 14:40:40 +0530
Message-ID: <20160207091040.GA6112@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <CAJZ5v0im=K5zVQMgOTKDUnXUTZ-ursAOQ+cu_YYAZisUbvx++g@mail.gmail.com>
 <CAOh2x==QtJaczU4kfEckw=tdzQanRMq3JzEYpPTT=6i9k8UCQA@mail.gmail.com>
 <21714199.nYFAWx0Z54@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35087 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcBGJKo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 04:10:44 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so57852123pac.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 01:10:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <21714199.nYFAWx0Z54@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 06-02-16, 00:10, Rafael J. Wysocki wrote:
> On Friday, February 05, 2016 08:17:56 PM Viresh Kumar wrote:
> > Okay, how about this then.
> > 
> > We do some computations here and based on them, conditionally want to
> > update sample_delay_ns. Because there is no penalty now, in terms of
> > removing/adding timers/wq, etc, why shouldn't we simply update the
> > sample_delay_ns everytime without any checks? That would mean that the
> > change of sampling rate is effective immediately, what can be better than that?
> 
> Yes, we can do that.
> 
> There is a small concern about updating in parallel with dbs_work_handler()
> in which case we may overwrite the (hopefully already correct) sample_delay_ns
> value that it has just written, but then it will be corrected next time we
> take a sample, so it shouldn't be a big deal.
> 
> OK, I'll update the patch to do that.

Great.

> > Also, we should do the same from update-sampling-rate of conservative
> > governor as well.
> 
> Let's just not change the whole world in one patch, OK?

Yeah, I wasn't asking to update in the same patch, but just that we
should do that as well.

> > I did bit of that this morning, and there weren't any serious issues as
> > as far as I could see :)
> 
> The case I'm mostly concerned about is when update_sampling_rate() looks
> at a CPU with a policy completely unrelated to the dbs_data it was called
> for.  In that case the "shared" object may just go away from under it at
> any time while it is looking at that object in theory.

Right, a way (ofcourse we should try find something better) is to move
that update to a separate work item, just as I did it in my patch..

But, I am quite sure we can get that fixed.

-- 
viresh
