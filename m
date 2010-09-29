From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 29 Sep 2010 09:49:33 +0200
Message-ID: <201009290949.34245.trenn__17569.102618336$1285746653$gmane$org@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl> <4CA261F4.5070803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA261F4.5070803@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 28 September 2010 23:45:24 Arjan van de Ven wrote:
>   On 9/28/2010 2:22 PM, Rafael J. Wysocki wrote:
> > On Tuesday, September 28, 2010, Jean Pihet wrote:
> >> Hi,
> > Hi,
> >
> >> Here is what I am proposing, in reply to all your comments:
> >>
> >> 1) rename the events to match Thomas's proposal:
> >>     power:power_cpu_cstate
> >>     power:power_cpu_pstate
> >>     power:power_cpu_sstate
I'd not name it that X86/ACPI specific.
    power:processor_sleep
    power:processor_frequency
    power:system_suspend
This would map with X86/ACPI c/p/s states but the name would
also match fine with ARM and other archs.

> > If that sstate thing is going to mean "suspend", then please drop
> > it.
> > "Suspend" is not a state, let alone a CPU state.  It is a procedure
> > by which the (entire) system is put into a sleep state (that is not
> > confined to CPUs).
> 
> there are also non-suspend S states, like S0i1 and S0i3 (supported in 
> the current Intel "Moorestown" platform)
> 
> so it's slightly more complex than "just" suspend :)
Something specific for this arch could get introduced, similar as
Jean did for the ARM specifics, e.g.:
power:moorestown_suspend
Intel probably invented three names for this new technique, one
might fit as an event name?
Depending whether extra info needs passed through this event it
could also use
    power:system_suspend
and pass a suspend state of #define S0i1 0x100, #define S0i2 0x101...

I try to find time to come up with another cleanup patch.
I also want to look at perf timechart then where I remember some ugly
hacks with C-state accounting and the broken state_start, state_end and 
frequency_switch events. Hope it won't get too ugly and perf timechart 
can support both, the old and the cleaned up events for a while.

    Thomas
