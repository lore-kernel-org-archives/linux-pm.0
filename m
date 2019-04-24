From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] PM / devfreq: return PTR_ERR not NULL in try_then_request_governor()
Date: Wed, 24 Apr 2019 10:23:54 +0200
Message-ID: <CAFqH_512Z-R9O4oVZFq8dM629kfzKcvBuA1RbkEUn-7WH6jvHg@mail.gmail.com>
References: <20190403152602.10019-1-steven.price@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403152602.10019-1-steven.price@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Price <steven.price@arm.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Missatge de Steven Price <steven.price@arm.com> del dia dc., 3 d=E2=80=99ab=
r.
2019 a les 17:26:

>
> The callers of try_then_request_governor() only test for a PTR_ERR using
> IS_ERR(). However in the case that request_module() fails then NULL is
> currently returned which will cause a NULL-pointer dereference in the
> caller.
>
> Instead convert the error we already have to a valid PTR_ERR and return
> it.
>
> Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers=
 are built as modules.")
> Signed-off-by: Steven Price <steven.price@arm.com>

There is already a fix for that. The fix was initially sent in October [2] =
but
unfortunately, it got lost. I resend and now is queued [1]. Hopefully, the =
Fixes
tag will help to pick the fix to the proper kernel releases.

Thanks,
 Enric

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=
=3Dfor-next&id=3Db53b0128052ffd687797d5f4deeb76327e7b5711
[2] https://lkml.org/lkml/2018/10/16/744


> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..d29f66f0e52a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_gove=
rnor(const char *name)
>                 /* Restore previous state before return */
>                 mutex_lock(&devfreq_list_lock);
>                 if (err)
> -                       return NULL;
> +                       return ERR_PTR(err);
>
>                 governor =3D find_devfreq_governor(name);
>         }
> --
> 2.20.1
>
