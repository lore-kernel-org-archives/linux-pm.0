From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 23:19:48 +0200
Message-ID: <5988238.UOZUTms3Lr@vostro.rjw.lan>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org> <1628802.LW0F6bbOgI@vostro.rjw.lan> <20160721205245.GI3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61137 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754281AbcGUVOw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 17:14:52 -0400
In-Reply-To: <20160721205245.GI3122@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Thursday, July 21, 2016 01:52:45 PM Viresh Kumar wrote:
> On 21-07-16, 22:52, Rafael J. Wysocki wrote:
> > That'd be fine by me.
> > 
> > Please send a patch on top of the Steve's series and I can apply it too
> > (unless Steve sees some major problems in it, which seems unlikely to me).
> 
> Sure, thanks :)

It atually is slightly problematic as is, because if the driver doesn't
implement ->resolve_freq and doesn't use a frequency table, it will crash
AFAICS.

But I guess you can fix this too. :-)

Thanks,
Rafael

