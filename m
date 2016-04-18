From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 2/9] thermal: rockchip: fixes the code_to_temp for tsadc driver
Date: Mon, 18 Apr 2016 11:35:54 +0800
Message-ID: <1460950562-20652-3-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We should judge the table.id[mid].code insearch algorithm on matter the
adc value increment or decrement.

Or otherwise, the temperature return the incorrect value in some cases.
[    1.438589] adc_val=402,temp=-40000
[    1.438903] adc_val=403,temp=-39375
[    1.439217] adc_val=404,temp=-38750
...
[    1.441102] adc_val=410,temp=-40000
[    1.441416] adc_val=411,temp=-34445
[    1.441737] adc_val=412,temp=-33889
...

Let's fix it right now.

Fixes commit 020ba95dbbbe ("thermal: rockchip:
Add the sort mode for adc value increment or decrement").

Reported-by: Rocky Hao <rocky.hao@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
---

 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f4c4bcd..658772f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -405,8 +405,8 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 			return -EAGAIN;		/* Incorrect reading */
 
 		while (low <= high) {
-			if (code >= table.id[mid - 1].code &&
-			    code < table.id[mid].code)
+			if (code <= table.id[mid].code &&
+			    code > table.id[mid - 1].code)
 				break;
 			else if (code > table.id[mid].code)
 				low = mid + 1;
-- 
1.9.1
