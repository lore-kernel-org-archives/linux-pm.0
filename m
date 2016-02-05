From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v1 3/6] power_supply: Add types for USB Type C and PD chargers
Date: Fri, 5 Feb 2016 10:38:44 -0800
Message-ID: <CANLzEktsLH_hMPoaspuP1tZue-HkA3rqY2PbqOPOAOB7qm5+pA@mail.gmail.com>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
	<1454679181-8949-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36716 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbcBESip (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 13:38:45 -0500
Received: by mail-io0-f170.google.com with SMTP id g73so138098132ioe.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2016 10:38:45 -0800 (PST)
In-Reply-To: <1454679181-8949-4-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

Thanks for putting this up Tomeu!


On Fri, Feb 5, 2016 at 5:32 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> From: Benson Leung <bleung@chromium.org>
>
> This adds power supply types for USB chargers defined in
> the USB Type-C Specification 1.1 and in the
> USB Power Delivery Specification Revision 2.0 V1.1.
>
> The following are added :
> POWER_SUPPLY_TYPE_USB_TYPE_C,   /* Type C Port */
> POWER_SUPPLY_TYPE_USB_PD,       /* Type C Power Delivery Port */
> POWER_SUPPLY_TYPE_USB_PD_DRP,   /* Type C PD Dual Role Port */

I authored this patch, but in looking back, the comments should be tweaked.
USB_PD and USB_PD_DRP are not necessarily Type-C ports, as you may
have USB_PD ports that are either Type-A or Type-B as well.

Could you change these to be "USB Power Delivery Port" and "USB PD
Dual Role Port"?

>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Alec Berg <alecaberg@chromium.org>
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
> Reviewed-by: Todd Broch <tbroch@chromium.org>
> ---
>
>  drivers/power/power_supply_sysfs.c | 3 ++-
>  include/linux/power_supply.h       | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
> index ed2d7fd0c734..80fed98832f9 100644
> --- a/drivers/power/power_supply_sysfs.c
> +++ b/drivers/power/power_supply_sysfs.c
> @@ -45,7 +45,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>                                           char *buf) {
>         static char *type_text[] = {
>                 "Unknown", "Battery", "UPS", "Mains", "USB",
> -               "USB_DCP", "USB_CDP", "USB_ACA"
> +               "USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> +               "USB_PD", "USB_PD_DRP"
>         };
>         static char *status_text[] = {
>                 "Unknown", "Charging", "Discharging", "Not charging", "Full"
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index ef9f1592185d..206c3384c6fa 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -163,6 +163,9 @@ enum power_supply_type {
>         POWER_SUPPLY_TYPE_USB_DCP,      /* Dedicated Charging Port */
>         POWER_SUPPLY_TYPE_USB_CDP,      /* Charging Downstream Port */
>         POWER_SUPPLY_TYPE_USB_ACA,      /* Accessory Charger Adapters */
> +       POWER_SUPPLY_TYPE_USB_TYPE_C,   /* Type C Port */
> +       POWER_SUPPLY_TYPE_USB_PD,       /* Type C Power Delivery Port */
> +       POWER_SUPPLY_TYPE_USB_PD_DRP,   /* Type C PD Dual Role Port */

Same change as in commit message. Thanks!

>  };
>
>  enum power_supply_notifier_events {




-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
