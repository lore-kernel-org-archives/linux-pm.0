From: Anchal Agarwal <anchalag@amazon.com>
Subject: [RFC PATCH 09/12] x86/xen: save and restore steal clock
Date: Tue, 12 Jun 2018 20:56:16 +0000
Message-ID: <20180612205619.28156-10-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
Sender: netdev-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, netdev@vger.kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kamatam@amazon.com, anchalag@amazon.com, fllinden@amazon.com, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Save steal clock values of all present CPUs in the system core ops
suspend callbacks. Also, restore a boot CPU's steal clock in the system
core resume callback. For non-boot CPUs, restore after they're brought
up, because runstate info for non-boot CPUs are not active until then.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 arch/x86/xen/suspend.c | 13 ++++++++++++-
 arch/x86/xen/time.c    |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 784c448..dae0f74 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -91,12 +91,20 @@ void xen_arch_suspend(void)
 static int xen_syscore_suspend(void)
 {
 	struct xen_remove_from_physmap xrfp;
-	int ret;
+	int cpu, ret;
 
 	/* Xen suspend does similar stuffs in its own logic */
 	if (xen_suspend_mode_is_xen_suspend())
 		return 0;
 
+	for_each_present_cpu(cpu) {
+		/*
+		 * Nonboot CPUs are already offline, but the last copy of
+		 * runstate info is still accessible.
+		 */
+		xen_save_steal_clock(cpu);
+	}
+
 	xrfp.domid = DOMID_SELF;
 	xrfp.gpfn = __pa(HYPERVISOR_shared_info) >> PAGE_SHIFT;
 
@@ -118,6 +126,9 @@ static void xen_syscore_resume(void)
 
 	pvclock_resume();
 
+	/* Nonboot CPUs will be resumed when they're brought up */
+	xen_restore_steal_clock(smp_processor_id());
+
 	gnttab_resume();
 }
 
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e0f1bcf..85f8534 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -523,6 +523,9 @@ static void xen_hvm_setup_cpu_clockevents(void)
 {
 	int cpu = smp_processor_id();
 	xen_setup_runstate_info(cpu);
+	if (cpu)
+		xen_restore_steal_clock(cpu);
+
 	/*
 	 * xen_setup_timer(cpu) - snprintf is bad in atomic context. Hence
 	 * doing it xen_hvm_cpu_notify (which gets called by smp_init during
-- 
2.7.4
