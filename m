From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Fri, 18 Nov 2016 15:52:56 -0800
Message-ID: <1479513177-81504-2-git-send-email-briannorris@chromium.org>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

These error messages don't give much information about what went wrong.
It would be nice, for one, to see what invalid temperature was being
requested when conversion fails. It's also good to return an error when
we can't handle a conversion properly.

While we're at it, fix the grammar too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Note: it'd probably be even nicer to know which sensor this was, but we've
kinda abstracted that one away by this point...

 drivers/thermal/rockchip_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e227a9f0acf7..35554d146b9d 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 	}
 
 exit:
-	pr_err("Invalid the conversion, error=%d\n", error);
+	pr_err("%s: invalid temperature, temp=%d error=%d\n",
+		__func__, temp, error);
 	return error;
 }
 
@@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		}
 		break;
 	default:
-		pr_err("Invalid the conversion table\n");
+		pr_err("%s: invalid conversion table, mode=%d\n",
+			__func__, table.mode);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.8.0.rc3.226.g39d4020
