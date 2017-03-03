From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V10 2/6] thermal: of-thermal: Implement signed coefficient
 support
Date: Fri,  3 Mar 2017 23:18:45 +0000
Message-ID: <1488583129-4159-3-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Martin Sperl <kernel@martin.sperl.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Use the new function of_property_read_s32_array() to prepare
of-thermal for negative coefficients. These are used by
the upcoming bcm2835_thermal driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/thermal/of-thermal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b..491d58a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -821,7 +821,8 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	struct device_node *child = NULL, *gchild;
 	struct __thermal_zone *tz;
 	int ret, i;
-	u32 prop, coef[2];
+	u32 prop;
+	s32 coef[2];
 
 	if (!np) {
 		pr_err("no thermal zone np\n");
@@ -851,7 +852,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	 * one sensor per thermal zone. Thus, we are considering
 	 * only the first two values as slope and offset.
 	 */
-	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
+	ret = of_property_read_s32_array(np, "coefficients", coef, 2);
 	if (ret == 0) {
 		tz->slope = coef[0];
 		tz->offset = coef[1];
-- 
1.7.9.5
