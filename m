From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv3 5/5] cpuidle: coupled: add trace events
Date: Thu, 3 May 2012 14:13:27 -0700
Message-ID: <CAMbhsRQWwp6TLVbHefV5c0fsb0W5=B_EVEdWtHcwc799dWEHGg@mail.gmail.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<1335816551-27756-6-git-send-email-ccross@android.com>
	<1336078827.14207.109.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1336078827.14207.109.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 3, 2012 at 2:00 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2012-04-30 at 13:09 -0700, Colin Cross wrote:
>
>> diff --git a/include/trace/events/cpuidle.h b/include/trace/events/cpuid=
le.h
>> new file mode 100644
>> index 0000000..9b2cbbb
>> --- /dev/null
>> +++ b/include/trace/events/cpuidle.h
>> @@ -0,0 +1,243 @@
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM cpuidle
>> +
>> +#if !defined(_TRACE_CPUIDLE_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_CPUIDLE_H
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/tracepoint.h>
>> +
>> +extern atomic_t cpuidle_trace_seq;
>> +
>> +TRACE_EVENT(coupled_enter,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_exit,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_spin,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_unspin,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_safe_enter,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_safe_exit,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_idle_enter,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_idle_exit,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_abort,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_detected_abort,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_poke,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>> +
>> +TRACE_EVENT(coupled_poked,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int cpu),
>> +
>> + =A0 =A0 TP_ARGS(cpu),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field(unsigned int, seq)
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu =3D cpu;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->seq =3D atomic_inc_return(&cpuidle_tr=
ace_seq);
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("%u %u", __entry->seq, __entry->cpu)
>> +);
>
> Egad! Please use DECLARE_EVENT_CLASS() and DEFINE_EVENT() when adding
> events that are basically the same. Every TRACE_EVENT() can bloat the
> kernel by 5k, using the DEFINE_EVENT()s keeps each event around just a
> few hundred bytes.
>
> See include/trace/events/ext4.h for examples.

Thanks, I'll take a look.  There is no mention in Documentation/ or
samples/ of DECLARE_EVENT_CLASS() or DEFINE_EVENT(), nor any mention
of the cost of TRACE_EVENT().

Looking at the new power tracing code, I will also rework these events
to be more similar to the existing ones.

I suggest skipping this patch for 3.5, and I'll post an updated one for 3.6.
