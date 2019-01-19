From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
Date: Sun, 20 Jan 2019 00:08:35 +0800
Message-ID: <CAEExFWt3QcdAYuUCbJP8ZAr2nhQ4gt5zcnMJA5bwyw+rvxzNUw@mail.gmail.com>
References: <20190119050256.22520-1-tiny.windzz@gmail.com> <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cwchoi00@gmail.com
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Also, you better to add following codes to free the memory of
> 'devfreq->trans_table' and 'devfreq->time_in_state' because this patch
> handles the memory leak of 'trans_table' and 'time_in_state'
> variables.
Hi Chanwoo:

Isn't that the mem requested by the devm_ API automatically freed when
the device is detached?
So we don't need to pay attention to free these mem.

Thanks=EF=BC=8C
Yangtao
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..945f5f1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -593,6 +593,9 @@ static void devfreq_dev_release(struct device *dev)
>                 devfreq->profile->exit(devfreq->dev.parent);
>
>         mutex_destroy(&devfreq->lock);
> +       kfree(devfreq->trans_table);
> +       kfree(devfreq->time_in_state);
>         kfree(devfreq);
>  }
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
