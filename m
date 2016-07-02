From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 7/7] devfreq: exynos-bus: add missing of_node_put after
 calling of_parse_phandle
Date: Sat, 2 Jul 2016 13:53:39 +0900
Message-ID: <CAGTfZH2HmmEbbmvm9pqMKv_chzPfZvrRvk+g-fkYPQ7pDfGa0Q@mail.gmail.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com> <1467366121-14120-8-git-send-email-peter.chen@nxp.com>
Reply-To: chanwoo@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1467366121-14120-8-git-send-email-peter.chen@nxp.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

2016-07-01 18:42 GMT+09:00 Peter Chen <peter.chen@nxp.com>:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/devfreq/exynos-bus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 2363d0a..a38b5ec 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -383,7 +383,7 @@ err_clk:
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct device_node *np = dev->of_node;
> +       struct device_node *np = dev->of_node, node;
>         struct devfreq_dev_profile *profile;
>         struct devfreq_simple_ondemand_data *ondemand_data;
>         struct devfreq_passive_data *passive_data;
> @@ -415,10 +415,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       if (of_parse_phandle(dev->of_node, "devfreq", 0))
> +       node = of_parse_phandle(dev->of_node, "devfreq", 0);
> +       if (node) {
> +               of_node_put(node);
>                 goto passive;
> -       else
> +       } else {
>                 ret = exynos_bus_parent_parse_of(np, bus);
> +       }
>
>         if (ret < 0)
>                 goto err;

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi
