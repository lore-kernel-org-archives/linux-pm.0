From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 18/22] mfd: axp20x: add MFD cells for AXP20X and AXP22X
 battery driver
Date: Mon,  2 Jan 2017 17:37:18 +0100
Message-ID: <20170102163723.7939-19-quentin.schulz@free-electrons.com>
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

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the AXP20X/AXP22X battery driver to the MFD cells of the
AXP209, AXP221 and AXP223 MFD.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 7f0f05f..8730fc2 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -587,6 +587,9 @@ static struct mfd_cell axp20x_cells[] = {
 		.name		= "axp20x-adc",
 		.of_compatible	= "x-powers,axp209-adc",
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp209-battery-power-supply",
+	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp202-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
@@ -615,6 +618,9 @@ static struct mfd_cell axp221_cells[] = {
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp221-battery-power-supply",
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
@@ -631,6 +637,9 @@ static struct mfd_cell axp223_cells[] = {
 		.name		= "axp20x-adc",
 		.of_compatible	= "x-powers,axp221-adc"
 	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp221-battery-power-supply",
+	}, {
 		.name			= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-ac-power-supply",
-- 
2.9.3
