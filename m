From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in
	_noirq handlers
Date: Thu,  1 Sep 2011 11:12:02 -0700
Message-ID: <1314900722-10252-1-git-send-email-khilman__10209.4667185613$1314925434$gmane$org@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

The suspend/resume _noirq handlers were #ifdef'd out in the
!CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.1-rc4.

 arch/arm/plat-omap/omap_device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9a6a538..02609ee 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -615,6 +615,9 @@ static int _od_resume_noirq(struct device *dev)
 
 	return pm_generic_resume_noirq(dev);
 }
+#else
+#define _od_suspend_noirq NULL
+#define _od_resume_noirq NULL
 #endif
 
 static struct dev_pm_domain omap_device_pm_domain = {
-- 
1.7.6
