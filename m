From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH 3/3] usb/xhci-plat: remove unnecessary #ifdef checks
 for CONFIG_PM_SLEEP
Date: Fri, 13 Dec 2013 09:19:34 +0100
Message-ID: <CAPDyKFoXjRsLTZzFy3cTafqwFg4JX01=Gb=eL23eeb9ddZiofA@mail.gmail.com>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
	<1386911905-2366-4-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:44156 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3LMITf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2013 03:19:35 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so1332944qeb.35
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2013 00:19:34 -0800 (PST)
In-Reply-To: <1386911905-2366-4-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, sarah.a.sharp@linux.intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, santosh.shilimkar@ti.com

On 13 December 2013 06:18, David Cohen <david.a.cohen@linux.intel.com> wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Drivers using SET_*_PM_OPS() no longer need to #ifdef for CONFIG_PM_*
> So, let's remove the unnecessary #ifdef's.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
> ---
>  drivers/usb/host/xhci-plat.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index d9c169f470d3..b1d93c344e04 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -197,7 +197,6 @@ static int xhci_plat_remove(struct platform_device *dev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM

I think you can solve this in another way.

As a start, I would suggest to change above to CONFIG_PM_SLEEP

>  static int xhci_plat_suspend(struct device *dev)
>  {
>         struct usb_hcd  *hcd = dev_get_drvdata(dev);
> @@ -217,10 +216,6 @@ static int xhci_plat_resume(struct device *dev)
>  static const struct dev_pm_ops xhci_plat_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
>  };
> -#define DEV_PM_OPS     (&xhci_plat_pm_ops)
> -#else
> -#define DEV_PM_OPS     NULL
> -#endif /* CONFIG_PM */

Remove the use of DEV_PM_OPS define. Instead use below macro and
outside #ifdef CONFIG_PM_SLEEP.

"static SIMPLE_DEV_PM_OPS(xhci_plat_pm_ops, xhci_plat_suspend,
xhci_plat_resume)"

That should do the trick I believe, without the need for changing the
existing SET_SYSTEM_SLEEP_PM_OPS macro in patch1.

Kind regards
Ulf Hansson

>
>  #ifdef CONFIG_OF
>  static const struct of_device_id usb_xhci_of_match[] = {
> @@ -235,7 +230,7 @@ static struct platform_driver usb_xhci_driver = {
>         .remove = xhci_plat_remove,
>         .driver = {
>                 .name = "xhci-hcd",
> -               .pm = DEV_PM_OPS,
> +               .pm = &xhci_plat_pm_ops,
>                 .of_match_table = of_match_ptr(usb_xhci_of_match),
>         },
>  };
> --
> 1.8.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
