From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Thu, 21 Jul 2016 16:45:58 -0700
Message-ID: <20160721234558.GX27987@graphite.smuckle.net>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan>
 <20160721232228.GT27987@graphite.smuckle.net>
 <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 22, 2016 at 01:32:00AM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 22, 2016 at 1:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > On Fri, Jul 22, 2016 at 01:22:22AM +0200, Rafael J. Wysocki wrote:
> >> OK, applied.
> >
> > FWIW I do have a concern on this patch, I think it adds unnecessary
> > overhead.
> 
> It isn't unnecessary.  It prevents an otherwise possible kernel crash
> from happening.

The logic may not be unecessary, but the overhead is. The crash could be
prevented in a way that doesn't require repeatedly checking a pointer
that doesn't change.
