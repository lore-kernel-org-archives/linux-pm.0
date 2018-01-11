From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes because of lockup detector watchdog threads
Date: Thu, 11 Jan 2018 02:20:00 +0100
Message-ID: <16492434.EAxfShfBdI@aspire.rjw.lan>
References: <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com> <CAJZ5v0gytg+ESkcH0uW+AYKaeiT_cb8vdUnhPzds13CaDR521g@mail.gmail.com> <20180110142158.GC16413@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110142158.GC16413@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 10, 2018 3:21:58 PM CET Juri Lelli wrote:
> On 10/01/18 13:35, Rafael J. Wysocki wrote:
> > On Wed, Jan 10, 2018 at 11:54 AM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > > On 09/01/18 16:50, Rafael J. Wysocki wrote:
> > >> On Tue, Jan 9, 2018 at 3:43 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > >
> > > [...]
> > >
> > >> > Every 4 seconds (really it's /proc/sys/kernel/watchdog_thresh * 2 / 5
> > >> > and watchdog_thresh defaults to 10). There is a per-cpu hrtimer which
> > >> > wakes the per-cpu thread in order to check that tasks can still
> > >> > execute, this works very well against bugs like infinite loops in
> > >> > softirq mode. The timers are synchronized initially but can get
> > >> > staggered (for example by hotplug).
> > >> >
> > >> > My guess is that it's only marked RT so that it executes ahead of other
> > >> > threads and the watchdog doesn't trigger simply when there are lots of
> > >> > userspace tasks.
> > >>
> > >> I think so too.
> > >>
> > >> I see a couple of more-or-less hackish ways to avoid the issue, but
> > >> nothing particularly attractive ATM.
> > >>
> > >> I wouldn't change the general behavior with respect to RT tasks
> > >> because of this, though, as we would quickly find a case in which that
> > >> would turn out to be not desirable.
> > >
> > > I agree we cannot generalize to all RT tasks, but what Patrick proposed
> > > (clamping utilization of certain known tasks) might help here:
> > >
> > > lkml.kernel.org/r/20170824180857.32103-1-patrick.bellasi@arm.com
> > >
> > > Maybe with a per-task interface instead of using cgroups?
> > 
> > The problem here is that this is a kernel thing and user space should
> > not be expected to have to do anything about fixing this IMO.
> 
> Not sure. If we would have such an interface, it should be possible to
> use it from both kernel and userspace.

OK

> In this case kernel might be able
> to do the "right" thing. Also, RT userspace is usually already responsible
> for configuring system priorities, it might be easy to set this as well.
> 
> > > The other option would be to relax DL tasks affinity constraints, so
> > > that a case like this might be handled. Daniel and Tommaso proposed
> > > possible approaches, this might be a driving use case. Not sure how we
> > > would come up with a proper runtime for the watchdog, though.
> > 
> > That is a problem.
> > 
> > Basically, it needs to run as soon as possible, but it will be running
> > for a very short time, every time.
> 
> Does it really require to run "as soon as possible" or is it "at least
> once every watchdog period"? In the latter case DL might still fit, with
> a very short runtime (to be defined).

I guess the latter is closer to what's needed.

> > Overall, using a thread for that seems wasteful ...
> 
> Not sure I'm following you here, aren't we using a thread already?

Yes, we are, which is why I'm wondering if that is the right choice. :-)

Thanks,
Rafael
