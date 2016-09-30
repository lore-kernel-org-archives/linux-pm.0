From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2] PM / devfreq: Add proper locking around list_del()
Date: Fri, 30 Sep 2016 22:46:39 +0900
Message-ID: <CAJ0PZbSrd9Xi=YZJF_XarRYj1tb75L8_Bgc=T1iMsMB3YLnzDQ@mail.gmail.com>
References: <1475115208-6817-1-git-send-email-axel.lin@ingics.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36590 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbcI3Nqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 09:46:55 -0400
In-Reply-To: <1475115208-6817-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Thu, Sep 29, 2016 at 11:13 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Use devfreq_list_lock around list_del() to prevent list corruption.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

LGTM.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
> v2: changes base on MyungJoo's comment.
> Note, devfreq_list_lock lock region does not to include device_unregister(&devfreq->dev);
>  drivers/devfreq/devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 478006b..66d3c718 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -594,17 +594,19 @@ struct devfreq *devfreq_add_device(struct device *dev,
>         if (devfreq->governor)
>                 err = devfreq->governor->event_handler(devfreq,
>                                         DEVFREQ_GOV_START, NULL);
> -       mutex_unlock(&devfreq_list_lock);
>         if (err) {
>                 dev_err(dev, "%s: Unable to start governor for the device\n",
>                         __func__);
>                 goto err_init;
>         }
> +       mutex_unlock(&devfreq_list_lock);
>
>         return devfreq;
>
>  err_init:
>         list_del(&devfreq->node);
> +       mutex_unlock(&devfreq_list_lock);
> +
>         device_unregister(&devfreq->dev);
>  err_out:
>         return ERR_PTR(err);
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
