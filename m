From: Len Brown <lenb@kernel.org>
Subject: RFC: /sys/power/policy_preference
Date: Wed, 16 Jun 2010 17:05:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Create /sys/power/policy_preference, giving user-space
the ability to express its preference for kernel based
power vs. performance decisions in a single place.

This gives kernel sub-systems and drivers a central place
to discover this system-wide policy preference.
It also allows user-space to not have to be updated
every time a sub-system or driver adds a new power/perf knob.

policy_preference has 5 levels, from max_performance
through max_powersave.  Here is how 4 parts of the kernel
might respond to those 5 levels:

max_performance (unwilling to sacrifice any performance)
	scheduler: default (optimized for performance)
	cpuidle: disable all C-states except polling mode
	ondemand: disable all P-states except max perf
	msr_ia32_energy_perf_bias: 0 of 15

performance (care primarily about performance)
	scheduler: default (optimized for performance)
	cpuidle: enable all C-states subject to QOS
	ondemand: all P-states, using no bias
	msr_ia32_energy_perf_bias: 3 of 15

balanced (default)
	scheduler: enable sched_mc_power_savings
	cpuidle: enable all C-states subject to QOS
	ondemand: all P-states, powersave_bias=5
	msr_ia32_energy_perf_bias: 7 of 15

powersave (can sacrifice measurable performance)
	scheduler: enable sched_smt_power_savings
	cpuidle: enable all C-states, subject to QOS
	ondemand: disable turbo mode, powersave_bias=10
	msr_ia32_energy_perf_bias: 11 of 15

max_powersave (can sacrifice significant performance)
	scheduler: enable sched_smt_power_savings
	cpuidle: enable all C-states, subject to QOS
	ondemand: min P-state (do not invoke T-states)
	msr_ia32_energy_perf_bias: 15 of 15

Note that today Linux is typically operating in the mode
called "performance" above, rather than "balanced",
which is proposed to be the default.  While a system
should work well if left in "balanced" mode, it is likely
that some users would want to use "powersave" when on
battery and perhaps shift to "performance" on A/C.

Please let me know what you think.

thanks,
Len Brown, Intel Open Source Technology Center
