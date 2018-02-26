From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
Date: Mon, 26 Feb 2018 16:48:23 +0200
Message-ID: <CAHp75VcervG-TWbt6t7q7505meXG=0E3hrO8pT-pc_=BJGqwpw@mail.gmail.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com> <20180226144118.24693-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226144118.24693-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, groeck@chromium.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 26, 2018 at 4:41 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:

> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c

>         if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
> -               result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
> +               mode = THERMAL_DEVICE_ENABLED;
>         else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
> -               result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
> +               mode = THERMAL_DEVICE_DISABLED;
>         else
> -               result = -EINVAL;
> +               return -EINVAL;

sysfs_match_string()?


-- 
With Best Regards,
Andy Shevchenko
