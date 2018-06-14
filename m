From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Date: Thu, 14 Jun 2018 12:18:47 +0530
Message-ID: <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
References: <cover.1528799892.git.amit.kucheria@linaro.org> <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On Tue, Jun 12, 2018 at 4:24 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses the TSENS v2 IP block
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +
>  drivers/thermal/qcom/Makefile                            |  2 +-
>  drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
>  drivers/thermal/qcom/tsens.c                             |  3 +++
>  drivers/thermal/qcom/tsens.h                             |  5 ++++-
>  5 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/thermal/qcom/tsens-sdm845.c
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 292ed89..8652499 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,sdm845-tsens"  : For SDM845 Family of SoCs
>
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 2cc2193..dc9f169 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)       += qcom_tsens.o
> -qcom_tsens-y                   += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> +qcom_tsens-y                   += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o tsens-sdm845.o
> diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
> new file mode 100644
> index 0000000..a647265
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens-sdm845.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
> +#include "tsens.h"
> +
> +static const struct tsens_ops ops_sdm845 = {
> +       .init           = init_common,
> +       .get_temp       = get_temp_tsens_v2,
> +};
> +
> +const struct tsens_data data_sdm845 = {

Just a minor nit. 'static' here?

> +       .ops            = &ops_sdm845,
> +};

[snip]

Thanks & Regards
Vivek


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
