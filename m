From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Skip status update on uninitialized previous_freq
Date: Fri, 30 Sep 2016 23:09:34 +0900
Message-ID: <CAJ0PZbSOrkdNM4c0qhkboMU5JmyHLCcnw0wKA54JJruSxWqU5g@mail.gmail.com>
References: <1475152596-7892-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36813 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932417AbcI3OJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 10:09:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id h186so2955694oia.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Sep 2016 07:09:50 -0700 (PDT)
In-Reply-To: <1475152596-7892-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Thu, Sep 29, 2016 at 9:36 PM, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> In case devfreq->previous_freq is still uninitialized in
> devfreq_update_status(), i.e. it has value '0', the lookups in
> that function fail, eventually leading to some error message:
> [    3.041292] devfreq bus_dmc: Couldn't update frequency transition information.
>
> Just skip the statup update in this situation.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/devfreq/devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 478006b..1bb300f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -137,6 +137,10 @@ static int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>
>         cur_time = jiffies;
>
> +       /* Immediately exit if previous_freq is not initialized yet. */
> +       if (!devfreq->previous_freq)
> +               goto out;
> +

Thanks!


Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

>         prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>         if (prev_lev < 0) {
>                 ret = prev_lev;
> --
> 2.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
