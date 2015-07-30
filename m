From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state variable
Date: Thu, 30 Jul 2015 13:35:41 +0530
Message-ID: <20150730080541.GD31351@linux>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
 <9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
 <20150724100905.7e2e53f4@radivoje-desk2>
 <9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33417 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbG3IFs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 04:05:48 -0400
Received: by pdbnt7 with SMTP id nt7so20473160pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 01:05:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net
Cc: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

Cc'ing Rafael as well..

On 29-07-15, 17:46, Punit Agrawal wrote:
> [ adding Viresh ]

Thanks. That earned me few more patches ;)

> Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> writes:
> 
> > Hi Agarwal,
> >
> > On Fri, 24 Jul 2015 16:26:12 +0100
> > Punit Agrawal <punit.agrawal@arm.com> wrote:
> >
> >> Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> writes:
> >> 
> >> > From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> >> >
> >> > there is no need to keep local state variable. if another driver
> >> > changes the policy under our feet the cpu_cooling driver will
> >> > have the wrong state. Get current state from the policy directly
> >> > instead
> >> >
> >> 
> >> Although the patch below looks good, it does add additional
> >> processing. I was wondering in what situation do you observe the
> >> problem $SUBJECT solves?
> >> 
> >> Presumably, the policy caps are tighter than those imposed by the cpu
> >> cooling device (cpufreq_thermal_notifier should take care of this).
> >
> > we are using this solution on the platfrom which has user space
> > component control cpufreq throttling. However, user space 
> > component has its limitations so we are using cpu_cooling as a 
> > critical backup. Due to this cpu_cooling does not have correct state
> > as a current state so when the change is needed cpu_cooling does
> > not make the change since it believes it is in the "correct" state.
> > I agree that there is slight increase in processing, but in the case 
> > when user space is changing the policy the notifier will not have
> > access to the current state of the cpu_cooling to change it
> > appropriately.
> >
> 
> Makes sense. Thanks for the explanation.

Sorry, but with what I understood it doesn't make sense. And I can be wrong
here, so please don't laugh at me :)

So, we have two external suppliers to policy->max here:
- user space: which decides the maximum frequency the policy can ever achieve.
- thermal: which decides the maximum safe frequency the policy should ever be
  set to.

We need to set policy->max based on what user requested, but keeping in mind the
thermal limitations.

So if the clipped-freq from thermal is higher than what user has requested, we
don't need to do anything.

But if the clipped-freq is lower than what user has requested, then we need to
correct that to keep the system in safe range.

That's what the code is doing as well.

Now coming to the change you made. What you are saying is, we should report
current state based on the value of policy->max. But why?

policy->max can be lesser than clipped-freq (set by thermal), and the current
state of thermal clipped-freq isn't what policy->max gives.

Now, I didn't understood when you said "cpu_cooling doesn't change the state
since it believes it is in correct state". Can you please explain that with some
example?

-- 
viresh
