From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Fri, 27 Jun 2014 22:12:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406272202220.16842@knanqh.ubzr>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com> <CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com> <53AC42CE.2050304@arm.com> <CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com> <53AC6D31.7010709@arm.com>
 <CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com> <CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:50740 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbaF1CMD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 22:12:03 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so189578qgf.28
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2014 19:12:02 -0700 (PDT)
In-Reply-To: <CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <ta.omasab@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, 27 Jun 2014, Viresh Kumar wrote:

> On 27 June 2014 11:41, Thomas Abraham <ta.omasab@gmail.com> wrote:
> > On Fri, Jun 27, 2014 at 12:27 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> >> Alternatively in a multi-cluster platform if I hotplug out all the cpus in
> >> one
> >> cluster, do you mean we still have to explicitly set the frequency to lowest
> >> before the last cpu goes down.
> >
> > Yes, but it would "after" the last cpu goes down. As mentioned in my
> 
> How will you change freq *after* last cpu goes down? This code
> always initiate freq-switch from last-cpu.
> 
> Also, we must keep in mind that switching to lowest freq would make
> it take more time to execute the cluster shutdown code..
> 
> > previous reply, there is an opportunity to save power by doing this.
> >
> >> This needs to be handled implicitly IMO, but
> >> they may be some restrictions on some platforms which I am not aware of.
> >
> > This change is useful on Exynos based platforms and not intrusive
> > either. So if we can get this on linux-next and gets test coverage on
> > other platforms until maybe -rc7, we can be reasonably sure that other
> > platforms are not affected by this. I see no reason in holding this
> > back just based on assumptions about other platforms.
> 
> I don't think getting this to linux-next would make a difference. There
> aren't many big LITTLE platforms, even lesser would be using linux-next
> and very very few would be using IKS :)
> 
> So, we have to decide whatever we want here only.
> 
> @Nicolas: Please comment here, we need your suggestions :)

OK...

If reducing the frequency of the cluster going down saves power, then it 
should be done _all_ the time i.e. when using CPU hotplug, when cpuidle 
sends all CPUs to sleep, etc.  So this has nothing to do with the 
switcher even if the switcher would also benefit from this.

In other words, this should be performed by the MCPM backend as part of 
the last man operations. This way it is generic and completely 
transparent to the rest of the system.

To restore the CPU frequency that was effective before going down, you 
may use the MCPM powered_up method.


Nicolas
