From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state
 variable
Date: Thu, 30 Jul 2015 13:21:30 -0700
Message-ID: <20150730132130.3c957267@radivoje-desk2>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
	<9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
	<20150724100905.7e2e53f4@radivoje-desk2>
	<9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
	<20150730080541.GD31351@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63122 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbbG3UYF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jul 2015 16:24:05 -0400
In-Reply-To: <20150730080541.GD31351@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

On Thu, 30 Jul 2015 13:35:41 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

Hi Viresh,

> Cc'ing Rafael as well..
> 
> On 29-07-15, 17:46, Punit Agrawal wrote:
> > [ adding Viresh ]
> 
> Thanks. That earned me few more patches ;)
> 
> > Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> writes:
> > 
> > > Hi Agarwal,
> > >
> > > On Fri, 24 Jul 2015 16:26:12 +0100
> > > Punit Agrawal <punit.agrawal@arm.com> wrote:
> > >
> > >> Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> writes:
> > >> 
> > >> > From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> > >> >
> > >> > there is no need to keep local state variable. if another
> > >> > driver changes the policy under our feet the cpu_cooling
> > >> > driver will have the wrong state. Get current state from the
> > >> > policy directly instead
> > >> >
> > >> 
> > >> Although the patch below looks good, it does add additional
> > >> processing. I was wondering in what situation do you observe the
> > >> problem $SUBJECT solves?
> > >> 
> > >> Presumably, the policy caps are tighter than those imposed by
> > >> the cpu cooling device (cpufreq_thermal_notifier should take
> > >> care of this).
> > >
> > > we are using this solution on the platfrom which has user space
> > > component control cpufreq throttling. However, user space 
> > > component has its limitations so we are using cpu_cooling as a 
> > > critical backup. Due to this cpu_cooling does not have correct
> > > state as a current state so when the change is needed cpu_cooling
> > > does not make the change since it believes it is in the "correct"
> > > state. I agree that there is slight increase in processing, but
> > > in the case when user space is changing the policy the notifier
> > > will not have access to the current state of the cpu_cooling to
> > > change it appropriately.
> > >
> > 
> > Makes sense. Thanks for the explanation.
> 
> Sorry, but with what I understood it doesn't make sense. And I can be
> wrong here, so please don't laugh at me :)
> 
> So, we have two external suppliers to policy->max here:
> - user space: which decides the maximum frequency the policy can ever
> achieve.
> - thermal: which decides the maximum safe frequency the policy should
> ever be set to.
> 
> We need to set policy->max based on what user requested, but keeping
> in mind the thermal limitations.
> 
> So if the clipped-freq from thermal is higher than what user has
> requested, we don't need to do anything.
> 
> But if the clipped-freq is lower than what user has requested, then
> we need to correct that to keep the system in safe range.
> 
> That's what the code is doing as well.
> 
> Now coming to the change you made. What you are saying is, we should
> report current state based on the value of policy->max. But why?
> 
> policy->max can be lesser than clipped-freq (set by thermal), and the
> current state of thermal clipped-freq isn't what policy->max gives.
> 
> Now, I didn't understood when you said "cpu_cooling doesn't change
> the state since it believes it is in correct state". Can you please
> explain that with some example?
> 
In this case both userspace thermal solution and cpu_cooling are
changing policy->max and the userspace solution will let governor or HW
(depends on architecture) decide the clipped-freq. Now let us say that
cpu_cooling has 4 available states 0-3 and let us say that cpu_cooling
has set the state 1 as the last state. Now userspace component comes in
and changes the state of the system that matches cpu_cooling state 0.
cpu_cooling is unaware of this change and does not change the local
cur_state. Now the temperature changes and cpu_cooling should change
the system state to 1 (userspace component malfunctioned and is not
picking up this change) but since the cur_state is already at 1
cpu_cooling will not do anything since it believes it is in the correct
state. Hope this explains it better
