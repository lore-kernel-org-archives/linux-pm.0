From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Domains: Take .power_off() error code
	into account
Date: Wed, 13 Jul 2011 23:55:27 +0200
Message-ID: <201107132355.27355.rjw__49368.7283866622$1310594681$gmane$org@sisk.pl>
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

Currently pm_genpd_poweroff() discards error codes returned by
the PM domain's .power_off() callback, because it's safer to always
regard the domain as inaccessible to drivers after a failing
.power_off().  Still, there are situations in which the low-level
code may want to indicate that it doesn't want to power off the
domain, so allow it to do that by returning -EBUSY from .power_off().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -312,8 +312,16 @@ static int pm_genpd_poweroff(struct gene
 		}
 	}
 
-	if (genpd->power_off)
-		genpd->power_off(genpd);
+	if (genpd->power_off) {
+		ret = genpd->power_off(genpd);
+		if (ret == -EBUSY) {
+			genpd_set_active(genpd);
+			if (parent)
+				genpd_release_lock(parent);
+
+			goto out;
+		}
+	}
 
 	genpd->status = GPD_STATE_POWER_OFF;
 
