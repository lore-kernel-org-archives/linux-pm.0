From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/6] KVM: Use syscore_ops instead of sysdev class
	and sysdev
Date: Tue, 22 Mar 2011 00:37:06 +0100
Message-ID: <201103220037.06465.rjw__3733.78860899738$1300752095$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103220031.22729.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103220031.22729.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: kvm@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, cpufreq@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, tglx@linutronix.de, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

KVM uses a sysdev class and a sysdev for executing kvm_suspend()
after interrupts have been turned off on the boot CPU (during system
suspend) and for executing kvm_resume() before turning on interrupts
on the boot CPU (during system resume).  However, since both of these
functions ignore their arguments, the entire mechanism may be
replaced with a struct syscore_ops object which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 virt/kvm/kvm_main.c |   34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

Index: linux-2.6/virt/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/virt/kvm/kvm_main.c
+++ linux-2.6/virt/kvm/kvm_main.c
@@ -30,7 +30,7 @@
 #include <linux/debugfs.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/cpu.h>
 #include <linux/sched.h>
 #include <linux/cpumask.h>
@@ -2447,33 +2447,26 @@ static void kvm_exit_debug(void)
 	debugfs_remove(kvm_debugfs_dir);
 }
 
-static int kvm_suspend(struct sys_device *dev, pm_message_t state)
+static int kvm_suspend(void)
 {
 	if (kvm_usage_count)
 		hardware_disable_nolock(NULL);
 	return 0;
 }
 
-static int kvm_resume(struct sys_device *dev)
+static void kvm_resume(void)
 {
 	if (kvm_usage_count) {
 		WARN_ON(raw_spin_is_locked(&kvm_lock));
 		hardware_enable_nolock(NULL);
 	}
-	return 0;
 }
 
-static struct sysdev_class kvm_sysdev_class = {
-	.name = "kvm",
+static struct syscore_ops kvm_syscore_ops = {
 	.suspend = kvm_suspend,
 	.resume = kvm_resume,
 };
 
-static struct sys_device kvm_sysdev = {
-	.id = 0,
-	.cls = &kvm_sysdev_class,
-};
-
 struct page *bad_page;
 pfn_t bad_pfn;
 
@@ -2557,14 +2550,6 @@ int kvm_init(void *opaque, unsigned vcpu
 		goto out_free_2;
 	register_reboot_notifier(&kvm_reboot_notifier);
 
-	r = sysdev_class_register(&kvm_sysdev_class);
-	if (r)
-		goto out_free_3;
-
-	r = sysdev_register(&kvm_sysdev);
-	if (r)
-		goto out_free_4;
-
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
@@ -2572,7 +2557,7 @@ int kvm_init(void *opaque, unsigned vcpu
 					   0, NULL);
 	if (!kvm_vcpu_cache) {
 		r = -ENOMEM;
-		goto out_free_5;
+		goto out_free_3;
 	}
 
 	r = kvm_async_pf_init();
@@ -2589,6 +2574,8 @@ int kvm_init(void *opaque, unsigned vcpu
 		goto out_unreg;
 	}
 
+	register_syscore_ops(&kvm_syscore_ops);
+
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
@@ -2600,10 +2587,6 @@ out_unreg:
 	kvm_async_pf_deinit();
 out_free:
 	kmem_cache_destroy(kvm_vcpu_cache);
-out_free_5:
-	sysdev_unregister(&kvm_sysdev);
-out_free_4:
-	sysdev_class_unregister(&kvm_sysdev_class);
 out_free_3:
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	unregister_cpu_notifier(&kvm_cpu_notifier);
@@ -2631,8 +2614,7 @@ void kvm_exit(void)
 	misc_deregister(&kvm_dev);
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_async_pf_deinit();
-	sysdev_unregister(&kvm_sysdev);
-	sysdev_class_unregister(&kvm_sysdev_class);
+	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	unregister_cpu_notifier(&kvm_cpu_notifier);
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
