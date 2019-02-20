From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 2/3] firmware: imx: scu-pd: add specifying the base of domain
 name index support
Date: Wed, 20 Feb 2019 14:38:32 +0000
Message-ID: <1550673013-21462-3-git-send-email-aisheng.dong@nxp.com>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

As the domain resource id in the same type may not be continuous, so it's
hard to describe all such power domains with current struct imx_sc_pd_range.

Adding the optional base for domain name index to address this issue.
Then we can add the discrete domains easily later.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 107 ++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index d1d39d9..48f49f8 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -74,7 +74,10 @@ struct imx_sc_pd_range {
 	char *name;
 	u32 rsrc;
 	u8 num;
+
+	/* add domain index */
 	bool postfix;
+	u8 start_from;
 };
 
 struct imx_sc_pd_soc {
@@ -84,71 +87,71 @@ struct imx_sc_pd_soc {
 
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
-	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true },
-	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true },
-	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true },
-	{ "lsio-kpp", IMX_SC_R_KPP, 1, false },
-	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true },
-	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true },
+	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true, 0 },
+	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
+	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true, 0 },
+	{ "lsio-kpp", IMX_SC_R_KPP, 1, false, 0 },
+	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
+	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true, 0 },
 
 	/* CONN SS */
-	{ "con-usb", IMX_SC_R_USB_0, 2, true },
-	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false },
-	{ "con-usb2", IMX_SC_R_USB_2, 1, false },
-	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false },
-	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true },
-	{ "con-enet", IMX_SC_R_ENET_0, 2, true },
-	{ "con-nand", IMX_SC_R_NAND, 1, false },
-	{ "con-mlb", IMX_SC_R_MLB_0, 1, true },
+	{ "con-usb", IMX_SC_R_USB_0, 2, true, 0 },
+	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
+	{ "con-usb2", IMX_SC_R_USB_2, 1, false, 0 },
+	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
+	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
+	{ "con-enet", IMX_SC_R_ENET_0, 2, true, 0 },
+	{ "con-nand", IMX_SC_R_NAND, 1, false, 0 },
+	{ "con-mlb", IMX_SC_R_MLB_0, 1, true, 0 },
 
 	/* Audio DMA SS */
-	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false },
-	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false },
-	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false },
-	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true },
-	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true },
-	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true },
-	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false },
-	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false },
-	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false },
-	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false },
-	{ "adma-sai", IMX_SC_R_SAI_0, 3, true },
-	{ "adma-amix", IMX_SC_R_AMIX, 1, false },
-	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false },
-	{ "adma-dsp", IMX_SC_R_DSP, 1, false },
-	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false },
-	{ "adma-can", IMX_SC_R_CAN_0, 3, true },
-	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true },
-	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true },
-	{ "adma-adc", IMX_SC_R_ADC_0, 1, true },
-	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true },
-	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true },
-	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true },
-	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true },
+	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
+	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
+	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
+	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
+	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
+	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
+	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
+	{ "adma-sai", IMX_SC_R_SAI_0, 3, true, 0 },
+	{ "adma-amix", IMX_SC_R_AMIX, 1, false, 0 },
+	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
+	{ "adma-dsp", IMX_SC_R_DSP, 1, false, 0 },
+	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
+	{ "adma-can", IMX_SC_R_CAN_0, 3, true, 0 },
+	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true, 0 },
+	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "adma-adc", IMX_SC_R_ADC_0, 1, true, 0 },
+	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
+	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 
 	/* VPU SS  */
-	{ "vpu", IMX_SC_R_VPU, 1, false },
-	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true },
-	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false },
-	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false },
+	{ "vpu", IMX_SC_R_VPU, 1, false, 0 },
+	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
+	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
+	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
 
 	/* GPU SS */
-	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true },
+	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
 
 	/* HSIO SS */
-	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false },
-	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false },
-	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false },
+	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
+	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
 	/* MIPI/LVDS SS */
-	{ "mipi0", IMX_SC_R_MIPI_0, 1, false },
-	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false },
-	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true },
-	{ "lvds0", IMX_SC_R_LVDS_0, 1, false },
+	{ "mipi0", IMX_SC_R_MIPI_0, 1, false, 0 },
+	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false, 0 },
+	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true, 0 },
+	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
 
 	/* DC SS */
-	{ "dc0", IMX_SC_R_DC_0, 1, false },
-	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true },
+	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
+	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
@@ -236,7 +239,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 
 	if (pd_ranges->postfix)
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
-			 "%s%i", pd_ranges->name, idx);
+			 "%s%i", pd_ranges->name, pd_ranges->start_from + idx);
 	else
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
 			 "%s", pd_ranges->name);
-- 
2.7.4
