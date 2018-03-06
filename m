From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 02/12] thermal: exynos: remove parsing of
 samsung,tmu_default_temp_offset property
Date: Tue, 06 Mar 2018 15:43:45 +0100
Message-ID: <1520347435-22970-3-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144436epcas2p2f26ee2297cbd0e654930e8bb85512fe6@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Trimming (one point based or two points based) is always used for
the temperature calibration and the default non-trimming code should
never be reached.

Modify temp_to_code() and code_to_temp() accordingly (WARN_ON(1)
in the default cases) and then remove no longer needed parsing of
samsung,tmu_default_temp_offset property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 drivers/thermal/samsung/exynos_tmu.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7..e42a08b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,7 +260,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
 		break;
 	default:
-		temp_code = temp + pdata->default_temp_offset;
+		WARN_ON(1);
 		break;
 	}
 
@@ -287,7 +287,7 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
 		break;
 	default:
-		temp = temp_code - pdata->default_temp_offset;
+		WARN_ON(1);
 		break;
 	}
 
@@ -1164,8 +1164,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->first_point_trim = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
 	pdata->second_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_default_temp_offset", &value);
-	pdata->default_temp_offset = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 8c468b6..a7e81b4 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -50,7 +50,6 @@ enum soc_type {
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
- * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
@@ -65,7 +64,6 @@ struct exynos_tmu_platform_data {
 	u32 max_efuse_value;
 	u8 first_point_trim;
 	u8 second_point_trim;
-	u8 default_temp_offset;
 
 	u32 cal_type;
 };
-- 
1.9.1
