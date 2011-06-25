From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup devices
	during system sleep transitions
Date: Sat, 25 Jun 2011 23:29:24 +0200
Message-ID: <201106252329.24342.rjw__33773.9093149596$1309037604$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106252324.13454.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Devices that are set up to wake up the system from sleep states
should not be stopped and power should not be removed from them
when the system goes into a sleep state.  Make the generic PM domain
code respect that limitation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -445,6 +445,9 @@ static int pm_genpd_suspend_noirq(struct
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 
@@ -665,6 +668,9 @@ static int pm_genpd_dev_poweroff_noirq(s
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 
