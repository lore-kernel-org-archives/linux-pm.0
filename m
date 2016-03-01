From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/3] PM / sleep: try to runtime suspend for direct complete
Date: Tue, 1 Mar 2016 21:41:33 +0100
Message-ID: <CAPDyKFqjLuy63fsZQGE7DSR818dUt4Z+rTLPOG_gbsrQ0-htHw@mail.gmail.com>
References: <1456359089-19807-1-git-send-email-dbasehore@chromium.org>
	<1456359089-19807-2-git-send-email-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38427 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcCAUle (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 15:41:34 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so50529455wml.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 12:41:34 -0800 (PST)
In-Reply-To: <1456359089-19807-2-git-send-email-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "James E . J . Bottomley" <JBottomley@odin.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi <linux-scsi@vger.kernel.org>

On 25 February 2016 at 01:11, Derek Basehore <dbasehore@chromium.org> wrote:
> This tries to runtime suspend devices that are still active for direct
> complete. This is for cases such as autosuspend delays which leaves
> devices able to runtime suspend but still active. It's beneficial in
> this case to runtime suspend the device to take advantage of direct
> complete when possible.

Unfortunate this doesn't work. In the device_prepare() phase the PM
core prevents runtime suspend via a call to pm_runtime_get_noresume().

Kind regards
Uffe

>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Eric Caruso <ejcaruso@chromium.org>
> ---
>  drivers/base/power/main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e0017d9..9693032 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1380,7 +1380,12 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>                 goto Complete;
>
>         if (dev->power.direct_complete) {
> -               if (pm_runtime_status_suspended(dev)) {
> +               /*
> +                * Check if we're runtime suspended. If not, try to runtime
> +                * suspend for autosuspend cases.
> +                */
> +               if (pm_runtime_status_suspended(dev) ||
> +                   !pm_runtime_suspend(dev)) {
>                         pm_runtime_disable(dev);
>                         if (pm_runtime_status_suspended(dev))
>                                 goto Complete;
> --
> 2.7.0.rc3.207.g0ac5344
>
