From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 06/12] thermal: thermal_core: correct kernel doc wording on thermal_zone_get_temp
Date: Mon,  9 Feb 2015 17:34:07 -0400
Message-ID: <1423517653-11359-7-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Fix summary wording on thermal_zone_get_temp kernel doc.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 87e0b07..846b68a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -402,7 +402,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 }
 
 /**
- * thermal_zone_get_temp() - returns its the temperature of thermal zone
+ * thermal_zone_get_temp() - returns the temperature of thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device
  * @temp: a valid pointer to where to store the resulting temperature.
  *
-- 
2.1.3
