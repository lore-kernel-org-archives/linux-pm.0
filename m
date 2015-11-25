From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 1/5] thermal: rockchip: fix a trivial typo
Date: Wed, 25 Nov 2015 15:59:33 +0800
Message-ID: <1448438377-29203-2-git-send-email-wxt@rock-chips.com>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e845841..85a7930 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -57,10 +57,10 @@ enum sensor_id {
 };
 
 /**
-* The conversion table has the adc value and temperature.
-* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
-* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
-*/
+ * The conversion table has the adc value and temperature.
+ * ADC_DECREMENT is the adc value decrement.(e.g. v2_code_table)
+ * ADC_INCREMNET is the adc value increment.(e.g. v3_code_table)
+ */
 enum adc_sort_mode {
 	ADC_DECREMENT = 0,
 	ADC_INCREMENT,
@@ -617,7 +617,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	return 0;
 }
 
-/*
+/**
  * Reset TSADC Controller, reset all tsadc registers.
  */
 static void rockchip_thermal_reset_controller(struct reset_control *reset)
-- 
1.9.1
