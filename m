From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 112621] New: cpupower reports wrong frequencies
Date: Wed, 17 Feb 2016 19:53:21 +0000
Message-ID: <bug-112621-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43237 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbcBQTxY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Feb 2016 14:53:24 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 376DE203A0
	for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 19:53:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 2A05320398
	for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 19:53:22 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=112621

            Bug ID: 112621
           Summary: cpupower reports wrong frequencies
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.4.1
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: karol@babioch.de
        Regression: No

I already reported this to Thomas Renninger, who is a maintainer of cpupower.
He confirmed the problem and told me to raise a ticket here, and to add some
Intel guys, since this seems to be Intel related.

The output of cpupower looks like this for me:

> [kbabioch@vpcs ~]$ LANG=C cpupower frequency-info
> analyzing CPU 0:
>   driver: acpi-cpufreq
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency: 10.0 us.
>   hardware limits: 1.20 GHz - 2.53 GHz
>   available frequency steps: 2.53 GHz, 2.53 GHz, 2.40 GHz, 2.27 GHz,
> 2.13 GHz, 2.00 GHz, 1.87 GHz, 1.73 GHz, 1.60 GHz, 1.47 GHz, 1.33 GHz,
> 1.20 GHz
>   available cpufreq governors: ondemand, performance
>   current policy: frequency should be within 1.20 GHz and 2.53 GHz.
>                   The governor "ondemand" may decide which speed to use
>                   within this range.
>   current CPU frequency is 1.20 GHz.
>   boost state support:
>     Supported: yes
>     Active: yes
>     25500 MHz max turbo 4 active cores
>     25500 MHz max turbo 3 active cores
>     25500 MHz max turbo 2 active cores
>     25500 MHz max turbo 1 active cores

As you can see my core can be clocked with up to 2.53 GHz, which is something
like 2530 MHz. But at the very bottom 25500 MHz is displayed. Note that I'm not
complaining about the .2 GHz difference, but it seems that there is an error in
magnitude. 1 GHz = 1000 MHz, not 10000 MHz.

Thomas told me that another MSR read might be necessary to get this scaling
factor right, but I'm not sure about the details on this.

Here is my /proc/cpuinfo output:

[kbabioch@vpcs openvpn]$ cat /proc/cpuinfo 
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 540  @ 2.53GHz
stepping    : 2
microcode    : 0xe
cpu MHz        : 1466.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr
pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5055.39
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 540  @ 2.53GHz
stepping    : 2
microcode    : 0xe
cpu MHz        : 2534.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr
pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5055.39
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 540  @ 2.53GHz
stepping    : 2
microcode    : 0xe
cpu MHz        : 1199.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr
pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5055.39
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i5 CPU       M 540  @ 2.53GHz
stepping    : 2
microcode    : 0xe
cpu MHz        : 1199.000
cache size    : 3072 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 2
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr
pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dtherm tpr_shadow vnmi
flexpriority ept vpid
bugs        :
bogomips    : 5055.39
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

-- 
You are receiving this mail because:
You are the assignee for the bug.
