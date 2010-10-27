From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Wed, 27 Oct 2010 23:43:20 +0200
Message-ID: <201010272343.20968.rjw__35161.8394758136$1288216037$gmane$org@sisk.pl>
References: <20101026181421.GA30090@Krystal> <201010271222.08921.rjw@sisk.pl>
	<20101027122115.GA10722@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101027122115.GA10722@Krystal>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 27, 2010, Mathieu Desnoyers wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
...
> 
> Hrm, then why export pm_runtime_get_noresume() at all ?

Basically, the PM core needs it for some obscure stuff.  Beyond that people
really should use it with care (preferably avoid using it at all).

> I don't feel comfortable with some of the pm_runtime_get_noresume() callers.
> 
> > 
> > So if you don't want to resume the device immediately after increasing its
> > usage_count (in which case it's better to use pm_runtime_get_sync()), you
> > should do something like this:
> > 
> > 1) pm_runtime_get_noresume(dev);
> > 1a) pm_runtime_barrier(dev);  // That takes care of all pending requests etc.
> > 
> > 2) ...
> >  
> > 3) pm_runtime_put_noidle(dev);
> > 
> > [The meaning of pm_runtime_barrier() is that all of the runtime PM activity
> > started before the barrier has been completed when it returns.]
> > 
> > There's one place in the PM core where that really is necessary, but I wouldn't
> > recommend anyone doing anything like it in a driver.
> 
> grep -r pm_runtime_get_noresume drivers/    hands out very interesting info.
> 
> e.g.:
> 
> drivers/usb/core/drivers.c: usb_autopm_get_interface_async()
> 
>         pm_runtime_get_noresume(&intf->dev);
>         s = ACCESS_ONCE(intf->dev.power.runtime_status);
>         if (s == RPM_SUSPENDING || s == RPM_SUSPENDED)
>                 status = pm_request_resume(&intf->dev);
> 
> How is this supposed to work ?
> 
> If the ACCESS_ONCE can be reordered before the atomic_inc(), then I fear the
> device can be suspended even after the check.
> 
> My point is that a get/put semantic should imply memory barriers, especially if
> these are exported APIs.

Well, IMO adding a memory barrier to pm_runtime_get_noresume() wouldn't really
change a lot (it still would be racy with respect to some other runtime PM helper
funtions).  That said I guess we should put a "handle with care" sticker on it.

Thanks,
Rafael
