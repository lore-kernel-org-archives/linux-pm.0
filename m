From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 4 Feb 2013 14:36:48 +0100
Message-ID: <20130204133648.GE13909@pd.tnic>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
 <5808458.pvV2iHpBWm@vostro.rjw.lan>
 <CAKohpok7RiJ_HKGi3r0vU26kNEtFKq==pMMoshT6Z2yy9ghemA@mail.gmail.com>
 <20130204123221.GA22340@pd.tnic>
 <CAKohpomcrtV3i9fL4zV6Mt0uDza-9pHTOsqTe2=C1t6mE6cpCQ@mail.gmail.com>
 <20130204130403.GD13909@pd.tnic>
 <CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37769 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab3BDNg7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 08:36:59 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com

On Mon, Feb 04, 2013 at 06:55:25PM +0530, Viresh Kumar wrote:
> That's not completely true. There lies cpufreq directory in cpu/cpu*/
> too, where we have per policy stuff in cpu/cpu*/, like policy tunable=
s
> and stats. And the same is true for governor too.

$ tree /sys/devices/system/cpu/cpu0/cpufreq/
/sys/devices/system/cpu/cpu0/cpufreq/
=E2=94=9C=E2=94=80=E2=94=80 affected_cpus
=E2=94=9C=E2=94=80=E2=94=80 bios_limit
=E2=94=9C=E2=94=80=E2=94=80 cpb
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_cur_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_max_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_min_freq
=E2=94=9C=E2=94=80=E2=94=80 cpuinfo_transition_latency
=E2=94=9C=E2=94=80=E2=94=80 related_cpus
=E2=94=9C=E2=94=80=E2=94=80 scaling_available_frequencies
=E2=94=9C=E2=94=80=E2=94=80 scaling_available_governors
=E2=94=9C=E2=94=80=E2=94=80 scaling_cur_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_driver
=E2=94=9C=E2=94=80=E2=94=80 scaling_governor
=E2=94=9C=E2=94=80=E2=94=80 scaling_max_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_min_freq
=E2=94=9C=E2=94=80=E2=94=80 scaling_setspeed
=E2=94=94=E2=94=80=E2=94=80 stats
    =E2=94=9C=E2=94=80=E2=94=80 time_in_state
    =E2=94=9C=E2=94=80=E2=94=80 total_trans
    =E2=94=94=E2=94=80=E2=94=80 trans_table

1 directory, 19 files

$ grep -r . /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/bios_limit:4000000
/sys/devices/system/cpu/cpu0/cpufreq/cpb:1
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1400000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:4000000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:1400000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:4000
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0 1
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:4000=
000 3400000 2800000 2100000 1400000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:powers=
ave userspace conservative ondemand perform
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1400000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:4000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1400000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state:4000000 308932=
8
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state:3400000 47448
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state:2800000 67185
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state:2100000 92731
/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state:1400000 114169=
14
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:         :   400=
0000   3400000   2800000   2100000   140000
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:  4000000:      =
   0     34756     46388     53179    21824
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:  3400000:     1=
2938         0      3755      3555     1450
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:  2800000:     1=
9940         0         0      4547     2565
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:  2100000:     1=
8523         0         0         0     4275
/sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table:  1400000:    30=
1168         0         0         0
/sys/devices/system/cpu/cpu0/cpufreq/stats/total_trans:799918

Show me the policy tunables here.

> That was slightly confusing to me :( The whole governor directory
> is per policy, i have to keep that in cpu/cpu*/cpufreq instead of
> cpu/cpufreq.

So make a /sys/devices/system/cpu/cpufreq/policies/ and add
functionality to assign cpus to policies or whatever the design of this
thing will be.

> Its not only for multicluster system, but a system where multiple cpu=
s
> have separate clock control and hence multiple policy structures.

What are those systems? Examples?

> Problem with this is it would fail for single image solutions on whic=
h
> everybody is working on. So, with multiple platforms compiled into a
> single image, this wouldn't work.

Single-image solutions will enable that config option and get built wit=
h
it - no problem at all.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
