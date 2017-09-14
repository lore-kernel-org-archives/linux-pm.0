From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH] thermal: brcmstb: disable trip points properly when needed
Date: Thu, 14 Sep 2017 16:25:34 -0700
Message-ID: <CAGt4E5sBikXQ84Suz28+FXpfcMJdrO8JipTgbBJkWWxZRy2utg@mail.gmail.com>
References: <CAGt4E5vbM-eyQVH5X3EK_6sUg7iOeYYoh72oG=+pAsTnu8dr0w@mail.gmail.com>
 <20170914231928.45542-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47204 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdINXZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2017 19:25:36 -0400
Received: by mail-wm0-f45.google.com with SMTP id 13so4304743wmq.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2017 16:25:36 -0700 (PDT)
In-Reply-To: <20170914231928.45542-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Colin King <colin.king@canonical.com>, Power Management List <linux-pm@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 14 September 2017 at 16:19, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
>
> The code checking for low and high temperature points was still based
> on an earlier implementation of the driver. It wasn't working properly
> with the data types currently being used.
>
> We fix this by disabling the high trip point if our high temperature is
> INT_MAX and disabling the low trip point if our low temperature is -INT_MAX
> (or lower).
>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>
> Here is my patch for the issue described. Please let me know if I should be
> squashing this into the driver patch and re-submit the entire series.

Looks like my attempt at adding this patch to the existing thread may
not have worked out so well.

Here's a link: https://marc.info/?l=linux-pm&m=150472721929919&w=2

>  drivers/thermal/broadcom/brcmstb_thermal.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 87b8e7a..1919f91 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -277,22 +277,23 @@ static int brcmstb_set_trips(void *data, int low, int high)
>
>         dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
>
> -       if (low) {
> -               if (low > INT_MAX)
> -                       low = INT_MAX;
> +       /*
> +        * Disable low-temp if "low" is too small. As per thermal framework
> +        * API, we use -INT_MAX rather than INT_MIN.
> +        */
> +       if (low <= -INT_MAX) {
> +               avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 0);
> +       } else {
>                 avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
>                 avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
> -       } else {
> -               avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 0);
>         }
>
> -       if (high < ULONG_MAX) {
> -               if (high > INT_MAX)
> -                       high = INT_MAX;
> +       /* Disable high-temp if "high" is too big. */
> +       if (high == INT_MAX) {
> +               avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 0);
> +       } else {
>                 avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
>                 avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
> -       } else {
> -               avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 0);
>         }
>
>         return 0;
> --
> 2.7.4
>
