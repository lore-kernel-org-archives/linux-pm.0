From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 1/5] thermal: rockchip: improve conversion error messages
Date: Tue, 22 Nov 2016 20:34:44 +0800
Message-ID: <1479818088-6007-2-git-send-email-wxt@rock-chips.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35249 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbcKVMfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 07:35:16 -0500
In-Reply-To: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, heiko@sntech.de, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>

From: Brian Norris <briannorris@chromium.org>

These error messages don't give much information about what went wrong.
It would be nice, for one, to see what invalid temperature was being
requested when conversion fails. It's also good to return an error when
we can't handle a conversion properly.

While we're at it, fix the grammar too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes:
- The original Brian posted on https://patchwork.kernel.org/patch/9437685
  Brain said: "Note: it'd probably be even nicer to know which sensor this was, but we've
  kinda abstracted that one away by this point..."

 drivers/thermal/rockchip_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index b811b0f..26c247c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 	}
 
 exit:
-	pr_err("Invalid the conversion, error=%d\n", error);
+	pr_err("%s: invalid temperature, temp=%d error=%d\n",
+	       __func__, temp, error);
 	return error;
 }
 
@@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		}
 		break;
 	default:
-		pr_err("Invalid the conversion table\n");
+		pr_err("%s: invalid conversion table, mode=%d\n",
+		       __func__, table.mode);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.7.4

