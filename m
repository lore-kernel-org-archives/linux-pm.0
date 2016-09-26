From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 17:15:23 -0500
Message-ID: <b6e8a1a9-1fe5-20d8-2b98-f8640aec3492@lwfinger.net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan>
 <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan>
 <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com>
 <1474926384.35049.128.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35949 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbcIZWP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 18:15:26 -0400
In-Reply-To: <1474926384.35049.128.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 09/26/2016 04:46 PM, Srinivas Pandruvada wrote:
> On Mon, 2016-09-26 at 23:37 +0200, Rafael J. Wysocki wrote:
>> On Mon, Sep 26, 2016 at 11:28 PM, Larry Finger
>> <Larry.Finger@lwfinger.net> wrote:
>>>
>>> On 09/26/2016 04:06 PM, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Monday, September 26, 2016 11:15:45 AM Larry Finger wrote:
>>>>>
>>>>>
>>>>> On 09/26/2016 06:37 AM, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>
>>>>>> On Friday, September 23, 2016 09:45:09 PM Larry Finger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 09/18/2016 09:54 PM, Larry Finger wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 09/14/2016 11:00 AM, Larry Finger wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 09/09/2016 12:39 PM, Larry Finger wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I have found a regression in kernel 4.8-rc2 that
>>>>>>>>>> causes the speed of
>>>>>>>>>> my laptop
>>>>>>>>>> with an Intel(R) Core(TM) i7-4600M CPU @ 2.90GHz to
>>>>>>>>>> suddenly have a
>>>>>>>>>> maximum cpu
>>>>>>>>>> frequency of ~400 MHz. Unfortunately, I do not know
>>>>>>>>>> how to trigger
>>>>>>>>>> this problem,
>>>>>>>>>> thus a bisection is not possible. It usually happens
>>>>>>>>>> under heavy
>>>>>>>>>> load, such as a
>>>>>>>>>> kernel build or the RPM build of VirtualBox, but it
>>>>>>>>>> does not always
>>>>>>>>>> fail with
>>>>>>>>>> these loads. In my most recent failure, 'hwinfo --
>>>>>>>>>> cpu' reports cpu
>>>>>>>>>> MHz of
>>>>>>>>>> 396.130 for #3. The bogomips value is 5787.73, and
>>>>>>>>>> the cpu clock
>>>>>>>>>> before the
>>>>>>>>>> fault is 3437 MHz. Nothing is logged when this
>>>>>>>>>> happens.
>>>>>>>>>>
>>>>>>>>>> If I were to get a patch that would show a backtrace
>>>>>>>>>> when the
>>>>>>>>>> maximum CPU
>>>>>>>>>> frequency is changed, perhaps it would be possible to
>>>>>>>>>> track this
>>>>>>>>>> bug.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have not yet found the bad commit, but I have reduced
>>>>>>>>> the range of
>>>>>>>>> commits a
>>>>>>>>> bit. This bug has been difficult to trigger. So far, it
>>>>>>>>> has not taken
>>>>>>>>> over 1/2
>>>>>>>>> day to appear in bad kernels, thus I am allowing three
>>>>>>>>> days before
>>>>>>>>> deciding that
>>>>>>>>> a given trial is good. I never saw the problem with 4.7
>>>>>>>>> kernels, but
>>>>>>>>> I did in
>>>>>>>>> 4.8-rc1. I also know that it appeared before commit
>>>>>>>>> 581e0cd. Commit
>>>>>>>>> 1b05cf6 did
>>>>>>>>> not show the bug.
>>>>>>>>>
>>>>>>>>> Testing continues.
>>>>>>>>
>>>>>>>>
>>>>>>>> And still does. My bisection seemed to be trending toward
>>>>>>>> an
>>>>>>>> improbable set of
>>>>>>>> commits, and I needed to do some other work with the
>>>>>>>> machine, thus I
>>>>>>>> started
>>>>>>>> running 4.8-rc6. It failed nearly 48 hours after the
>>>>>>>> reboot, which
>>>>>>>> indicated
>>>>>>>> that using 3 days to indicate a "good" trial was likely
>>>>>>>> too short. I
>>>>>>>> am
>>>>>>>> currently testing the first of the trial and will run it
>>>>>>>> for at least
>>>>>>>> a week. It
>>>>>>>> is unlikely that these tests will be complete before 4,8
>>>>>>>> is released,
>>>>>>>> even if
>>>>>>>> -rc8 is needed. I will keep attempting to find the faulty
>>>>>>>> commit.
>>>>>>>
>>>>>>>
>>>>>>> My debugging continues. After 7 days of beating on commit
>>>>>>> f7816ad, I
>>>>>>> have
>>>>>>> concluded that it is likely good. Thus I think the bug lies
>>>>>>> between
>>>>>>> commit
>>>>>>> 581e0cd (bad) and f7816ad (good). I will need to do a long
>>>>>>> test on
>>>>>>> commit
>>>>>>> 1b05cf6, which did not fail with a shorter run.
>>>>>>
>>>>>>
>>>>>> 581e0cd is not a valid mainline commit hash AFAICS.
>>>>>
>>>>>
>>>>> That was a typo. The correct value is 581e0c7.
>>>>>>
>>>>>>
>>>>>>
>>>>>> What cpufreq driver do you use?
>>>>>
>>>>>
>>>>> My "Default CPUFreq governor" is on demand.
>>>>>
>>>>> Running the command 'egrep -r "CPU_FREQ|CPUFREQ" .config'
>>>>> results in
>>>>>
>>>>> CONFIG_ACPI_CPU_FREQ_PSS=y
>>>>> CONFIG_CPU_FREQ=y
>>>>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>>>>> CONFIG_CPU_FREQ_GOV_COMMON=y
>>>>> # CONFIG_CPU_FREQ_STAT is not set
>>>>> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>>>>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>>>>> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>>>>> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>>>>> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
>>>>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>>>>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>>>>> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>>>>> CONFIG_CPU_FREQ_GOV_USERSPACE=m
>>>>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>>>>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
>>>>> # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
>>>>> CONFIG_X86_PCC_CPUFREQ=m
>>>>> CONFIG_X86_ACPI_CPUFREQ=m
>>>>> CONFIG_X86_ACPI_CPUFREQ_CPB=y
>>>>>
>>>>> Commit 1b05cf6 did fail on longer testing, thus my bisection
>>>>> had ended up
>>>>> going
>>>>> wrong. Further tests have shown that commit 351a4ded is bad.
>>>>> Once again,
>>>>> by
>>>>> bisection seems to be converging to a set of commits that seem
>>>>> unlikely
>>>>> to cause
>>>>> this problem. Perhaps commit f7816ad is not really good even
>>>>> though it
>>>>> survived
>>>>> 7 days of heavy CPU usage.
>>>>>
>>>>> I have been reluctant to post my entire .config on the list. It
>>>>> is
>>>>> available at
>>>>> http://pastebin.com/aMZaAKwL.
>>>>
>>>>
>>>> If the governor is ondemand, the driver is acpi-cpufreq, most
>>>> likely.
>>>>
>>>> How do you measure the frequency?
>>>
>>>
>>> Mostly I use a KDE applet named "System load" and look at the
>>> "average
>>> clock", but the same info is also available in /proc/cpuinfo as
>>> "cpu MHz".
>>> When the bug triggers, the system gets very slow, and the cpu fan
>>> stops even
>>> though the cpu is still busy.
>>
>> That sounds like thermal throttling kicking in.
>>
> This will help to know, if there is thermal throttle from OS.
> # cat /sys/devices/system/cpu/cpufreq/policy?/scaling_max_freq
> # grep -r . /sys/class/thermal/thermal_zone*

