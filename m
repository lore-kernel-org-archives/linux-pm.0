From: Patrick Venture <venture@google.com>
Subject: Re: [PATCH 2/6] hwmon: (aspeed-pwm-tacho) Use devm_thermal_of_cooling_device_register
Date: Thu, 18 Apr 2019 13:35:31 -0700
Message-ID: <CAO=notxzQUyRJ4L7w6o4Cdbwp-Sg4FXyMDgJUN-7YPm9JgiQuw@mail.gmail.com>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net> <1555617500-10862-3-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555617500-10862-3-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.l>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 18, 2019 at 12:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Use devm_thermal_of_cooling_device_register() to register the cooling
> device. As a side effect, this fixes a driver bug:
> thermal_cooling_device_unregister() was not called on removal.
>
> Fixes: f198907d2ff6d ("hwmon: (aspeed-pwm-tacho) cooling device support.")
> Cc: Mykola Kostenok <c_mykolak@mellanox.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Patrick Venture <venture@google.com>

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index c4dd6301e7c8..0daf0b32aa4a 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -830,10 +830,8 @@ static int aspeed_create_pwm_cooling(struct device *dev,
>         }
>         snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
>
> -       cdev->tcdev = thermal_of_cooling_device_register(child,
> -                                                        cdev->name,
> -                                                        cdev,
> -                                                        &aspeed_pwm_cool_ops);
> +       cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
> +                                       cdev->name, cdev, &aspeed_pwm_cool_ops);
>         if (IS_ERR(cdev->tcdev))
>                 return PTR_ERR(cdev->tcdev);
>
> --
> 2.7.4
>
