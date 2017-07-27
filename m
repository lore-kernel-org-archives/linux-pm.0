From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Document new pm_runtime_set_suspended constraint
Date: Thu, 27 Jul 2017 15:20:16 +0200
Message-ID: <CAPDyKFrp4wNJs_pc+hM6zv7ZRBjWjJ9Cf3GdtjPPMECQgNChaA@mail.gmail.com>
References: <20170724095356.21667-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37031 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdG0NUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 09:20:17 -0400
Received: by mail-qk0-f178.google.com with SMTP id z18so21535289qka.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 06:20:17 -0700 (PDT)
In-Reply-To: <20170724095356.21667-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Lindgren <tony@atomide.com>

On 24 July 2017 at 11:53, Johan Hovold <johan@kernel.org> wrote:
> Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> device with an active child") it is no longer permitted to set
> RPM_SUSPENDED state for a device with active children unless
> power.ignore_children is set.
>
> Update the documentation to reflect this.
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/power/runtime_pm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 0fde3dcf077a..625549d4c74a 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -435,7 +435,8 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        PM status to 'suspended' and update its parent's counter of 'active'
>        children as appropriate (it is only valid to use this function if
>        'power.runtime_error' is set or 'power.disable_depth' is greater than
> -      zero)
> +      zero); it will fail and return an error code if the device has a child
> +      which is active and the 'power.ignore_children' flag is unset
>
>    bool pm_runtime_active(struct device *dev);
>      - return true if the device's runtime PM status is 'active' or its
> --
> 2.13.3
>
