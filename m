From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Fix potential NULL pointer dereference in
 governor_store
Date: Thu, 07 Dec 2017 10:24:21 +0900
Message-ID: <5A289845.5040301@samsung.com>
References: <CGME20171206202028epcas2p44920d43cbde12943ed978b1e6d192ba5@epcas2p4.samsung.com>
        <20171206202015.GA15636@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171206202015.GA15636@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017년 12월 07일 05:20, Gustavo A. R. Silva wrote:
> df->governor is being dereferenced before it is null checked,
> hence there is a potential null pointer dereference.
> 
> Notice that df->governor is being null checked at line 1004:
> if (df->governor) {, which implies it might be null.
> 
> Fix this by null checking df->governor before dereferencing it.
> 
> Addresses-Coverity-ID: 1401988 ("Dereference before null check")
> Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/devfreq/devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 78fb496..14fe76b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -996,7 +996,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
> -	} else if (df->governor->immutable || governor->immutable) {
> +	} else if ((df->governor && df->governor->immutable) ||
> +					governor->immutable) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> 

Actually, df->governor would be never NULL because devfreq_add_device()
initializes the ->governor always. But, governor_store() doesn't know it.

So, looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
