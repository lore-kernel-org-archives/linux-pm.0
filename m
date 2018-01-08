From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes because of lockup detector watchdog threads
Date: Mon, 08 Jan 2018 14:10:56 +0100
Message-ID: <7433376.gbrxC2yhp4@aspire.rjw.lan>
References: <1515184652.6892.26.camel@nxp.com> <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com> <20180108040121.GB4003@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108040121.GB4003@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 8, 2018 5:01:21 AM CET Viresh Kumar wrote:
> On 05-01-18, 23:18, Rafael J. Wysocki wrote:
> > On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > Hello,
> > >
> > > When using the schedutil governor together with the softlockup detector
> > > all CPUs go to their maximum frequency on a regular basis. This seems
> > > to be because the watchdog creates a RT thread on each CPU and this
> > > causes regular kicks with:
> > >
> > >     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
> > >
> > > The schedutil governor responds to this by immediately setting the
> > > maximum cpu frequency, this is very undesirable.
> > >
> > > The issue can be fixed by this patch from android:
> > >     https://patchwork.kernel.org/patch/9301909/
> > >
> > > The patch stalled in a long discussion about how it's difficult for
> > > cpufreq to deal with RT and how some RT users might just disable
> > > cpufreq. It is indeed hard but if the system experiences regular power
> > > kicks from a common debug feature they will end up disabling schedutil
> > > instead.
> > 
> > They are basically free to use the other governors instead if they prefer them.
> > 
> > > No other governors behave this way,
> > 
> > Because they work differently overall.
> > 
> > > perhaps the current behavior should be considered a bug in schedutil.
> > >
> > > That patch now has conflicts with latest upstream. Perhaps a modified
> > > variant should be reconsidered for inclusion, or is there some other
> > > solution pending?
> > 
> > Patrick has a series of patches dealing with this problem area AFAICS,
> > but we are currently integrating material from Juri related to
> > deadline tasks.
> 
> I am not sure if Patrick's patches would solve this problem at all as
> we still go to max for RT and the RT task is created from the
> softlockup detector somehow.
> 
> One way to fix that can be to use DL for the softlockup detector as
> after Juri's patches we don't always go to max for DL.
> 
> On the other side, AFAIR, Peter was very clear during the previous LPC
> that it doesn't make sense to use rt-avg as the above patch suggests.

Right.

Why does the softlockup watchdog use RT tasks in the first place?

Thanks,
Rafael
