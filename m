From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC PATCH 0/2] Simplified runtime PM for CPU devices?
Date: Tue,  6 Oct 2015 15:57:34 -0600
Message-ID: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33501 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbbJFV5t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 17:57:49 -0400
Received: by pacex6 with SMTP id ex6so221950815pac.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 14:57:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: grygorii.strashko@ti.com, ulf.hansson@linaro.org, khilman@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de, geert+renesas@glider.be, lorenzo.pieralisi@arm.com, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Hello,

This is a re-examination of the genpd patches [1] and using runtime PM and
genpd for CPU devices. Discussions following my last submission [1] and many
one on one conversations at LPC and Linaro Connect conferences indicated that
the latency and the unpredictability associated with calling into runtime PM
from the cpuidle path needs to be understood better. I want to summarize some
of those discussions here and questions that stood out during those
discussions. I would like to hear your thoughts on them.

Why runtime PM and genpd, why not a new framework?
	Runtime PM and genpd are established frameworks for power savings in
devices and their domains. As we look beyond cpuidle to save power around the
CPUs, there is the option to invent a new framework for CPU domains or reuse
and extend existing frameworks to suit the specific usecase of CPU devices.
Inventing a new framework has been explored as well; other than adding a bunch
of code to parse and depict the hierarchy, the core code ends up the same as
genpd/runtime PM framework providing reference counting, locks to synchronize
state of the domains, traversing the hierarchy and powering off domains as we
go. The new framework would duplicate a lot of genpd code. CAF downstream tree
takes this approach [2]. It seems to me that the complexity and the feature
set, would bring in the same amount of additional latency to cpuidle
irrespective of the approach. But, at what cost?

Using genpd/runtime PM, risk for cpuidle?
	Using the same frameworks for both device idle and cpuidle would mean
that changes made for supporting a specific relationship of devices and domains
may affect generic cpuidle. This could be a problem, as these changes lie in
the critical path of a CPU operation. A new framework would isolate such risks.
What would be the middle ground of code re-use and stability? Could we stick to
the device struct but isolate some of the code in the CPU critical path from
runtime PM?

What about performance, latency and predictability for RT kernel?
	We did a bit of profiling on the existing patchset [1], and saw some
really a big range of latency 50-80 usec on a 800 Mhz quad core ARM SoC. Upon
further investigation, it became clear that there is quite a bit of
unpredictability as a result of CPUs waiting for locks.

Using runtime PM and genpd framework for CPU PM domain brings out a few
interesting requirements - interrupts are disabled, runtime PM and genpd
locking, spinlocks in -RT.

Locking?
	CPUs can only tell with absolute certainity the PM state of 'their'
devices. Reporting runtime PM state of another CPU would be inaccurate, as CPUs
enter idle independently. So if CPUs can only runtime PM on 'their' devices, do
we need to lock the CPU device?
	Genpd on the other hand, needs locks. It is a shared resource among
CPUs within a cluster, or as dictated in the DT for the SoC. Most likely there
are multiple CPUs sharing the same domain and there is bound be a collision to
acquire locks. This increases latency and unpredictability.
	-RT kernels bring out a different set of requirement, regular spinlocks
may sleep in -RT kernel. Should we use raw_spinlocks for genpd when called from
CPU idle in -RT or for all cases, when the domain is defined as IRQ-safe?

Investigation results and questions:
	While investigating these, I saw an opportunity to prototype a bare
minimum code to solve the problems using runtime PM and genpd. I came with
additional functions specifically for the CPU devices to do runtime PM, that
would be lockless and call into genpd. With that I can see a predictable value
of about additional 9 usec for any CPU to call into runtime PM as part of
cpuidle and about 50 usec for the last CPU in the cluster to lock genpd and do
a NULL callback to platform to suspend the domain. Reference counting of the
last CPU in a domain is done using atomic variables instead of locking and
iterating through all the devices in the domain to determine if they are
runtime suspended. Locks are only used when the CPU is the last non-suspended
device in the domain or the first CPU in the domain to be active.
The proof of concept patches are included herewith. 

It still needs to be seen how do we solve the -RT kernel problem. I am hoping
to hear more about other cases and problems that could be foreseen at this
time.

Thanks,
Lina

[1] https://lwn.net/Articles/656793/
[2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.18/tree/drivers/cpuidle/lpm_levels.c?h=aosp/android-3.10&id=AU_LINUX_ANDROID_LNX.LA.3.7.2.04.04.04.151.083	

Lina Iyer (2): PM / runtime: Add CPU runtime PM suspend/resume api
  PM / Domains: Atomic counters for domain usage count

 drivers/base/power/domain.c  | 16 ++++++++++--
 drivers/base/power/runtime.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h    |  1 +
 include/linux/pm_runtime.h   |  3 ++-
 4 files changed, 78 insertions(+), 3 deletions(-)

-- 
2.1.4

