From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: How to remove warn msg "cache: parent cpui should not be
 sleeping" i=1, 2, 3...
Date: Wed, 21 Dec 2016 16:54:22 +0000
Message-ID: <a793d088-2faf-3ea8-41b6-f0b614a71e19@arm.com>
References: <20161221193703.6eac880c@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757871AbcLUQy1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 11:54:27 -0500
In-Reply-To: <20161221193703.6eac880c@xhacker>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>



On 21/12/16 11:37, Jisheng Zhang wrote:
> Hi all,
> 
> I'm not sure this is a bug, when wake up from s2ram, I could get something
> like:
> 
> [  313.271464] Enabling non-boot CPUs ...
> [  313.271551] CPU1: Booted secondary processor
> [  313.271556] Detected VIPT I-cache on CPU1
> [  313.301378]  cache: parent cpu1 should not be sleeping
> [  313.301504] CPU1 is up
> [  313.301582] CPU2: Booted secondary processor
> [  313.301585] Detected VIPT I-cache on CPU2
> [  313.331485]  cache: parent cpu2 should not be sleeping
> [  313.331605] CPU2 is up
> [  313.331683] CPU3: Booted secondary processor
> [  313.331686] Detected VIPT I-cache on CPU3
> [  313.361599]  cache: parent cpu3 should not be sleeping
> [  313.361719] CPU3 is up
> 
> This is because we call cpu_device_create() when secondary cpu is brought
> online, the cpu_cache device's parent device: cpu device isn't already
> resumed, all device resume will resume after secondary cores are brought
> up.
> 
> What's the elegant solution to remove this warning msg?
> 

It is not a serious warning as you can see a comment in the code:
"/*
 * This is a fib.  But we'll allow new children to be added below
 * a resumed device, even if the device hasn't been completed yet.
 */"

But if we think it needs to be removed, I have something like below in
my mind. I am not sure if this is hacky or not(completely untested, not
even compiled).

Regards,
Sudeep

-->8

diff --git i/drivers/base/cpu.c w/drivers/base/cpu.c
index 4c28e1a09786..2a5c04377adf 100644
--- i/drivers/base/cpu.c
+++ w/drivers/base/cpu.c
@@ -344,6 +344,14 @@ static int cpu_uevent(struct device *dev, struct
kobj_uevent_env *env)
 }
 #endif

+static int cpu_dev_pm_unset_is_prepared(unsigned int cpu)
+{
+       struct device *cpu_dev = get_cpu_device(cpu);
+
+       if(cpu_dev)
+               cpu_dev->power.is_prepared = false;
+       return 0;
+}
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -377,7 +385,9 @@ int register_cpu(struct cpu *cpu, int num)
        per_cpu(cpu_sys_devices, num) = &cpu->dev;
        register_cpu_under_node(num, cpu_to_node(num));

-       return 0;
+       return cpuhp_setup_state_nocalls(CPUHP_CPUDEV_PM_PREPARE,
+                                "base/cpu/dev_pm:prepare",
+                                cpu_dev_pm_unset_is_prepared, NULL);
 }

 struct device *get_cpu_device(unsigned cpu)
diff --git i/include/linux/cpuhotplug.h w/include/linux/cpuhotplug.h
index 2ab7bf53d529..5bfe3c1aa148 100644
--- i/include/linux/cpuhotplug.h
+++ w/include/linux/cpuhotplug.h
@@ -51,6 +51,7 @@ enum cpuhp_state {
        CPUHP_SLAB_PREPARE,
        CPUHP_MD_RAID5_PREPARE,
        CPUHP_RCUTREE_PREP,
+       CPUHP_CPUDEV_PM_PREPARE,
        CPUHP_CPUIDLE_COUPLED_PREPARE,
        CPUHP_POWERPC_PMAC_PREPARE,
        CPUHP_POWERPC_MMU_CTX_PREPARE,
