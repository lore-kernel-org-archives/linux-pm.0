From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 15:35:16 +0200
Message-ID: <201010261535.17240.trenn__44411.4891965457$1288100240$gmane$org@suse.de>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<20101026115422.GA2942@elte.hu> <201010261517.44417.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010261517.44417.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 October 2010 15:17:43 Thomas Renninger wrote:
> On Tuesday 26 October 2010 13:54:22 Ingo Molnar wrote:
> > 
> > * Thomas Renninger <trenn@suse.de> wrote:
...
> If cpuidle is not registered, the events you get are arch specific.
> I mean they are arch specific anyway, but with cpuidle you can
> build up an arch independent userspace framework nicely by looking
> up name/desc/power/... of an cpu_idle event in cpuidle sysfs as
> described above.
About cpuidle and cpu_idle events:
There is some oddness that:
arch specific code which registers for cpuidle has to
throw the cpu_idle enter sleep state X event
and the generic cpuidle framework triggers the "exit" event.

So as there are only cpu_idle events in drivers/idle/intel_idle.c,
but not in drivers/acpi/processor_idle.c, I expect that processor.ko
idle driver is broken and only exit states are sent.
Ideally all cpuidle events should be thrown in cpuidle.c like this:

        trace_processor_idle(target_state, smp_processor_id());
        dev->last_residency = target_state->enter(dev, target_state);                                                                     
        trace_processor_idle(PWR_EVENT_EXIT, smp_processor_id());

My patches do not touch this behavior. If, it was broken before.
I'll look at it separately.

      Thomas
