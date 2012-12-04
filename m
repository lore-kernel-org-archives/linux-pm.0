From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH 07/10] KVM: VMX: fix invalid cpu passed to
 smp_call_function_single
Date: Tue, 04 Dec 2012 14:25:38 +0530
Message-ID: <20121204085533.25919.54306.stgit@srivatsabhat.in.ibm.com>
References: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org
Cc: sbw@mit.edu, tj@kernel.org, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>

In loaded_vmcs_clear, loaded_vmcs->cpu is the fist parameter passed to
smp_call_function_single, if the target cpu is downing (doing cpu hot remove),
loaded_vmcs->cpu can become -1 then -1 is passed to smp_call_function_single

It can be triggered when vcpu is being destroyed, loaded_vmcs_clear is called
in the preemptionable context

Signed-off-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kvm/vmx.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f858159..9dc562a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1007,9 +1007,11 @@ static void __loaded_vmcs_clear(void *arg)
 
 static void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
 {
-	if (loaded_vmcs->cpu != -1)
-		smp_call_function_single(
-			loaded_vmcs->cpu, __loaded_vmcs_clear, loaded_vmcs, 1);
+	int cpu = loaded_vmcs->cpu;
+
+	if (cpu != -1)
+		smp_call_function_single(cpu,
+			 __loaded_vmcs_clear, loaded_vmcs, 1);
 }
 
 static inline void vpid_sync_vcpu_single(struct vcpu_vmx *vmx)
