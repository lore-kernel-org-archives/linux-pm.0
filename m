From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: FW: [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
Date: Fri, 02 Jun 2017 02:41:04 +0200
Message-ID: <1531609.n2MRKDRlk2@aspire.rjw.lan>
References: <3772609.tskOqDLWI3@aspire.rjw.lan> <CGME20170516042313epcms1p5523f4e3e1ae608eaf0327be0242ee46e@epcms1p1> <20170601010816epcms1p16cded9ef0657a694c5a7a73ab723ecd7@epcms1p1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601010816epcms1p16cded9ef0657a694c5a7a73ab723ecd7@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
To: jongman.heo@samsung.com
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 01, 2017 01:08:16 AM Jongman Heo wrote:
> > 
> >--------- Original Message ---------
> >Sender : Rafael J. Wysocki <rjw@rjwysocki.net>
> >Date   : 2017-06-01 08:58 (GMT+9)
> >Title  : Re: FW: [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
> > 
> >On Monday, May 29, 2017 02:18:52 AM Jongman Heo wrote:
> >> 
> >> Hi,
> >> 
> >> FYI, 4.12-rc3 still has this issue.
> >> 
> >>  
> >> --------- Original Message ---------
> >> Sender : 허종만 <jongman.heo@samsung.com>
> >> Date   : 2017-05-16 13:25 (GMT+9)
> >> Title  : [4.12 regression] "cpufreq: intel_pstate: Active mode P-state limits rework"
> >>  
> >>  
> >> Hi,
> >>  
> >> With 4.12-rc1 (Linus git), booting fails due to kernel panic, at intel_pstate_register_driver+0x56/0x110.
> >> I can't copy the whole trace from the graphic console, it looks like below.
> >>  
> >> Call Trace:
> >>   intel_pstate_init
> >>   intel_pstate_setup
> >>   do_one_initcall
> >>   set_debug_rodata
> >>   kernel_init_freeable
> >>   rest_init
> >>   kernel_init
> >>   ret_from_fork
> >>     Code: ...
> >>   RIP: intel_pstate_register_driver+0x56/0x110 RSP: ffffa3a98000bd80
> >>   ...
> > 
> >I guess this is a division by 0 due to the unmet assumption that the denominator
> >in min_perf_pct_min() will always be nonzero.
> > 
> >If this guess is correct, the patch below should help, so can you please test it?
> > 
> >Thanks,
> >Rafael
> > 
> > 
> >---
> > drivers/cpufreq/intel_pstate.c |    5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> >Index: linux-pm/drivers/cpufreq/intel_pstate.c
> >===================================================================
> >--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> >+++ linux-pm/drivers/cpufreq/intel_pstate.c
> >@@ -571,9 +571,10 @@ static inline void update_turbo_state(vo
> > static int min_perf_pct_min(void)
> > {
> >         struct cpudata *cpu = all_cpu_data[0];
> >+        int turbo_pstate = cpu->pstate.turbo_pstate;
> > 
> >-        return DIV_ROUND_UP(cpu->pstate.min_pstate * 100,
> >-                            cpu->pstate.turbo_pstate);
> >+        return turbo_pstate ?
> >+                DIV_ROUND_UP(cpu->pstate.min_pstate * 100, turbo_pstate) : 0;
> > }
> > 
> > static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
> > 
> > 
> > 
> 
> Hi,
> 
> Your patch fixes the issue.

OK, thanks for the confirmation.

Here it goes again with a changelog and all.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Avoid division by 0 in min_perf_pct_min()

Commit c5a2ee7dde89 (cpufreq: intel_pstate: Active mode P-state
limits rework) incorrectly assumed that pstate.turbo_pstate will
always be nonzero for CPU0 in min_perf_pct_min() if
cpufreq_register_driver() has succeeded which may not be the case
in virtualized environments.

If that is not the case, it leads to an early crash on boot in
intel_pstate_register_driver(), so add a sanity check to
min_perf_pct_min() to prevent the crash from happening.

Fixes: c5a2ee7dde89 (cpufreq: intel_pstate: Active mode P-state limits rework)
Reported-and-tested-by: Jongman Heo <jongman.heo@samsung.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
