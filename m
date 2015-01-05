From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 13/14] cpufreq: stats: Fix locking
Date: Mon, 5 Jan 2015 13:36:39 +0530
Message-ID: <CAKohpon2gVxVQp7Yg4+DNKg=WAp35rAi=Bynu8igjNw9NutVDQ@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<0447fedc2d07cd35eed66d7de97ad4e0940b6110.1420177186.git.viresh.kumar@linaro.org>
	<2107105.bVfAua7dNn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:40430 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbAEIGk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 03:06:40 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so59999919obc.7
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2015 00:06:39 -0800 (PST)
In-Reply-To: <2107105.bVfAua7dNn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 04:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> This is pants, sorry.

I am sorry :(

> Whenever you change locking, you need to know exactly (a) what is wrong with
> the way it is currently done and (b) how you are going to improve it.  All of
> that needs to be described here.

Thanks for kicking me here..

> For example, you seem to be thinking that locking is missing from
> __cpufreq_stats_free_table(), so you are adding it in there.  Thus you need to
> describe (a) why it is missing (eg. what races are possible because of that)
> and (b) why adding it the way you do is going to improve the situation.

Yeah, that's what I thought. That race between create/free of stats will
be eliminated by this..

But now as you forced me to write it properly, I am failing to understand why
do we need to have any locking in place for stats ?

These are the reasons why I think we can remove all locking stuff
from stats:

1.) create/free calls to stats can't run in parallel. They are all sequential.
It happens with:
- cpu hotplug: which is sequential with proper locking in place.
- driver unregister: again sequential
- stats unregister: again sequential

So, actually we will never try to allocate stats for a single policy in parallel
threads. Same goes for freeing as well..

2.) Any race possible with sysfs reads ?

These routines are called from show() routine from cpufreq.c and it has
policy locks on the way. So, policy can't go away and so will stats.

Also, if stats unregister we will unregister the notifiers first. And that will
again make things fall in line.

What else are we protecting? Maybe the calls to cpufreq_stats_update()
can happen in parallel and so we may need locking only within that routine.

I might be missing the obvious logic, but then what exactly ?

--
viresh
