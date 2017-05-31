From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: FW: [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
Date: Thu, 01 Jun 2017 01:51:32 +0200
Message-ID: <3772609.tskOqDLWI3@aspire.rjw.lan>
References: <20170516042511epcms1p33c79e84f62d4b1d37cf227d2379bbecf@epcms1p3> <CGME20170516042313epcms1p5523f4e3e1ae608eaf0327be0242ee46e@epcms1p6> <20170529021852epcms1p66b2e89d2aec7988e00fb64c41a48a839@epcms1p6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55069 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750954AbdEaX61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 19:58:27 -0400
In-Reply-To: <20170529021852epcms1p66b2e89d2aec7988e00fb64c41a48a839@epcms1p6>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jongman.heo@samsung.com
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Monday, May 29, 2017 02:18:52 AM Jongman Heo wrote:
> 
> Hi,
> 
> FYI, 4.12-rc3 still has this issue.
> 
>  
> --------- Original Message ---------
> Sender : 허종만 <jongman.heo@samsung.com>
> Date   : 2017-05-16 13:25 (GMT+9)
> Title  : [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
>  
>  
> Hi,
>  
> With 4.12-rc1 (Linus git), booting fails due to kernel panic, at intel_pstate_register_driver+0x56/0x110.
> I can't copy the whole trace from the graphic console, it looks like below.
>  
> Call Trace:
>   intel_pstate_init
>   intel_pstate_setup
>   do_one_initcall
>   set_debug_rodata
>   kernel_init_freeable
>   rest_init
>   kernel_init
>   ret_from_fork
>     Code: ...
>   RIP: intel_pstate_register_driver+0x56/0x110 RSP: ffffa3a98000bd80
>   ...

I guess this is a division by 0 due to the unmet assumption that the denominator
in min_perf_pct_min() will always be nonzero.

If this guess is correct, the patch below should help, so can you please test it?

Thanks,
Rafael


---
 drivers/cpufreq/intel_pstate.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -571,9 +571,10 @@ static inline void update_turbo_state(vo
 static int min_perf_pct_min(void)
 {
 	struct cpudata *cpu = all_cpu_data[0];
+	int turbo_pstate = cpu->pstate.turbo_pstate;
 
-	return DIV_ROUND_UP(cpu->pstate.min_pstate * 100,
-			    cpu->pstate.turbo_pstate);
+	return turbo_pstate ?
+		DIV_ROUND_UP(cpu->pstate.min_pstate * 100, turbo_pstate) : 0;
 }
 
 static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
