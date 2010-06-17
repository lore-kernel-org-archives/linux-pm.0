From: Mike Chan <mike@android.com>
Subject: Re: RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 13:48:11 -0700
Message-ID: <AANLkTilkblF0tfSnvLdVZVOi0r-dc32uAMuaiUlKesdn@mail.gmail.com>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 16, 2010 at 2:05 PM, Len Brown <lenb@kernel.org> wrote:
> Create /sys/power/policy_preference, giving user-space
> the ability to express its preference for kernel based
> power vs. performance decisions in a single place.
>
> This gives kernel sub-systems and drivers a central place
> to discover this system-wide policy preference.
> It also allows user-space to not have to be updated
> every time a sub-system or driver adds a new power/perf knob.
>

This might be ok as a convince feature for userspace, but if that is
the sole intention, is 5 states enough? Are these values sufficient? I
can say at least for Android this will probably won't be as useful
(but perhaps on your platforms it makes sense).

As for a place for subsystems and drivers to check for what
performance mode you're in, do my driver how to check two places now?
Whats stopping someone from overriding cpufreq, or cpuidle? I might be
confused here (if I am someone please correct me) but isn't this
somewhat along he lines of pm runtime / pm qos if drivers want to
check what power / performance state the system is in?

-- Mike

> policy_preference has 5 levels, from max_performance
> through max_powersave. =A0Here is how 4 parts of the kernel
> might respond to those 5 levels:
>
> max_performance (unwilling to sacrifice any performance)
> =A0 =A0 =A0 =A0scheduler: default (optimized for performance)
> =A0 =A0 =A0 =A0cpuidle: disable all C-states except polling mode
> =A0 =A0 =A0 =A0ondemand: disable all P-states except max perf
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 0 of 15
>
> performance (care primarily about performance)
> =A0 =A0 =A0 =A0scheduler: default (optimized for performance)
> =A0 =A0 =A0 =A0cpuidle: enable all C-states subject to QOS
> =A0 =A0 =A0 =A0ondemand: all P-states, using no bias
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 3 of 15
>
> balanced (default)
> =A0 =A0 =A0 =A0scheduler: enable sched_mc_power_savings
> =A0 =A0 =A0 =A0cpuidle: enable all C-states subject to QOS
> =A0 =A0 =A0 =A0ondemand: all P-states, powersave_bias=3D5
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 7 of 15
>
> powersave (can sacrifice measurable performance)
> =A0 =A0 =A0 =A0scheduler: enable sched_smt_power_savings
> =A0 =A0 =A0 =A0cpuidle: enable all C-states, subject to QOS
> =A0 =A0 =A0 =A0ondemand: disable turbo mode, powersave_bias=3D10
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 11 of 15
>
> max_powersave (can sacrifice significant performance)
> =A0 =A0 =A0 =A0scheduler: enable sched_smt_power_savings
> =A0 =A0 =A0 =A0cpuidle: enable all C-states, subject to QOS
> =A0 =A0 =A0 =A0ondemand: min P-state (do not invoke T-states)
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 15 of 15
>
> Note that today Linux is typically operating in the mode
> called "performance" above, rather than "balanced",
> which is proposed to be the default. =A0While a system
> should work well if left in "balanced" mode, it is likely
> that some users would want to use "powersave" when on
> battery and perhaps shift to "performance" on A/C.
>
> Please let me know what you think.
>
> thanks,
> Len Brown, Intel Open Source Technology Center
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