With the system OK, I get

finger@linux-1t8h:~/wireless-drivers-next> cat 
/sys/devices/system/cpu/cpufreq/policy?/scaling_max_freq
3600000
3600000
3600000
3600000

finger@linux-1t8h:~/wireless-drivers-next> grep -r . 
/sys/class/thermal/thermal_zone*
grep: /sys/class/thermal/thermal_zone0/k_d: Input/output error
grep: /sys/class/thermal/thermal_zone0/k_i: Input/output error
grep: /sys/class/thermal/thermal_zone0/k_po: Input/output error
grep: /sys/class/thermal/thermal_zone0/k_pu: Input/output error
/sys/class/thermal/thermal_zone0/mode:enabled
/sys/class/thermal/thermal_zone0/temp:16000
/sys/class/thermal/thermal_zone0/type:acpitz
grep: /sys/class/thermal/thermal_zone0/integral_cutoff: Input/output error
/sys/class/thermal/thermal_zone0/power/control:auto
/sys/class/thermal/thermal_zone0/power/async:disabled
/sys/class/thermal/thermal_zone0/power/runtime_enabled:disabled
/sys/class/thermal/thermal_zone0/power/runtime_active_kids:0
/sys/class/thermal/thermal_zone0/power/runtime_active_time:0
grep: /sys/class/thermal/thermal_zone0/power/autosuspend_delay_ms: Input/output 
error
/sys/class/thermal/thermal_zone0/power/runtime_status:unsupported
/sys/class/thermal/thermal_zone0/power/runtime_usage:0
/sys/class/thermal/thermal_zone0/power/runtime_suspended_time:0
grep: /sys/class/thermal/thermal_zone0/slope: Input/output error
/sys/class/thermal/thermal_zone0/trip_point_0_temp:102000
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
grep: /sys/class/thermal/thermal_zone0/offset: Input/output error
/sys/class/thermal/thermal_zone0/policy:step_wise
/sys/class/thermal/thermal_zone0/passive:0
/sys/class/thermal/thermal_zone0/available_policies:user_space bang_bang 
fair_share step_wise
grep: /sys/class/thermal/thermal_zone0/sustainable_power: Input/output error
/sys/class/thermal/thermal_zone1/k_d:0
/sys/class/thermal/thermal_zone1/k_i:0
/sys/class/thermal/thermal_zone1/k_po:0
/sys/class/thermal/thermal_zone1/k_pu:0
/sys/class/thermal/thermal_zone1/temp:43000
/sys/class/thermal/thermal_zone1/type:x86_pkg_temp
/sys/class/thermal/thermal_zone1/integral_cutoff:0
/sys/class/thermal/thermal_zone1/power/control:auto
/sys/class/thermal/thermal_zone1/power/async:disabled
/sys/class/thermal/thermal_zone1/power/runtime_enabled:disabled
/sys/class/thermal/thermal_zone1/power/runtime_active_kids:0
/sys/class/thermal/thermal_zone1/power/runtime_active_time:0
grep: /sys/class/thermal/thermal_zone1/power/autosuspend_delay_ms: Input/output 
error
/sys/class/thermal/thermal_zone1/power/runtime_status:unsupported
/sys/class/thermal/thermal_zone1/power/runtime_usage:0
/sys/class/thermal/thermal_zone1/power/runtime_suspended_time:0
/sys/class/thermal/thermal_zone1/slope:0
/sys/class/thermal/thermal_zone1/trip_point_0_temp:0
/sys/class/thermal/thermal_zone1/trip_point_0_type:passive
/sys/class/thermal/thermal_zone1/trip_point_1_temp:0
/sys/class/thermal/thermal_zone1/trip_point_1_type:passive
/sys/class/thermal/thermal_zone1/offset:0
/sys/class/thermal/thermal_zone1/policy:step_wise
/sys/class/thermal/thermal_zone1/available_policies:user_space bang_bang 
fair_share step_wise
/sys/class/thermal/thermal_zone1/sustainable_power:0

I will recheck once I trigger another failure.

Larry

