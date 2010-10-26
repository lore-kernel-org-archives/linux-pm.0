From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 10:08:08 +0200
Message-ID: <AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2__3058.98748706586$1288080615$gmane$org@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101026071020.GC13036@elte.hu>
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
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-pm@vger.kernel.org

Ingo,

On Tue, Oct 26, 2010 at 9:10 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Thomas Renninger <trenn@suse.de> wrote:
>
>> Changes in V2:
>> =A0 - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>> =A0 - Use u32 instead of u64 for cpuid, state which is by far enough

...

>>
>> +#define PWR_EVENT_EXIT 0xFFFFFFFF
>
> Shouldnt this be part of the POWER_ enum? (and you can write -1 there)
>
>> +#ifndef _TRACE_POWER_ENUM_
>> +#define _TRACE_POWER_ENUM_
>> +enum {
>> + =A0 =A0 POWER_NONE =3D 0,
>> + =A0 =A0 POWER_CSTATE =3D 1,
>> + =A0 =A0 POWER_PSTATE =3D 2,
>> +};
>> +#endif
>
> Since we are cleaning up all these events, those enum definitions dont re=
ally look
> logical. For example, what is 'POWER_NONE'? Can a CPU have 'no power'?
The enum belongs to the deprecated API so I would rather not touch it.
Keeping the deprecated code isolated will make it easier to remove
later.

>
> Plus:
>
>> +DECLARE_EVENT_CLASS(processor,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state, unsigned int cpu_id),
>> +
>> + =A0 =A0 TP_ARGS(state, cpu_id),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0 =
=A0 =A0state =A0 =A0 =A0 =A0 =A0 )
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0 =
=A0 =A0cpu_id =A0 =A0 =A0 =A0 =A0)
>
> Trace entries can carry a cpu_id of the current processor already. Can th=
is cpu_id
> ever be different from that CPU id?
I have no evidence of that (powr mgt on SMP ARM is coming real
soon...) but one can imagine one of the CPUs being the master for PM
decisions.

>
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->state =3D state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu_id =3D cpu_id;
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("state=3D%lu cpu_id=3D%lu", (unsigned long)__entry->=
state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)__entry->cpu_id)
>> +);
>> +
>> +DEFINE_EVENT(processor, processor_idle,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state, unsigned int cpu_id),
>> +
>> + =A0 =A0 =A0 =A0 =A0TP_ARGS(state, cpu_id)
>> +);
>> +
>> +#define PWR_EVENT_EXIT 0xFFFFFFFF
>> +
>> +DEFINE_EVENT(processor, processor_frequency,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int frequency, unsigned int cpu_id),
>> +
>> + =A0 =A0 TP_ARGS(frequency, cpu_id)
>> +);
>
> So, we have a 'state' field in the class, which is used as 'state' by the
> power::cpu_idle event, and as 'frequency' by the power::cpu_freq event?
>
> Are there any architectures that track frequency in Hz, not in kHz? If ye=
s, might
> there ever be a need for the frequency value to be larger than 4.29 GHz? =
If yes,
> then it wont fit into u32.
>
> Also, might there be a future need to express different types of frequenc=
ies? For
> example, should we decide to track turbo frequencies in Intel CPUs, how w=
ould that
> be expressed via these events? Are there any architectures and CPUs that =
somehow
> have some extra attribute to the frequency value?
>
>> +TRACE_EVENT(machine_suspend,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state),
>> +
>> + =A0 =A0 TP_ARGS(state),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0 =
=A0 =A0state =A0 =A0 =A0 =A0 =A0 )
>> + =A0 =A0 ),
>
> Hm, this event is not used anywhere in the submitted patches. Where is th=
e patch
> that adds usage, and what are the possible values for 'state'?
This will come as a separate patch, which fits all platforms. Cf.
http://marc.info/?l=3Dlinux-omap&m=3D128620575300682&w=3D2.
The state field is of type suspend_state_t, cf. include/linux/suspend.h
>
> =A0 =A0 =A0 =A0Ingo
>

Jean
