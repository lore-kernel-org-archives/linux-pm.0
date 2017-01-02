From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 02/22] mfd: axp20x: add ADC data regs to volatile regs for
 AXP22X
Date: Mon,  2 Jan 2017 17:37:02 +0100
Message-ID: <20170102163723.7939-3-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The AXP22X PMICs have multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the different ADC data registers to the volatile registers of
the AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 619a83e..a33db5e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -100,6 +100,7 @@ static const struct regmap_range axp22x_writeable_ranges[] = {
 static const struct regmap_range axp22x_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
 	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
+	regmap_reg_range(AXP22X_TEMP_ADC_H, AXP20X_BATT_DISCHRG_I_L),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
 	regmap_reg_range(AXP22X_PMIC_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
-- 
2.9.3
