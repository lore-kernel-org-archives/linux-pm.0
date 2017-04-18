From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 00/10] timer: Move from a push remote at enqueue to a pull at expiry model
Date: Tue, 18 Apr 2017 15:57:20 +0200
Message-ID: <2861423.RglJRjL0L9@aspire.rjw.lan>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44136 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753052AbdDRODY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 10:03:24 -0400
In-Reply-To: <20170417183241.244217993@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Monday, April 17, 2017 08:32:41 PM Thomas Gleixner wrote:
> Placing timers at enqueue time on a target CPU based on dubious heuristics
> does not make any sense:
> 
>  1) Most timer wheel timers are canceled or rearmed before they expire.
> 
>  2) The heuristics to predict which CPU will be busy when the timer expires
>     are wrong by definition.
> 
> So we waste precious cycles to place timers at enqueue time.
> 
> The proper solution to this problem is to always queue the timers on the
> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
> expiry time.
> 
> To achieve this the timer storage has been split into local pinned and
> global timers. Local pinned timers are always expired on the CPU on which
> they have been queued. Global timers can be expired on any CPU.
> 
> As long as a CPU is busy it expires both local and global timers. When a
> CPU goes idle it arms for the first expiring local timer. If the first
> expiring pinned (local) timer is before the first expiring movable timer,
> then no action is required because the CPU will wake up before the first
> movable timer expires. If the first expiring movable timer is before the
> first expiring pinned (local) timer, then this timer is queued into a idle
> timerqueue and eventually expired by some other active CPU.
> 
> To avoid global locking the timerqueues are implemented as a hierarchy. The
> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
> groups of 8, which are seperated per node. If more than one CPU group
> exist, then a second level in the hierarchy collects the groups. Depending
> on the size of the system more than 2 levels are required. Each group has a
> "migrator" which checks the timerqueue during the tick for remote expirable
> timers.
> 
> If the last CPU in a group goes idle it reports the first expiring event in
> the group up to the next group(s) in the hierarchy. If the last CPU goes
> idle it arms its timer for the first system wide expiring timer to ensure
> that no timer event is missed.
> 
> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers

No concerns from me FWIW.

Thanks,
Rafael
