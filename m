From: Len Brown <lenb@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Tue, 8 Mar 2016 16:13:34 -0500
Message-ID: <CAJvTdKkXzyRUAbNH6hGRZPGSm6C0myuOoc-ekVqZZmP_hw0muQ@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
	<1456938654.17839.9.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34869 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcCHVNg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:13:36 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so36818382lbc.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2016 13:13:35 -0800 (PST)
In-Reply-To: <1456938654.17839.9.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Arto Jantunen <viiru@iki.fi>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> Having the mwait based idle states working would probably
> get the CPU to spend a lot less time in HLT, and more time
> in "proper" idle states.

Agreed, the ACPI IOPORT latencies are sort of nonsense on this box,
and the workaround for "intel_idle.max_cstate" is a better workaround than
"idle=nomwait", because it at least allows ACPI to use mwait.

But the difference is sort of minor compared to the other issues a play.

>> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI IOPORT 0x1819
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1034
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:2068
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:14169
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:3375

Len Brown, Intel Open Source Technology Center
