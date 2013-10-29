From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: fix return value check in devfreq_init()
Date: Tue, 29 Oct 2013 16:19:40 +0900
Message-ID: <CAJ0PZbTossYacGOWLid4C-X0-zJ8G5f8kiOGJs=4uKArnfzeag@mail.gmail.com>
References: <CAPgLHd9J4LL9SvxN1FeibN-gaCsoFu6o=PSGZDnzS4Ha1yN69w@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:48728 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab3J2HTk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2013 03:19:40 -0400
Received: by mail-vb0-f52.google.com with SMTP id f13so6114093vbg.39
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2013 00:19:40 -0700 (PDT)
In-Reply-To: <CAPgLHd9J4LL9SvxN1FeibN-gaCsoFu6o=PSGZDnzS4Ha1yN69w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: kyungmin.park@samsung.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On Fri, Oct 25, 2013 at 10:52 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function create_freezable_workqueue() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

I'm sorry but I've found that this is duplicated with a previous
(pending) patch.



Cheers,
myungJoo.

> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index c99c00d..22e5d2f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -993,10 +993,10 @@ static int __init devfreq_init(void)
>         }
>
>         devfreq_wq = create_freezable_workqueue("devfreq_wq");
> -       if (IS_ERR(devfreq_wq)) {
> +       if (!devfreq_wq) {
>                 class_destroy(devfreq_class);
>                 pr_err("%s: couldn't create workqueue\n", __FILE__);
> -               return PTR_ERR(devfreq_wq);
> +               return -ENOMEM;
>         }
>         devfreq_class->dev_groups = devfreq_groups;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
System S/W Lab, S/W Center, Samsung Electronics
