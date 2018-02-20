From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] power: supply: axp20x_battery: axp209_data can be static
Date: Tue, 20 Feb 2018 17:12:25 +0800
Message-ID: <20180220091225.GA95450@cairo>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, lars@metafoo.de, thomas.petazzoni@bootlin.com, linux-pm@vger.kernel.org, maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, linux@armlinux.org.uk, sre@kernel.org, linux-iio@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, kbuild-all@01.org, pmeerw@pmeerw.net, knaack.h@gmx.de, lee.jones@linaro.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


Fixes: 94767270f0b0 ("power: supply: axp20x_battery: use data struct for variant specific code")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 axp20x_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 099e785..04a0d91 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -476,14 +476,14 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
-const struct axp_data axp209_data = {
+static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
 
-const struct axp_data axp221_data = {
+static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
 	.has_fg_valid = true,
