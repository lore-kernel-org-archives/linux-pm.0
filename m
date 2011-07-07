From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/05] ARM: mach-shmobile: sh7372 late pm domain
	off
Date: Thu, 07 Jul 2011 22:32:37 +0900
Message-ID: <20110707133237.22347.5463.sendpatchset__12269.3035439172$1310045244$gmane$org@t400s>
References: <20110707133212.22347.68775.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110707133212.22347.68775.sendpatchset@t400s>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7372 specific code to power down unused pm domains.

This should really be replaced by some generic PM core
code IMO, but until that happens this patch makes sure
we don't waste power by leaving unused power domains on.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0005/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-07-07 20:15:19.000000000 +0900
@@ -96,6 +96,17 @@ static bool pd_active_wakeup(struct devi
 	return true;
 }
 
+static void sh7372_late_pm_domain_off(void)
+{
+	/* request power down of unused pm domains */
+	queue_work(pm_wq, &sh7372_a4lc.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_a4mp.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_d4.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_a3rv.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_a3ri.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_a3sg.genpd.power_off_work);
+}
+
 void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd)
 {
 	struct generic_pm_domain *genpd = &sh7372_pd->genpd;
@@ -107,6 +118,8 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
 	pd_power_up(&sh7372_pd->genpd);
+
+	shmobile_runtime_pm_late_init = sh7372_late_pm_domain_off;
 }
 
 void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
