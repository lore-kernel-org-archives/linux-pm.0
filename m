From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 13/14] cpufreq: stats: Fix locking
Date: Tue, 06 Jan 2015 00:35:29 +0100
Message-ID: <21209857.m88aJg9vUk@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <2107105.bVfAua7dNn@vostro.rjw.lan> <CAKohpon2gVxVQp7Yg4+DNKg=WAp35rAi=Bynu8igjNw9NutVDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65488 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753024AbbAEXNN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 18:13:13 -0500
In-Reply-To: <CAKohpon2gVxVQp7Yg4+DNKg=WAp35rAi=Bynu8igjNw9NutVDQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On Monday, January 05, 2015 01:36:39 PM Viresh Kumar wrote:
> On 4 January 2015 at 04:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > This is pants, sorry.
> 
> I am sorry :(
> 
> > Whenever you change locking, you need to know exactly (a) what is wrong with
> > the way it is currently done and (b) how you are going to improve it.  All of
> > that needs to be described here.
> 
> Thanks for kicking me here..
> 
> > For example, you seem to be thinking that locking is missing from
> > __cpufreq_stats_free_table(), so you are adding it in there.  Thus you need to
> > describe (a) why it is missing (eg. what races are possible because of that)
> > and (b) why adding it the way you do is going to improve the situation.
> 
> Yeah, that's what I thought. That race between create/free of stats will
> be eliminated by this..
> 
> But now as you forced me to write it properly, I am failing to understand why
> do we need to have any locking in place for stats ?
> 
> These are the reasons why I think we can remove all locking stuff
> from stats:
> 
> 1.) create/free calls to stats can't run in parallel. They are all sequential.
> It happens with:
> - cpu hotplug: which is sequential with proper locking in place.
> - driver unregister: again sequential
> - stats unregister: again sequential
> 
> So, actually we will never try to allocate stats for a single policy in parallel
> threads. Same goes for freeing as well..
> 
> 2.) Any race possible with sysfs reads ?
> 
> These routines are called from show() routine from cpufreq.c and it has
> policy locks on the way. So, policy can't go away and so will stats.
> 
> Also, if stats unregister we will unregister the notifiers first. And that will
> again make things fall in line.

That sounds about right.

> What else are we protecting? Maybe the calls to cpufreq_stats_update()
> can happen in parallel and so we may need locking only within that routine.
> 
> I might be missing the obvious logic, but then what exactly ?

Hard to say from the top of my head and I'm not sure if I have the time to
have a deeper look into that during the next few days.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
