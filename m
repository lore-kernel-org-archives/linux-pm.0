From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 28 Sep 2010 23:43:55 +0200
Message-ID: <AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc__43357.6619405814$1285710285$gmane$org@mail.gmail.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009222049.18154.rjw@sisk.pl>
	<AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009282322.16291.rjw@sisk.pl>
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

On Tue, Sep 28, 2010 at 11:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, September 28, 2010, Jean Pihet wrote:
>> Hi,
>
> Hi,
>
>> Here is what I am proposing, in reply to all your comments:
>>
>> 1) rename the events to match Thomas's proposal:
>> =A0 =A0power:power_cpu_cstate
>> =A0 =A0power:power_cpu_pstate
>> =A0 =A0power:power_cpu_sstate
>
> If that sstate thing is going to mean "suspend", then please drop it.
> "Suspend" is not a state, let alone a CPU state. =A0It is a procedure by =
which
> the (entire) system is put into a sleep state (that is not confined to CP=
Us).

Since suspend is tied to the power management of the system, is it ok
to rename it to e.g. power:system_suspend?

>
>> =A0 =A0...
>>
>> 2) introduce a new Kconfig option CONFIG_DEPRECATED_POWER_EVENTS and
>> conditionally map a subset of the new events to the old ones for
>> backward compatibility with the existing user apps. The apps should be
>> converted to the new API asap,
>>
>> 3) update documentation
>
> Sounds reasonable.
OK

>
>> Other remarks here below:
>>
>> On Wed, Sep 22, 2010 at 8:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> ...
>> > This POWER_SSTATE thing seems to be totally artificial and omap-specif=
ic.
>> >
>> > Why do you want it to be done this way?
>> >
>> > Or is the ACPI handling added in the ACPI patch? =A0In which case, why=
 don't you
>> > put that power_switch_state(POWER_SSTATE, 1, 0, cpu) into
>> > kernel/power/suspend.c:suspend_enter() (and analogously for
>> > power_switch_state(POWER_SSTATE, 0, 0, cpu)).
>> The ACPI code is not using the SSTATE event.
>> Indeed inserting a tracepoint at
>> kernel/power/suspend.c:suspend_enter() is more generic. I will correct
>> this.
>
> OK
>
>> > Moreover, why is the cpu argument necessary for POWER_SSTATE at all?
>> The cpu_id parameter is present in all events prototypes. This is not
>> needed. I will correct this.
>
> OK
>
> Thanks,
> Rafael
>

Thanks,
Jean
