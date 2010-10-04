From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/4] perf: provide a DEPRECTAED power trace
	API to user space
Date: Mon, 4 Oct 2010 18:47:55 +0200
Message-ID: <AANLkTikxEFiAQM8JkP4YwL2nB+vhNTDTGR9exJ367XsT__36559.1781134301$1286210948$gmane$org@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<1286205661-24448-5-git-send-email-jean.pihet@newoldbits.com>
	<20101004161051.GF16489@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101004161051.GF16489@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Jean Pihet <j-pihet@ti.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Oct 4, 2010 at 6:10 PM, Frank Ch. Eigler <fche@redhat.com> wrote:
> Hi -
>
>> Provide a CONFIG_DEPRECATED_POWER_EVENT_TRACING =A0option in order
>> to provide backward compatibility with the user space tracing tools.
>
> This is clever:
>
>> +/* Map new events trace points calls to old ones */
>> +#define trace_processor_idle(state, cpu_id) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (state !=3D 0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_start(POWER_CSTATE=
, state, cpu_id); \
>> + =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_end(cpu_id); =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 } while (0)
>
> but with this code, are the new tracepoints firing at all? =A0In other
> words, does this backward-compatibility config option effectively
> disable the newer ones? =A0If so, this is probably avoidable.
Yes the events are fired. In fact with the CONFIG option defined the
trace_processor_* trace points are not defined, only the macro remaps
them (at compile time) to the old ones.

> Instead of redirecting the new tracepoint calls to these macros, an
> alternative may intercept (un)registration for the old tracepoint
> names, and map them to (un)registration of the real tracepoints. =A0See
> how syscall tracepoints map to a special (un)registration callback in
> include/trace/events/syscalls.h (syscall_*regfunc). =A0Instead of
> setting a TIF flag, the new functions can call
> register_processor_idle() et al., and their respective callbacks can
> call the backward-compatibility tracepoints.
>
> The starting point would be to recast the power_start, power_end,
> power_frequency tracepoints via TRACE_EVENT_FN() instead of
> TRACE_EVENT().
That could be done but it is not easy to do. In fact the power.h is
included and parsed multiple times in order to generate the trace
points prototype function _and_ the trace generation code. Please
check 'include/trace/ftrace.h' which is really smart but rather
complicated.

I am aiming at simple to read and maintainable code. Furthermore the
code is going to be removed soon or later.

Thanks for the suggestion!

>
> - FChE
>
Jean
