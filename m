From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Date: Wed, 04 Jul 2018 14:30:32 +0900
Message-ID: <5B3C5B78.6020401@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
        <20180703234705.227473-8-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180703234705.227473-8-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi,

I didn't see any framework which exporting the class instance.
It is very dangerous. Unknown device drivers is able to reset
the 'devfreq_class' instance. I can't agree this approach.

Regards,
Chanwoo Choi


On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> Exporting the device class allows other parts of the kernel to enumerate
> the devfreq devices and receive notification when a devfreq device is
> added or removed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - patch added to series
> ---
>  drivers/devfreq/devfreq.c | 3 ++-
>  include/linux/devfreq.h   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4cbaa7ad1972..38b90b64fc6e 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -31,7 +31,8 @@
>  #define MAX(a,b)	((a > b) ? a : b)
>  #define MIN(a,b)	((a < b) ? a : b)
>  
> -static struct class *devfreq_class;
> +struct class *devfreq_class;
> +EXPORT_SYMBOL_GPL(devfreq_class);
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index c4f84a769cb5..964e064a951f 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -206,6 +206,8 @@ struct devfreq_freqs {
>  };
>  
>  #if defined(CONFIG_PM_DEVFREQ)
> +extern struct class *devfreq_class;
> +
>  extern struct devfreq *devfreq_add_device(struct device *dev,
>  				  struct devfreq_dev_profile *profile,
>  				  const char *governor_name,
> 
