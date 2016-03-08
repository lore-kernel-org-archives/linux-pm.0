From: Len Brown <lenb@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Tue, 8 Mar 2016 16:19:13 -0500
Message-ID: <CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33657 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcCHVTP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:19:15 -0500
Received: by mail-lb0-f178.google.com with SMTP id k15so37446175lbg.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2016 13:19:14 -0800 (PST)
In-Reply-To: <87si087tsr.fsf@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rik van Riel <riel@redhat.com>

On Wed, Mar 2, 2016 at 11:01 AM, Arto Jantunen <viiru@iki.fi> wrote:
> Len Brown <lenb@kernel.org> writes:
>
>>> Since this is about cpuidle, I'll also mention that this hardware
>>> requires idle=nomwait on the command line, otherwise the kernel will not
>>> boot.
>>
>> Arto,
>>
>> A boot failure is even more disruptive than bad P-state and C-state choices!
>> Please tell us more about it.
>>
>> What c-states are used when you use "idle=nomwait"?
>> you can see them this way:
>>
>> grep . /sys/devices/system/cpu/cpu0/cpuidle/*/*
>
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time:1405175
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage:135
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI HLT
> /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:69898878
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:25539
> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI IOPORT 0x1816
> /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:151
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:302
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time:28132
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage:10724
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI IOPORT 0x1819
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1034
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:2068
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:14169
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:3375
>
>> Please boot with intel_idle.max_cstate=0
>>
>> If that also boots, please again show the available c-states via the grep above.
>
> It does, here:
>
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time:30951
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage:132
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH INTEL MWAIT 0x0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:4231850
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:14709
> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI FFH INTEL MWAIT 0x33
> /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:151
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:302
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time:6524492
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage:4621
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH INTEL MWAIT 0x60
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1034
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:2068
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:52217106
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:3364
>
>> Does it happen if you use default cmdline,
>> but edit intel_idle.c to comment out c8 and c9 support?
>
> That also boots, ts.out attached (as is the patch to do this, to make
> sure there is no miscommunication).

yes, patch looks good, and thanks for running turbostat.

If your system boots and runs properly with "intel_idle.max_cstate=7",
then you are suffering this issue:

https://bugzilla.kernel.org/show_bug.cgi?id=109081

> With this change the original bug disappears as well.

Hmm, so your problems with frequency staying constant,
as well as the boot issue both went away by deleting c8 and c9?

Still works with intel_idle.max_cstate=7 ?

thanks,
Len Brown, Intel Open Source Technology Center
