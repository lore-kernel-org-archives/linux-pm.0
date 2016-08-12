From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2][RFC] PM / sleep: Make DPM watchdog depend on PM_SLEEP
Date: Fri, 12 Aug 2016 02:40:37 +0200
Message-ID: <CAJZ5v0jGLqntP21beGUs4yZp7VFOZnApiehGrxR8h_E0QbhGfw@mail.gmail.com>
References: <cover.1470908324.git.yu.c.chen@intel.com> <5134abc1ff41c139f46b6ff9c77092bd1f0095b1.1470908324.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34798 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbcHLAkl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 20:40:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so114808wma.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Aug 2016 17:40:38 -0700 (PDT)
In-Reply-To: <5134abc1ff41c139f46b6ff9c77092bd1f0095b1.1470908324.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

On Thu, Aug 11, 2016 at 2:29 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> The DPM watchdog is implemented only when PM_SLEEP is
> set, so make it depending on the latter.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Looks good to me.

> ---
>  kernel/power/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 68d3ebc..a359bc5 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -186,7 +186,7 @@ config PM_SLEEP_DEBUG
>
>  config DPM_WATCHDOG
>         bool "Device suspend/resume watchdog"
> -       depends on PM_DEBUG && PSTORE
> +       depends on PM_DEBUG && PSTORE && PM_SLEEP
>         ---help---
>           Sets up a watchdog timer to capture drivers that are
>           locked up attempting to suspend/resume a device.
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
