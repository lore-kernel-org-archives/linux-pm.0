From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct
 on governor switch
Date: Wed, 07 Oct 2015 05:59:56 -0400
Message-ID: <5614ED1C.8070709@redhat.com>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbbJGJ76 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 05:59:58 -0400
In-Reply-To: <002701d100cc$98cb8c60$ca62a520$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>



On 10/07/2015 02:51 AM, Doug Smythies wrote:

> 
> And before patch I get, using primitives and not cpupower:
> Executive Summary: Everything works fine (or at least as I thought it was supposed to).
> 
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
> ...
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:42
> root@s15:/home/doug/temp# echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
> root@s15:/home/doug/temp# echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:50
> root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance

The switch has to be from performance to powersave.  Switch again and you'll see
the problem.  I can also reproduce this without using 'cpupower'.

P.
