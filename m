From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] thermal: qcom-spmi: Delete unused field 'prev_stage'
Date: Tue, 24 Jul 2018 16:56:36 -0700
Message-ID: <20180724235636.60357-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The field 'prev_stage' in struct qpnp_tm_chip is not used, remove it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom-spmi-temp-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8d6560..964d35e32027 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -67,7 +67,6 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
-	unsigned int			prev_stage;
 	unsigned int			base;
 	struct iio_channel		*adc;
 };
-- 
2.18.0.233.g985f88cf7e-goog
