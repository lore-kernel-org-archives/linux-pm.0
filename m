From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Fri, 22 Jul 2016 10:49:10 -0700
Message-ID: <20160722174910.GF27987@graphite.smuckle.net>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
 <20160721195926.GF3122@ubuntu>
 <2012245.HQXNKhffmu@vostro.rjw.lan>
 <20160721203041.GH3122@ubuntu>
 <20160721232131.GS27987@graphite.smuckle.net>
 <20160721233003.GM3122@ubuntu>
 <20160721233648.GV27987@graphite.smuckle.net>
 <20160722004405.GA27987@graphite.smuckle.net>
 <20160722151641.GQ3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33979 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbcGVRtO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 13:49:14 -0400
Received: by mail-pa0-f47.google.com with SMTP id fi15so41566359pac.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 10:49:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160722151641.GQ3122@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Fri, Jul 22, 2016 at 08:16:42AM -0700, Viresh Kumar wrote:
> > Long term as I was mentioning in the other thread I think it'd be good
> > if the current target() drivers were modified to supply resolve_freq(),
> > and that cpufreq_register_driver() were again changed to require it for
> > those drivers.
> 
> There is no need for us to force this, its really optional for such
> platforms. Worst case, schedutil wouldn't work at the best, so what?
> Its a platform driver's choice, isn't it ?

This would be in the context of then being able to remove the additional if
statement from the hot path.

To reply to the suggestion of using likely() here, I'm partial to
solving it without that because I'm guessing likely() has to be an
architecture-dependent thing? It seems cleaner to me if the existing
few target() drivers were augmented to provide the resolve_freq() calback
and its presence required. But it's certainly not a big deal and won't
affect any platforms I'm involved with, at least for now. Maybe I could
work on those target() drivers if things change.
