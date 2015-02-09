From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 05/12] thermal: thermal.h: minor kernel doc fix
Date: Mon,  9 Feb 2015 17:34:06 -0400
Message-ID: <1423517653-11359-6-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

s/scallbacks/callbacks/g

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e30..46c16a0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -261,7 +261,7 @@ struct thermal_genl_event {
 };
 
 /**
- * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
+ * struct thermal_zone_of_device_ops - callbacks for handling DT based zones
  *
  * Mandatory:
  * @get_temp: a pointer to a function that reads the sensor temperature.
-- 
2.1.3
