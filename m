From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH] devfreq: add error check for sscanf in userspace governor
Date: Tue, 8 Aug 2017 12:26:24 +0530
Message-ID: <CAEU1=PmSq+UXO_zwrMSTbsejUi5G8BCKaqYA_cxmo4pcFO1z_Q@mail.gmail.com>
References: <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org> <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdHHG40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 02:56:26 -0400
In-Reply-To: <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Mardi <gsantosh@codeaurora.org>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, gsantosh@qti.qualcomm.com, skannan@quicinc.com, rgottimu@qti.qualcomm.com

Hi Santosh,

On Mon, Aug 7, 2017 at 6:36 PM, Santosh Mardi <gsantosh@codeaurora.org> wrote:
> store_freq function of devfreq userspace governor
> executes further, even if error is returned from sscanf,
> this will result in setting up wrong frequency value.
>
> Add proper error check to bail out if any error is returned.
>
> Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>
> ---
>  drivers/devfreq/governor_userspace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 77028c2..1d0c9cc 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -53,12 +53,15 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
>         mutex_lock(&devfreq->lock);
>         data = devfreq->data;
>
> -       sscanf(buf, "%lu", &wanted);
> +       err = sscanf(buf, "%lu", &wanted);
> +       if (err != 1)
> +               goto out;

You can save this goto statement by moving this sscanf checking to
before taking the mutex.

>         data->user_frequency = wanted;
>         data->valid = true;
>         err = update_devfreq(devfreq);
>         if (err == 0)
>                 err = count;
> +out:
>         mutex_unlock(&devfreq->lock);
>         return err;
>  }
> --
> 1.9.1
>


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
