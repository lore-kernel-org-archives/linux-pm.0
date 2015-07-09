From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: New suspicious RCU usage in 4.2.0-rc1 plus patch
Date: Fri, 10 Jul 2015 01:27:07 +0200
Message-ID: <49543292.DnkKtR9nKG@vostro.rjw.lan>
References: <2195797.u9FVj8R87o@vostro.rjw.lan> <20150709043614.GX3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64419 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750927AbbGIXAi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 19:00:38 -0400
In-Reply-To: <20150709043614.GX3717@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Steven Rostedt <srostedt@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, July 08, 2015 09:36:14 PM Paul E. McKenney wrote:
> On Thu, Jul 09, 2015 at 02:50:25AM +0200, Rafael J. Wysocki wrote:
> > Hi Paul,
> > 
> > Something seems to have changed in RCU in 4.2-rc1, as it is now complaining
> > about a tracepoint in tick_freeze() like this:
> > 
> > [   66.340508] ===============================
> > [   66.340509] [ INFO: suspicious RCU usage. ]
> > [   66.340512] 4.2.0-rc1+ #1691 Not tainted
> > [   66.340513] -------------------------------
> > [   66.340515] /scratch/rafael/work/linux-pm/include/trace/events/power.h:193 suspicious rcu_dereference_check() usage!
> > [   66.340517] 
> > other info that might help us debug this:
> > 
> > [   66.340519] 
> > RCU used illegally from idle CPU!
> > rcu_scheduler_active = 1, debug_locks = 0
> > [   66.340520] RCU used illegally from extended quiescent state!
> > [   66.340522] 1 lock held by swapper/0/0:
> > [   66.340538]  #0:  (tick_freeze_lock){......}, at: [<ffffffff810dcb39>] tick_freeze+0x19/0x230
> > [   66.340539] 
> > stack backtrace:
> > [   66.340543] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc1+ #1691
> > [   66.340544] Hardware name: TOSHIBA PORTEGE R500/Portable PC, BIOS Version 1.60 03/04/2008
> > [   66.340550]  0000000000000001 ffffffff81c03e48 ffffffff817ab99d 0000000000000004
> > [   66.340555]  ffffffff81c10500 ffffffff81c03e78 ffffffff810a2dd7 0000000000000003
> > [   66.340560]  0000000000000000 ffffffff81a6b2c7 ffffffffa00b3090 ffffffff81c03ea8
> > [   66.340561] Call Trace:
> > [   66.340567]  [<ffffffff817ab99d>] dump_stack+0x4f/0x7b
> > [   66.340573]  [<ffffffff810a2dd7>] lockdep_rcu_suspicious+0xe7/0x120
> > [   66.340577]  [<ffffffff810dcca8>] tick_freeze+0x188/0x230
> > [   66.340582]  [<ffffffff816357a0>] cpuidle_enter_freeze+0x30/0x80
> > [   66.340586]  [<ffffffff8109a495>] cpu_startup_entry+0x455/0x490
> > [   66.340591]  [<ffffffff8179e882>] rest_init+0x132/0x140
> > [   66.340595]  [<ffffffff8179e750>] ? csum_partial_copy_generic+0x170/0x170
> > [   66.340601]  [<ffffffff81d14049>] start_kernel+0x484/0x491
> > [   66.340604]  [<ffffffff81d139aa>] ? set_init_arg+0x58/0x58
> > [   66.340608]  [<ffffffff81d135ad>] x86_64_start_reservations+0x2a/0x2c
> > [   66.340611]  [<ffffffff81d13696>] x86_64_start_kernel+0xe7/0xeb
> > 
> > It didn't complained about it before, AFAICS, but in any case the simplest
> > way to deal with it seems to be to put tick_freeze() under RCU_NONIDLE()
> > like in the patch below.
> 
> The above warning won't show up unless you have lockdep enabled, so
> maybe that is what changed?  (Recent RCU changes could expose additional
> uses of RCU from offline CPUs, but shouldn't be any change from idle
> CPUs.  Famous last words!)
> 
> > I wonder what you think about it?
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

OK, thanks!

I'm applying the patch, then.

Rafael

