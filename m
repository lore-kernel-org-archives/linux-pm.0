From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
Date: Wed, 13 Feb 2019 10:09:53 -0600
Message-ID: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
References: <20181205195050.4759-6-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Can someone apply this please.

>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index d67242d87744..87e93406d7cd 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
>         }
>
>         list_for_each_entry(edev, &devfreq_event_list, node) {
> -               if (!strcmp(edev->desc->name, node->name))
> +               if (of_node_name_eq(node, edev->desc->name))
>                         goto out;
>         }
>         edev = NULL;
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0bdf053..c2ea94957501 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
>                         if (!ppmu_events[i].name)
>                                 continue;
>
> -                       if (!of_node_cmp(node->name, ppmu_events[i].name))
> +                       if (of_node_name_eq(node, ppmu_events[i].name))
>                                 break;
>                 }
>
> --
> 2.19.1
>
