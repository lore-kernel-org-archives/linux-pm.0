From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Wed, 7 Oct 2015 07:04:20 -0700
Message-ID: <000001d10109$10d34630$3279d290$@net>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net> <5614ED1C.8070709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta15.telus.net ([209.171.16.88]:51276 "EHLO cmta15.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbbJGOEW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 10:04:22 -0400
In-Reply-To: <5614ED1C.8070709@redhat.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Prarit Bhargava' <prarit@redhat.com>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>


On 2015.10.07 03:00 Prarit Bhargava wrote:
> On 10/07/2015 02:51 AM, Doug Smythies wrote:
>> 
>> And before patch I get, using primitives and not cpupower:
>> Executive Summary: Everything works fine (or at least as I thought it was supposed to).
>> 
>> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
>> ...
>> /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
>> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:42
>> root@s15:/home/doug/temp# echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>> root@s15:/home/doug/temp# echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
>> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:50
>> root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done
>> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
>> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
>
> The switch has to be from performance to powersave.  Switch again and you'll see
> the problem.

Yes, of course, and I did.
The first "powersave" listing was just to show the setup.
Continue reading my original reply, also added back below:
The "..." stuff is just where I deleted 6 of the 8 CPUs saying the same thing.

root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:performance
root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "powersave" > $file; done
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50

> I can also reproduce this without using 'cpupower'.

Interesting. Then maybe it is a difference between legacy mode
and Hardware P state (HWP) mode. I do not have an HWP capable processor
to test.

I compiled cpupower, but get the same results as I get using primitives,
meaning things work properly before the patch and resort to defaults
after the patch.


