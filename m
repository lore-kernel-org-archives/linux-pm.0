From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 1/5] thermal: rockchip: improve conversion error messages
Date: Mon, 12 Dec 2016 19:05:31 +0800
Message-ID: <1481540735-12710-2-git-send-email-wxt@rock-chips.com>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

These error messages don't give much information about what went wrong.
It would be nice, for one, to see what invalid temperature was being
requested when conversion fails. It's also good to return an error when
we can't handle a conversion properly.

While we're at it, fix the grammar too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4:
- As Eduardo and Brian commnets on
  https://patchwork.kernel.org/patch/9449301

Changes in v3: None
Changes in v2: None
Changes in v1:
- The original Brian posted on https://patchwork.kernel.org/patch/9437686
  Note: it'd probably be even nicer to know which sensor this was, but we've
  kinda abstracted that one away by this point...

 drivers/thermal/rockchip_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index b811b0f..3bbc97c 100644
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
 
@@ -475,7 +476,8 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 		}
 		break;
 	default:
-		pr_err("Invalid the conversion table\n");
+		pr_err("%s: unknown table mode: %d\n", __func__, table.mode);
+		return -EINVAL;
 	}
 
 	/*
-- 
2.7.4
