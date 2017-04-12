From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 12 Apr 2017 18:14:23 +0200
Message-ID: <20170412161423.jktdg6tacp7wwpno@hirez.programming.kicks-ass.net>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
 <20170412124822.GG3093@worktop>
 <20170412132741.GK29455@e110439-lin>
 <20170412143414.2c27dakhrydl2pqb@hirez.programming.kicks-ass.net>
 <20170412144310.GB7572@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41488 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbdDLQOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 12:14:31 -0400
Content-Disposition: inline
In-Reply-To: <20170412144310.GB7572@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Wed, Apr 12, 2017 at 03:43:10PM +0100, Patrick Bellasi wrote:
> On 12-Apr 16:34, Peter Zijlstra wrote:
> > On Wed, Apr 12, 2017 at 02:27:41PM +0100, Patrick Bellasi wrote:
> > > On 12-Apr 14:48, Peter Zijlstra wrote:
> > > > On Tue, Apr 11, 2017 at 06:58:33PM +0100, Patrick Bellasi wrote:
> > > > > >     illustrated per your above points in that it affects both, while in
> > > > > >     fact it actually modifies another metric, namely util_avg.
> > > > > 
> > > > > I don't see it modifying in any direct way util_avg.
> > > > 
> > > > The point is that clamps called 'capacity' are applied to util. So while
> > > > you don't modify util directly, you do modify the util signal (for one
> > > > consumer).
> > > 
> > > Right, but this consumer (i.e. schedutil) it's already translating
> > > the util_avg into a next_freq (which ultimately it's a capacity).
> > > 
> > > Thus, I don't see a big misfit in that code path to "filter" this
> > > translation with a capacity clamp.
> > 
> > Still strikes me as odd though.
> 
> Can you better elaborate on they why?

Because capacity is, as you pointed out earlier, a relative measure of
inter CPU performance (which isn't otherwise exposed to userspace
afaik).

While the utilization thing is a per task running signal.

There is no direct relation between the two.

The two main uses for the util signal are:

  OPP selection: the aggregate util of all runnable tasks for a
    particular CPU is used to select an OPP for said CPU [*], against
    whatever max-freq that CPU has. Capacity doesn't really come into play
    here.

  Task placement: capacity comes into play in so far that we want to
    make sure our task fits.


And I'm not at all sure we want to have both uses of our utilization
controlled by the one knob. They're quite distinct.


[*] yeah, I know clock domains with multiple CPUs in etc.. lets keep
this simple ;-)
