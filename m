From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [Update][PATCH v3 2/3] cpufreq: intel_pstate: Do not reinit performance limits in ->setpolicy
Date: Wed, 29 Mar 2017 15:01:17 -0700
Message-ID: <004101d2a8d7$ff31bb50$fd9531f0$@net>
References: <2694426.SgxlQuL17D@aspire.rjw.lan> <2326598.n0dkg1GrdM@aspire.rjw.lan> <2188688.SPioTUuSuO@aspire.rjw.lan> jZL3cbFe8sVy3jZL4c6fog
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: jZL3cbFe8sVy3jZL4c6fog
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Sorry for the delay, but I didn't notice until today that this
commit causes a regression, at least in my computer.

I have not figured out exactly what is wrong, as I must
admit I am finding these policy interactions difficult
to follow.

On 2017.03.02 14:29 Rafael J. Wysocki wrote:
>From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the current P-state selection algorithm is set to "performance"
> in intel_pstate_set_policy(), the limits may be initialized from

... [cut] ...

Going back to kernel 4.11-rc1 I get this after boot**:

$ uname -a
Linux s15 4.11.0-rc1-stock #217 SMP Sun Mar 5 15:34:38 PST 2017 x86_64 x86_64 x86_64 GNU/Linux

$ grep . /sys/devices/system/cpu/intel_pstate/*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100  <<< Correct
/sys/devices/system/cpu/intel_pstate/min_perf_pct:43   <<< Correct
/sys/devices/system/cpu/intel_pstate/no_turbo:0
/sys/devices/system/cpu/intel_pstate/num_pstates:23
/sys/devices/system/cpu/intel_pstate/status:active
/sys/devices/system/cpu/intel_pstate/turbo_pct:18

$ grep . /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
grep: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:3800000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:1600000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:4294967295
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:performance powersave
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1600805
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave  <<< Notice
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:3800000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1600000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>

$ sudo rdmsr --bitfield 15:8 -d -a 0x199 <<< Requested P-States
16
16
17
17
16
16
16
16

Going back to kernel 4.11-rc2 I get this after boot**:

~$ uname -a
Linux s15 4.11.0-rc2-stock #218 SMP Sun Mar 12 23:57:44 PDT 2017 x86_64 x86_64 x86_64 GNU/Linux

$ grep . /sys/devices/system/cpu/intel_pstate/*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100  <<< Correct
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100  <<< Incorrect
/sys/devices/system/cpu/intel_pstate/no_turbo:0
/sys/devices/system/cpu/intel_pstate/num_pstates:23
/sys/devices/system/cpu/intel_pstate/status:active
/sys/devices/system/cpu/intel_pstate/turbo_pct:18

$ grep . /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
grep: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:3800000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:1600000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:4294967295
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:performance powersave
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1600805
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave  <<< Notice
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:3800000  <<< Correct
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:3800000  <<< Incorrect
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>

$ sudo rdmsr --bitfield 15:8 -d -a 0x199  <<< Requested P-States
38   <<<< All are pinned, system is idle
38
38
38
38
38
38
38

**: After boot means > 1 minute after boot, because my distro (Ubtunu)
starts up using the performance governor and then changes to powersave
after 1 minute.

... Doug
