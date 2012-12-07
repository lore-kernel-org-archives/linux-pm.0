From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 8/9] kvm,
 vmx: Add atomic synchronization with CPU Hotplug
Date: Fri, 07 Dec 2012 23:10:08 +0530
Message-ID: <20121207174003.27305.71976.stgit@srivatsabhat.in.ibm.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com
Cc: sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

preempt_disable() will no longer help prevent CPUs from going offline, once
stop_machine() gets removed from the CPU offline path. So use
get/put_online_cpus_atomic() in vmx_vcpu_load() to prevent CPUs from
going offline while clearing vmcs.

Reported-by: Michael Wang <wangyun@linux.vnet.ibm.com>
Debugged-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kvm/vmx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f858159..d8a4cf1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1519,10 +1519,14 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
 
-	if (!vmm_exclusive)
+	if (!vmm_exclusive) {
 		kvm_cpu_vmxon(phys_addr);
-	else if (vmx->loaded_vmcs->cpu != cpu)
+	} else if (vmx->loaded_vmcs->cpu != cpu) {
+		/* Prevent any CPU from going offline */
+		get_online_cpus_atomic();
 		loaded_vmcs_clear(vmx->loaded_vmcs);
+		put_online_cpus_atomic();
+	}
 
 	if (per_cpu(current_vmcs, cpu) != vmx->loaded_vmcs->vmcs) {
 		per_cpu(current_vmcs, cpu) = vmx->loaded_vmcs->vmcs;
