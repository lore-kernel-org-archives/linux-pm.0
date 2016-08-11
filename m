From: Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH] thermal: armada: add support for suspend/resume
Date: Thu, 11 Aug 2016 10:40:19 +0200
Message-ID: <CAH76GKNBSmF=46eO+sjxtdFidsg+xZJhPZhZnC0r3V7SzM5aqQ@mail.gmail.com>
References: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcin Wojtas <mw@semihalf.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Lior Amsalem <alior@marvell.com>, Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I just wanted to kindly remind about this patch.

Best regards,
Grzegorz

2016-07-21 12:43 GMT+02:00 Grzegorz Jaszczyk <jaz@semihalf.com>:
> There is no need to implement subroutine for suspend since there is no
> data to store before suspending.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  drivers/thermal/armada_thermal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328..65f9838 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -304,12 +304,26 @@ static int armada_thermal_exit(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int armada_thermal_resume(struct device *dev)
> +{
> +       struct thermal_zone_device *thermal =
> +               dev_get_drvdata(dev);
> +       struct armada_thermal_priv *priv = thermal->devdata;
> +
> +       priv->data->init_sensor(to_platform_device(dev), priv);
> +
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(armada_thermal_pm_ops, NULL, armada_thermal_resume);
> +
>  static struct platform_driver armada_thermal_driver = {
>         .probe = armada_thermal_probe,
>         .remove = armada_thermal_exit,
>         .driver = {
>                 .name = "armada_thermal",
>                 .of_match_table = armada_thermal_id_table,
> +               .pm = &armada_thermal_pm_ops,
>         },
>  };
>
> --
> 1.8.3.1
>
