From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH -next] power/supply: fix sc27xx_fuel_gauge build errors
Date: Tue, 13 Nov 2018 09:38:48 +0800
Message-ID: <CAMz4kuKwvSOV4vU7_iVoyigdkMRDYMoNLLuiCFs33=E7br4wDw@mail.gmail.com>
References: <3736c0f9-9f2c-bc74-22c2-677c42a2a630@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3736c0f9-9f2c-bc74-22c2-677c42a2a630@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Randy,

On 13 November 2018 at 01:06, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors when FUEL_GUAGE_SC27XX is enabled but IIO is either
> not enabled or IIO=m and FUEL_GUAGE_SC27XX=y.
>
> ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_get_temp':
> sc27xx_fuel_gauge.c:(.text+0x1d2): undefined reference to `iio_read_channel_processed'
> ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_probe':
> sc27xx_fuel_gauge.c:(.text+0x97f): undefined reference to `devm_iio_channel_get'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---

Thanks for fixing this issue.
Acked-by: Baolin Wang <baolin.wang@linaro.org>

>  drivers/power/supply/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20181112.orig/drivers/power/supply/Kconfig
> +++ linux-next-20181112/drivers/power/supply/Kconfig
> @@ -655,6 +655,7 @@ config CHARGER_SC2731
>  config FUEL_GAUGE_SC27XX
>         tristate "Spreadtrum SC27XX fuel gauge driver"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +       depends on IIO
>         help
>          Say Y here to enable support for fuel gauge with SC27XX
>          PMIC chips.
>
>



-- 
Baolin Wang
Best Regards
