From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Mon, 30 May 2016 21:02:33 +0530
Message-ID: <20160530153233.GA9463@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
 <20160526071629.GW17585@vireshk-i7>
 <CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
 <20160530101830.GE30066@vireshk-i7>
 <CAJZ5v0hwohZh_Pubt5pc2NoiMWrSDkcfjkbcFuugPkRTwKhejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36815 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161328AbcE3Pci (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 11:32:38 -0400
Received: by mail-pf0-f182.google.com with SMTP id f144so52872936pfa.3
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 08:32:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hwohZh_Pubt5pc2NoiMWrSDkcfjkbcFuugPkRTwKhejQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

I clearly missed the !policy->fast_switch_enabled check in sugov_limit() and so
the confusion.

On 30-05-16, 16:25, Rafael J. Wysocki wrote:
> On Mon, May 30, 2016 at 12:18 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Suppose this is the current range of frequencies supported by a
> > driver: 200, 400, 600, 800, 1000 (in MHz).
> >
> > And policy->cur = next_freq = 400 MHz.
> >
> > A.) Suppose that we change policy->min to 400 MHz from userspace.
> >     -> sugov_limits()
> >        This will find everything in order and simply set
> >        need_freq_update, without updating the frequency.
> >
> >     On next util-callback, we will forcefully return true from
> >     sugov_should_update_freq() and reach sugov_update_commit().
> >
> >     We calculate next_freq and that comes to 400 MHz again (that's the
> >     case we are trying to target with the above code).
> >
> >     With the current code, we will forcefully end up calling
> >     cpufreq_driver_fast_switch().
> >
> >     Because the new and current frequencies are same,
> >     cpufreq_driver->fast_switch() will simply return.
> >
> >     NOTE: I also think that cpufreq_driver_fast_switch() should have a
> >     check like (policy->cur == target_freq). I will add that too, in
> >     case you agree.
> >
> >     So, forcefully updating next_freq to UINT_MAX will end up wasting
> >     some cycles, but wouldn't do any useful stuff.
> 
> It will, but there's no way to distinguish this case from B in the
> governor with the current min/max synchronization mechanism.  That is,
> it only knows that something has changed, but checking what exactly
> has changed would be racy.
> 
> > B.) Suppose that we change policy->min to 600 MHz from userspace.
> >     -> sugov_limits()
> >        This will find that policy->cur is less than 600 and will set
> >        that to 600 MHz by calling __cpufreq_driver_target(). We will
> >        also set need_freq_update.
> >
> >        Note that next_freq and policy->cur are not in sync anymore and
> >        perhaps this is the most important case for the above code.
> 
> It is.
> 
> Moreover, please note that __cpufreq_driver_target() is only called in
> sugov_limits() when policy->fast_switch_enabled is unset.

Yep, I missed it.

I am not sure how harmful it can be, but we are returning from sugov_limits()
without making sure that policy->cur is in valid range currently. I also know
that you left it out because of the possible races with the util handler.

But this is something that is fundamentally broken for now. The user writes
updates the policy->max/min, we return the call to the user thinks that it has
successfully written to the file and everything is aligned. But we may be
running at an frequency from invalid range. Yes, that will happen very soon, but
its broken.

-- 
viresh
