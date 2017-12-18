From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v4 02/12] thermal: armada: Use msleep for long delays
Date: Mon, 18 Dec 2017 15:36:33 +0100
Message-ID: <20171218143643.7714-3-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

Use msleep for long (> 10ms) delays, instead of the busy waiting mdelay.
All delays are called from the probe routine, where scheduling is
allowed.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 706d74798cbe..6c4af2622d4f 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -113,7 +113,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
 	reg &= ~PMU_TDC0_START_CAL_MASK;
 	writel(reg, priv->control);
 
-	mdelay(10);
+	msleep(10);
 }
 
 static void armada375_init_sensor(struct platform_device *pdev,
@@ -127,11 +127,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
 	reg &= ~A375_HW_RESETn;
 
 	writel(reg, priv->control + 4);
-	mdelay(20);
+	msleep(20);
 
 	reg |= A375_HW_RESETn;
 	writel(reg, priv->control + 4);
-	mdelay(50);
+	msleep(50);
 }
 
 static void armada380_init_sensor(struct platform_device *pdev,
@@ -143,7 +143,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
 		writel(reg, priv->control);
-		mdelay(10);
+		msleep(10);
 	}
 }
 
-- 
2.11.0
