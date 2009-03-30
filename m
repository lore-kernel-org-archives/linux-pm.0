From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 4/4] timers: logic to move non pinned
	timers
Date: Mon, 30 Mar 2009 10:30:50 +0530
Message-ID: <20090330050050.GA7494__30766.8248111897$1238389664$gmane$org@linux.vnet.ibm.com>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111548.GE4686@linux.vnet.ibm.com>
	<alpine.LFD.2.00.0903171017590.29264@localhost.localdomain>
	<20090317114557.GA32233@linux.vnet.ibm.com>
	<alpine.LFD.2.00.0903171350020.29264@localhost.localdomain>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0903171350020.29264@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [2009-03-17 14:01:00]:

> On Tue, 17 Mar 2009, Arun R Bharadwaj wrote:
> > * Thomas Gleixner <tglx@linutronix.de> [2009-03-17 11:22:24]:
> > >   Let's assume we are on CPU0 and try to enqueue the timer on CPU1,
> > >   where the next timer expiry is 5ms away. The timer which we enqueue
> > >   is due in 500us. So you introduce 4.5ms latency.
> > >
> > We are moving timers to the ilb which wakes up every jiffy.
> > So we can move the timer to the ilb only if it's expiry
> > time is greater than 1 jiffy. Else we can fire on the same CPU.
> 
> Please do not start to add some obscure jiffies magic. The correct
> check is whether the new timers expiry time is before the first timers
> expiry time on the target CPU.
>

Hi Thomas,

Currently, there is a function get_next_timer_interrupt() which
returns the next timer's expiry on the CPU. This is used by
tick_nohz_stop_sched_tick() in order to reprogram the timer device
before stopping the tick.

get_next_timer_interrupt() returns the earliest between the
next timer expiry and the next hrtimer expiry.

In case of the hrtimer expiry, the ktime is rounded off to the next
jiffie and returned.

So using the current infrastructure, there is no benefit in finding
out when the next timer is going to fire on the target cpu over just
checking if the current hrtimer which we are migrating is firing
before the next jiffie or not. If it is firing after 1 jiffie, it can
be migrated and the target cpu (idle load balancer) will reprogram
its timer device accordingly.

--arun
> Thanks,
> 
> 	tglx
