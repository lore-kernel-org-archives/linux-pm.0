From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 3/8] PM / devfreq: Use the available min/max frequency
Date: Tue, 17 Oct 2017 23:43:00 +0900
Message-ID: <CAJ0PZbRarw8hSmkUZydn79czJj7HK1nc2G8egQdabDRVHE7W_w@mail.gmail.com>
References: <CGME20171013074833epcas1p433f03287f42a5b6dc16e796efa2a3bf3@epcas1p4.samsung.com>
 <1507880904-31956-1-git-send-email-cw00.choi@samsung.com> <1507880904-31956-4-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55806 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965048AbdJQOnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 10:43:17 -0400
In-Reply-To: <1507880904-31956-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> The commit a76caf55e5b35 ("thermal: Add devfreq cooling") is able
> to disable OPP as a cooling device. In result, both update_devfreq()
> and {min|max}_freq_show() have to consider the 'opp->available'
> status of each OPP.
>
> So, this patch adds the 'scaling_{min|max}_freq' to struct devfreq
> in order to indicate the available mininum and maximum frequency
> by adjusting OPP interface such as dev_pm_opp_{disable|enable}().
> The 'scaling_{min|max}_freq' are used for on both update_devfreq()
> and {min|max}_freq_show().
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++++++--------
>  include/linux/devfreq.h   |  4 ++++
>  2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6ba24e5db0d..9de013ffeb67 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
[]
> @@ -494,6 +499,19 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>         int ret;
>
>         mutex_lock(&devfreq->lock);
> +
> +       devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> +       if (!devfreq->scaling_min_freq) {
> +               mutex_unlock(&devfreq->lock);
> +               return -EINVAL;
> +       }
> +
> +       devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> +       if (!devfreq->max_freq) {

1. s/max_freq/scaling/max_freq/ ??

2. what if thermal is not active or has never triggered any event and
the user has never stated max/min? (making scaling_*_freq zero)

> +               mutex_unlock(&devfreq->lock);
> +               return -EINVAL;
> +       }
> +
>         ret = update_devfreq(devfreq);
>         mutex_unlock(&devfreq->lock);
>



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
