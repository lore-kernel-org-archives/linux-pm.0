From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 5/8] PM / devfreq: Fix the checkpatch warnings
Date: Fri, 30 Dec 2016 19:38:06 +0900
Message-ID: <CAJ0PZbSwBMqAr62Pb3bK7+z2jFvt9W0fu8ayM1FA4mVzovp=6g@mail.gmail.com>
References: <CGME20161228115654epcas1p1fd3636bca6d05331fcd9b629a8aeb921@epcas1p1.samsung.com>
 <1482926212-19223-1-git-send-email-cw00.choi@samsung.com> <1482926212-19223-6-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36558 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbcL3KiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 05:38:23 -0500
In-Reply-To: <1482926212-19223-6-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 28, 2016 at 8:56 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch just fixes the checkpatch warnings.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 47206a21bb90..8e5938c9c7d6 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -538,15 +538,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>         devfreq = find_device_devfreq(dev);
>         mutex_unlock(&devfreq_list_lock);
>         if (!IS_ERR(devfreq)) {
> -               dev_err(dev, "%s: Unable to create devfreq for the device. It already has one.\n", __func__);
> +               dev_err(dev, "%s: Unable to create devfreq for the device.\n",
> +                       __func__);

Actually, you do not need to try to keep it under 80col for printing strings.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>                 err = -EINVAL;
>                 goto err_out;
>         }
>
>         devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
>         if (!devfreq) {
> -               dev_err(dev, "%s: Unable to create devfreq for the device\n",
> -                       __func__);
>                 err = -ENOMEM;
>                 goto err_out;
>         }


-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
