From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Thu, 21 Jul 2016 17:09:03 -0700
Message-ID: <20160722000903.GY27987@graphite.smuckle.net>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan>
 <20160721232228.GT27987@graphite.smuckle.net>
 <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com>
 <20160721234558.GX27987@graphite.smuckle.net>
 <CAJZ5v0j1vX+TwjcDxhbfd2ZruxWz7hFfiMUD6NL_+ZHyDqcU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j1vX+TwjcDxhbfd2ZruxWz7hFfiMUD6NL_+ZHyDqcU5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 22, 2016 at 01:53:13AM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 22, 2016 at 1:45 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > On Fri, Jul 22, 2016 at 01:32:00AM +0200, Rafael J. Wysocki wrote:
> >> On Fri, Jul 22, 2016 at 1:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> >> > On Fri, Jul 22, 2016 at 01:22:22AM +0200, Rafael J. Wysocki wrote:
> >> >> OK, applied.
> >> >
> >> > FWIW I do have a concern on this patch, I think it adds unnecessary
> >> > overhead.
> >>
> >> It isn't unnecessary.  It prevents an otherwise possible kernel crash
> >> from happening.
> >
> > The logic may not be unecessary, but the overhead is. The crash could be
> > prevented in a way that doesn't require repeatedly checking a pointer
> > that doesn't change.
> 
> Well, you had the ->resolve_freq check in your patch, didn't you?
> 
> Viresh simply added a ->target_index check to it.
> 
> Now, you can argue that this is one check too many, but as long as
> drivers are allowed to implement ->target without implementing
> ->resolve_freq, the *number* of checks in this routine cannot be
> reduced.
> 
> There are three possible cases and two checks are required to
> determine which case really takes place.

My thinking was that one of these two would be preferable:

- Forcing ->target() drivers to install a ->resolve_freq callback,
  enforcing this at cpufreq driver init time. My understanding is
  ->target() drivers are deprecated anyway and theren't aren't many of
  them, though I don't know offhand exactly how many or how hard it
  would be to do for each one.

- Forcing callers (schedutil in this case) to check that either
  ->target() or ->resolve_freq() is implemented. It means
  catching and scrutinizing future callers of resolve_freq.

But even if one of these is better than it could always be done on top
of this patch I suppose. I'm also not familiar with the platforms that use
->target() style drivers. So strictly speaking for my purposes it won't
matter since the number of tests is the same for them. 
