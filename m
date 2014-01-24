From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Preserving Sysfs file permissions on suspend/resume
Date: Fri, 24 Jan 2014 17:20:38 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59E61F08@BGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3415 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbaAXRVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2014 12:21:12 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat (srivatsa.bhat@linux.vnet.ibm.com)" <srivatsa.bhat@linux.vnet.ibm.com>, "Viresh Kumar (viresh.kumar@linaro.org)" <viresh.kumar@linaro.org>
Cc: "Linux PM list (linux-pm@vger.kernel.org)" <linux-pm@vger.kernel.org>

Hi Srivatsa/Viresh,

I am using a 3.10 kernel (on a 4-core machine)and trying out
the Sysfs permission patches. I took the series of 7 patches
from Srivatsa from here:
https://lkml.org/lkml/2013/7/30/434
They apply cleanly on top of the 3.10 kernel that I use; and the top
commit that I have now is the 7th patch in this series i.e
"perform light-weight init/teardown".

But I observe a crash on resume (crash logs attached in the end of
this mail).  Further looking at the patch history from linux-pm archives,
I see the following patches might be required to fix this:

1) cb38ed5cf1c4fdb7454e4b48fb70c396f5acfb21
[Prevent problems in update_policy_cpu() if last_cpu == new_cpu]

2) 0d66b91ebff49841f607a3c079984c907c8a4199
[Fix crash in cpufreq-stats during suspend/resume]

I am neither a cpufreq expert, nor have the luxury of moving to
the latest version of cpufreq (may be from stable 3.13),
I would appreciate your advice here.

I also see some fixes for kobject related crashes from Viresh in the
commit history, but the crash I see doesn't look like it is related to
any of these. [again, from whatever I understand ;)]

Thanks,
Durga
--crash logs--
[  132.139372] smpboot: CPU 1 is now offline
[  132.140472] BUG: unable to handle kernel NULL pointer dereference at   (null)
[  132.140501] IP: [<c17dbb16>] cpufreq_stat_notifier_policy+0xa6/0xf0
[  132.140516] *pdpt = 0000000000000000 *pde = f000f3b5f000f3b0 
[  132.140532] Oops: 0002 [#1] PREEMPT SMP
...
[  132.140792] Call Trace:
[  132.140814]  [<c124d442>] ? try_to_del_timer_sync+0x42/0x60
[  132.140833]  [<c1a80c87>] notifier_call_chain+0x47/0x90
[  132.140853]  [<c12652c1>] __blocking_notifier_call_chain+0x41/0x80
[  132.140869]  [<c126531f>] blocking_notifier_call_chain+0x1f/0x30
[  132.140886]  [<c17da115>] __cpufreq_remove_dev.isra.10+0x185/0x4a0
[  132.140903]  [<c1a7d9d6>] ? _raw_spin_unlock_irqrestore+0x26/0x50
[  132.140918]  [<c124d442>] ? try_to_del_timer_sync+0x42/0x60
[  132.140938]  [<c1a6ed8f>] cpufreq_cpu_callback+0x4b/0x5e
[  132.140952]  [<c1a80c87>] notifier_call_chain+0x47/0x90
[  132.140969]  [<c12651ae>] __raw_notifier_call_chain+0x1e/0x30
[  132.140985]  [<c1241024>] __cpu_notify+0x24/0x50
[  132.141002]  [<c1a62484>] _cpu_down+0x74/0x260
[  132.141021]  [<c124136c>] disable_nonboot_cpus+0x6c/0x100
[  132.141038]  [<c1283445>] suspend_devices_and_enter+0x1f5/0x400
[  132.141055]  [<c12838ca>] pm_suspend+0x27a/0x2a0
[  132.141071]  [<c1284065>] try_to_suspend+0xa5/0xc0
[  132.141086]  [<c1a7d98d>] ? _raw_spin_unlock_irq+0x1d/0x40
[  132.141103]  [<c1259a0d>] process_one_work+0x11d/0x3e0
[  132.141117]  [<c1a80edd>] ? add_preempt_count+0x7d/0xf0
[  132.141130]  [<c1a80dd5>] ? sub_preempt_count+0x55/0xe0
[  132.141147]  [<c125a0a6>] worker_thread+0xf6/0x310
[  132.141162]  [<c1a7d9d6>] ? _raw_spin_unlock_irqrestore+0x26/0x50
[  132.141178]  [<c1259fb0>] ? rescuer_thread+0x2b0/0x2b0
[  132.141193]  [<c125fc64>] kthread+0x94/0xa0
[  132.141207]  [<c1a80dd5>] ? sub_preempt_count+0x55/0xe0
[  132.141228]  [<c1a84237>] ret_from_kernel_thread+0x1b/0x28
[  132.141242]  [<c125fbd0>] ? kthread_create_on_node+0xc0/0xc0
[  132.141466] EIP: [<c17dbb16>] cpufreq_stat_notifier_policy+0xa6/0xf0 SS:ESP 0068:f0fd3d08
[  132.141471] CR2: 0000000000000000
[  132.141486] ---[ end trace a047d761256e0391 ]---
