From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: event: Remove unnecessary NULL test for to_devfreq_event(dev)
Date: Fri, 30 Sep 2016 22:50:49 +0900
Message-ID: <CAJ0PZbSOLWXTwiqT_8eEHr=8bCK1USbR_YSBt6j34_vi=-f-8w@mail.gmail.com>
References: <1474805788-30702-1-git-send-email-axel.lin@ingics.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36468 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbcI3NvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2016 09:51:05 -0400
In-Reply-To: <1474805788-30702-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Sun, Sep 25, 2016 at 9:16 PM, Axel Lin <axel.lin@ingics.com> wrote:
> to_devfreq_event(dev) never returns NULL.


If dev == 8 in 32bit system, it is NULL. :)

>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/devfreq/devfreq-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 9aea2c7..d0ae087 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -442,7 +442,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  {
>         struct devfreq_event_dev *edev = to_devfreq_event(dev);
>
> -       if (!edev || !edev->desc)
> +       if (!edev->desc)
>                 return -EINVAL;
>
>         return sprintf(buf, "%s\n", edev->desc->name);
> @@ -454,7 +454,7 @@ static ssize_t enable_count_show(struct device *dev,
>  {
>         struct devfreq_event_dev *edev = to_devfreq_event(dev);
>
> -       if (!edev || !edev->desc)
> +       if (!edev->desc)
>                 return -EINVAL;
>
>         return sprintf(buf, "%d\n", edev->enable_count);
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
