From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v4.8 cpufreq regression?
Date: Sat, 8 Oct 2016 01:59:25 +0300
Message-ID: <20161007225925.GI15204@raspberrypi.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm upgrading from v4.7 to v4.8 on MIPS/loongson2_cpufreq with
cpufreq/ondemand and I noticed that /proc/cpuinfo is always reporting
(regardless of system load):

BogoMIPS                : 697150.20

	and sysfs:

/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:797800
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:797800
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:199450
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:199450 299175 398900 498625 598350 698075 797800 
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand performance 
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:797800
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:loongson2
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:797800
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:199450
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

although previously they reported (when idle):

BogoMIPS                : 132.09

/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:199445 299167 398890 498612 598335 698057 797780 
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand performance 
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:loongson2
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

and under full load:

BogoMIPS                : 528.38

/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:199445 299167 398890 498612 598335 698057 797780 
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand performance 
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:loongson2
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:797780
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:199445
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>

The offeding commit (bisected) seems to be:

commit da0c6dc00c69d0adaae99c3b3d2ea0c869a3fb35
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon Jun 27 16:04:07 2016 +0530

    cpufreq: Handle sorted frequency tables more efficiently

Any ideas?

A.
