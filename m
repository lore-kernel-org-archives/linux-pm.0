From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, intel_pstate, set max_sysfs_pct and min_sysfs_pct on governor switch
Date: Tue, 6 Oct 2015 23:51:28 -0700
Message-ID: <002701d100cc$98cb8c60$ca62a520$@net>
References: <1444168147-17812-1-git-send-email-prarit@redhat.com> <1755198.JNkaHg87IV@vostro.rjw.lan> <1594304.lVcRDcB3yL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:33673 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbbJGGvb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 02:51:31 -0400
In-Reply-To: <1594304.lVcRDcB3yL@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Prarit Bhargava' <prarit@redhat.com>
Cc: 'Kristen Carlson Accardi' <kristen@linux.intel.com>, linux-kernel@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>


On 2015.09.06 16:48 Rafael J. Wysocki wrote:
> On Wednesday, October 07, 2015 12:43:55 AM Rafael J. Wysocki wrote:
>> On Tuesday, October 06, 2015 05:49:07 PM Prarit Bhargava wrote:
>>> Intel CPUs will not enter higher p-states when after switching from the
>>> performance governor to the powersave governor, until
>>> /sys/devices/system/cpu/intel_pstate/min_perf_pct is set to a low value.

It works properly for me.

Isn't the root issue here an incompatibility between
tools/power/cpupower/utils/cpufreq-set.c and
drivers/cpufreq/intel_pstate.c?
(see experiment results below, where I do not use "cpupower")

I am not familiar with tools/power/cpupower/utils/cpufreq-set.c, but will
look at it more tomorrow.

>>> This differs from previous behaviour in which a switch to the powersave
>>> governor would result in a low default value for min_perf_pct.
>>> 
>>> The behavior of the powersave governor changed after commit a04759924e25
>>> ("[cpufreq] intel_pstate: honor user space min_perf_pct override on
>>> resume").  The commit introduced tracking of performance percentage
>>> changes via sysfs in order to restore userspace changes during
>>> suspend/resume.  The problem occurs because the global values of the newly
>>> introduced max_sysfs_pct and min_sysfs_pct are not reset on a governor
>>> change and this causes the new governor to inherit the previous governor's
>>> settings.
>>> 
>>> This patch sets max_sysfs_pct to 100 and min_sysfs_pct to 0 on a governor
>>> change which fixes the problem with governor switching.  These changes
>>> also make the initial calculations for max_perf_pct and min_perf_pct
>>> slightly simpler.
>>> 
>>> Before patch:
>>> [root@intel-skylake-y-01 power]# cpupower frequency-set -g performance
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>> 100
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
>>> 100
>>> [root@intel-skylake-y-01 power]# cpupower frequency-set -g powersave
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>> 100
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
>>> 100

And before patch I get, using primitives and not cpupower:
Executive Summary: Everything works fine (or at least as I thought it was supposed to).

root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42
root@s15:/home/doug/temp# echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
root@s15:/home/doug/temp# echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50
root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done
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

>>> 
>>> After patch:
>>> [root@intel-skylake-y-01 power]# cpupower frequency-set -g performance
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>> 100
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
>>> 100
>>> [root@intel-skylake-y-01 power]# cpupower frequency-set -g powersave
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>> 14
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
>>> 100
>>> 

And after the patch I get, using primitives and not cpupower:
Executive Summary: Settings go back to default, and user settings are lost.
This is not how I thought things were supposed to behave, but I'm not actually sure.

root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42
root@s15:/home/doug/temp# echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
root@s15:/home/doug/temp# echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:80
/sys/devices/system/cpu/intel_pstate/min_perf_pct:50
root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:performance
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100
root@s15:/home/doug/temp# for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "powersave" > $file; done
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
...
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
root@s15:/home/doug/temp# grep . /sys/devices/system/cpu/intel_pstate/*_perf_*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42

>>> Also note that I have tested suspend/resume (using CONFIG_PM_DEBUG):
>>> [root@intel-skylake-y-01 power]# echo 50 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
>>> 100
>>> 50
>>> [root@intel-skylake-y-01 power]# echo devices > /sys/power/pm_test
>>> [root@intel-skylake-y-01 power]# echo platform > /sys/power/disk
>>> [root@intel-skylake-y-01 power]# echo disk > /sys/power/state
>>> [root@intel-skylake-y-01 power]# cat /sys/devices/system/cpu/intel_pstate/*_perf_pct
>>> 100
>>> 50

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

>>> 
>>> Fixes: a04759924e25 ("[cpufreq] intel_pstate: honor user space min_perf_pct override on resume")
>>> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>> ---
>>>  drivers/cpufreq/intel_pstate.c |    7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>> index 3af9dd7..bb24458 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -986,6 +986,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>  	if (!policy->cpuinfo.max_freq)
>>>  		return -ENODEV;
>>>  
>>> +	limits.min_sysfs_pct = 0;
>>> +	limits.max_sysfs_pct = 100;
>>> +
>>>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
>>>  	    policy->max >= policy->cpuinfo.max_freq) {
>>>  		limits.min_policy_pct = 100;
>>> @@ -1004,9 +1007,9 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>  	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
>>>  
>>>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>>> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
>>> +	limits.min_perf_pct = limits.min_policy_pct;
>>>  	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
>>> -	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
>>> +	limits.max_perf_pct = limits.max_sysfs_pct;
>
> On a second thought, isn't that always 100?  If so, doesn't it basically discard
> limits.max_policy_pct?
>

Yes, I think so, see above.

>>>  	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
>>>  
>>>  	/* Make sure min_perf_pct <= max_perf_pct */
>>> 

Kernels used: 4.3-rc4 and same plus this patch.


