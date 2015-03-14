From: Len Brown <lenb@kernel.org>
Subject: Re: cpufreq-info and acpi-cpufreq: reporting MSR_IA32_PERF_CTL as
 "actual frequency"
Date: Sat, 14 Mar 2015 13:18:55 -0400
Message-ID: <CAJvTdKk8yUeHzEE6G1KNyBi28-fSmVnPnkB6K4fn8U2jNa1Srw@mail.gmail.com>
References: <CAHOOexvOXKr4s-mg20VdUOAR3o7EN5iAS-ModAk6-vNKbhwT=g@mail.gmail.com>
	<5475F1EA.7020003@intel.com>
	<CAHOOexses3--hwcL5Mz=hnk+e1O32T8NXH=y+Se24-VXkWWAcw@mail.gmail.com>
	<3849711.qUm3dg8PlV@vostro.rjw.lan>
	<CAHOOextX=QK1-x7SbgKG9_zSUaZFLBX5FU5+iCFzJaqeJ7BYrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAHOOextX=QK1-x7SbgKG9_zSUaZFLBX5FU5+iCFzJaqeJ7BYrg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Magdalena Dobosz <maj.dobosz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, dirk.j.brandewie@intel.com, "cpufreq@vger.kernel.org" <CPUFREQ@vger.kernel.org>, Ross Lagerwall <rosslagerwall@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> {PERF_STATUS} can be already stale? Why is that?

Hello Magdalena,

Say two cores share a voltage domain.
core0 makes a P-state request via PERF_CTRL to run FAST.
core1 makes a P-state request via PERF_CTRL to run SLOW.
The hardware is responsible for programming the shared VR to
support the most demanding request -- FAST.  It does this,
and since it would be wasteful to have core1 run SLOW when
the VR supports FAST, core1 also runs fast.

Say core0 then goes idle.
The SLOW request on core1 may now be the most demanding VR request,
and so the VR is lowered, and core1 now runs SLOW.

Say PERF_STATUS is read on core1 before and after this transition.
One will read FAST, the other will read SLOW.  Which one is the
real frequency?

The problem is that they are *both* the real frequency, and *neither*
is the real frequency.  Indeed, the concept of instantaneous frequency
in  many scenarios is extremely mis-leading.

There are other scenarios related to turbo-mode and thermal control
that make instantaneous frequency even more mis-leading,
particularly since the frequency can change many times per second.
Thus, the OS itself, can't depend on PERF_STATUS for anything.

Requested frequency, however, does actually have *some* meaning.

Average frequency is generally more useful.
It requires is an accurate count of elapsed cycles
divided by a reliable measurement of elapsed time.
The problem with this is who decides the interval,
and what do you do if somebody wants an instantaneous answer?

The turbostat utility computes average frequency this in user-space,
of course.  intel_pstate can do it in-kernel because it is actually a
governor+driver, and so it runs periodically.

But if somebody wants to know the instantaneous frequency,
you have to ask why, and what they'll do with it...

> Anyway, cpufreq documentation is misleading:
> it says "cpuinfo_cur_freq: Current frequency of the CPU
> as obtained from the hardware, in KHz.
> This is the frequency the CPU actually runs at."

Yes, I see this in Documentation/cpu-freq/user-guide.txt

It was added by this commit: da470db16c703d7f9617c366a36c6670f89a9830
[CPUFREQ] update Doc for cpuinfo_cur_freq and scaling_cur_freq

Maybe it would have been a better idea to not update
that documentation, and instead leave these as vague?

> while the value is
> read from MSR_IA32_PERF_STATUS (or MSR_IA32_PERF_CTL
> in newer kernels).

Both of those are bugs.  The code that does this in acpi-cpufreq
should be replaced with code that reads no MSR, and simply
reutrns the last requested frequency (from memory).
I think I had a patch to remove all that current-frequency
cruft from the driver a while back -- perhaps time to revive it,
and to fix the documentation too.

thanks,
Len Brown, Intel Open Source Technology Center
