From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCHv3] thermal: exynos: Add support for TRIM_RELOAD feature at
 Exynos3250
Date: Wed, 20 Aug 2014 14:14:52 +0200
Message-ID: <1706216.YJ4TzvQvn4@amdc1032>
References: <1408450078-6296-1-git-send-email-cw00.choi@samsung.com>
 <1408492364-8012-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1408492364-8012-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: devicetree@vger.kernel.org, l.majewski@samsung.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, t.figa@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com, amit.daniel@samsung.com, linux-samsung-soc@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Wednesday, August 20, 2014 08:52:44 AM Chanwoo Choi wrote:
> This patch add support for TRIM_RELOAD feature at Exynos3250. The TMU of
> Exynos3250 has two TRIMINFO_CON register.

This patch also silently fixes wrong behavior of the Exynos thermal
driver and TRIM_RELOAD feature for Exynos5260 and Exynos5420.  Currently
these SoCs claim TRIM_RELOAD support but don't have triminfo_ctrl
register address defined in their struct exynos_tmu_registers entries.
This causes write of value "1" to data->base + 0x00 address (which
happens to be TRIMINFO register).  Your patch doesn't define
triminfo_reload_count on all SoCs that use TRIM_RELOAD flag so wrong
write to TRIMINFO register no longer happens but I think that it would
be the best to fix it explicitly by removing TRIM_RELOAD flag for
Exynos5260 and Exynos5420 in a pre-patch to your patch, please see:

	https://lkml.org/lkml/2014/8/20/334

One other issue with your patch is that it modifies struct
exynos_tmu_registers and struct exynos_tmu_platform_data without
updating corresponding documentation.  Please fix it.

Otherwise it looks fine to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Changes from v2:
> - Fix build break because of missing 'or' operation.
> Changes from v1:
> - Add missing 'TMU_SUPPORT_TRIM_RELOAD' feature
> 
>  drivers/thermal/samsung/exynos_tmu.c      |  7 +++++--
>  drivers/thermal/samsung/exynos_tmu.h      |  5 +++--
>  drivers/thermal/samsung/exynos_tmu_data.c | 11 +++++++++--
>  drivers/thermal/samsung/exynos_tmu_data.h |  7 +++++--
>  4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index acbff14..ed01606 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -164,8 +164,11 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (TMU_SUPPORTS(pdata, TRIM_RELOAD))
> -		__raw_writel(1, data->base + reg->triminfo_ctrl);
> +	if (TMU_SUPPORTS(pdata, TRIM_RELOAD)) {
> +		for (i = 0; i < pdata->triminfo_reload_count; i++)
> +			__raw_writel(pdata->triminfo_reload[i],
> +					data->base + reg->triminfo_ctrl[i]);
> +	}
>  
>  	if (pdata->cal_mode == HW_MODE)
>  		goto skip_calib_data;
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
> index 1b4a644..72cb54e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -151,8 +151,7 @@ struct exynos_tmu_registers {
>  	u32	triminfo_25_shift;
>  	u32	triminfo_85_shift;
>  
> -	u32	triminfo_ctrl;
> -	u32	triminfo_ctrl1;
> +	u32	triminfo_ctrl[2];
>  	u32	triminfo_reload_shift;
>  
>  	u32	tmu_ctrl;
> @@ -295,6 +294,8 @@ struct exynos_tmu_platform_data {
>  	u8 second_point_trim;
>  	u8 default_temp_offset;
>  	u8 test_mux;
> +	u8 triminfo_reload[2];
> +	u8 triminfo_reload_count;
>  
>  	enum calibration_type cal_type;
>  	enum calibration_mode cal_mode;
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
> index aa8e0de..8cd609c 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.c
> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> @@ -95,6 +95,8 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>  	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>  	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>  	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
> +	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
> +	.triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
>  	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>  	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
>  	.buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
> @@ -160,8 +162,11 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>  		.temp_level = 95, \
>  	}, \
>  	.freq_tab_count = 2, \
> +	.triminfo_reload[0] = 0x1, \
> +	.triminfo_reload[1] = 0x11, \
> +	.triminfo_reload_count = 2, \
>  	.registers = &exynos3250_tmu_registers, \
> -	.features = (TMU_SUPPORT_EMULATION | \
> +	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
>  			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
>  			TMU_SUPPORT_EMUL_TIME)
>  #endif
> @@ -184,7 +189,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>  	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>  	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>  	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
> -	.triminfo_ctrl = EXYNOS_TMU_TRIMINFO_CON,
> +	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON2,
>  	.triminfo_reload_shift = EXYNOS_TRIMINFO_RELOAD_SHIFT,
>  	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>  	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
> @@ -252,6 +257,8 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>  		.temp_level = 95, \
>  	}, \
>  	.freq_tab_count = 2, \
> +	.triminfo_reload[0] = 0x1, \
> +	.triminfo_reload_count = 1, \
>  	.registers = &exynos4412_tmu_registers, \
>  	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
>  			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
> index f0979e5..e0536c3 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.h
> +++ b/drivers/thermal/samsung/exynos_tmu_data.h
> @@ -57,8 +57,11 @@
>  #define EXYNOS4210_TMU_TRIG_LEVEL_MASK	0x1111
>  #define EXYNOS4210_TMU_INTCLEAR_VAL	0x1111
>  
> -/* Exynos5250 and Exynos4412 specific registers */
> -#define EXYNOS_TMU_TRIMINFO_CON	0x14
> +/* Exynos3250 specific registers */
> +#define EXYNOS_TMU_TRIMINFO_CON1	0x10
> +
> +/* Exynos5250, Exynos4412 and Exynos3250 specific registers */
> +#define EXYNOS_TMU_TRIMINFO_CON2	0x14
>  #define EXYNOS_THD_TEMP_RISE		0x50
>  #define EXYNOS_THD_TEMP_FALL		0x54
>  #define EXYNOS_EMUL_CON		0x80
