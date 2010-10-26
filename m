From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 09:59:24 +0200
Message-ID: <AANLkTikf8QXwbmz6=Pv_onHOb3trUtaz1D5kmsHCPqy+__45705.4572100334$1288080085$gmane$org@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 26, 2010 at 1:33 AM, Thomas Renninger <trenn@suse.de> wrote:
> Changes in V2:
> =A0- Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
> =A0- Use u32 instead of u64 for cpuid, state which is by far enough
>
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
> =A0power:power_start
> =A0power:power_end
> are replaced with:
> =A0power:processor_idle
>
> and
> =A0power:power_frequency
> is replaced with:
> =A0power:processor_frequency
>
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.
This will come as a separate patch, which fits all platforms. Cf.
http://marc.info/?l=3Dlinux-omap&m=3D128620575300682&w=3D2.

...

> @@ -481,10 +484,12 @@ static void mwait_idle(void)
> =A0static void poll_idle(void)
> =A0{
> =A0 =A0 =A0 =A0trace_power_start(POWER_CSTATE, 0, smp_processor_id());
> +       trace_processor_idle(1, smp_processor_id());

Should that be:
+       trace_processor_idle(0, smp_processor_id());
instead?
Since state '0' is for the CPU active in polling mode and
PWR_EVENT_EXIT means 'exit from any idle state'.

> =A0 =A0 =A0 =A0local_irq_enable();
> =A0 =A0 =A0 =A0while (!need_resched())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> - =A0 =A0 =A0 trace_power_end(0);
> + =A0 =A0 =A0 trace_power_end(smp_processor_id());
> + =A0 =A0 =A0 trace_processor_idle(PWR_EVENT_EXIT, smp_processor_id());
> =A0}
>
> =A0/*

...

> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
...

Regards,
Jean
