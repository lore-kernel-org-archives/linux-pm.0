From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 06:55:08 -0700
Message-ID: <4CC58C3C.60706__15559.9534781233$1288015041$gmane$org@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
	<1287488171-25303-3-git-send-email-trenn@suse.de>
	<4CC529AA.9070804@linux.intel.com>
	<201010251141.12429.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010251141.12429.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 10/25/2010 2:41 AM, Thomas Renninger wrote:
> On Monday 25 October 2010 08:54:34 Arjan van de Ven wrote:
>> On 10/19/2010 4:36 AM, Thomas Renninger wrote:
>>>    static void poll_idle(void)
>>>    {
>>> -	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
>>>    	local_irq_enable();
>>>    	while (!need_resched())
>>>    		cpu_relax();
>>> -	trace_power_end(0);
>>>    }
>> why did you remove the idle tracepoints from this one ???
> Because no idle/sleep state is entered here.
> State 0 does not exist or say, it means the machine is not idle.
> The new event uses idle state 0 spec conform as "exit sleep state".
>
> If this should still be trackable some kind of dummy sleep state:
> #define IDLE_BUSY_LOOP 0xFE
> (or similar) must get defined and passed like this:
> trace_processor_idle(IDLE_BUSY_LOOP, smp_processor_id());
>      cpu_relax()
> trace_processor_idle(0, smp_processor_id());
>
> I could imagine this is somewhat worth it to compare idle results
> to "no idle state at all" is used.
> But nobody should ever use idle=poll, comparing deep sleep states
> with C1 with (idle=halt) should be sufficient?

this is not idle=poll on the command line only.
this also gets used normally, in two cases
1) during real time operations, for some short periods of time
     (think wallstreet trading)
2) by the menu governor when the next event is less than a few 
microseconds away, so short that even C1 is too much

I know that your new API tries to use "0" as exit, but 0 is already 
taken (in all power terminology at least on x86 it is) for this.

why isn't your "exit" a special define?


also, if you look at many other similar perf events, they ever separate 
entry/exit points:

process/do_process.cpp:         
perf_events->add_event("irq:irq_handler_entry");
process/do_process.cpp:         
perf_events->add_event("irq:irq_handler_exit");
process/do_process.cpp:         perf_events->add_event("irq:softirq_entry");
process/do_process.cpp:         perf_events->add_event("irq:softirq_exit");
process/do_process.cpp:         
perf_events->add_event("timer:timer_expire_entry");
process/do_process.cpp:         
perf_events->add_event("timer:timer_expire_exit");
process/do_process.cpp:         
perf_events->add_event("timer:hrtimer_expire_entry");
process/do_process.cpp:         
perf_events->add_event("timer:hrtimer_expire_exit");
process/do_process.cpp:         perf_events->add_event("power:power_start");
process/do_process.cpp:         perf_events->add_event("power:power_end");
process/do_process.cpp:         
perf_events->add_event("workqueue:workqueue_execute_start");
process/do_process.cpp:         
perf_events->add_event("workqueue:workqueue_execute_end");

so there is already an API consistency precedent
(and frankly, trying to multiplex in "exit" via a magic value is asking 
for trouble API wise)
