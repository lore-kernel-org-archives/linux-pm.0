From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Fri, 22 Jul 2016 08:16:42 -0700
Message-ID: <20160722151641.GQ3122@ubuntu>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
 <20160721195926.GF3122@ubuntu>
 <2012245.HQXNKhffmu@vostro.rjw.lan>
 <20160721203041.GH3122@ubuntu>
 <20160721232131.GS27987@graphite.smuckle.net>
 <20160721233003.GM3122@ubuntu>
 <20160721233648.GV27987@graphite.smuckle.net>
 <20160722004405.GA27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32975 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbcGVPQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 11:16:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id ks6so40587268pab.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 08:16:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160722004405.GA27987@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On 21-07-16, 17:44, Steve Muckle wrote:
> Going back and checking I see I was thinking of your suggestion that
> cpufreq_register_driver() check that only target() drivers offer a
> resolve_freq() callback. I put a comment for this in cpufreq.h but not a
> check - I could add a check in another patch if you like.

That can be done as we aren't supporting the ->resolve_freq() callback
for ->target_index() drivers.

> Long term as I was mentioning in the other thread I think it'd be good
> if the current target() drivers were modified to supply resolve_freq(),
> and that cpufreq_register_driver() were again changed to require it for
> those drivers.

There is no need for us to force this, its really optional for such
platforms. Worst case, schedutil wouldn't work at the best, so what?
Its a platform driver's choice, isn't it ?

-- 
viresh
