From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/05] ARM: mach-shmobile: sh7372 A3RV requires
	A4LC
Date: Thu, 07 Jul 2011 22:32:53 +0900
Message-ID: <20110707133253.22347.66361.sendpatchset__24909.7338798039$1310045257$gmane$org@t400s>
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

Add a power domain workaround for the VPU and A3RV on sh7372.

The sh7372 data sheet mentions that the VPU is located in the
A3RV power domain. The A3RV power domain is not related to A4LC
in any way, but testing shows that unless A3RV _and_ A4LC are
powered on the VPU test program will bomb out.

This issue may be caused by a more or less undocumented dependency
on the MERAM block that happens to be located in A4LC. So now we
know that the out-of-reset requirement of the VPU is that the MERAM
is powered on.

This patch adds a workaround for A3RV to make sure A4LC is powered
on - this so we can use the VPU even though the LCDCs are in blanking
state and A4LC is supposed to be off.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |   45 +++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

--- 0006/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-07-07 21:57:14.000000000 +0900
@@ -91,6 +91,36 @@ static int pd_power_up(struct generic_pm
 	return ret;
 }
 
+static int pd_power_up_a3rv(struct generic_pm_domain *genpd)
+{
+	int ret = pd_power_up(genpd);
+
+	/* force A4LC on after A3RV has been requested on */
+	pm_genpd_poweron(&sh7372_a4lc.genpd);
+
+	return ret;
+}
+
+static int pd_power_down_a3rv(struct generic_pm_domain *genpd)
+{
+	int ret = pd_power_down(genpd);
+
+	/* try to power down A4LC after A3RV is requested off */
+	pm_genpd_poweron(&sh7372_a4lc.genpd);
+	queue_work(pm_wq, &sh7372_a4lc.genpd.power_off_work);
+
+	return ret;
+}
+
+static int pd_power_down_a4lc(struct generic_pm_domain *genpd)
+{
+	/* only power down A4LC if A3RV is off */
+	if (!(__raw_readl(PSTR) & (1 << sh7372_a3rv.bit_shift)))
+		return pd_power_down(genpd);
+
+	return 0;
+}
+
 static bool pd_active_wakeup(struct device *dev)
 {
 	return true;
@@ -115,9 +145,18 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->stop_device = pm_clk_suspend;
 	genpd->start_device = pm_clk_resume;
 	genpd->active_wakeup = pd_active_wakeup;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
-	pd_power_up(&sh7372_pd->genpd);
+
+	if (sh7372_pd == &sh7372_a4lc) {
+		genpd->power_off = pd_power_down_a4lc;
+		genpd->power_on = pd_power_up;
+	} else if (sh7372_pd == &sh7372_a3rv) {
+		genpd->power_off = pd_power_down_a3rv;
+		genpd->power_on = pd_power_up_a3rv;
+	} else {
+		genpd->power_off = pd_power_down;
+		genpd->power_on = pd_power_up;
+	}
+	genpd->power_on(&sh7372_pd->genpd);
 
 	shmobile_runtime_pm_late_init = sh7372_late_pm_domain_off;
 }
