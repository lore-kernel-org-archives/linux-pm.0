From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: [PATCH] video: da8xx-fb: fix typos
Date: Fri, 21 Feb 2014 12:11:04 +0530
Message-ID: <1392964864-25371-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch fixes couple of typos in the comments
for da8xx-fb.c file.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/video/da8xx-fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index a1d74dd..dced43a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -265,7 +265,7 @@ static void lcd_enable_raster(void)
 		lcdc_write(0, LCD_CLK_RESET_REG);
 	mdelay(1);
 
-	/* Above reset sequence doesnot reset register context */
+	/* Above reset sequence does not reset register context */
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (!(reg & LCD_RASTER_ENABLE))
 		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
@@ -357,7 +357,7 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
 	lcd_enable_raster();
 }
 
-/* Configure the Burst Size and fifo threhold of DMA */
+/* Configure the Burst Size and fifo threshold of DMA */
 static int lcd_cfg_dma(int burst_size, int fifo_th)
 {
 	u32 reg;
@@ -393,7 +393,7 @@ static void lcd_cfg_ac_bias(int period, int transitions_per_int)
 {
 	u32 reg;
 
-	/* Set the AC Bias Period and Number of Transisitons per Interrupt */
+	/* Set the AC Bias Period and Number of Transitions per Interrupt */
 	reg = lcdc_read(LCD_RASTER_TIMING_2_REG) & 0xFFF00000;
 	reg |= LCD_AC_BIAS_FREQUENCY(period) |
 		LCD_AC_BIAS_TRANSITIONS_PER_INT(transitions_per_int);
-- 
1.7.9.5
