From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH] thermal: tsens: qcom: do not create duplicate regmap
 debugfs entries
Date: Mon, 19 Nov 2018 20:52:33 +0530
Message-ID: <CAP245DXUVfMc--TwkGkd-kzeDwSnDtG62zfjYQnMJr5XVmVjNw@mail.gmail.com>
References: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 15, 2018 at 11:15 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Regmap would use device name to create debugfs entries. If the device
> has multiple regmaps it is recommended to use name field in regmap_config.
> Fix this by providing name to the regmap configs correctly.
>
> Without this patch we would see below error on DB820c.
>
> qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
> debugfs directory

Good catch!

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

after a minor fix below...

> ---
>  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 3be4be2e0465..78652cac7f3d 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -114,6 +114,14 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  }
>
>  static const struct regmap_config tsens_config = {

I suggest renaming this to tsens_tm_config and modifying the
corresponding devm_regmap_init_mmio below.

> +       .name           = "tm",
> +       .reg_bits       = 32,
> +       .val_bits       = 32,
> +       .reg_stride     = 4,
> +};
> +
> +static const struct regmap_config tsens_srot_config = {
> +       .name           = "srot",
>         .reg_bits       = 32,
>         .val_bits       = 32,
>         .reg_stride     = 4,
> @@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
>                 if (IS_ERR(srot_base))
>                         return PTR_ERR(srot_base);
>
> -               tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
> -                                                       srot_base, &tsens_config);
> +               tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
> +                                                       &tsens_srot_config);
>                 if (IS_ERR(tmdev->srot_map))
>                         return PTR_ERR(tmdev->srot_map);
>
> --
> 2.19.1
>
