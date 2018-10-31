From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 04/17] thermal: separate sensor registration and
 enable+check operations
Date: Wed, 31 Oct 2018 18:10:00 +0530
Message-ID: <CAHLCerNYO+srv4codxKqbOgtaUBr3WKV460jpry-Ppn1mf0Nug@mail.gmail.com>
References: <CGME20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478@epcas1p3.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com> <1539791563-5959-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539791563-5959-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

<snip>

> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -161,6 +161,11 @@ static int hwmon_thermal_add_sensor(struct device *dev,
>         if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
>                 return PTR_ERR(tzd);
>
> +       if (!IS_ERR(tzd)) {
> +               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tzd);
> +       }
> +
>         return 0;
>  }
>  #else
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index c52d07c..d423b0f 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -647,6 +647,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
>                                                   &ntc_of_thermal_ops);
>         if (IS_ERR(tz))
>                 dev_dbg(dev, "Failed to register to thermal fw.\n");
> +       else {
> +               thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tz);
> +       }

Use the negative check here as above to get rid of the 'else' statement?

>         return 0;
>  }
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 111d521..ad5c5d7 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -288,6 +288,10 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>                  */
>                 if (IS_ERR(z))
>                         devm_kfree(dev, zone);
> +               else {
> +                       thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
> +                       thermal_zone_device_check(z);
> +               }

Use the negative check here (!IS_ERR(z)) as above to get rid of the
'else' statement? The memory is allocated through devm_kzalloc so it
doesn't need to be explicitly freed.

>         }
>
>         return 0;
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 04d7147..ff67f72 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -659,6 +659,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>                                 PTR_ERR(info->tzd));
>                         return PTR_ERR(info->tzd);
>                 }
> +               if (!IS_ERR(info->tzd)) {
> +                       thermal_zone_set_mode(info->tzd,
> +                                             THERMAL_DEVICE_ENABLED);
> +                       thermal_zone_device_check(info->tzd);
> +               }
>         }
