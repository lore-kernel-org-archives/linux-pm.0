From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH DEBUG] x86, pat/mtrr: MTRR/PAT init earlier for each APs
Date: Tue, 20 Dec 2016 18:21:28 +0800
Message-ID: <1482229288-30913-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3527 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933516AbcLTKMm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 05:12:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suresh Siddha <sbsiddha@gmail.com>, Borislav Petkov <bp@suse.de>, Lukas Wunner <lukas@wunner.de>, "Brandt, Todd E" <todd.e.brandt@intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

This is a debug patch to descibe/workaround the issue
we encountered recently.

Problem and the cause:
Currently we are suffering from *extremely* slow CPU online
speed during system resuming from S3. Say, the MacBookPro 2015
has 4 CPUs, and it took more than 1 second each for both CPU1
and CPU3 to be brought back to idle thread again. Further ftrace
result showed that, *each* instruction the CPU1 and CPU3 execute
will take much longer time than it will take during normal cpu
online via sysfs(without S3 involved). And more interesting
thing was found that after resumed back, every instruction CPU1 and
CPU3 execute is back to its normal speed(unixbench has the same score
before/after S3). So it smells like there is something wrong with
the cache/tlb settings only during resuming back from S3.
Finally we have found this might be related to BIOS who has
scribbled the mtrr/pat before it resumed back to the OS, and every
instruction seems to be run in an uncached behavior, fortunately
later after all the APs have been brought up again, mtrr_aps_init()
will be invoked to synchronize the mtrr on these APs to the value
once saved by CPU0 before suspended, thus everything is back
to normal after resumed.

Workaround:
So it turns out to be that if we can synchronize the APs with boot CPU
ASAP, rather than waiting till all CPUS online, it might reduce the
impact of the bogus BIOS who scribbled the mtrr/pat. So here is the
hack patch to let the users to synchronize mtrr on APs earlier.
With the following debug patch applied, the resume time for CPU1 and
CPU3 have dropped a lot.

(Notice, the following result were tested with ftrace function_graph enabled
during suspend/resume, by this tool:
https://01.org/suspendresume


Before patch applied:
[  619.810899] Enabling non-boot CPUs ...
[  619.825528] x86: Booting SMP configuration:
[  619.825537] smpboot: Booting Node 0 Processor 1 APIC 0x2
-------skip--------
[  621.723809] CPU1 is up
[  621.762843] smpboot: Booting Node 0 Processor 2 APIC 0x1
-------skip--------
[  621.766679] CPU2 is up
[  621.840228] smpboot: Booting Node 0 Processor 3 APIC 0x3
-------skip--------
[  626.690900] CPU3 is up

So it took CPU1 621.723809 - 619.825537 = 1898.272 ms, and
CPU3 626.690900 - 621.840228 = 4850.672 ms !


After patch applied:
[  106.931790] smpboot: Booting Node 0 Processor 1 APIC 0x2
-------skip--------
[  106.948360] CPU1 is up
[  106.963975] smpboot: Booting Node 0 Processor 2 APIC 0x1
-------skip--------
[  106.968087] CPU2 is up
[  106.986534] smpboot: Booting Node 0 Processor 3 APIC 0x3
-------skip--------
[  106.990702] CPU3 is up

It took CPU1 106.948360 - 106.931790 = 16.57 ms, and
CPU3 106.990702 - 106.986534 = 4.16 ms

Question:
So it turns out to be a BIOS issue, but Linux should also deal with
this bogus BIOS, right? I studied the commit we delay the synchronization
until all the APs are brought up, and according to:

Commit d0af9eed5aa9 ("x86, pat/mtrr: Rendezvous all the cpus
for MTRR/PAT init")

It seems that there would be problem if we do not sync APs at the same
time(some CPUs run with cache disabled will hang the system, because its
sibling is trying to adjust the mtrr which might disable its cache) on
some special platforms? But I have a question that, even in our current
solution which defers the synchronization, the scenario mentioned above
can not be avoided because at the time CPU3 is trying to restore mtrr,
its sibling CPU1 might also be doing some kworker or ticking tasks,
the CPU1 might also run with cache disabled?
I'm not sure if I understand the code correctly, and it would be
appreciated if people could give any comments/suggestions on how to deal
with this situation found on MacProBook, and if you need me to do any test
please feel free to let me know.

Thanks,
Yu

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/cpu/mtrr/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 24e87e7..eddaa89 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -813,15 +813,28 @@ void mtrr_save_state(void)
 	put_online_cpus();
 }
 
+static bool __read_mostly no_aps_delay;
+
+static int __init no_aps_setup(char *str)
+{
+	no_aps_delay = true;
+	pr_info("hack: do not delay aps mtrr/pat initialization.\n");
+
+	return 0;
+}
+
 void set_mtrr_aps_delayed_init(void)
 {
 	if (!mtrr_enabled())
 		return;
 	if (!use_intel())
 		return;
+	if (no_aps_delay)
+		return;
 
 	mtrr_aps_delayed_init = true;
 }
+early_param("no_aps_delay", no_aps_setup);
 
 /*
  * Delayed MTRR initialization for all AP's
-- 
2.7.4

