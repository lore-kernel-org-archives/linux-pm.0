From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v7 0/8] sched/cpuidle: Idle loop rework
Date: Wed, 21 Mar 2018 14:55:36 +0100
Message-ID: <4584935.MPnHlxh7Zu@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1521635467.6308.13.camel@surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521635467.6308.13.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 21, 2018 1:31:07 PM CET Rik van Riel wrote:
> On Tue, 2018-03-20 at 16:12 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > Thanks a lot for the feedback so far!
> > 
> > Respin after recent comments from Peter.
> > 
> > Patches [1-3] unmodified since v5, patch 4 is new and the other ones
> > have been updated to address feedback.
> > 
> > The previous summary that still applies:

Thanks for the testing!
 
> For some reason I see increased CPU utilization
> with this patch series (75% -> 85%) with the same
> rate of requests being handled by the vanilla
> kernel and a kernel with these patches applied.
> 
> I am running a bisect in the series to see what
> change could possibly cause that,

The first 4 patches in the v7 should not change functionality by
themselves.

If you replace the original [5/8] with the v7.2 of it I've just
posted (https://patchwork.kernel.org/patch/10299429/), then it
should not change functionality by itself too.

Then you only have 3 patches to check. :-)

> and also digging
> through system statistics to see whether it might
> be something as perverse as not mistakenly choosing
> deeper C-states on one core causing other cores to
> miss out on turbo mode...

I have no idea ATM.  And what's the workload?
