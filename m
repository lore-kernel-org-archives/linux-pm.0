From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] power: add new interface to return pm_transition state
Date: Sat, 22 Jun 2013 23:26:50 +0200
Message-ID: <4133846.I1XZFprb5V@vostro.rjw.lan>
References: <1371931874-3220-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371931874-3220-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, airlied@linux.ie, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Saturday, June 22, 2013 02:11:14 PM Shuah Khan wrote:
> Add a new interface get_pm_transition() to return pm_transition state.
> This interface is intended to be used from dev_pm_ops class and type
> suspend interfaces that call legacy pm ops driver suspend interfaces.
> Legacy suspend pm_ops take pm_message_t as a parameter.
> 
> e.g: drm_class_suspend() calls into driver suspend routines
> via drm_dev->driver->suspend(drm_dev, state).
> 
> Once drm_class_suspend() is converted to dev_pm_ops, it will no longer
> have access to pm_transition which it has to pass into driver legacy
> suspend calls. get_pm_transition() interface addresses this need.

That shouldn't be necessary because each transition has its own callback
in strict dev_pm_ops.

Thanks,
Rafael


> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> ---
>  drivers/base/power/main.c |   17 +++++++++++++++++
>  include/linux/pm.h        |    3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c2132b8..3e2e09d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -57,6 +57,23 @@ static pm_message_t pm_transition;
>  static int async_error;
>  
>  /**
> + * get_pm_transition - return pm_transition state.
> + * This interface is intended to be used from dev_pm_ops class and type
> + * suspend interfaces that call legacy pm ops driver suspend interfaces.
> + * Legacy suspend pm_ops take pm_message_t as a parameter.
> + * e.g: drm_class_suspend() calls into driver suspend routines
> + * via drm_dev->driver->suspend(drm_dev, state).
> + * Once drm_class_suspend() is converted to dev_pm_ops, it will no longer
> + * have access to pm_transition which it has to pass into driver legacy
> + * suspend calls. get_pm_transition() interface addresses this need.
> +*/
> +pm_message_t get_pm_transition()
> +{
> +	return pm_transition;
> +}
> +EXPORT_SYMBOL_GPL(get_pm_transition);
> +
> +/**
>   * device_pm_sleep_init - Initialize system suspend-related device fields.
>   * @dev: Device object being initialized.
>   */
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index a224c7f..46f3252 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -63,6 +63,9 @@ typedef struct pm_message {
>  	int event;
>  } pm_message_t;
>  
> +/* drivers/base/power/main.c */
> +extern pm_message_t get_pm_transition(void);
> +
>  /**
>   * struct dev_pm_ops - device PM callbacks
>   *
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
