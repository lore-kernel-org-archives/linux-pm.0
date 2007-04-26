From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] re-add pnx4008 standby mode
Date: Thu, 26 Apr 2007 18:17:59 +0200
Message-ID: <1177604279.6814.84.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I just noticed that when I was cleaning up the pm_ops implementations I
accidentally removed the standby mode from pnx4008 by not marking it
valid. This patch adds it back and also removes some useless related
code.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 arch/arm/mach-pnx4008/pm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- wireless-dev.orig/arch/arm/mach-pnx4008/pm.c	2007-04-26 17:25:56.793249310 +0200
+++ wireless-dev/arch/arm/mach-pnx4008/pm.c	2007-04-26 17:26:45.503249310 +0200
@@ -107,17 +107,19 @@ static int pnx4008_pm_enter(suspend_stat
 	case PM_SUSPEND_MEM:
 		pnx4008_suspend();
 		break;
-	case PM_SUSPEND_DISK:
-		return -ENOTSUPP;
-	default:
-		return -EINVAL;
 	}
 	return 0;
 }
 
+static int pnx4008_pm_valid(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_STANDBY) ||
+	       (state == PM_SUSPEND_MEM);
+}
+
 static struct pm_ops pnx4008_pm_ops = {
 	.enter = pnx4008_pm_enter,
-	.valid = pm_valid_only_mem,
+	.valid = pnx4008_pm_valid,
 };
 
 static int __init pnx4008_pm_init(void)
