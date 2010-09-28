From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 28 Sep 2010 10:35:27 +0200
Message-ID: <AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt__23080.3337217823$1285663075$gmane$org@mail.gmail.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009180026.59482.trenn@suse.de>
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	<201009222049.18154.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009222049.18154.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

Here is what I am proposing, in reply to all your comments:

1) rename the events to match Thomas's proposal:
   power:power_cpu_cstate
   power:power_cpu_pstate
   power:power_cpu_sstate
   ...

2) introduce a new Kconfig option CONFIG_DEPRECATED_POWER_EVENTS and
conditionally map a subset of the new events to the old ones for
backward compatibility with the existing user apps. The apps should be
converted to the new API asap,

3) update documentation

Other remarks here below:

On Wed, Sep 22, 2010 at 8:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...
> This POWER_SSTATE thing seems to be totally artificial and omap-specific.
>
> Why do you want it to be done this way?
>
> Or is the ACPI handling added in the ACPI patch? =A0In which case, why do=
n't you
> put that power_switch_state(POWER_SSTATE, 1, 0, cpu) into
> kernel/power/suspend.c:suspend_enter() (and analogously for
> power_switch_state(POWER_SSTATE, 0, 0, cpu)).
The ACPI code is not using the SSTATE event.
Indeed inserting a tracepoint at
kernel/power/suspend.c:suspend_enter() is more generic. I will correct
this.

> Moreover, why is the cpu argument necessary for POWER_SSTATE at all?
The cpu_id parameter is present in all events prototypes. This is not
needed. I will correct this.

>
> Thanks,
> Rafael
>

A new patch should be ready in the coming days. I would like to have
your opinion on the proposed rework before re-doing it all again.

Thanks,
Jean
