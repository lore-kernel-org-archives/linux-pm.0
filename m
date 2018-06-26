From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] power: generic-adc-battery: check for duplicate properties copied from iio channels
Date: Tue, 26 Jun 2018 15:28:30 +0200
Message-ID: <0df4d5dc7d3591b8341dba50481d10fbb201fa9d.1530019688.git.hns@goldelico.com>
References: <cover.1530019688.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
References: <cover.1530019688.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, anish kumar <anish198519851985@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If an iio channel defines a basic property, there are duplicate entries
in /sys/class/power/*/uevent.

So add a check to avoid duplicates. Since all channels may be duplicates,
we have to modify the related error check.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
---
 drivers/power/supply/generic-adc-battery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 11f59275bff4..bc462d1ec963 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -244,6 +244,7 @@ static int gab_probe(struct platform_device *pdev)
 	int ret = 0;
 	int chan;
 	int index = ARRAY_SIZE(gab_props);
+	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -290,12 +291,22 @@ static int gab_probe(struct platform_device *pdev)
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			psy_desc->properties[index++] = gab_dyn_props[chan];
+			int index2;
+
+			for (index2 = 0; index2 < index; index2++) {
+				if (psy_desc->properties[index2] ==
+				    gab_dyn_props[chan])
+					break;	/* already known */
+			}
+			if (index2 == index)	/* really new */
+				psy_desc->properties[index++] =
+					gab_dyn_props[chan];
+			any = true;
 		}
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (index == ARRAY_SIZE(gab_props)) {
+	if (!any) {
 		ret = -ENODEV;
 		goto second_mem_fail;
 	}
-- 
2.12.2
