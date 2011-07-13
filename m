From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] ARM / shmobile: Return -EBUSY from A4LC
	power off if A3RV is active
Date: Wed, 13 Jul 2011 23:56:44 +0200
Message-ID: <201107132356.45037.rjw__21550.0480182984$1310594288$gmane$org@sisk.pl>
References: <201107132352.59801.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107132352.59801.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the A4LC should only be powered off if the A3RV is off, make
the A4LC's power down routine return -EBUSY if A3RV is not off to
indicate to the core that it doesn't want to power off the domain in
that case.  This will cause the core to regard A4LC as active, so
the pm_genpd_poweron() in pd_power_down_a3rv() is not necessary any
more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
@@ -106,7 +106,6 @@ static int pd_power_down_a3rv(struct gen
 	int ret = pd_power_down(genpd);
 
 	/* try to power down A4LC after A3RV is requested off */
-	pm_genpd_poweron(&sh7372_a4lc.genpd);
 	genpd_queue_power_off_work(&sh7372_a4lc.genpd);
 
 	return ret;
@@ -118,7 +117,7 @@ static int pd_power_down_a4lc(struct gen
 	if (!(__raw_readl(PSTR) & (1 << sh7372_a3rv.bit_shift)))
 		return pd_power_down(genpd);
 
-	return 0;
+	return -EBUSY;
 }
 
 static bool pd_active_wakeup(struct device *dev)
