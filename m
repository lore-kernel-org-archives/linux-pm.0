From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and provide it to scheduler
Date: Wed, 04 Jun 2014 23:56:55 +0200
Message-ID: <2484761.vkWavnsDx3@vostro.rjw.lan>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com> <20140604160230.GS29593@e103034-lin> <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 04, 2014 07:27:12 PM Peter Zijlstra wrote:
> On Wed, Jun 04, 2014 at 05:02:30PM +0100, Morten Rasmussen wrote:
> > On Tue, Jun 03, 2014 at 12:50:15PM +0100, Peter Zijlstra wrote:
> > > On Fri, May 23, 2014 at 07:16:33PM +0100, Morten Rasmussen wrote:
> > > > +static struct capacity_state cap_states_cluster_a7[] = {
> > > > +	/* Cluster only power */
> > > > +	 { .cap =  358, .power = 2967, }, /*  350 MHz */
> > > > +	 { .cap =  410, .power = 2792, }, /*  400 MHz */
> > > > +	 { .cap =  512, .power = 2810, }, /*  500 MHz */
> > > > +	 { .cap =  614, .power = 2815, }, /*  600 MHz */
> > > > +	 { .cap =  717, .power = 2919, }, /*  700 MHz */
> > > > +	 { .cap =  819, .power = 2847, }, /*  800 MHz */
> > > > +	 { .cap =  922, .power = 3917, }, /*  900 MHz */
> > > > +	 { .cap = 1024, .power = 4905, }, /* 1000 MHz */
> > > > +	};
> > > 
> > > So one thing I remember was that we spoke about restricting this to
> > > frequency levels where the voltage changed.
> > > 
> > > Because voltage jumps were the biggest factor to energy usage.
> > > 
> > > Any word on that?
> > 
> > Since we don't drive P-state changes from the scheduler, I think we
> > could leave out P-states from the table without too much trouble. Good
> > point.
> 
> Well, we eventually want to go there I think. Although we still needed
> to come up with something for Intel, because I'm not at all sure how all
> that works.

Do you mean power numbers or how P-states work on Intel in general?

Rafael
