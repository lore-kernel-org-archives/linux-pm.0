From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 14:40:37 +0530
Message-ID: <20161104091037.GD3414@vireshk-i7>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104085830.GA4089@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

I am really confused about where the problem is. 4.8 or 4.9 ? :)

On 04-11-16, 09:58, Pavel Machek wrote:
> On Fri 2016-11-04 09:38:49, Pavel Machek wrote:
> > Hi!
> > 
> > I'm debugging overheats on v4.9-rc1... which did not seem to happen in
> > v4.8-rc1. I'm running basically "nice make -j 3" on kernel... cpus are
> > fully loaded. 
> > 
> > %Cpu(s):  7.5 us, 18.5 sy, 72.6 ni,  0.0 id,  0.0 wa,  0.0 hi,  1.5
> > si,  0.0 st
> > KiB Mem:   3087096 total,  2993076 used,    94020 free,    52900
> > buffers
> > KiB Swap:  1681428 total,    60900 used,  1620528 free.  1183664
> > cached Mem
> > 
> > Still, cpus don't stay on maximum frequency on v4.8-rc1. (I suspect
> > that may be why machine does not overheat).
> 
> What is worse, they go to low frequency even with "performance"
> governor on v4.8-rc1?!

You sure about it? How did you check it?

Also why are you testing on 4.8-rc1? And not a 4.8 stable kernel? What if the
core is already fixed upstream ?

There is one core fix in 4.8:

commit 899bb6642f2a ("cpufreq: skip invalid entries when searching the
frequency")

> pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$ sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
> 1000000
> 1000000
> 1000000
> 1000000
> 1833000
> 1833000
> 1000000
> 1000000
> 1833000
> 1833000
> 1000000
> 1000000

Is this happening because of thermal capping ? That is the only reason that I
could think of where freq can change with performance governor.

> pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$ grep -i
> . /sys/devices/system/cpu/cpu0/cpufreq/*
> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
> /sys/devices/system/cpu/cpu0/cpufreq/bios_limit:1000000
> grep: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:
> Permission denied
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1833000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:1000000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:10000
> /sys/devices/system/cpu/cpu0/cpufreq/freqdomain_cpus:0 1
> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:1833000
> 1333000 1000000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:conservative
> powersave schedutil ondemand performance
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1000000

And this value sort of confirms it.

> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1000000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory
> pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$
> 
> Let me try v4.9-rc2... that works ok (cpus at the high frequency
> during the kernel build). Unfortunately that sends my cpus to 99C
> temperature range (and eventually forces emergency shutdown).

Unbelievable.

> v4.9-rc2, current policy changes without me touching it. Notice the
> 1.47GHz below? I did not do that, it oscilates itself. Is that thermal
> protection? 

Looks like to me.

Can we verify somehow about what's the situation should look like? Perhaps with
some older stable kernel? And then see if 4.8.X works fine or 4.9-rc.

-- 
viresh
