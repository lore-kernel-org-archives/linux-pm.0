From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 14:16:24 -0700
Message-ID: <20160721211624.GK3122@ubuntu>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1628802.LW0F6bbOgI@vostro.rjw.lan>
 <20160721205245.GI3122@ubuntu>
 <5988238.UOZUTms3Lr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5988238.UOZUTms3Lr@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 21-07-16, 23:19, Rafael J. Wysocki wrote:
> On Thursday, July 21, 2016 01:52:45 PM Viresh Kumar wrote:
> > On 21-07-16, 22:52, Rafael J. Wysocki wrote:
> > > That'd be fine by me.
> > > 
> > > Please send a patch on top of the Steve's series and I can apply it too
> > > (unless Steve sees some major problems in it, which seems unlikely to me).
> > 
> > Sure, thanks :)
> 
> It atually is slightly problematic as is, because if the driver doesn't
> implement ->resolve_freq and doesn't use a frequency table, it will crash
> AFAICS.
> 
> But I guess you can fix this too. :-)

I replied with exact same detail a minute ago :), yeah my patch is
going to fix that as well.

-- 
viresh
