From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct
 on governor switch
Date: Wed, 07 Oct 2015 17:31:25 -0400
Message-ID: <56158F2D.50200@redhat.com>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net> <5614ED1C.8070709@redhat.com> <000001d10109$10d34630$3279d290$@net> <561527D9.3020009@redhat.com> <000301d10116$88852330$998f6990$@net> <56153E55.3060306@redhat.com> <000f01d10131$59c67a60$0d536f20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697AbbJGVb0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 17:31:26 -0400
In-Reply-To: <000f01d10131$59c67a60$0d536f20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>



On 10/07/2015 02:52 PM, Doug Smythies wrote:
> On 2015.10.07 08:46 Prarit Bhargava wrote:
>> On 10/07/2015 11:40 AM, Doug Smythies wrote:
>>>
>>> Do we agree or disagree that the root issue seems to be (from your test)?:
>>>
>>> \#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>>
>>> [   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
>>> [   21.489373] store_min_perf_pct[456] min_perf_pct = 100
>>> [   21.495203] store_min_perf_pct[459] min_perf_pct = 100
>>> [   21.501050] store_min_perf_pct[462] min_perf_pct = 100
>>
>> Yep, and it appears to be done by default in Fedora & RHEL :/ ... the issue is
>> still the same IMO that min_sysfs_pct & max_sysfs_pct are not cleared on a
>> governor switch.
> 
> Clearing them will break some other things. For example, and as
> shown in my original reply, resume from suspend.
> 
> Why? Because, at least on my computer, the governor is changed to
> "performance" during suspend, and the "powersave" governor is
> restored sometime during resume. The users wants the settings they had
> before the suspend.
> 

Looking at this in more detail after having tested on a Intel(R) Core(TM)
i7-2600 CPU @ 3.40GHz in Fedora and RHEL.

I have a feeling that the switch you're seeing (poweersave->performance, suspend
... resume, performance->powersave) is occurring in userspace, and not as a
result of the kernel.  IMO if userspace changes the governor, all bets are off
on maintaining max_sysfs_pct and min_sysfs_pct.

Here's something I cannot figure out (because I do not have an Ubuntu install).
 *Why* is Ubuntu making the governor switch during suspend/resume?  Is it
because of archaic brokeness they were trying to paper over?

> Continuing with that printk debug kernel from earlier:
> 
> pm-suspend:
> 
> [12599.912028] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.913781] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.915343] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.916877] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.918444] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.919686] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.920932] intel_pstate_set_policy[1001] min_perf_pct = 100
> [12599.922191] intel_pstate_set_policy[1001] min_perf_pct = 100
> 
> Then push the power button, i.e. resume:
> 
> [12609.953358] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.953360] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.953361] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.953796] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.953797] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.953798] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.954209] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.954210] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.954211] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.954619] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.954620] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.954621] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.955028] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.955029] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.955030] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.955431] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.955432] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.955433] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.955833] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.955834] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.955835] intel_pstate_set_policy[1028] min_perf_pct = 50
> [12609.956234] intel_pstate_set_policy[1020] min_perf_pct = 50
> [12609.956235] intel_pstate_set_policy[1023] min_perf_pct = 50
> [12609.956235] intel_pstate_set_policy[1028] min_perf_pct = 50
> 
> The below is copied from my original reply:
> 
> Before Patch, I get:
> 
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:50
> root@s15:/home/doug/temp# pm-suspend
> ...
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:50
> 
> After Patch, I get:
> 
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:50
> root@s15:/home/doug/temp# pm-suspend
> ...
> root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:42

Here's what I get after the patch (again, on Fedora which appears to let the
kernel do it's thing during suspend/resume) on the same processor you are using
(a Sandybridge, Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz), and using the
powersave governor,

[root@intel-skylake-y-01 ~]# cpupower frequency-info
analyzing CPU 0:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 0.97 ms.
  hardware limits: 400 MHz - 2.70 GHz
  available cpufreq governors: performance, powersave
  current policy: frequency should be within 400 MHz and 2.70 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency is 800 MHz (asserted by call to hardware).
  boost state support:
    Supported: yes
    Active: yes


[root@intel-skylake-y-01 ~]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
100
14
[root@intel-skylake-y-01 ~]# echo devices > /sys/power/pm_test; echo platform >
/sys/power/disk; sleep 1; echo disk > /sys/power/state
[root@intel-skylake-y-01 ~]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
100
14

Even if I manually change the max & min,

[root@intel-skylake-y-01 ~]# echo 80 >
/sys/devices/system/cpu/intel_pstate/max_perf_pct
[root@intel-skylake-y-01 ~]# echo 50 >
/sys/devices/system/cpu/intel_pstate/min_perf_pct
[root@intel-skylake-y-01 ~]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
80
50
[root@intel-skylake-y-01 ~]# echo devices > /sys/power/pm_test; echo platform >
/sys/power/disk; sleep 1; echo disk > /sys/power/state
[root@intel-skylake-y-01 ~]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
80
50
[root@intel-skylake-y-01 ~]#

Everything works.  It doesn't work on Ubuntu because userspace is doing
something weird.  Let's figure out why that is -- anyone know who works on s/r @
Ubuntu?

P.
> 
> 
