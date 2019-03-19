From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 3/3] firmware: imx: scu-pd: decouple the SS information
 from domain names
Date: Tue, 19 Mar 2019 17:04:42 +0800
Message-ID: <20190319090441.GA28063@dragon>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
 <1550673013-21462-4-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1550673013-21462-4-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 02:38:36PM +0000, Aisheng Dong wrote:
> As resource power domain service is provided by SCU firmware, no
> SS information required. So we can remove the SS indicator from
> the domain names, then the domains defined can be better shared
> among different SCU based platforms.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/firmware/imx/scu-pd.c | 92 ++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> index 48f49f8..cd745b9 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -87,49 +87,51 @@ struct imx_sc_pd_soc {
>  
>  static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>  	/* LSIO SS */
> -	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true, 0 },
> -	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
> -	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true, 0 },
> -	{ "lsio-kpp", IMX_SC_R_KPP, 1, false, 0 },
> -	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
> -	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true, 0 },
> +	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
> +	{ "gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
> +	{ "gpt", IMX_SC_R_GPT_0, 5, true, 0 },
> +	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
> +	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
> +	{ "mu", IMX_SC_R_MU_0A, 14, true, 0 },
>  
>  	/* CONN SS */
> -	{ "con-usb", IMX_SC_R_USB_0, 2, true, 0 },
> -	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
> -	{ "con-usb2", IMX_SC_R_USB_2, 1, false, 0 },
> -	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
> -	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
> -	{ "con-enet", IMX_SC_R_ENET_0, 2, true, 0 },
> -	{ "con-nand", IMX_SC_R_NAND, 1, false, 0 },
> -	{ "con-mlb", IMX_SC_R_MLB_0, 1, true, 0 },
> -
> -	/* Audio DMA SS */
> -	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
> -	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
> -	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
> -	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
> -	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
> -	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
> -	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
> -	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
> -	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
> -	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
> -	{ "adma-sai", IMX_SC_R_SAI_0, 3, true, 0 },
> -	{ "adma-amix", IMX_SC_R_AMIX, 1, false, 0 },
> -	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
> -	{ "adma-dsp", IMX_SC_R_DSP, 1, false, 0 },
> -	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
> -	{ "adma-can", IMX_SC_R_CAN_0, 3, true, 0 },
> -	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true, 0 },
> -	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
> -	{ "adma-adc", IMX_SC_R_ADC_0, 1, true, 0 },
> -	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true, 0 },
> -	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
> -	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true, 0 },
> -	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
> -
> -	/* VPU SS  */
> +	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
> +	{ "usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
> +	{ "usb2", IMX_SC_R_USB_2, 1, false, 0 },
> +	{ "usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
> +	{ "sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
> +	{ "enet", IMX_SC_R_ENET_0, 2, true, 0 },
> +	{ "nand", IMX_SC_R_NAND, 1, false, 0 },
> +	{ "mlb", IMX_SC_R_MLB_0, 1, true, 0 },
> +
> +	/* AUDIO SS */
> +	{ "audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
> +	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
> +	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
> +	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
> +	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
> +	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
> +	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
> +	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
> +	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
> +	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
> +	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
> +	{ "amix", IMX_SC_R_AMIX, 1, false, 0 },
> +	{ "mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
> +	{ "dsp", IMX_SC_R_DSP, 1, false, 0 },
> +	{ "dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
> +
> +	/* DMA SS */
> +	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
> +	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
> +	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
> +	{ "adc", IMX_SC_R_ADC_0, 1, true, 0 },
> +	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
> +	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
> +	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
> +	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
> +
> +	/* VPU SS */
>  	{ "vpu", IMX_SC_R_VPU, 1, false, 0 },
>  	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
>  	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
> @@ -139,14 +141,16 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>  	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
>  
>  	/* HSIO SS */
> -	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
> -	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
> +	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
> +	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
>  	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },

Why is gpio so special that we need to keep the SS indicator?

Shawn

>  
> -	/* MIPI/LVDS SS */
> +	/* MIPI SS */
>  	{ "mipi0", IMX_SC_R_MIPI_0, 1, false, 0 },
>  	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false, 0 },
>  	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true, 0 },
> +
> +	/* LVDS SS */
>  	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
>  
>  	/* DC SS */
> -- 
> 2.7.4
> 
