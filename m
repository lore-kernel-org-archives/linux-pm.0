From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: Too many timer interrupts in NO_HZ
Date: Sun, 16 Mar 2008 23:47:11 +0530
Message-ID: <20080316181711.GK18923@dirshya.in.ibm.com>
References: <20080302194812.GD10028@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080302194812.GD10028@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.c>
List-Id: linux-pm@vger.kernel.org

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2008-03-03 01:18:13]:

[sniped]
       
 
> The problem:
> 
> There are way too many timer interrupts even though the CPUs have
> entered tickless idle loop.  Timer interrupts basically bring the CPU
> out of idle, and then return to tickless idle.  There are very few
> try_to_wake_up()s or need_resched() in between the timer interrupts.
> 
> What can happen in an idle system in the timer interrupt context that
> does not invoke a need_resched() or try_to_wake_up()?
> 

[sniped]
 
> Please help me to understand the following scenario:
> 
> * What can happen in timer interrupt context that need not wakeup any
>   process?
> * What can prevent tick_nohz_stop_sched_tick() from actually stopping
>   the tick?  
> * Whats wrong in expecting to see some of the CPUs having tickless
>   idle time of few minutes

I think I have the answers to some of the above questions.  

Function        Count                   Name
Address

c0219922        : 5		blk_unplug_timeout
c014f464        : 55		wb_timer_fn
c02b2e67        : 350		bnx2_timer
c03efcbc        : 115		neigh_periodic_timer
c012894a        : 220		process_timeout
c027d1c4        : 2		hangcheck_fire
c03fe232        : 3		peer_check_expire
c012e830        : 25		delayed_work_timer_fn
c03afe92        : 2783		ehci_watchdog
c03f1a35        : 10		neigh_timer_handler
c01d7456        : 110		commit_timeout
c04381e9        : 2		addrconf_verify
c03f6d39        : 365		dev_watchdog
c04126bc        : 114		tcp_write_timer

These are roughly the list of functions that were responsible for the
timer interrupts across all cpus including the ones in idle.  Most of
the functions complete the job in interrupt context and also re-queue
the timer.  The count number is the call count in the 120s observation
window across all 4 CPUs.

I got these function addresses from __next_timer_interrupt() in
timer.c.  Previously, I did not look in timer.c since hrtimers were
enabled and I assumed all timer call will be through __run_hrtimer
from hrtimer.c.  The call count of __run_hrtimer was very minimal and
did not correspond to the local timer interrupt count.

These are device driver timers that we need to investigate.  We should
try to migrate them to CPU0 (or some other package) to get really long
uninterrupted CPU sleep time.  

I will post more results after tweaking some of the above timers.

Should PowerTop include local timer interrupt counts as well during
the observation period?  Interrupt do significantly affect CPU sleep
time whether they wakeup any process or not.

Comments?

Thanks,
Vaidy
