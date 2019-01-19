From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
Date: Sat, 19 Jan 2019 21:27:08 +0900
Message-ID: <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
References: <20190119050256.22520-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119050256.22520-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Yangtao,

2019=EB=85=84 1=EC=9B=94 19=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 2:03, Y=
angtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
>
> devm_kzalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..fe6c157cb7e0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>                 mutex_unlock(&devfreq->lock);
>                 err =3D set_freq_table(devfreq);
>                 if (err < 0)
> -                       goto err_out;
> +                       goto err_dev;
>                 mutex_lock(&devfreq->lock);
>         }
>
> @@ -683,16 +683,27 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,
>                 goto err_out;
>         }
>
> -       devfreq->trans_table =3D
> -               devm_kzalloc(&devfreq->dev,
> -                            array3_size(sizeof(unsigned int),
> -                                        devfreq->profile->max_state,
> -                                        devfreq->profile->max_state),
> -                            GFP_KERNEL);
> +       devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,
> +                                           array3_size(sizeof(unsigned i=
nt),
> +                                           devfreq->profile->max_state,
> +                                           devfreq->profile->max_state),
> +                                           GFP_KERNEL);

The above 10 ten lines are not related to the memory leak for this
patch. If you want to fix the indentation, you have to make it
separately.

> +       if (!devfreq->trans_table) {
> +               mutex_unlock(&devfreq->lock);
> +               err =3D -ENOMEM;
> +               goto err_devfreq;
> +       }
> +
>         devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,
> -                                               devfreq->profile->max_sta=
te,
> -                                               sizeof(unsigned long),
> -                                               GFP_KERNEL);
> +                                             devfreq->profile->max_state=
,
> +                                             sizeof(unsigned long),
> +                                             GFP_KERNEL);

ditto. The above 6 ten lines are not related to the memory leak for
this patch. If you want to fix the indentation, you have to make it
separately.

> +       if (!devfreq->time_in_state) {
> +               mutex_unlock(&devfreq->lock);
> +               err =3D -ENOMEM;
> +               goto err_devfreq;
> +       }
> +
>         devfreq->last_stat_updated =3D jiffies;
>
>         srcu_init_notifier_head(&devfreq->transition_notifier_list);
> @@ -726,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>
>  err_init:
>         mutex_unlock(&devfreq_list_lock);
> -
> +err_devfreq:
>         devfreq_remove_device(devfreq);
>         devfreq =3D NULL;
>  err_dev:

Also, you better to add following codes to free the memory of
'devfreq->trans_table' and 'devfreq->time_in_state' because this patch
handles the memory leak of 'trans_table' and 'time_in_state'
variables.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..945f5f1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -593,6 +593,9 @@ static void devfreq_dev_release(struct device *dev)
                devfreq->profile->exit(devfreq->dev.parent);

        mutex_destroy(&devfreq->lock);
+       kfree(devfreq->trans_table);
+       kfree(devfreq->time_in_state);
        kfree(devfreq);
 }

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
