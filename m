From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Mon, 20 Dec 2010 14:33:12 +0000
Message-ID: <1292855593-30608-1-git-send-email-broonie__22951.2113648982$1292855670$gmane$org@opensource.wolfsonmicro.com>
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
To: Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The pm_generic_ operations are all exported but are not prototyped in any
header file for direct use. Do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/pm.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 40f3f45..f7b5bed 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -610,4 +610,11 @@ extern unsigned int	pm_flags;
 #define PM_APM	1
 #define PM_ACPI	2
 
+int pm_generic_suspend(struct device *dev);
+int pm_generic_resume(struct device *dev);
+int pm_generic_freeze(struct device *dev);
+int pm_generic_thaw(struct device *dev);
+int pm_generic_restore(struct device *dev);
+int pm_generic_poweroff(struct device *dev);
+
 #endif /* _LINUX_PM_H */
-- 
1.7.2.3
