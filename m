From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][Update][PATCH v2 2/2] PM / QoS: Fix device resume latency framework
Date: Tue, 07 Nov 2017 02:07:58 +0100
Message-ID: <2253893.iYce5Lnvnl@aspire.rjw.lan>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <24760503.0xEJ3726B9@aspire.rjw.lan> <cba84d75-e30c-db30-2bf9-f493e7a1a568@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cba84d75-e30c-db30-2bf9-f493e7a1a568@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 6, 2017 6:47:35 PM CET Reinette Chatre wrote:
> Hi Rafael,
> 
> On 11/4/2017 5:34 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The special value of 0 for device resume latency PM QoS means
> > "no restriction", but there are two problems with that.
> > 
> > First, device resume latency PM QoS requests with 0 as the
> > value are always put in front of requests with positive
> > values in the priority lists used internally by the PM QoS
> > framework, causing 0 to be chosen as an effective constraint
> > value.  However, that 0 is then interpreted as "no restriction"
> > effectively overriding the other requests with specific
> > restrictions which is incorrect.
> > 
> > Second, the users of device resume latency PM QoS have no
> > way to specify that *any* resume latency at all should be
> > avoided, which is an artificial limitation in general.
> > 
> > To address these issues, modify device resume latency PM QoS to
> > use S32_MAX as the "no constraint" value and 0 as the "no
> > latency at all" one and rework its users (the cpuidle menu
> > governor, the genpd QoS governor and the runtime PM framework)
> > to follow these changes.
> > 
> > Also add a special "n/a" value to the corresponding user space I/F
> > to allow user space to indicate that it cannot accept any resume
> > latencies at all for the given device.
> > 
> > Fixes: 85dc0b8a4019 (PM / QoS: Make it possible to expose PM QoS latency constraints)
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
> > Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Ramesh Thomas <ramesh.thomas@intel.com>
> > ---
> > 
> > Re-sending as an update rather than as v3, because the update is very minor
> > (an additional check under the WARN_ON() in apply_constraint()).
> > 
> > Reinette, please test this one instead of the last version.  The WARN_ON()
> > issue should be gone with this.
> > 
> 
> I tested this update of the v2 2/2 patch with v2 of 1/2 but please note as captured below that I am testing with the menu governor, so not testing 1/2 if I understand correctly.
> 
> I just repeated the test I ran against the original patch that was merged, with some details added. I hope that it has some value to you considering that it did not catch all issues the first time :(
> 
> I tested on an Intel(R) NUC NUC6CAYS (Apollo Lake with a Goldmont cpu). As you maybe know it has some issues with monitor/mwait, so acpi_idle is used:
> # grep . /sys/devices/system/cpu/cpuidle/current_*
> /sys/devices/system/cpu/cpuidle/current_driver:acpi_idle
> /sys/devices/system/cpu/cpuidle/current_governor_ro:menu
> 
> As with your original patch I still see the new behavior on boot:
>        swapper/0-1     [000] ....     0.347284: dev_pm_qos_add_request: device=cpu0 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
>        swapper/0-1     [000] ....     0.347300: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
>        swapper/0-1     [000] ....     0.347533: dev_pm_qos_add_request: device=cpu1 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
>        swapper/0-1     [000] ....     0.347536: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
>        swapper/0-1     [000] ....     0.347741: dev_pm_qos_add_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
>        swapper/0-1     [000] ....     0.347743: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
>        swapper/0-1     [000] ....     0.347958: dev_pm_qos_add_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=2147483647
>        swapper/0-1     [000] ....     0.347961: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=2147483647
> 
> Even though the default latency required values on boot are much higher, the user API still shows zero:
> # grep . /sys/devices/system/cpu/cpu?/power/pm_qos_resume_latency_us
> /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu1/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu2/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu3/power/pm_qos_resume_latency_us:0
> 
> At this time when I run turbostat I observe that more than 99% of time is spent in C6 as reported by the actual hardware counters (the CPU%c6 value). I also see that the requested value is more than 99% for C3.
> 
> In my code the dev_pm_qos_add_request() API is used to request a new latency requirement of 30 usec (this previously failed) from core #2 and #3. I run my code with tracing enabled while also running turbostat. Tracing now shows me a successful request:
> 
>            runit-505   [003] ....   393.656679: dev_pm_qos_add_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=30
>            runit-505   [003] ....   393.656700: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=30
>            runit-505   [003] ....   393.656705: dev_pm_qos_add_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=30
>            runit-505   [003] ....   393.656707: pm_qos_update_target: action=ADD_REQ prev_value=2147483647 curr_value=30
> 
> Turbostat also reflects this with cores 2 and 3 now reporting more than 99% in their CPU%c1 and C1% columns.
> 
> User API still shows:
> # grep . /sys/devices/system/cpu/cpu?/power/pm_qos_resume_latency_us
> /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu1/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu2/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu3/power/pm_qos_resume_latency_us:0
> 
> Next I use dev_pm_qos_remove_request() to remove the previous latency requirement (again with tracing and turbostat running).
> 
>            rmdir-665   [002] ....   686.925230: dev_pm_qos_remove_request: device=cpu3 type=DEV_PM_QOS_RESUME_LATENCY new_value=-1
>            rmdir-665   [002] ....   686.925250: pm_qos_update_target: action=REMOVE_REQ prev_value=30 curr_value=2147483647
>            rmdir-665   [002] ....   686.925254: dev_pm_qos_remove_request: device=cpu2 type=DEV_PM_QOS_RESUME_LATENCY new_value=-1
>            rmdir-665   [002] ....   686.925257: pm_qos_update_target: action=REMOVE_REQ prev_value=30 curr_value=2147483647
> 
> Turbostat also shows that cores 2 and 3 return to their high residency in C6.
> 
> As before, user API shows:
> # grep . /sys/devices/system/cpu/cpu?/power/pm_qos_resume_latency_us
> /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu1/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu2/power/pm_qos_resume_latency_us:0
> /sys/devices/system/cpu/cpu3/power/pm_qos_resume_latency_us:0
> 
> 
> Thank you very much for making this work!
> 
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

Rafael
