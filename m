From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: CPUfreq lockdep issue
Date: Thu, 18 Feb 2016 13:06:49 +0200
Message-ID: <1455793609.9851.45.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60272 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425490AbcBRLGs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 06:06:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@intel.com>

Hi,

The Intel P-state driver has a lockdep issue as described below. It
could in theory cause a deadlock if initialization and suspend were to
be performed simultaneously. Conflicting calling paths are as follows:

intel_pstate_init(...)
	...cpufreq_online(...)
		down_write(&policy->rwsem); // Locks policy->rwsem
		...
		cpufreq_init_policy(policy);
			...intel_pstate_hwp_set();
				get_online_cpus(); // Temporarily locks cpu_hotplug.lock
		...
		up_write(&policy->rwsem);

pm_suspend(...)
	...disable_nonboot_cpus()
		_cpu_down()
			cpu_hotplug_begin(); // Locks cpu_hotplug.lock
			__cpu_notify(CPU_DOWN_PREPARE, ...);
				...cpufreq_offline_prepare();
					down_write(&policy->rwsem); // Locks policy->rwsem

Quickly looking at the code, some refactoring has to be done to fix the
issue. I think it would a good idea to document some of the driver
callbacks related to what locks are held etc. in order to avoid future
situations like this.

Because get_online_cpus() is of recursive nature and the way it
currently works, adding wider get_online_cpus() scope up around
cpufreq_online() does not fix the issue because it only momentarily
locks cpu_hotplug.lock and proceeds to do so again at next call.

Moving get_online_cpus() completely away from pstate_hwp_set() and
assuring it is called higher in the call chain might be a viable
solution. Then it could be made sure get_online_cpus() is not called
while policy->rwsem is being held already.

Do you think that would be an appropriate way of fixing it?

This issue arose on SKL platforms on i915 DRM driver continuous
integration system when we enabled lockdep debugging.

Regards, Joonas

FULL TRACE FOR P-STATE INIT

get_online_cpus+0x90/0xa0
? get_online_cpus+0x2d/0xa0
intel_pstate_hwp_set+0x40/0x150
intel_pstate_set_policy+0x135/0x170
cpufreq_set_policy+0xdb/0x3f0
cpufreq_init_policy+0x6a/0xc0
? cpufreq_update_policy+0x1e0/0x1e0
cpufreq_online+0x314/0xad0
cpufreq_add_dev+0x5a/0x80
subsys_interface_register+0xa7/0xf0
? _raw_write_unlock_irqrestore+0x3d/0x60
cpufreq_register_driver+0x147/0x210
intel_pstate_init+0x35b/0x481
? cpufreq_gov_dbs_init+0x12/0x12
do_one_initcall+0xa6/0x1d0
kernel_init_freeable+0x113/0x199
? rest_init+0x140/0x140
kernel_init+0x9/0xe0
ret_from_fork+0x3f/0x70
? rest_init+0x140/0x140

FULL TRACE FOR SUSPEND

lock_acquire+0xc3/0x1d0
? cpufreq_offline_prepare+0x92/0x2d0
down_write+0x3f/0x70
? cpufreq_offline_prepare+0x92/0x2d0
cpufreq_offline_prepare+0x92/0x2d0
cpufreq_cpu_callback+0x45/0x50
notifier_call_chain+0x39/0xa0
__raw_notifier_call_chain+0x9/0x10
_cpu_down+0x9e/0x330
? vprintk_emit+0x2cb/0x610
? vprintk_emit+0x324/0x610
? vprintk_default+0x1a/0x20
disable_nonboot_cpus+0xc0/0x350
suspend_devices_and_enter+0x409/0xb30
pm_suspend+0x53f/0x8c0
state_store+0x77/0xe0
kobj_attr_store+0xf/0x20
sysfs_kf_write+0x40/0x50
kernfs_fop_write+0x13c/0x180
__vfs_write+0x23/0xe0
? percpu_down_read+0x52/0x90
? __sb_start_write+0xb2/0xf0
? __sb_start_write+0xb2/0xf0
vfs_write+0xa2/0x190
? __fget_light+0x6a/0x90
SyS_write+0x44/0xb0
entry_SYSCALL_64_fastpath+0x16/0x73

-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation

