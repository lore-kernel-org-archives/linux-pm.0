From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3 1/3] mfd/axp20x: change battery cell name to fuel gauge
Date: Wed, 28 Jan 2015 13:23:38 -0800
Message-ID: <7eeb583b0922e325cdf65ac6f450680169721b7d.1422478693.git.todd.e.brandt@linux.intel.com>
References: <cover.1422478693.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1422478693.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1422478693.git.todd.e.brandt@linux.intel.com>
References: <cover.1422478693.git.todd.e.brandt@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, david.woodhouse@intel.com, jic23@kernel.org
List-Id: linux-pm@vger.kernel.org

Name changes to the battery cell structure to a
more generic cell type: fuel gauge.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Acked-By: Sebastian Reichel <sre@kernel.org>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/mfd/axp20x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

v1: 01/07/14
v2: 01/22/14
- replaced the const in axp20x_acpi_match declaration
v3: same as v2

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index b1b580a..0acbe52 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -87,7 +87,7 @@ static struct resource axp20x_pek_resources[] = {
 	},
 };
 
-static struct resource axp288_battery_resources[] = {
+static struct resource axp288_fuel_gauge_resources[] = {
 	{
 		.start = AXP288_IRQ_QWBTU,
 		.end   = AXP288_IRQ_QWBTU,
@@ -350,9 +350,9 @@ static struct mfd_cell axp288_cells[] = {
 		.resources = axp288_charger_resources,
 	},
 	{
-		.name = "axp288_battery",
-		.num_resources = ARRAY_SIZE(axp288_battery_resources),
-		.resources = axp288_battery_resources,
+		.name = "axp288_fuel_gauge",
+		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
+		.resources = axp288_fuel_gauge_resources,
 	},
 	{
 		.name = "axp288_pmic_acpi",
-- 
2.1.0
