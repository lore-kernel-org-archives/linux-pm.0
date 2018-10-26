From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 08/17] thermal: qcom: tsens: enable+check sensor after
 its setup is finished
Date: Fri, 26 Oct 2018 17:41:08 +0530
Message-ID: <CAHLCerNsdhG1OjiRiy5s4uSRGB6dUCVe7mvknCqWqMeQzxCb7Q@mail.gmail.com>
References: <CGME20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843@epcas2p1.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com> <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 17, 2018 at 9:24 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Enable+check sensor after setting tmdev->sensor[i].tzd and calling
> chipset specific enable operation.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/qcom/tsens.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index dbd2556..01bff96 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -105,13 +105,13 @@ static int tsens_register(struct tsens_device *tmdev)
>                 if (IS_ERR(tzd))
>                         continue;
>
> -               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> -               thermal_zone_device_check(tzd);
> -

I don't quite understand why you're making this move explicitly in a
separate patch for each of the drivers? You added it here in patch 4
in the first place, why not add it in the correct place there itself?


>                 tmdev->sensor[i].tzd = tzd;
>
>                 if (tmdev->ops->enable)
>                         tmdev->ops->enable(tmdev, i);
> +
> +               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tzd);
>
>         }
>         return 0;
>  }
> --
> 1.9.1
>
