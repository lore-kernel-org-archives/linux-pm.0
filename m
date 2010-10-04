From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH 4/4] perf: provide a DEPRECTAED power trace
	API to user space
Date: Mon, 4 Oct 2010 12:10:51 -0400
Message-ID: <20101004161051.GF16489__1261.4875719466$1286208722$gmane$org@redhat.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<1286205661-24448-5-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1286205661-24448-5-git-send-email-jean.pihet@newoldbits.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Jean Pihet <j-pihet@ti.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi -

> Provide a CONFIG_DEPRECATED_POWER_EVENT_TRACING  option in order
> to provide backward compatibility with the user space tracing tools.

This is clever:

> +/* Map new events trace points calls to old ones */
> +#define trace_processor_idle(state, cpu_id)				\
> +	do {								\
> +		if (state != 0)						\
> +			trace_power_start(POWER_CSTATE, state, cpu_id);	\
> +		else							\
> +			trace_power_end(cpu_id);			\
> +	} while (0)

but with this code, are the new tracepoints firing at all?  In other
words, does this backward-compatibility config option effectively
disable the newer ones?  If so, this is probably avoidable.

Instead of redirecting the new tracepoint calls to these macros, an
alternative may intercept (un)registration for the old tracepoint
names, and map them to (un)registration of the real tracepoints.  See
how syscall tracepoints map to a special (un)registration callback in
include/trace/events/syscalls.h (syscall_*regfunc).  Instead of
setting a TIF flag, the new functions can call
register_processor_idle() et al., and their respective callbacks can
call the backward-compatibility tracepoints.

The starting point would be to recast the power_start, power_end,
power_frequency tracepoints via TRACE_EVENT_FN() instead of
TRACE_EVENT().

- FChE
