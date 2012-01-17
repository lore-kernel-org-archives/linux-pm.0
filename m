From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/50] intel_idle: fix API misuse
Date: Tue, 17 Jan 2012 07:21:35 -0500
Message-ID: <39a74fdedd1c1461d6fb6d330b5266886513c98f.1326802230.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>

smp_call_function() only lets all other CPUs execute a specific function,
while we expect all CPUs do in intel_idle.  Without the fix, we could have
one cpu which has auto_demotion enabled or has no broadcast timer setup.
Usually we don't see impact because auto demotion just harms power and the
intel_idle init is called in CPU 0, where boradcast timer delivers
interrupt, but this still could be a problem.

Cc: stable@vger.kernel.org
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d2f8e1..af0b4a5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -394,7 +394,7 @@ static int intel_idle_probe(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
 	else {
-		smp_call_function(__setup_broadcast_timer, (void *)true, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
 		register_cpu_notifier(&setup_broadcast_notifier);
 	}
 
@@ -471,7 +471,7 @@ static int intel_idle_cpuidle_driver_init(void)
 	}
 
 	if (auto_demotion_disable_flags)
-		smp_call_function(auto_demotion_disable, NULL, 1);
+		on_each_cpu(auto_demotion_disable, NULL, 1);
 
 	return 0;
 }
@@ -568,7 +568,7 @@ static void __exit intel_idle_exit(void)
 	cpuidle_unregister_driver(&intel_idle_driver);
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
-		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
 		unregister_cpu_notifier(&setup_broadcast_notifier);
 	}
 
-- 
1.7.9.rc1
