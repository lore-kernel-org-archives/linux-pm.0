From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 04/12] thermal: of-thermal: remove kernel doc warn
Date: Mon,  9 Feb 2015 17:34:05 -0400
Message-ID: <1423517653-11359-5-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The comment about trip type map is not a kernel doc
comment. Therefore, remove the kernel doc format,
so kernel doc won't complain.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d717f3d..b66e3b2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -621,7 +621,7 @@ end:
 	return ret;
 }
 
-/**
+/*
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
  */
-- 
2.1.3
