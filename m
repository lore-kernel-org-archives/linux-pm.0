From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.25-mm1: not looking good
Date: Fri, 18 Apr 2008 14:18:53 +0200
Message-ID: <20080418121853.GA13623@elte.hu>
References: <20080417160331.b4729f0c.akpm@linux-foundation.org>
	<20080418005034.6e4dd9e7.akpm@linux-foundation.org>
	<20080418005323.7c015c42.akpm@linux-foundation.org>
	<20080418005733.aa3e8250.akpm@linux-foundation.org>
	<20080418092254.GA20661@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418092254.GA20661@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jack Steiner <steiner@sgi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Alan Mayer <ajm@sgi.com>, linux-usb@vger.kernel.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>, Thomas Gleixner <tglx@linutronix.de>, Mike Travis <travis@sgi.com>, Stephen Smalley <sds@tycho.nsa.gov>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Subject: x86: disable preemption in native_smp_prepare_cpus

that should be the patch below.

	Ingo

------------>
Subject: x86: disable preemption in native_smp_prepare_cpus
From: Ingo Molnar <mingo@elte.hu>
Date: Fri Apr 18 11:07:10 CEST 2008

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/smpboot.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-x86.q/arch/x86/kernel/smpboot.c
===================================================================
--- linux-x86.q.orig/arch/x86/kernel/smpboot.c
+++ linux-x86.q/arch/x86/kernel/smpboot.c
@@ -1181,6 +1181,7 @@ static void __init smp_cpu_index_default
  */
 void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
+	preempt_disable();
 	nmi_watchdog_default();
 	smp_cpu_index_default();
 	current_cpu_data = boot_cpu_data;
@@ -1197,7 +1198,7 @@ void __init native_smp_prepare_cpus(unsi
 	if (smp_sanity_check(max_cpus) < 0) {
 		printk(KERN_INFO "SMP disabled\n");
 		disable_smp();
-		return;
+		goto out;
 	}
 
 	preempt_disable();
@@ -1237,6 +1238,8 @@ void __init native_smp_prepare_cpus(unsi
 	printk(KERN_INFO "CPU%d: ", 0);
 	print_cpu_info(&cpu_data(0));
 	setup_boot_clock();
+out:
+	preempt_enable();
 }
 /*
  * Early setup to make printk work.
