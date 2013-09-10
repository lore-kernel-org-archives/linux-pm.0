From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Date: Tue, 10 Sep 2013 21:46:19 +0200
Message-ID: <2703632.ul5ekQh5oq@vostro.rjw.lan>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange> <4292924.3iHJT5nzNS@vostro.rjw.lan> <CAKohponUdE0LCciPb+nf3t_vfNqAy3MeWQO8gTOdEDvQJeWcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62530 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751022Ab3IJTfT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2013 15:35:19 -0400
In-Reply-To: <CAKohponUdE0LCciPb+nf3t_vfNqAy3MeWQO8gTOdEDvQJeWcgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Tuesday, September 10, 2013 08:44:18 PM Viresh Kumar wrote:
> On 10 September 2013 17:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > That said I'm actually unsure what problems *exactly* are fixed by commit
> > 7c30ed5.  The commit log only says that PRECHANGE or POSTCHAGE shouldn't be
> > called twice in a row, but it doesn't say why.  As the fallout indicates,
> > that actually happened before commit 7c30ed5 and nothing visibly broke, so
> > the benefit from having that commit is questionable to me.  On the other hand,
> > the commit itself is evidently broken, so what exactly is the reason for
> > keeping it?
> 
> Okay, so the first question is can we have multiple PRECHANGE notfication
> done without any POSTCHANGE inbetween?
> - Scenario: One reading value of cpuinfo_cur_freq, which will call
> __cpufreq_cpu_get()->cpufreq_out_of_sync()->cpufreq_notify_transition()..
> 
> And ondemand governor trying to change freq of cpu and so doing notification..
> 
> There can be more similar scenarios possible..

OK, and what exactly does break here?  What's the exact race you're concerned
about?

What field is corrupted in which object, for example, or what incorrect
behavior of the hardware results from this?

> Now Second question, is this fine to have multiple PRECHANGE notfications
> before any POSTCHANGE notification?
> 
> Logically it looks obvious to me that these must be serialized..
> Otherwise this is what we are broadcasting:
> - We are changing for freq X, please prepare and let us know if you are
> okay with it..
> - Oh.. So sorry, we are changing to freq Y instead, please adjust accordingly.
> 
> - Yes we have changed to freq Y...
> - Yes we have changed to freq X...
> 
> This looks stupid, isn't it? I don't know how the drivers would behave when
> they see such notifications and so got to this patch initially..

Well, precisely, you don't know.

Can you please look for specific problems and address those instead of trying
to address potential issues that may or may not happen and may or may not really
be issues even if they actually happen?

And broken patches that try to fix such things definitely don't help.

For now I'm reverting the commit in question and everything on top of it.

Thanks,
Rafael

