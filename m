From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/14] power: ipaq-micro-battery: use __maybe_unused to hide
 pm functions
Date: Wed,  2 Mar 2016 16:58:55 +0100
Message-ID: <1456934350-1389172-4-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The ipaq micro battery driver has suspend/resume functions that
are accessed using SIMPLE_DEV_PM_OPS, which hide the reference
when CONFIG_PM_SLEEP is not set, resulting in a warning about
unused functions:

drivers/power/ipaq_micro_battery.c:284:12: error: 'micro_batt_suspend' defined but not used [-Werror=unused-function]
drivers/power/ipaq_micro_battery.c:292:12: error: 'micro_batt_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to let the compiler know
it can silently drop the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/ipaq_micro_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index f03014ea1dc4..3f314b1a30d7 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -281,7 +281,7 @@ static int micro_batt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int micro_batt_suspend(struct device *dev)
+static int __maybe_unused micro_batt_suspend(struct device *dev)
 {
 	struct micro_battery *mb = dev_get_drvdata(dev);
 
@@ -289,7 +289,7 @@ static int micro_batt_suspend(struct device *dev)
 	return 0;
 }
 
-static int micro_batt_resume(struct device *dev)
+static int __maybe_unused micro_batt_resume(struct device *dev)
 {
 	struct micro_battery *mb = dev_get_drvdata(dev);
 
-- 
2.7.0
