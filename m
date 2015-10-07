From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Wed, 7 Oct 2015 11:52:42 -0700
Message-ID: <000f01d10131$59c67a60$0d536f20$@net>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan> <002701d100cc$98cb8c60$ca62a520$@net> <5614ED1C.8070709@redhat.com> <000001d10109$10d34630$3279d290$@net> <561527D9.3020009@redhat.com> <000301d10116$88852330$998f6990$@net> <56153E55.3060306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta13.telus.net ([209.171.16.86]:45568 "EHLO cmta13.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbbJGSwp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 14:52:45 -0400
In-Reply-To: <56153E55.3060306@redhat.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Prarit Bhargava' <prarit@redhat.com>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>

On 2015.10.07 08:46 Prarit Bhargava wrote:
> On 10/07/2015 11:40 AM, Doug Smythies wrote:
>> 
>> Do we agree or disagree that the root issue seems to be (from your test)?:
>> 
>> \#  echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>> 
>> [   21.483436] store_min_perf_pct[453] min_sysfs_pct = 100
>> [   21.489373] store_min_perf_pct[456] min_perf_pct = 100
>> [   21.495203] store_min_perf_pct[459] min_perf_pct = 100
>> [   21.501050] store_min_perf_pct[462] min_perf_pct = 100
>
> Yep, and it appears to be done by default in Fedora & RHEL :/ ... the issue is
> still the same IMO that min_sysfs_pct & max_sysfs_pct are not cleared on a
> governor switch.

Clearing them will break some other things. For example, and as
shown in my original reply, resume from suspend.

Why? Because, at least on my computer, the governor is changed to
"performance" during suspend, and the "powersave" governor is
restored sometime during resume. The users wants the settings they had
before the suspend.

Continuing with that printk debug kernel from earlier:

pm-suspend:

[12599.912028] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.913781] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.915343] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.916877] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.918444] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.919686] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.920932] intel_pstate_set_policy[1001] min_perf_pct = 100
[12599.922191] intel_pstate_set_policy[1001] min_perf_pct = 100

Then push the power button, i.e. resume:

[12609.953358] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.953360] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.953361] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.953796] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.953797] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.953798] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.954209] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.954210] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.954211] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.954619] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.954620] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.954621] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.955028] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.955029] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.955030] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.955431] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.955432] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.955433] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.955833] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.955834] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.955835] intel_pstate_set_policy[1028] min_perf_pct = 50
[12609.956234] intel_pstate_set_policy[1020] min_perf_pct = 50
[12609.956235] intel_pstate_set_policy[1023] min_perf_pct = 50
[12609.956235] intel_pstate_set_policy[1028] min_perf_pct = 50

The below is copied from my original reply:

Before Patch, I get:

root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50
root@s15:/home/doug/temp# pm-suspend
...
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50

After Patch, I get:

root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50
root@s15:/home/doug/temp# pm-suspend
...
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42


