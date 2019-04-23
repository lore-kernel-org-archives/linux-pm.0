From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] PM / devfreq: Return -ENODEV from
 try_then_request_governor
Date: Tue, 23 Apr 2019 11:55:52 +0200
Message-ID: <ed7c20b9-b435-5f40-55ab-97d6384749f1@collabora.com>
References: <20190423081158.29859-1-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423081158.29859-1-tomeu.vizoso@collabora.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomeu,

On 23/4/19 10:11, Tomeu Vizoso wrote:
> Callers don't expect it to return NULL, but an error code.
> 
> Fixes Oops such as the one below, when one tries to set a governor that
> isn't available:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000018
> 
> [<c0dcf718>] (governor_store) from [<c0539558>] (kernfs_fop_write+0x100/0x1e0)
> [<c0539558>] (kernfs_fop_write) from [<c04b09b4>] (__vfs_write+0x2c/0x17c)
> [<c04b09b4>] (__vfs_write) from [<c04b33fc>] (vfs_write+0xa4/0x184)
> [<c04b33fc>] (vfs_write) from [<c04b361c>] (ksys_write+0x4c/0xac)
> [<c04b361c>] (ksys_write) from [<c0301000>] (ret_fast_syscall+0x0/0x28)
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
> Reported-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

There is already a fix for that. The fix was initially sent in October [2] but
unfortunately it got lost. I resend and now is queued [1]. Hopefully the Fixes
tag will help to pick the fix to the proper kernel releases.

Thanks,
 Enric

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b53b0128052ffd687797d5f4deeb76327e7b5711

[2] https://lkml.org/lkml/2018/10/16/744

>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..5539e9be718d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  		/* Restore previous state before return */
>  		mutex_lock(&devfreq_list_lock);
>  		if (err)
> -			return NULL;
> +			return ERR_PTR(-ENODEV);
>  
>  		governor = find_devfreq_governor(name);
>  	}
> 
