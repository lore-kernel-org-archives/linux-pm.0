From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] cpuidle: stop depending on pm_idle
 --build break
Date: Fri, 05 Aug 2011 17:48:18 +0530
Message-ID: <4E3BDF8A.5090103__26558.8689748713$1312546783$gmane$org@linux.vnet.ibm.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
	<619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Following is a patch required to compile on arm
and sh with the latest cpuidle cleanup changes. 

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>

Index: linux/arch/arm/kernel/process.c
===================================================================
--- linux.orig/arch/arm/kernel/process.c        2011-08-05 11:02:59.000000000 +0000
+++ linux/arch/arm/kernel/process.c     2011-08-05 11:10:03.000000000 +0000
@@ -197,7 +197,7 @@
                                cpu_relax();
                        } else {
                                stop_critical_timings();
-                               if (cpuidle_call_idle())
+                               if (cpuidle_idle_call())
                                        pm_idle();
                                start_critical_timings();
                                /*
Index: linux/arch/sh/kernel/idle.c
===================================================================
--- linux.orig/arch/sh/kernel/idle.c    2011-08-05 11:02:59.000000000 +0000
+++ linux/arch/sh/kernel/idle.c 2011-08-05 11:13:23.000000000 +0000
@@ -101,7 +101,7 @@
                        local_irq_disable();
                        /* Don't trace irqs off for idle */
                        stop_critical_timings();
-                       if (cpuidle_call_idle())
+                       if (cpuidle_idle_call())
                                pm_idle();
                        /*
                         * Sanity check to ensure that pm_idle() returns
