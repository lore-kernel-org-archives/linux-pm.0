From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v6 PATCH 0/4] timers: Framework for migration of timers
Date: Thu, 16 Apr 2009 12:11:36 +0530
Message-ID: <20090416064136.GA7510__41602.60173162$1239864388$gmane$org@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Chris Zankel <chris@zankel.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, a.p.zijlstra@chello.nl, Richard Henderson <rth@twiddle.net>, vatsa@linux.vnet.ibm.com, Mikael Starvik <starvik@axis.com>, andi@firstfloor.org, arun@linux.vnet.ibm.com, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Ingo, Thomas, all,


In an SMP system, tasks are scheduled on different CPUs by the
scheduler, interrupts are managed by irqbalancer daemon, but timers
are still stuck to the CPUs that they have been initialised.  Timers
queued by tasks gets re-queued on the CPU where the task gets to run
next, but timers from IRQ context like the ones in device drivers are
still stuck on the CPU they were initialised.  This framework will
help move all 'movable timers' using a sysctl interface.

Please consider for inclusion into -tip


Testing Carried Out:

* Kernbench on a 2-package, quad-core machine results are as follows:

-----------------------------------------------------------------------
| No. of Threads  |	 Time(s) - Without   |	   Time(s) - With the |
|		  |       patches applied    |	     patches applied  |
-----------------------------------------------------------------------
|	2	  |	      106.9	     |		106.3	      |
|	4	  |	       54.7	     |		 54.4	      |
|	8	  |	       31.5	     |		 31.1	      |
|      16	  |	       28.0	     |		 27.5	      |
|      32	  |	       28.1	     |		 28.9	      |
-----------------------------------------------------------------------

* I have cross-compiled my patches against alpha architecture in order
to test if my patches have any issues for architectures without
clockevents support.

The patches cross-compile without any issues for alpha architecture,
but I need help to test if there is any performance regression.
So I'm Cc-ing the maintainers of architectures without clockevents support.


The following patches are included:
PATCH 1/4 - framework to identify pinned timers.
PATCH 2/4 - identifying the existing pinned hrtimers.
PATCH 3/4 - /proc/sys sysctl hook to enable timer migration.
PATCH 4/4 - logic to enable timer migration.

The patchset is based on the latest tip/master.

Timer migration is enabled by default.
It can be turned off when CONFIG_SCHED_DEBUG=y by

echo 0 > /proc/sys/kernel/timer_migration


--arun
