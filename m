From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes
 because of lockup detector watchdog threads
Date: Wed, 10 Jan 2018 11:54:51 +0100
Message-ID: <20180110105451.GB16413@localhost.localdomain>
References: <1515184652.6892.26.camel@nxp.com>
 <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
 <20180108040121.GB4003@vireshk-i7>
 <1515417622.3207.5.camel@nxp.com>
 <20180108151450.GA30937@e110439-lin>
 <1515426694.3207.28.camel@nxp.com>
 <CAJZ5v0hnY+2pL0LGAeQv7xZcYN42+_azKH9cGGLvPU1iO6fmWg@mail.gmail.com>
 <1515508985.3310.8.camel@nxp.com>
 <CAJZ5v0gV_4y1rKio9QRP_-M65rXtQHi2W3O22uiXJ08oafVtOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gV_4y1rKio9QRP_-M65rXtQHi2W3O22uiXJ08oafVtOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 09/01/18 16:50, Rafael J. Wysocki wrote:
> On Tue, Jan 9, 2018 at 3:43 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

[...]

> > Every 4 seconds (really it's /proc/sys/kernel/watchdog_thresh * 2 / 5
> > and watchdog_thresh defaults to 10). There is a per-cpu hrtimer which
> > wakes the per-cpu thread in order to check that tasks can still
> > execute, this works very well against bugs like infinite loops in
> > softirq mode. The timers are synchronized initially but can get
> > staggered (for example by hotplug).
> >
> > My guess is that it's only marked RT so that it executes ahead of other
> > threads and the watchdog doesn't trigger simply when there are lots of
> > userspace tasks.
> 
> I think so too.
> 
> I see a couple of more-or-less hackish ways to avoid the issue, but
> nothing particularly attractive ATM.
> 
> I wouldn't change the general behavior with respect to RT tasks
> because of this, though, as we would quickly find a case in which that
> would turn out to be not desirable.

I agree we cannot generalize to all RT tasks, but what Patrick proposed
(clamping utilization of certain known tasks) might help here:

lkml.kernel.org/r/20170824180857.32103-1-patrick.bellasi@arm.com

Maybe with a per-task interface instead of using cgroups?

The other option would be to relax DL tasks affinity constraints, so
that a case like this might be handled. Daniel and Tommaso proposed
possible approaches, this might be a driving use case. Not sure how we
would come up with a proper runtime for the watchdog, though.

Best,

- Juri
