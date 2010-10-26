From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Mon, 25 Oct 2010 18:09:42 -0700
Message-ID: <4CC62A56.7070908__12429.0588930764$1288055445$gmane$org@linux.intel.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288049630-10947-1-git-send-email-trenn@suse.de>
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

On 10/25/2010 4:33 PM, Thomas Renninger wrote:
> Changes in V2:
>    - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>    - Use u32 instead of u64 for cpuid, state which is by far enough
>
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
>    power:power_start
>    power:power_end
> are replaced with:
>    power:processor_idle
>
> and
>    power:power_frequency
> is replaced with:
>    power:processor_frequency
>
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.
>
> the type= field got removed from both, it was never
> used and the type is differed by the event type itself.
>
> perf timechart
> userspace tool gets adjusted in a separate patch.
>

Acked-by: Arjan van de Ven <arjan@linux.intel.com>
