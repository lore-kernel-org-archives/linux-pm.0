From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 3/3][RFC/RFT] PM / sleep: Do not delay the synchronization of MTRR during resume
Date: Tue, 31 Oct 2017 17:58:50 +0800
Message-ID: <cbb3b328b1a07e61635c59db958b83318ca18dbd.1509438899.git.yu.c.chen@intel.com>
References: <cover.1509438899.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509438899.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

Sometimes it is too late for the APs to synchronize the MTRR
after all the APs have been brought up. In some cases the BIOS
might scribble the MTRR across suspend/resume, as a result we
might get insane MTRR after resumed back, thus every instruction
run on this AP would be extremely slow if it happended to be 'uncached'
in the MTRR, although after all the APs have been brought up, the
delayed invoking of set_mtrr_state() will adjust the MTRR on APs
thus brings everything back to normal. In practice it is necessary
to synchronize the MTRR as early as possible to get it fixed during
each AP's online. And this is what this patch does.

Moreover, since we have put the synchronization earlier, there is
a side effect that, during each AP's online, the other cpus already
online will be forced stopped to run mtrr_rendezvous_handler() and
reprogram the MTRR again and again. This symptom can be lessened
by checking if this cpu has already finished the synchronization
during the enable_nonboot_cpus() stage, if it is, we can safely
bypass the reprogramming action. (We can not bypass the
mtrr_rendezvous_handler(), because the other online cpus must be
stopped running the VMX transaction while one cpu is updating
its MTRR, which is described here:
Commit d0af9eed5aa9 ("x86, pat/mtrr: Rendezvous all the cpus for
MTRR/PAT init")

This patch does not impact the normal boot up and cpu hotplug.

On a platform with insane MTRR after resumed,
1 .before this patch:
   [  619.810899] Enabling non-boot CPUs ...
   [  619.825537] smpboot: Booting Node 0 Processor 1 APIC 0x2
   [  621.723809] CPU1 is up
   [  621.840228] smpboot: Booting Node 0 Processor 3 APIC 0x3
   [  626.690900] CPU3 is up

So it took cpu1 621.723809 - 619.825537 = 1898.272 ms, and
cpu3 626.690900 - 621.840228 = 4850.672 ms.

2. after this patch:
   [  106.931790] smpboot: Booting Node 0 Processor 1 APIC 0x2
   [  106.948360] CPU1 is up
   [  106.986534] smpboot: Booting Node 0 Processor 3 APIC 0x3
   [  106.990702] CPU3 is up

It took cpu1 106.948360 - 106.931790 = 16.57 ms, and
cpu3 106.990702 - 106.986534 = 4.16 ms.

For comparison, I also verify the suspend on a 88 cpus Xeon Broadwell
platform, and the result also shows that with this patch applied,
the overall APs online time has decreased a little bit, I think this
is because after we synchronize the MTRR earlier, the MTRRs also get
updated to the correct value earlier.

I've tested 5 times each, before/after the patch applied:

1. before this patch:
[   64.549430] Enabling non-boot CPUs ...
[   66.253304] End enabling non-boot CPUs

overall cpu online: 1.703874 second

[   62.159063] Enabling non-boot CPUs ...
[   64.483443] End enabling non-boot CPUs

overall cpu online: 2.32438 second

[   58.351449] Enabling non-boot CPUs ...
[   60.796951] End enabling non-boot CPUs

overall cpu online: 2.445502 second

[   64.491317] Enabling non-boot CPUs ...
[   66.996208] End enabling non-boot CPUs

overall cpu online: 2.504891 second

[   60.593235] Enabling non-boot CPUs ...
[   63.397886] End enabling non-boot CPUs

overall cpu online: 2.804651 second

average: 2.3566596 second

2. after this patch:

[   66.077368] Enabling non-boot CPUs ...
[   68.343374] End enabling non-boot CPUs

overall cpu online: 2.266006 second

[   64.594605] Enabling non-boot CPUs ...
[   66.092688] End enabling non-boot CPUs

overall cpu online: 1.498083 second

[   64.778546] Enabling non-boot CPUs ...
[   66.277577] End enabling non-boot CPUs

overall cpu online: 1.499031 second

[   63.773091] Enabling non-boot CPUs ...
[   65.601637] End enabling non-boot CPUs

overall cpu online: 1.828546 second

[   64.638855] Enabling non-boot CPUs ...
[   66.327098] End enabling non-boot CPUs

overall cpu online: 1.688243 second

average: 1.7559818 second

In one word, with the patch applied, the cpu online time during resume
has decreased by about 6 seconds on a bogus MTRR platform, and decreased
by about 600ms on a 88 cpus Xeon platform after resumed.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/cpu/mtrr/main.c | 3 +++
 arch/x86/kernel/smpboot.c       | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index a4e7e23f3c2e..f4c2c60c6ac8 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -179,6 +179,9 @@ static int mtrr_rendezvous_handler(void *info)
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
 	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+		if (in_enable_nonboot_cpus() &&
+		    data->smp_cpu != smp_processor_id())
+			return 0;
 		mtrr_if->set_all();
 	}
 	return 0;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ad59edd84de7..2d1ec878df63 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1366,12 +1366,10 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_enable_nonboot_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
 }
 
 void arch_enable_nonboot_cpus_end(void)
 {
-	mtrr_aps_init();
 }
 
 /*
-- 
2.13.5
