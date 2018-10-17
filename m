From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Fix static checker warning in
 try_then_request_governor
Date: Wed, 17 Oct 2018 09:27:49 +0900
Message-ID: <5BC68205.1090406@samsung.com>
References: <CGME20181016100221epcas2p3da3cd977eefd0681e7d1231640b9e96e@epcas2p3.samsung.com>
        <20181016100203.18624-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20181016100203.18624-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On 2018년 10월 16일 19:02, Enric Balletbo i Serra wrote:
> The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
> drivers are built as modules." leads to the following static checker
> warning:
> 
>     drivers/devfreq/devfreq.c:1043 governor_store()
>     warn: 'governor' can also be NULL
> 
> The reason is that the try_then_request_governor() function returns both
> error pointers and NULL. It should just return error pointers, so fix
> this by returning a ERR_PTR to the error intead of returning NULL.
> 
> Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 62ead442a872..b10124c7308f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -231,7 +231,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>   * if is not found. This can happen when both drivers (the governor driver
>   * and the driver that call devfreq_add_device) are built as modules.
>   * devfreq_list_lock should be held by the caller. Returns the matched
> - * governor's pointer.
> + * governor's pointer or an error pointer.
>   */
>  static struct devfreq_governor *try_then_request_governor(const char *name)
>  {
> @@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  		/* Restore previous state before return */
>  		mutex_lock(&devfreq_list_lock);
>  		if (err)
> -			return NULL;
> +			return ERR_PTR(err);
>  
>  		governor = find_devfreq_governor(name);
>  	}
>

LGTM.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
