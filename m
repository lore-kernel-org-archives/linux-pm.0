From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Too many timer interrupts in NO_HZ
Date: Sun, 16 Mar 2008 22:34:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803162224460.2108-100000__27039.6198066466$1205721405$gmane$org@netrider.rowland.org>
References: <20080316181711.GK18923@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080316181711.GK18923@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Chanda Sethia <chanda.sethia@in.ibm.com>, suresh.b.siddha@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de, discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 16 Mar 2008, Vaidyanathan Srinivasan wrote:

> > The problem:
> > 
> > There are way too many timer interrupts even though the CPUs have
> > entered tickless idle loop.  Timer interrupts basically bring the CPU
> > out of idle, and then return to tickless idle.  There are very few
> > try_to_wake_up()s or need_resched() in between the timer interrupts.
> > 
> > What can happen in an idle system in the timer interrupt context that
> > does not invoke a need_resched() or try_to_wake_up()?

> Function        Count                   Name
> Address
> 
> c0219922        : 5		blk_unplug_timeout
> c014f464        : 55		wb_timer_fn
> c02b2e67        : 350		bnx2_timer
> c03efcbc        : 115		neigh_periodic_timer
> c012894a        : 220		process_timeout
> c027d1c4        : 2		hangcheck_fire
> c03fe232        : 3		peer_check_expire
> c012e830        : 25		delayed_work_timer_fn
> c03afe92        : 2783		ehci_watchdog
> c03f1a35        : 10		neigh_timer_handler
> c01d7456        : 110		commit_timeout
> c04381e9        : 2		addrconf_verify
> c03f6d39        : 365		dev_watchdog
> c04126bc        : 114		tcp_write_timer

> These are device driver timers that we need to investigate.  We should
> try to migrate them to CPU0 (or some other package) to get really long
> uninterrupted CPU sleep time.  

The largest entry is for ehci_watchdog.  This timer won't run at all if
your EHCI controllers are allowed to autosuspend, which will happen
automatically if

	(1) You enable CONFIG_USB_SUSPEND, and

	(2) You have no high-speed USB devices attached, or the
	    ones that are attached have all been suspended.

On the other hand, if you were actively using some high-speed USB 
device during the test then it's understandable that there should be 
lots of timer interrupts as a result.

Alan Stern
