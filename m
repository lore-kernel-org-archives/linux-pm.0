From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / sleep: fix unbalanced pm runtime disable in __device_suspend_late()
Date: Thu, 19 May 2016 15:38:30 +0200
Message-ID: <CAJZ5v0ja-poNq0J+giAJJb+pPFyGg1a7rUcUfFyhcn9qPnaieQ@mail.gmail.com>
References: <1463162628-16976-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33134 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcESNic (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 09:38:32 -0400
In-Reply-To: <1463162628-16976-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 13, 2016 at 8:03 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> The PM runtime will be left disabled for the device if its .suspend_late()
> callback fails and async suspend is not allowed for this device. In
> this case device will not be added in dpm_late_early_list and
> dpm_resume_early() will ignore this device, as result PM runtime will
> be disabled for it forever (side effect: after 8 subsequent failures
> for the same device the PM runtime will be reenabled due to
> disable_depth overflow).
>
> Hence, re-enable PM runtime in __device_suspend_late() if
> .suspend_late() callback fails and async suspend is not allowed for
> this device.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/base/power/main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 6e7c3cc..9b266e5 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1207,10 +1207,13 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>         }
>
>         error = dpm_run_callback(callback, dev, state, info);
> -       if (!error)
> +       if (!error) {
>                 dev->power.is_late_suspended = true;
> -       else
> +       } else {
>                 async_error = error;
> +               if (!is_async(dev))

Why is the is_async() check necessary here?

> +                       pm_runtime_enable(dev);
> +       }
>
>  Complete:
>         TRACE_SUSPEND(error);
> --
