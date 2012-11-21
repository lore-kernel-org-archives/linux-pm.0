From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH 2/2] Thermal: Introduce THERMAL_TREND_RAISE/DROP_FULL
 support for step_wise governor
Date: Wed, 21 Nov 2012 15:07:43 +0530
Message-ID: <CAK44p22XdWZogaN6es+e8Qp-=0MD2=EEWpWQpUktOSyPO3d9Aw@mail.gmail.com>
References: <1353313293.6468.4.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43343 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2KUJho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Nov 2012 04:37:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6829035obb.19
        for <linux-pm@vger.kernel.org>; Wed, 21 Nov 2012 01:37:43 -0800 (PST)
In-Reply-To: <1353313293.6468.4.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, durga <durgadoss.r@intel.com>

On 19 November 2012 13:51, Zhang Rui <rui.zhang@intel.com> wrote:
> From fcc7e0a36388f468c25526290e2fb2beebaae99c Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Mon, 19 Nov 2012 16:10:20 +0800
> Subject: [PATCH 2/2] Introduce THERMAL_TREND_RAISE/DROP_FULL support for
>  step_wise governor
>
> step_wise governor should set the device cooling state to
> upper/lower limit directly when THERMAL_TREND_RAISE/DROP_FULL.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 1242cff..6273f7d 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -35,6 +35,10 @@
>   *       state for this trip point
>   *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>   *       state for this trip point
> + *    c. if the trend is THERMAL_TREND_RAISE_FULL, use upper limit
> + *       for this trip point
> + *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
> + *       for this trip point
>   */
>  static unsigned long get_target_state(struct thermal_instance *instance,
>                                         enum thermal_trend trend)
> @@ -44,12 +48,23 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>
>         cdev->ops->get_cur_state(cdev, &cur_state);
>
> -       if (trend == THERMAL_TREND_RAISING) {
> +       switch (trend) {
> +       case THERMAL_TREND_RAISING:
>                 cur_state = cur_state < instance->upper ?
>                             (cur_state + 1) : instance->upper;
> -       } else if (trend == THERMAL_TREND_DROPPING) {
> +               break;
> +       case THERMAL_TREND_DROPPING:
>                 cur_state = cur_state > instance->lower ?
>                             (cur_state - 1) : instance->lower;
> +               break;
> +       case THERMAL_TREND_RAISE_FULL:
> +               cur_state = instance->upper;
> +               break;
> +       case THERMAL_TREND_DROP_FULL:
> +               cur_state = instance->lower;
> +               break;
> +       default:
> +               break;
>         }
>Hi Rui,

Sorry for late review. This part looks good. But can this
get_target_state be also called in update_instance_for_dethrottle as
done by my patch for quick cooling.

Thanks,
Amit Daniel
>         return cur_state;
> --
> 1.7.9.5
>
>
>
