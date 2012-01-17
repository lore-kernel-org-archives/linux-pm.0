From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/50] intel idle: Make idle driver more robust
Date: Tue, 17 Jan 2012 07:21:41 -0500
Message-ID: <58d40ff92451e9639ad58d7a00539f2833c85413.1326802230.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, stable@vger.kernel.org, Bruno Friedmann <bruno@ioda-net.ch>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Renninger <trenn@suse.de>

kvm -cpu host passes the original cpuid info to the guest.

Latest kvm version seem to return true for mwait_leaf cpuid
function on recent Intel CPUs. But it does not return mwait
C-states (mwait_substates), instead zero is returned.

While real CPUs seem to always return non-zero values, the intel
idle driver should not get active in kvm (mwait_substates == 0)
case and bail out.
Otherwise a Null pointer exception will happen later when the
cpuidle subsystem tries to get active:
[0.984807] BUG: unable to handle kernel NULL pointer dereference at (null)
[0.984807] IP: [<(null)>] (null)
...
[0.984807][<ffffffff8143cf34>] ? cpuidle_idle_call+0xb4/0x340
[0.984807][<ffffffff8159e7bc>] ? __atomic_notifier_call_chain+0x4c/0x70
[0.984807][<ffffffff81001198>] ? cpu_idle+0x78/0xd0

Reference:
https://bugzilla.novell.com/show_bug.cgi?id=726296

Cc: stable@vger.kernel.org
Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Bruno Friedmann <bruno@ioda-net.ch>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 6a3d91d..e56ae0b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -356,7 +356,8 @@ static int intel_idle_probe(void)
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-		!(ecx & CPUID5_ECX_INTERRUPT_BREAK))
+	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
+	    !mwait_substates)
 			return -ENODEV;
 
 	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
-- 
1.7.9.rc1
