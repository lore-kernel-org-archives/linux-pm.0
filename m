From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: sched-freq locking
Date: Thu, 21 Jan 2016 10:49:58 +0000
Message-ID: <20160121104958.GX8573@e106622-lin>
References: <56984C30.8040402@linaro.org>
 <2058083.HonoCMD469@vostro.rjw.lan>
 <56A036C2.4090403@linaro.org>
 <5334719.Agh48cz3NL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5334719.Agh48cz3NL@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

[+Punit, Javi]

Hi Rafael,

On 21/01/16 02:46, Rafael J. Wysocki wrote:
> On Wednesday, January 20, 2016 05:39:14 PM Steve Muckle wrote:
> > On 01/20/2016 05:22 PM, Rafael J. Wysocki wrote:
> > > One comment here (which may be a bit off in which case please ignore it).
> > > 
> > > You seem to be thinking that sched-freq needs to be a cpufreq governor
> > > and thus be handled in the same way as ondemand, for example.
> > 
> > That's true, I hadn't really given much thought to the alternative you
> > mention below.
> > 
> > > 
> > > However, this doesn't have to be the case in principle.  For example,
> > > if we have a special driver callback specifically to work with sched-freq,
> > > it may just use that callback and bypass (almost) all of the usual
> > > cpufreq mechanics.  This way you may avoid worrying about the governor
> > > locking and related ugliness entirely.
> > 
> > That sounds good but I'm worried about other consequences of taking
> > cpufreq out of the loop. For example wouldn't we need a new way for
> > something like thermal to set frequency limits?
> 
> I don't know from the top of my head, but that's at least worth investigating.
> 

Yes, that's an interesting alternative that we have to think through.

> Maybe we can keep the interface for those things unchanged, but handle it
> differently under the hood?
> 

Let me see if I understand what you are proposing :). If we don't want
to duplicate too many things, maybe it is still feasible to just use
existing cpufreq mechanics to handle hotplug, sysfs, thermal, etc. (with
possibly minor modifications to be notified of events) and only create a
new method to ask the driver for frequency changes, since we will have
replicated policy and freq_table information inside sched-freq.  Is that
what you were also thinking of by saying "bypass (almost) all the usual
cpufreq mechanics"? :)

Thanks,

- Juri
