From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization update flags
Date: Tue, 19 Dec 2017 11:44:58 +0100
Message-ID: <2751455.goTIWJZO51@aspire.rjw.lan>
References: <20456740.6R3DDKEUDv@aspire.rjw.lan> <CAJWu+oo+_30hFy16Fnu=dmJV3u-8_EVZw1j2pBC5PbEMBrnWUg@mail.gmail.com> <20171219034118.GP19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171219034118.GP19815@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 19, 2017 4:41:18 AM CET Viresh Kumar wrote:
> On 18-12-17, 19:30, Joel Fernandes wrote:
> > Yes that's clean to me but then as Rafael said, the use of this flag
> > will be too specific for schedutil-only sg_cpu->flags clearing purpose
> > right?
> 
> And so would be the extra parameter ?

Right.

I don't like the new parameter idea too much.

"Clearing" flags are generally fine by me, but I want them to have a meaning
for whoever who may receive them.

I guess you can define the original CLEAR thing to mean "clear the RT and
DL flags if you have saved them or ignore them if set here otherwise"
and then intel_pstate can work as though it was called with the flags
argument equal to zero (or just with IOWAIT set, but that never happens
if CLEAR is set I guess).

Still, IMO NO_DL and NO_RT would be conceptually more straightforward
(clear X if NO_X is set or ignore NO_X otherwise).

But anyway it is scheduler code and the scheduler maintainers haven't
spoken up so far, so what I'm saying may just not matter. :-)

Thanks,
Rafael
