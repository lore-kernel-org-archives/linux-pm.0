From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 2/4] timers: Identifying the existing
	pinned timers
Date: Tue, 17 Mar 2009 14:07:44 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903171401190.29264__48279.0597169243$1237295574$gmane$org@localhost.localdomain>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111337.GC4686@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090316111337.GC4686@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Mar 2009, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-03-16 16:40:45]:
> 
> The following pinned hrtimers have been identified and marked:
> 1)sched_rt_period_timer
> 2)tick_sched_timer
> 3)stack_trace_timer_fn

How did you verify that these are the only timers which need to be
pinned ?

Can we be sure that there is no code which relies on the current
behaviour to keep functionality tied together ? Networking and block
layer comes to mind.

Thanks,

	tglx
