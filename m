From: Rik van Riel <riel@surriel.com>
Subject: Re: [RFT][PATCH v7 0/8] sched/cpuidle: Idle loop rework
Date: Wed, 21 Mar 2018 10:53:58 -0400
Message-ID: <1521644038.6308.18.camel@surriel.com>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
         <1521635467.6308.13.camel@surriel.com> <4584935.MPnHlxh7Zu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4584935.MPnHlxh7Zu@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-03-21 at 14:55 +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 21, 2018 1:31:07 PM CET Rik van Riel wrote:
> > On Tue, 2018-03-20 at 16:12 +0100, Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > Thanks a lot for the feedback so far!
> > > 
> > > Respin after recent comments from Peter.
> > > 
> > > Patches [1-3] unmodified since v5, patch 4 is new and the other
> > > ones
> > > have been updated to address feedback.
> > > 
> > > The previous summary that still applies:
> 
> Thanks for the testing!
>  
> > For some reason I see increased CPU utilization
> > with this patch series (75% -> 85%) with the same
> > rate of requests being handled by the vanilla
> > kernel and a kernel with these patches applied.
> > 
> > I am running a bisect in the series to see what
> > change could possibly cause that,
> 
> The first 4 patches in the v7 should not change functionality by
> themselves.
> 
> If you replace the original [5/8] with the v7.2 of it I've just
> posted (https://patchwork.kernel.org/patch/10299429/), then it
> should not change functionality by itself too.
> 
> Then you only have 3 patches to check. :-)

I kicked off a test with your v7.2 series first.
I have the idle poll loop rework in the mix, too.

I will check the last 3 patches bit by bit through
today, and will let you know which causes the issue.

I will also try to figure out what the issue is,
if I can :)

> > and also digging
> > through system statistics to see whether it might
> > be something as perverse as not mistakenly choosing
> > deeper C-states on one core causing other cores to
> > miss out on turbo mode...
> 
> I have no idea ATM.  And what's the workload?

The workload is memcache style, with equal
queries coming in to both the system running
the control kernel, and the system running
the test kernel.

On the control system, CPU utilization is
around 75%, while on the test system it is
up to 85% - for the same number of queries.

-- 
All Rights Reversed.
