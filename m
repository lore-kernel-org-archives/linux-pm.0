From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 08/11] thermal: tsens: Check if the IP is correctly
 enabled by firmware
Date: Fri, 31 Aug 2018 00:53:48 +0530
Message-ID: <CAHLCerPF0U22XZ8kEBkXZYJHkL73K8_RFkArs9gXvc0Qmufr-g@mail.gmail.com>
References: <cover.1535462942.git.amit.kucheria@linaro.org> <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 7:08 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> The SROT registers are initialised by the secure firmware at boot. We
> don't have write access to the registers. Check if the block is enabled
> before continuing.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 0b8a793f15f4..d250b757d1f0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -12,6 +12,11 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>
> +/* SROT */
> +#define CTRL_OFFSET            0x4

This OFFSET is not constant across the TSENS family and breaks atleast
one platform in the test below. I have a patch to fix this for all
platforms, will post it after a bit more testing.


> +#define TSENS_EN               BIT(0)
> +
> +/* TM */
>  #define STATUS_OFFSET          0x30
>  #define SN_ADDR_OFFSET         0x4
>  #define SN_ST_TEMP_MASK                0x3ff
> @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
>  {
>         void __iomem *tm_base, *srot_base;
>         struct resource *res;
> +       u32 code;
> +       int ret;
>         struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>
>         if (!op)
> @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
>         if (IS_ERR(tmdev->tm_map))
>                 return PTR_ERR(tmdev->tm_map);
>
> +       if (tmdev->srot_map) {
> +               ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> +               if (ret)
> +                       return ret;
> +               if (!(code & TSENS_EN)) {
> +                       dev_err(tmdev->dev, "tsens device is not enabled\n");
> +                       return -ENODEV;
> +               }
> +       }
> +
>         return 0;
>  }
> --
> 2.17.1
>
