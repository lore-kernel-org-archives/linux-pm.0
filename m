From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate: Lower p-state when putting down CPU
Date: Thu, 13 Mar 2014 22:39:40 +0100
Message-ID: <9561793.q4TIRAuSon@vostro.rjw.lan>
References: <CAKQMxzQhVz0QT6tV0PKFjXXpYpDbtnOBH=miARoeQhrvs2TKFQ@mail.gmail.com> <16035918.jZXKnQ3yiq@vostro.rjw.lan> <CAKohponCJH4E0WUeqkKAhni49Jp+k4HbmiPd2cBZL63pBY+r3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63455 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753228AbaCMVYS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Mar 2014 17:24:18 -0400
In-Reply-To: <CAKohponCJH4E0WUeqkKAhni49Jp+k4HbmiPd2cBZL63pBY+r3g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Patrick Marlier <patrick.marlier@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, March 13, 2014 12:56:02 PM Viresh Kumar wrote:
> On 13 March 2014 08:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, March 12, 2014 02:27:07 PM Dirk Brandewie wrote:
> 
> >> > I see two possibilities:
> >> >   1. Move the exit() callback to __cpufreq_remove_dev_prepare().  I don't
> >> >      have a good understanding of what carnage this would cause in the core
> >> >      or other scaling drivers.
> >> >
> >> >   2. Add another callback to the cpufreq_driver interface that would be call
> >> >      from __cpufreq_remove_dev_prepare() if the callback was set.
> >
> > I prefer 2, the reason being that it pretty much is guaranteed not to break
> > anything.  For the record, I'm not a fan of adding new cpufreq driver callbacks,
> > but in this particular case it seems we can't really do anything better.
> 
> I haven't thought a lot about which one of these two looks better, probably
> Rafael might be correct. But I can see another way out here as this is very
> much driver specific. Why can't we do a register_hotcpu_notifier() from
> pstate driver alone?

Why would that be better than adding a new callback?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
