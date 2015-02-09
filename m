From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 09/12] thermal: user space: fix kernel doc entry
Date: Mon,  9 Feb 2015 17:34:10 -0400
Message-ID: <1423517653-11359-10-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Update kernel doc entry and correct the format. Now
kernel doc does not complain about it.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/user_space.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 10adcdd..29c91cb 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -28,9 +28,12 @@
 
 /**
  * notify_user_space - Notifies user space about thermal events
- * @tz - thermal_zone_device
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * This function notifies the user space through UEvents.
+ *
+ * Return: 0.
  */
 static int notify_user_space(struct thermal_zone_device *tz, int trip)
 {
-- 
2.1.3
