From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/12] pinctrl: samsung: Add missing initconst annotation
Date: Mon, 16 Jan 2017 21:14:00 +0200
Message-ID: <20170116191400.ehm3ivkmz4csynvq@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064526eucas1p1e3064fad71a3ab8de34d306dec531b14@eucas1p1.samsung.com>
 <1484549107-5957-7-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484549107-5957-7-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2017 at 07:45:01AM +0100, Marek Szyprowski wrote:
> Exynos5433 support has been added in parallel to adding initconst
> annotation to most of the init data structures, so add those
> annotations also to Exynos5433 structures.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index bf753a596209..70b94ad10cc1 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -1266,7 +1266,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  };
>  
>  /* pin banks of exynos5433 pin-controller - ALIVE */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
>  	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
>  	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
> @@ -1279,28 +1279,28 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  };

Your change is aligned with existing code... but after I started to look
into it I think this should not be initconst.

The pin_banks (initconst) are referenced in pin_ctrl (initconst) which
is referenced in samsung_pinctrl_dt_match (NOT initconst). The dt_match
then is used in samsung_pinctrl_driver (for obvious reasons not
initconst).

We suppress the bind so this looks safe - this data should not be ever used
after init - but it is not correct strictly speaking.

Let's imagine some weird future platform which will use DT overlays with
pinctrl. I think the overlays could affect the tree after the init
stage.

The other question is why the DEBUG_SECTION_MISMATCH is not complaining
about this...

Best regards,
Krzysztof

>  
>  /* pin banks of exynos5433 pin-controller - AUD */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks1[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
>  	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - CPIF */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks2[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - eSE */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks3[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - FINGER */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks4[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - FSYS */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks5[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
>  	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
>  	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
> @@ -1310,17 +1310,17 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  };
>  
>  /* pin banks of exynos5433 pin-controller - IMEM */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks6[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - NFC */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks7[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - PERIC */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks8[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
>  	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
>  	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
> @@ -1341,7 +1341,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  };
>  
>  /* pin banks of exynos5433 pin-controller - TOUCH */
> -static const struct samsung_pin_bank_data exynos5433_pin_banks9[] = {
> +static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
>  	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
>  };
>  
> @@ -1349,7 +1349,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>   * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
>   * ten gpio/pin-mux/pinconfig controllers.
>   */
> -const struct samsung_pin_ctrl exynos5433_pin_ctrl[] = {
> +const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
>  	{
>  		/* pin-controller instance 0 data */
>  		.pin_banks	= exynos5433_pin_banks0,
> -- 
> 1.9.1
> 
