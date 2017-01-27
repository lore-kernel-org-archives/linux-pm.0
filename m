From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 02/25] mfd: axp20x: correct name of temperature data ADC
 registers
Date: Fri, 27 Jan 2017 09:54:35 +0100
Message-ID: <20170127085458.18270-3-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The registers 0x56 and 0x57 of AXP22X PMIC store the value of the
internal temperature of the PMIC.

This patch modifies the name of these registers from AXP22X_PMIC_ADC_H/L
to AXP22X_PMIC_TEMP_H/L so their purpose is clearer.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 drivers/mfd/axp20x.c       | 2 +-
 include/linux/mfd/axp20x.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 619a83e..9c2fd37 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -102,7 +102,7 @@ static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
-	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP22X_PMIC_TEMP_H, AXP20X_IPSOUT_V_HIGH_L),
 	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index a4860bc..5ecadbb 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -228,8 +228,8 @@ enum {
 #define AXP20X_OCV_MAX			0xf
 
 /* AXP22X specific registers */
-#define AXP22X_PMIC_ADC_H		0x56
-#define AXP22X_PMIC_ADC_L		0x57
+#define AXP22X_PMIC_TEMP_H		0x56
+#define AXP22X_PMIC_TEMP_L		0x57
 #define AXP22X_TS_ADC_H			0x58
 #define AXP22X_TS_ADC_L			0x59
 #define AXP22X_BATLOW_THRES1		0xe6
-- 
2.9.3
