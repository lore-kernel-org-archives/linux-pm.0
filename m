From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/18] cpuidle: stop using pm_idle
Date: Mon, 25 Apr 2011 16:11:23 +0530
Message-ID: <4DB54FD3.2090007__28621.5456588709$1303728156$gmane$org@linux.vnet.ibm.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5f8cf82855ca448698efe66f48779972ad08ffc0.1301724243.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5f8cf82855ca448698efe66f48779972ad08ffc0.1301724243.git.len.brown@intel.com>
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



On 04/02/2011 11:52 AM, Len Brown wrote:
> From: Len Brown<len.brown@intel.com>
>
> pm_idle does not scale as an idle handler registration mechanism.
> Don't use it for cpuidle.  Instead, call cpuidle directly, and
> allow architectures to use pm_idle as an arch-specific default
> if they need it.  ie.
>
> cpu_idle()
> 	...
> 	if(cpuidle_call_idle())
> 		pm_idle();
>

Hi Len,

This doesn't compile right now for ARM. The patch below
(on top of your series) is required to compile on arm, sh

Thanks,
-Trinabh

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d7ee0d4..1a347f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -197,7 +197,7 @@ void cpu_idle(void)
  				cpu_relax();
  			} else {
  				stop_critical_timings();
-				if (cpuidle_call_idle())
+				if (cpuidle_idle_call())
  					pm_idle();
  				start_critical_timings();
  				/*
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 9c7099e..1db1968 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -101,7 +101,7 @@ void cpu_idle(void)
  			local_irq_disable();
  			/* Don't trace irqs off for idle */
  			stop_critical_timings();
-			if (cpuidle_call_idle())
+			if (cpuidle_idle_call())
  				pm_idle();
  			/*
  			 * Sanity check to ensure that pm_idle() returns
