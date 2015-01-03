From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 2/3] video / backlight: remove the
 backlight_device_registered API
Date: Sat, 03 Jan 2015 10:05:48 +0900
Message-ID: <000c01d026f1$690a7050$3b1f50f0$%han@samsung.com>
References: <1419997818-19528-1-git-send-email-aaron.lu@intel.com>
 <1419997818-19528-3-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1419997818-19528-3-git-send-email-aaron.lu@intel.com>
Content-language: ko
Sender: linux-acpi-owner@vger.kernel.org
To: 'Aaron Lu' <aaron.lu@intel.com>
Cc: 'Lee Jones' <lee.jones@linaro.org>, 'Zhang Rui' <rui.zhang@intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 31, 2014 12:50 PM, Aaron Lu wrote:
> 
> Since we will need the backlight_device_get_by_type API, we can use it
> instead of the backlight_device_registered API whenever necessary so
> remove the backlight_device_registered API.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/acpi/video.c                | 2 +-
>  drivers/video/backlight/backlight.c | 6 ------
>  include/linux/backlight.h           | 1 -
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 1eaadff2e198..98d3f0de811e 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -246,7 +246,7 @@ static bool acpi_video_use_native_backlight(void)
>  bool acpi_video_verify_backlight_support(void)
>  {
>  	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> -	    backlight_device_registered(BACKLIGHT_RAW))
> +	    backlight_device_get_by_type(BACKLIGHT_RAW))
>  		return false;
>  	return acpi_video_backlight_support();
>  }
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index bea749329236..aec173d9e1ee 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -406,12 +406,6 @@ struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
>  }
>  EXPORT_SYMBOL(backlight_device_get_by_type);
> 
> -bool backlight_device_registered(enum backlight_type type)
> -{
> -	return backlight_device_get_by_type(type) ? true : false;
> -}
> -EXPORT_SYMBOL(backlight_device_registered);
> -
>  /**
>   * backlight_device_unregister - unregisters a backlight device object.
>   * @bd: the backlight device object to be unregistered and freed.
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index c59a020df3f8..287a4460054c 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -137,7 +137,6 @@ extern void devm_backlight_device_unregister(struct device *dev,
>  					struct backlight_device *bd);
>  extern void backlight_force_update(struct backlight_device *bd,
>  				   enum backlight_update_reason reason);
> -extern bool backlight_device_registered(enum backlight_type type);
>  extern int backlight_register_notifier(struct notifier_block *nb);
>  extern int backlight_unregister_notifier(struct notifier_block *nb);
>  extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
> --
> 2.1.0

